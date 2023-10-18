Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E707CE7D0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCKe-0002Pr-HI; Wed, 18 Oct 2023 15:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qtCKc-0002Pi-Fl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qtCKZ-0006HU-Au
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697657746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVQxu9oAqDpEhRkqXdqLBNVPrpqM5vnhvTMD/L/0WoE=;
 b=KOLXDSGEZusPMqytoXbwb41T87JkOyDYrBeDPmRx60A+zBDcA/Y4bfpEpCU4FanHBRBNEb
 cx6MXsJ20NA7Eh4Ft8CrRRoIAVU4KmOU2bubOIgn6HzZp5FuVm/y0DgY2OV45gNzGN1qkM
 vGRgfxELg9JrGYYRORm8sxSvUlFQ0To=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-eo8aC30ZNj6CiJi-eggm4Q-1; Wed, 18 Oct 2023 15:35:44 -0400
X-MC-Unique: eo8aC30ZNj6CiJi-eggm4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3DE6185A7B9
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 19:35:43 +0000 (UTC)
Received: from localhost (unknown [10.45.224.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 482BF2166B26;
 Wed, 18 Oct 2023 19:35:43 +0000 (UTC)
Date: Wed, 18 Oct 2023 21:35:41 +0200
From: Victor Toso <victortoso@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 10/10] qapi: scripts: add a generator for qapi's
 examples
Message-ID: <gfsdkqobnul2i6mgfwe2w3pwtvjf3db34ntpo3oo253eh6gyqe@5gc25wboaocl>
References: <20230919201857.675913-1-victortoso@redhat.com>
 <20230919201857.675913-11-victortoso@redhat.com>
 <87o7hv7ply.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qdae4hnzqmthssxe"
Content-Disposition: inline
In-Reply-To: <87o7hv7ply.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--qdae4hnzqmthssxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Sorry the delay on reply here.

On Thu, Sep 21, 2023 at 01:06:01PM +0200, Markus Armbruster wrote:
> Victor Toso <victortoso@redhat.com> writes:
>=20
> > This generator has two goals:
> >  1. Mechanical validation of QAPI examples
> >  2. Generate the examples in a JSON format to be consumed for extra
> >     validation.
> >
> > The generator iterates over every Example section, parsing both server
> > and client messages. The generator prints any inconsistency found, for
> > example:
> >
> >  |  Error: Extra data: line 1 column 39 (char 38)
> >  |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
> >  |  Data: {"execute": "cancel-vcpu-dirty-limit"},
> >  |      "arguments": { "cpu-index": 1 } }
>=20
> What language does it parse?

It parsers the Example section. Fetches client and server JSON
messages. Validate them.

> Can you give a grammar?

Not sure if needed? I just fetch the json from the example
section and validate it.
=20
> Should the parser be integrated into the doc parser, i.e. class QAPIDoc?

Yes, that would be better. I'll try that in the next iteration.

> > The generator will output other JSON file with all the examples in the
>=20
> Another JSON file, or other JSON files?

JSON files. QEMU'S QAPI qapi/migration.json will generate a
migration.json with the format mentioned bellow.
>=20
> > QAPI module that they came from. This can be used to validate the
> > introspection between QAPI/QMP to language bindings, for example:
> >
> >  | { "examples": [
> >  |   {
> >  |     "id": "ksuxwzfayw",
> >  |     "client": [
> >  |     {
> >  |       "sequence-order": 1
>=20
> Missing comma
>=20
> >  |       "message-type": "command",
> >  |       "message":
> >  |       { "arguments":
> >  |         { "device": "scratch", "size": 1073741824 },
> >  |         "execute": "block_resize"
> >  |       },
> >  |    } ],
> >  |    "server": [
> >  |    {
> >  |      "sequence-order": 2
>=20
> Another one.
>=20
> >  |      "message-type": "return",
> >  |      "message": { "return": {} },
>=20
> Extra comma.
>=20
> >  |    } ]
> >  |    }
> >  |  ] }
>=20
> Indentation is kind of weird.

The missing comma was likely my fault on copy & paste.  The
indentation should be what json.dumps() provides, but I think I
changed somehow in the git log too.
=20
> The JSON's Valid structure and semantics are not documented.
> We've developed a way specify that, you might've heard of it,
> it's called "QAPI schema" ;-P
>=20
> Kidding aside, we've done this before.  E.g. docs/interop/firmware.json
> specifies firmware descriptors.  We have some in pc-bios/descriptors/.

