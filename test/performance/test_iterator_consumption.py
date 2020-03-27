from perfpy.picking_data_model import using_pydantic as pydantic
from perfpy.picking_data_model import using_named_tuples as named_tuples
from perfpy.picking_data_model import using_dicts as dicts
from perfpy.picking_data_model import using_attrs as attrs

from toolz.itertoolz import take
import logging


logging.basicConfig(level=logging.DEBUG)


def template_method(test_config, generator):
    counter = 0
    for x in take(test_config.num_to_consume, generator(test_config.num_to_consume)):
        counter += 1


def test_consuming_pydantic_entities(test_config):
    template_method(test_config, pydantic.generate_alt_2)


def test_consuming_dicts(test_config):
    template_method(test_config, dicts.generate_alt_2)


def test_consuming_named_tuples(test_config):
    template_method(test_config, named_tuples.generate_alt_2)


def test_consuming_attrs(test_config):
    template_method(test_config, attrs.generate_alt_2)
