Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901F7A949E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJbQ-00041j-Je; Thu, 21 Sep 2023 09:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJb2-0003yf-Nb
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJax-0002ah-Pd
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lQw2YXXyrOihkrf7usTxJv+mSCyiHcorqeGLgRXgA50=;
 b=K6vftflRkpgK+JJjdmU+dSXRxlEr/utMgjZoPF5fo3jqv8zWF/oJTGTvRrFtO3cEKePjC4
 3WjfS4DmxjulXkrZUHYL6tQ1MIMaboTe5RN0V+bLUMZ5kyd92YzwuXxAqO15woZ15JVirQ
 3VqM1XzUIIxsmOVFxNJF/QNiNls9XoY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-k078qofeOW6bAypJohfM_g-1; Thu, 21 Sep 2023 07:06:03 -0400
X-MC-Unique: k078qofeOW6bAypJohfM_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E88C3822568
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 11:06:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7C591005B96
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 11:06:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B373621E6900; Thu, 21 Sep 2023 13:06:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 10/10] qapi: scripts: add a generator for qapi's
 examples
References: <20230919201857.675913-1-victortoso@redhat.com>
 <20230919201857.675913-11-victortoso@redhat.com>
Date: Thu, 21 Sep 2023 13:06:01 +0200
In-Reply-To: <20230919201857.675913-11-victortoso@redhat.com> (Victor Toso's
 message of "Tue, 19 Sep 2023 22:18:57 +0200")
Message-ID: <87o7hv7ply.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Victor Toso <victortoso@redhat.com> writes:

> This generator has two goals:
>  1. Mechanical validation of QAPI examples
>  2. Generate the examples in a JSON format to be consumed for extra
>     validation.
>
> The generator iterates over every Example section, parsing both server
> and client messages. The generator prints any inconsistency found, for
> example:
>
>  |  Error: Extra data: line 1 column 39 (char 38)
>  |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
>  |  Data: {"execute": "cancel-vcpu-dirty-limit"},
>  |      "arguments": { "cpu-index": 1 } }

What language does it parse?

Can you give a grammar?

Should the parser be integrated into the doc parser, i.e. class QAPIDoc?

> The generator will output other JSON file with all the examples in the

Another JSON file, or other JSON files?

> QAPI module that they came from. This can be used to validate the
> introspection between QAPI/QMP to language bindings, for example:
>
>  | { "examples": [
>  |   {
>  |     "id": "ksuxwzfayw",
>  |     "client": [
>  |     {
>  |       "sequence-order": 1

Missing comma

>  |       "message-type": "command",
>  |       "message":
>  |       { "arguments":
>  |         { "device": "scratch", "size": 1073741824 },
>  |         "execute": "block_resize"
>  |       },
>  |    } ],
>  |    "server": [
>  |    {
>  |      "sequence-order": 2

Another one.

>  |      "message-type": "return",
>  |      "message": { "return": {} },

Extra comma.

>  |    } ]
>  |    }
>  |  ] }

Indentation is kind of weird.

The JSON's Valid structure and semantics are not documented.  We've
developed a way specify that, you might've heard of it, it's called
"QAPI schema" ;-P

Kidding aside, we've done this before.  E.g. docs/interop/firmware.json
specifies firmware descriptors.  We have some in pc-bios/descriptors/.

> Note that the order matters, as read by the Example section and
> translated into "sequence-order". A language binding project can then
> consume this files to Marshal and Unmarshal, comparing if the results
> are what is to be expected.
>
> RFC discussion:
>     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/dumpexamples.py | 208 +++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py         |   3 +-
>  2 files changed, 210 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/qapi/dumpexamples.py
>
> diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> new file mode 100644
> index 0000000000..55d9f13ab7
> --- /dev/null
> +++ b/scripts/qapi/dumpexamples.py

Let's name this examples.py.  It already does a bit more than dump
(namely validate), and any future code dealing with examples will likely
go into this file.