Oh, that's neat. You meant to use QAPI schema as a way to
document output from examples.py?
=20
> > Note that the order matters, as read by the Example section and
> > translated into "sequence-order". A language binding project can then
> > consume this files to Marshal and Unmarshal, comparing if the results
> > are what is to be expected.
> >
> > RFC discussion:
> >     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/dumpexamples.py | 208 +++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py         |   3 +-
> >  2 files changed, 210 insertions(+), 1 deletion(-)
> >  create mode 100644 scripts/qapi/dumpexamples.py
> >
> > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> > new file mode 100644
> > index 0000000000..55d9f13ab7
> > --- /dev/null
> > +++ b/scripts/qapi/dumpexamples.py
>=20
> Let's name this examples.py.  It already does a bit more than
> dump (namely validate), and any future code dealing with
> examples will likely go into this file.

Ack.

> > @@ -0,0 +1,208 @@
> > +"""
> > +Dump examples for Developers
> > +"""
> > +# Copyright (c) 2023 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Victor Toso <victortoso@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.
>=20
> We should've insisted on v2+ for the QAPI generator back when we had a
> chance.  *Sigh*

:)
=20
> > +# See the COPYING file in the top-level directory.
> > +
> > +# Just for type hint on self
> > +from __future__ import annotations
> > +
> > +import os
> > +import json
> > +import random
> > +import string
> > +
> > +from typing import Dict, List, Optional
> > +
> > +from .schema import (
> > +    QAPISchema,
> > +    QAPISchemaType,
> > +    QAPISchemaVisitor,
> > +    QAPISchemaEnumMember,
> > +    QAPISchemaFeature,
> > +    QAPISchemaIfCond,
> > +    QAPISchemaObjectType,
> > +    QAPISchemaObjectTypeMember,
> > +    QAPISchemaVariants,
>=20
> pylint warns
>=20
>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaEnumMember=
 imported from schema (unused-import)
>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaObjectType=
Member imported from schema (unused-import)
>     scripts/qapi/dumpexamples.py:22:0: W0611: Unused QAPISchemaVariants i=
mported from schema (unused-import)

Yes, now I learned a few tricks around python linters and
formatting. Next iteration will be better.
=20
> > +)
> > +from .source import QAPISourceInfo
> > +
> > +
> > +def gen_examples(schema: QAPISchema,
> > +                 output_dir: str,
> > +                 prefix: str) -> None:
> > +    vis =3D QAPISchemaGenExamplesVisitor(prefix)
> > +    schema.visit(vis)
> > +    vis.write(output_dir)
>=20
> The other backends have this at the end of the file.  Either order
> works, but consistency is nice.

Ok.
=20
> > +
> > +
> > +def get_id(random, size: int) -> str:
>=20
> pylint warns
>=20
>     scripts/qapi/dumpexamples.py:44:11: W0621: Redefining name
>     'random' from outer scope (line 17) (redefined-outer-name)
>=20
> > +    letters =3D string.ascii_lowercase
> > +    return ''.join(random.choice(letters) for i in range(size))
> > +
> > +
> > +def next_object(text, start, end, context) -> (Dict, bool):
> > +    # Start of json object
> > +    start =3D text.find("{", start)
> > +    end =3D text.rfind("}", start, end+1)
>=20
> Single quotes, please, for consistency with quote use elsewhere.
>=20
> Rules of thumb:
>=20
> * Double quotes for english text (e.g. error messages), so we don't have
>   to escape apostrophes.
>=20
> * Double quotes when they reduce the escaping
>=20
> * Else single quotes
>=20
> More elsewhere, not flagged.
>=20
> > +
> > +    # try catch, pretty print issues
>=20
> Is this comment useful?

I'll remove.
=20
> > +    try:
> > +        ret =3D json.loads(text[start:end+1])
> > +    except Exception as e:
>=20
> pylint warns
>=20
>     scripts/qapi/dumpexamples.py:57:11: W0703: Catching too general excep=
tion Exception (broad-except)
>=20
> Catch JSONDecodeError?

Ack.

> > +        print("Error: {}\nLocation: {}\nData: {}\n".format(
> > +              str(e), context, text[start:end+1]))
>=20
> Errors need to go to stderr.
>=20
> Have you considered using QAPIError to report these errors?

Did not cross my mind, no. I'll take a look.
=20
> > +        return {}, True
> > +    else:
> > +        return ret, False
> > +
> > +
> > +def parse_text_to_dicts(text: str, context: str) -> (List[Dict], bool):
>=20
> Before I review the parser, I'd like to know the (intended) language
> being parsed.

Ok, I'll add documentation about it in the next iteration.
=20
> > +    examples, clients, servers =3D [], [], []
> > +    failed =3D False
> > +
> > +    count =3D 1
> > +    c, s =3D text.find("->"), text.find("<-")
> > +    while c !=3D -1 or s !=3D -1:
> > +        if c =3D=3D -1 or (s !=3D -1 and s < c):
> > +            start, target =3D s, servers
> > +        else:
> > +            start, target =3D c, clients
> > +
> > +        # Find the client and server, if any
> > +        if c !=3D -1:
> > +            c =3D text.find("->", start + 1)
> > +        if s !=3D -1:
> > +            s =3D text.find("<-", start + 1)
> > +
> > +        # Find the limit of current's object.
> > +        # We first look for the next message, either client or server.=
 If none
> > +        # is avaible, we set the end of the text as limit.
> > +        if c =3D=3D -1 and s !=3D -1:
> > +            end =3D s
> > +        elif c !=3D -1 and s =3D=3D -1:
> > +            end =3D c
> > +        elif c !=3D -1 and s !=3D -1:
> > +            end =3D (c < s) and c or s
>=20
> pylint advises
>=20
>     scripts/qapi/dumpexamples.py:91:12: R1706: Consider using ternary (c =
if c < s else s) (consider-using-ternary)
>=20
> > +        else:
> > +            end =3D len(text) - 1
> > +
> > +        message, error =3D next_object(text, start, end, context)
> > +        if error:
> > +            failed =3D True
> > +
> > +        if len(message) > 0:
> > +            message_type =3D "return"
> > +            if "execute" in message:
> > +                message_type =3D "command"
> > +            elif "event" in message:
> > +                message_type =3D "event"
> > +
> > +            target.append({
> > +                "sequence-order": count,
> > +                "message-type": message_type,
> > +                "message": message
> > +            })
> > +            count +=3D 1
> > +
> > +    examples.append({"client": clients, "server": servers})
> > +    return examples, failed
> > +
> > +
> > +def parse_examples_of(self: QAPISchemaGenExamplesVisitor,
>=20
> Uh, shouldn't this be a method of QAPISchemaGenExamplesVisitor?

Indeed.
=20
> > +                      name: str):
> > +
> > +    assert(name in self.schema._entity_dict)
>=20
> Makes both pycodestyle and pylint unhappy.  Better:
>=20
>        assert name in self.schema._entity_dict
>=20
> pylint warns
>=20
>     scripts/qapi/dumpexamples.py:120:19: W0212: Access to a protected mem=
ber _entity_dict of a client class (protected-access)
>=20
> here and two more times below.

Thanks, I'll have all of those fixed.
=20
> > +    obj =3D self.schema._entity_dict[name]
> > +
> > +    if not obj.info.pragma.doc_required:
> > +        return
> > +
> > +    assert((obj.doc is not None))
>=20
> Better:
>=20
>        assert obj.doc is not None
>=20
> > +    module_name =3D obj._module.name
> > +
> > +    # We initialize random with the name so that we get consistent exa=
mple
> > +    # ids over different generations. The ids of a given example might
> > +    # change when adding/removing examples, but that's acceptable as t=
he
> > +    # goal is just to grep $id to find what example failed at a given =
test
> > +    # with minimum chorn over regenerating.
>=20
> churn from?

There is one id per example section. The idea of having an id is
that, if a test failed, we can easily find what test failed.

The comment tries to clarify that the goal is the id to be kept
intact (hence, we seed from its name), reducing the churn over
regenerating the output.
=20
> > +    random.seed(name, version=3D2)
>=20
> You're reinitializing the global PRNG.  Feels unclean.  Create your own
> here?

I don't see much a problem with it, but sure, feels like local
would be cleaner indeed.
=20
> > +
> > +    for s in obj.doc.sections:
> > +        if s.name !=3D "Example":
>=20
> docs/devel/qapi-code-gen.rst section "Definition documentation":
>=20
>     A tagged section starts with one of the following words:
>     "Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
>     The section ends with the start of a new section.
>=20
> You're missing "Examples".

Aha! I see several tests that I'm skipping, thanks! (19 Examples
sections)

> docs/sphinx/qapidoc.py uses s.name.startswith('Example').
>=20
> > +            continue
> > +
> > +        if module_name not in self.target:
> > +            self.target[module_name] =3D []
> > +
> > +        context =3D f'''{name} at {obj.info.fname}:{obj.info.line}'''
> > +        examples, failed =3D parse_text_to_dicts(s.text, context)
> > +        if failed:
> > +            # To warn user that docs needs fixing
> > +            self.failed =3D True
> > +
> > +        for example in examples:
> > +            self.target[module_name].append({
> > +                    "id": get_id(random, 10),
> > +                    "client": example["client"],
> > +                    "server": example["server"]
> > +            })
> > +
> > +
> > +class QAPISchemaGenExamplesVisitor(QAPISchemaVisitor):
> > +
> > +    def __init__(self, prefix: str):
> > +        super().__init__()
> > +        self.target =3D {}
>=20
> @target maps what to what?