> @@ -0,0 +1,208 @@
> +"""
> +Dump examples for Developers
> +"""
> +# Copyright (c) 2023 Red Hat Inc.
> +#
> +# Authors:
> +#  Victor Toso <victortoso@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.

We should've insisted on v2+ for the QAPI generator back when we had a
chance.  *Sigh*

> +# See the COPYING file in the top-level directory.
> +
> +# Just for type hint on self
> +from __future__ import annotations
> +
> +import os
> +import json
> +import random
> +import string
> +
> +from typing import Dict, List, Optional
> +
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaType,
> +    QAPISchemaVisitor,
> +    QAPISchemaEnumMember,
> +    QAPISchemaFeature,
> +    QAPISchemaIfCond,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
> +    QAPISchemaVariants,

pylint warns

    scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaEnumMember imported from schema (unused-import)
    scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaObjectTypeMember imported from schema (unused-import)
    scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaVariants imported from schema (unused-import)

> +)
> +from .source import QAPISourceInfo
> +
> +
> +def gen_examples(schema: QAPISchema,
> +                 output_dir: str,
> +                 prefix: str) -> None:
> +    vis = QAPISchemaGenExamplesVisitor(prefix)
> +    schema.visit(vis)
> +    vis.write(output_dir)

The other backends have this at the end of the file.  Either order
works, but consistency is nice.

> +
> +
> +def get_id(random, size: int) -> str:

pylint warns

    scripts/qapi/dumpexamples.py:44:11: W0621: Redefining name 'random' from outer scope (line 17) (redefined-outer-name)

> +    letters = string.ascii_lowercase
> +    return ''.join(random.choice(letters) for i in range(size))
> +
> +
> +def next_object(text, start, end, context) -> (Dict, bool):
> +    # Start of json object
> +    start = text.find("{", start)
> +    end = text.rfind("}", start, end+1)

Single quotes, please, for consistency with quote use elsewhere.

Rules of thumb:

* Double quotes for english text (e.g. error messages), so we don't have
  to escape apostrophes.

* Double quotes when they reduce the escaping

* Else single quotes

More elsewhere, not flagged.

> +
> +    # try catch, pretty print issues

Is this comment useful?

> +    try:
> +        ret = json.loads(text[start:end+1])
> +    except Exception as e:

pylint warns

    scripts/qapi/dumpexamples.py:57:11: W0703: Catching too general exception Exception (broad-except)

Catch JSONDecodeError?

> +        print("Error: {}\nLocation: {}\nData: {}\n".format(
> +              str(e), context, text[start:end+1]))

Errors need to go to stderr.

Have you considered using QAPIError to report these errors?

> +        return {}, True
> +    else:
> +        return ret, False
> +
> +
> +def parse_text_to_dicts(text: str, context: str) -> (List[Dict], bool):

Before I review the parser, I'd like to know the (intended) language
being parsed.

> +    examples, clients, servers = [], [], []
> +    failed = False
> +
> +    count = 1
> +    c, s = text.find("->"), text.find("<-")
> +    while c != -1 or s != -1:
> +        if c == -1 or (s != -1 and s < c):
> +            start, target = s, servers
> +        else:
> +            start, target = c, clients
> +
> +        # Find the client and server, if any
> +        if c != -1:
> +            c = text.find("->", start + 1)
> +        if s != -1:
> +            s = text.find("<-", start + 1)
> +
> +        # Find the limit of current's object.
> +        # We first look for the next message, either client or server. If none
> +        # is avaible, we set the end of the text as limit.
> +        if c == -1 and s != -1:
> +            end = s
> +        elif c != -1 and s == -1:
> +            end = c
> +        elif c != -1 and s != -1:
> +            end = (c < s) and c or s

pylint advises

    scripts/qapi/dumpexamples.py:91:12: R1706: Consider using ternary (c if c < s else s) (consider-using-ternary)