Yes, lacking type hint and some documentation.

It is a dictionary that maps "filename" to an array of the
undocumented object. Each object has 3 fields:
    * "id"     : defines unique id for each test
    * "client" : object that wraps message sent by client (->)
    * "server" : object that wraps message sent by server (<-)

About client and server object, they contain 3 fields:
    * "message"      : The actual payload from the examples
                       section
    * "message-type" : Either "command", "return" or "event"
    * "sequence-order: (int) what index it had in the sequence of
                        examples section.

I'll have it properly documented.
=20
> > +        self.schema =3D None
> > +        self.failed =3D False
> > +
> > +    def visit_begin(self, schema):
> > +        self.schema =3D schema
> > +
> > +    def visit_end(self):
> > +        self.schema =3D None
> > +        assert not self.failed, "Should fix the docs"
>=20
> Unless I'm misreading the code, this asserts "all the examples parse
> fine."  Misuse of assert for reporting errors.
>=20
> > +
> > +    def write(self: QAPISchemaGenExamplesVisitor,
> > +              output_dir: str) -> None:
> > +        for filename, content in self.target.items():
> > +            pathname =3D os.path.join(output_dir, "examples", filename)
> > +            odir =3D os.path.dirname(pathname)
> > +            os.makedirs(odir, exist_ok=3DTrue)
> > +            result =3D {"examples": content}
> > +
> > +            with open(pathname, "w") as outfile:
>=20
> pylint warns
>=20
>     scripts/qapi/dumpexamples.py:180:17: W1514: Using open without explic=
itly specifying an encoding (unspecified-encoding)
>=20
> Recommend to pass encoding=3D'utf=3D8'.

Ack.

> > +                outfile.write(json.dumps(result, indent=3D2, sort_keys=
=3DTrue))
> > +
> > +    def visit_command(self: QAPISchemaGenExamplesVisitor,
> > +                      name: str,
> > +                      info: Optional[QAPISourceInfo],
> > +                      ifcond: QAPISchemaIfCond,
> > +                      features: List[QAPISchemaFeature],
> > +                      arg_type: Optional[QAPISchemaObjectType],
> > +                      ret_type: Optional[QAPISchemaType],
> > +                      gen: bool,
> > +                      success_response: bool,
> > +                      boxed: bool,
> > +                      allow_oob: bool,
> > +                      allow_preconfig: bool,
> > +                      coroutine: bool) -> None:
> > +
> > +        if gen:
> > +            parse_examples_of(self, name)
>=20
> Why only if gen?

I honestly don't remember. I'll test it out and document it
properly.
=20
> > +
> > +    def visit_event(self: QAPISchemaGenExamplesVisitor,
> > +                    name: str,
> > +                    info: Optional[QAPISourceInfo],
> > +                    ifcond: QAPISchemaIfCond,
> > +                    features: List[QAPISchemaFeature],
> > +                    arg_type: Optional[QAPISchemaObjectType],
> > +                    boxed: bool):
> > +
> > +        parse_examples_of(self, name)
>=20
> Examples in definition comments for types are silently ignored.  Should
> we do something with them?

The more the merrier. I'll tackle it in the next iteration too.
=20
> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 316736b6a2..9482439fa9 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -13,6 +13,7 @@
> > =20
> >  from .commands import gen_commands
> >  from .common import must_match
> > +from .dumpexamples import gen_examples
> >  from .error import QAPIError
> >  from .events import gen_events
> >  from .introspect import gen_introspect
> > @@ -53,7 +54,7 @@ def generate(schema_file: str,
> >      gen_commands(schema, output_dir, prefix, gen_tracing)
> >      gen_events(schema, output_dir, prefix)
> >      gen_introspect(schema, output_dir, prefix, unmask)
> > -
> > +    gen_examples(schema, output_dir, prefix)
> > =20
> >  def main() -> int:
> >      """
>=20
> You provide some type annotations, but mypy isn't happy:
>=20
>     $ mypy --config-file scripts/qapi/mypy.ini scripts/qapi/dumpexamples.=
py=20
>     scripts/qapi/parser.py:566: error: Function is missing a return type =
annotation
>     scripts/qapi/parser.py:570: error: Function is missing a return type =
annotation
>     scripts/qapi/dumpexamples.py:44: error: Function is missing a type an=
notation for one or more arguments
>     scripts/qapi/dumpexamples.py:49: error: Function is missing a type an=
notation for one or more arguments
>     scripts/qapi/dumpexamples.py:49: error: Syntax error in type annotati=
on
>     scripts/qapi/dumpexamples.py:49: note: Suggestion: Use Tuple[T1, ...,=
 Tn] instead of (T1, ..., Tn)
>     scripts/qapi/dumpexamples.py:65: error: Syntax error in type annotati=
on
>     scripts/qapi/dumpexamples.py:65: note: Suggestion: Use Tuple[T1, ...,=
 Tn] instead of (T1, ..., Tn)
>     scripts/qapi/dumpexamples.py:66: error: Need type annotation for "cli=
ents" (hint: "clients: List[<type>] =3D ...")
>     scripts/qapi/dumpexamples.py:66: error: Need type annotation for "ser=
vers" (hint: "servers: List[<type>] =3D ...")
>     scripts/qapi/dumpexamples.py:117: error: Function is missing a return=
 type annotation
>     scripts/qapi/dumpexamples.py:120: error: "None" has no attribute "_en=
tity_dict"
>     scripts/qapi/dumpexamples.py:121: error: "None" has no attribute "_en=
tity_dict"
>     scripts/qapi/dumpexamples.py:161: error: Need type annotation for "ta=
rget" (hint: "target: Dict[<type>, <type>] =3D ...")
>     scripts/qapi/dumpexamples.py:165: error: Function is missing a type a=
nnotation
>     scripts/qapi/dumpexamples.py:168: error: Function is missing a return=
 type annotation
>     scripts/qapi/dumpexamples.py:168: note: Use "-> None" if function doe=
s not return a value
>     scripts/qapi/dumpexamples.py:200: error: Function is missing a return=
 type annotation
>     Found 15 errors in 2 files (checked 1 source file)
>=20
> I think before I dig deeper, we should discuss my findings so far.

Yes, I think I agreed with mostly of your suggestions. I'm
learning how to write proper python, so sorry that we saw many
basic lint failures here.
=20
> Here's my .pylintrc, in case you want to run pylint yourself:
>=20
> disable=3D
>     consider-using-f-string,
>     fixme,
>     invalid-name,
>     missing-docstring,
>     too-few-public-methods,
>     too-many-arguments,
>     too-many-branches,
>     too-many-instance-attributes,
>     too-many-lines,
>     too-many-locals,
>     too-many-statements,
>     unused-argument,
>     unused-wildcard-import,

Thanks again for the review, I really appreciate it.

Cheers,
Victor

--qdae4hnzqmthssxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUwM40ACgkQl9kSPeN6
SE+RtQ/+I+i9u7x3Dp8JEB6ICfofgE0WjgTVBpXZDOirp48heMYmNpFXCWajWVvh
kXk+yLx+nYsPROTtTOGZOnxPfCuoLFU/gFypjRoEDfYUW/4UT77o9aCgb26mBFtn
ngNQYeGCopt3k8CxVcqdMQaBVb6UKU6a0je2fRJ57pnZNF0S2v1AbSIr4a1g4kPp
1eCVl8KgChJs4BppxTe7nSBv8T8mDUUcrVEDqpX+mrurKUtoCClJkksUkt6DkK0s
+AV3U5sSvlolSykfxvp0rDxBwnwVRB9Eb6Nb3PxkxjYFaa779Jk/+kbvXYUGWQfS
CLURvTkrKUy5+3wWPfSQG2cSNWY6oKtLxk0s3L8czD2EAjbUndsdeClrwVi1d+6E
kDRErSALxhf83QopKBfrHJYPhxjcEz+W/jqMocCSjiLBmefHqIkwQ8NJptvS2Ddw
DyhRS6JzmRH4e+C5CSIRmDH7fkM3K97/jf82kyTtJ2ZjFst238s/Pk9JulS5B+UE
g6aS5+KeMqM+5B4BfXFAXL+esikS+oYsebrIkB/z5GEs7Q3/a4CdWZfnnuubNn39
R5siIjHKigaX9p6/ZtuMAaxMiAcMQL731PlhJhPAFtnJ1bA3XVxOILbQN7aqPpni
vEGAoOn0tnWwDHCvJWD7ytipod5+WmwyRHhbwtFzS9T2tYf0Gdo=
=JJ0J
-----END PGP SIGNATURE-----

--qdae4hnzqmthssxe--