> +        else:
> +            end = len(text) - 1
> +
> +        message, error = next_object(text, start, end, context)
> +        if error:
> +            failed = True
> +
> +        if len(message) > 0:
> +            message_type = "return"
> +            if "execute" in message:
> +                message_type = "command"
> +            elif "event" in message:
> +                message_type = "event"
> +
> +            target.append({
> +                "sequence-order": count,
> +                "message-type": message_type,
> +                "message": message
> +            })
> +            count += 1
> +
> +    examples.append({"client": clients, "server": servers})
> +    return examples, failed
> +
> +
> +def parse_examples_of(self: QAPISchemaGenExamplesVisitor,

Uh, shouldn't this be a method of QAPISchemaGenExamplesVisitor?

> +                      name: str):
> +
> +    assert(name in self.schema._entity_dict)

Makes both pycodestyle and pylint unhappy.  Better:

       assert name in self.schema._entity_dict

pylint warns

    scripts/qapi/dumpexamples.py:120:19: W0212: Access to a protected member _entity_dict of a client class (protected-access)

here and two more times below.

> +    obj = self.schema._entity_dict[name]
> +
> +    if not obj.info.pragma.doc_required:
> +        return
> +
> +    assert((obj.doc is not None))

Better:

       assert obj.doc is not None

> +    module_name = obj._module.name
> +
> +    # We initialize random with the name so that we get consistent example
> +    # ids over different generations. The ids of a given example might
> +    # change when adding/removing examples, but that's acceptable as the
> +    # goal is just to grep $id to find what example failed at a given test
> +    # with minimum chorn over regenerating.

churn from?

> +    random.seed(name, version=2)

You're reinitializing the global PRNG.  Feels unclean.  Create your own
here?

> +
> +    for s in obj.doc.sections:
> +        if s.name != "Example":

docs/devel/qapi-code-gen.rst section "Definition documentation":

    A tagged section starts with one of the following words:
    "Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
    The section ends with the start of a new section.

You're missing "Examples".

docs/sphinx/qapidoc.py uses s.name.startswith('Example').

> +            continue
> +
> +        if module_name not in self.target:
> +            self.target[module_name] = []
> +
> +        context = f'''{name} at {obj.info.fname}:{obj.info.line}'''
> +        examples, failed = parse_text_to_dicts(s.text, context)
> +        if failed:
> +            # To warn user that docs needs fixing
> +            self.failed = True
> +
> +        for example in examples:
> +            self.target[module_name].append({
> +                    "id": get_id(random, 10),
> +                    "client": example["client"],
> +                    "server": example["server"]
> +            })
> +
> +
> +class QAPISchemaGenExamplesVisitor(QAPISchemaVisitor):
> +
> +    def __init__(self, prefix: str):
> +        super().__init__()
> +        self.target = {}

@target maps what to what?

> +        self.schema = None
> +        self.failed = False
> +
> +    def visit_begin(self, schema):
> +        self.schema = schema
> +
> +    def visit_end(self):
> +        self.schema = None
> +        assert not self.failed, "Should fix the docs"

Unless I'm misreading the code, this asserts "all the examples parse
fine."  Misuse of assert for reporting errors.

> +
> +    def write(self: QAPISchemaGenExamplesVisitor,
> +              output_dir: str) -> None:
> +        for filename, content in self.target.items():
> +            pathname = os.path.join(output_dir, "examples", filename)
> +            odir = os.path.dirname(pathname)
> +            os.makedirs(odir, exist_ok=True)
> +            result = {"examples": content}
> +
> +            with open(pathname, "w") as outfile:

pylint warns

    scripts/qapi/dumpexamples.py:180:17: W1514: Using open without explicitly specifying an encoding (unspecified-encoding)

Recommend to pass encoding='utf=8'.

> +                outfile.write(json.dumps(result, indent=2, sort_keys=True))
> +
> +    def visit_command(self: QAPISchemaGenExamplesVisitor,
> +                      name: str,
> +                      info: Optional[QAPISourceInfo],
> +                      ifcond: QAPISchemaIfCond,
> +                      features: List[QAPISchemaFeature],
> +                      arg_type: Optional[QAPISchemaObjectType],
> +                      ret_type: Optional[QAPISchemaType],
> +                      gen: bool,
> +                      success_response: bool,
> +                      boxed: bool,
> +                      allow_oob: bool,
> +                      allow_preconfig: bool,
> +                      coroutine: bool) -> None:
> +
> +        if gen:
> +            parse_examples_of(self, name)

Why only if gen?

> +
> +    def visit_event(self: QAPISchemaGenExamplesVisitor,
> +                    name: str,
> +                    info: Optional[QAPISourceInfo],
> +                    ifcond: QAPISchemaIfCond,
> +                    features: List[QAPISchemaFeature],
> +                    arg_type: Optional[QAPISchemaObjectType],
> +                    boxed: bool):
> +
> +        parse_examples_of(self, name)

Examples in definition comments for types are silently ignored.  Should
we do something with them?

> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..9482439fa9 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -13,6 +13,7 @@
>  
>  from .commands import gen_commands
>  from .common import must_match
> +from .dumpexamples import gen_examples
>  from .error import QAPIError
>  from .events import gen_events
>  from .introspect import gen_introspect
> @@ -53,7 +54,7 @@ def generate(schema_file: str,
>      gen_commands(schema, output_dir, prefix, gen_tracing)
>      gen_events(schema, output_dir, prefix)
>      gen_introspect(schema, output_dir, prefix, unmask)
> -
> +    gen_examples(schema, output_dir, prefix)
>  
>  def main() -> int:
>      """

You provide some type annotations, but mypy isn't happy:

    $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi/dumpexamples.py 
    scripts/qapi/parser.py:566: error: Function is missing a return type annotation
    scripts/qapi/parser.py:570: error: Function is missing a return type annotation
    scripts/qapi/dumpexamples.py:44: error: Function is missing a type annotation for one or more arguments
    scripts/qapi/dumpexamples.py:49: error: Function is missing a type annotation for one or more arguments
    scripts/qapi/dumpexamples.py:49: error: Syntax error in type annotation
    scripts/qapi/dumpexamples.py:49: note: Suggestion: Use Tuple[T1, ..., Tn] instead of (T1, ..., Tn)
    scripts/qapi/dumpexamples.py:65: error: Syntax error in type annotation
    scripts/qapi/dumpexamples.py:65: note: Suggestion: Use Tuple[T1, ..., Tn] instead of (T1, ..., Tn)
    scripts/qapi/dumpexamples.py:66: error: Need type annotation for "clients" (hint: "clients: List[<type>] = ...")
    scripts/qapi/dumpexamples.py:66: error: Need type annotation for "servers" (hint: "servers: List[<type>] = ...")
    scripts/qapi/dumpexamples.py:117: error: Function is missing a return type annotation
    scripts/qapi/dumpexamples.py:120: error: "None" has no attribute "_entity_dict"
    scripts/qapi/dumpexamples.py:121: error: "None" has no attribute "_entity_dict"
    scripts/qapi/dumpexamples.py:161: error: Need type annotation for "target" (hint: "target: Dict[<type>, <type>] = ...")
    scripts/qapi/dumpexamples.py:165: error: Function is missing a type annotation
    scripts/qapi/dumpexamples.py:168: error: Function is missing a return type annotation
    scripts/qapi/dumpexamples.py:168: note: Use "-> None" if function does not return a value
    scripts/qapi/dumpexamples.py:200: error: Function is missing a return type annotation
    Found 15 errors in 2 files (checked 1 source file)

I think before I dig deeper, we should discuss my findings so far.


Here's my .pylintrc, in case you want to run pylint yourself:

disable=
    consider-using-f-string,
    fixme,
    invalid-name,
    missing-docstring,
    too-few-public-methods,
    too-many-arguments,
    too-many-branches,
    too-many-instance-attributes,
    too-many-lines,
    too-many-locals,
    too-many-statements,
    unused-argument,
    unused-wildcard-import,


