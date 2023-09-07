Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C2797BFC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJpe-0002mq-Jm; Thu, 07 Sep 2023 14:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qeJpZ-0002lX-1J
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qeJpV-0006UC-RJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694111651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/VbRgs5tnLENG11aku8cewE5arstVvJjq4jn8jdHLY=;
 b=NoteIoyDDIA8l8ugu1il0HiAK9v0RXUqCtM2POVyl9BVdf0+YOYde68bDJS+oClKHmrkkf
 ZJm0ROBsD+l0Nmojn3NwRnR9oznhEvhN2FU2Rq6F4ratToDXTu+Rz0KE9hSmzhEZmcTima
 Ifmp1MLOaCM378/Q6R3ZofMhbsGPFiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-gjYEg4S0P-Ke07cuSb-svQ-1; Thu, 07 Sep 2023 14:34:09 -0400
X-MC-Unique: gjYEg4S0P-Ke07cuSb-svQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F40D3101A529
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 18:34:08 +0000 (UTC)
Received: from localhost (unknown [10.45.225.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62DA52026D76;
 Thu,  7 Sep 2023 18:34:08 +0000 (UTC)
Date: Thu, 7 Sep 2023 20:34:07 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/7] qapi: scripts: add a generator for qapi's examples
Message-ID: <smjkujz2ogjqma2gfoznpaziiwvnjhdep4na2cyifwr3ipnhcn@3wckktjnad2w>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <20230905194846.169530-2-victortoso@redhat.com>
 <ZPhDSD+qn66GmS0i@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dlsyvw2tfaaxubwt"
Content-Disposition: inline
In-Reply-To: <ZPhDSD+qn66GmS0i@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--dlsyvw2tfaaxubwt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 06, 2023 at 10:15:52AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Sep 05, 2023 at 09:48:40PM +0200, Victor Toso wrote:
> > This generator has two goals:
> >  1. Mechanical validation of QAPI examples
> >  2. Generate the examples in a JSON format to be consumed for extra
> >     validation.
> >=20
> > The generator iterates over every Example section, parsing both server
> > and client messages. The generator prints any inconsistency found, for
> > example:
> >=20
> >  |  Error: Extra data: line 1 column 39 (char 38)
> >  |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
> >  |  Data: {"execute": "cancel-vcpu-dirty-limit"},
> >  |      "arguments": { "cpu-index": 1 } }
> >=20
> > The generator will output other JSON file with all the examples in the
> > QAPI module that they came from. This can be used to validate the
> > introspection between QAPI/QMP to language bindings, for example:
> >=20
> >  | { "examples": [
> >  |   {
> >  |     "id": "ksuxwzfayw",
> >  |     "client": [
> >  |     {
> >  |       "sequence-order": 1
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
> >  |      "message-type": "return",
> >  |      "message": { "return": {} },
> >  |    } ]
> >  |    }
> >  |  ] }
> >=20
> > Note that the order matters, as read by the Example section and
> > translated into "sequence-order". A language binding project can then
> > consume this files to Marshal and Unmarshal, comparing if the results
> > are what is to be expected.
> >=20
> > RFC discussion:
> >     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/dumpexamples.py | 194 +++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py         |   2 +
> >  2 files changed, 196 insertions(+)
> >  create mode 100644 scripts/qapi/dumpexamples.py
> >=20
> > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> > new file mode 100644
> > index 0000000000..c14ed11774
> > --- /dev/null
> > +++ b/scripts/qapi/dumpexamples.py
> > @@ -0,0 +1,194 @@
> > +"""
> > +Dump examples for Developers
> > +"""
> > +# Copyright (c) 2022 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Victor Toso <victortoso@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.
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
> > +
> > +
> > +def get_id(random, size: int) -> str:
> > +    letters =3D string.ascii_lowercase
> > +    return ''.join(random.choice(letters) for i in range(size))
> > +
> > +
> > +def next_object(text, start, end, context) -> Dict:
> > +    # Start of json object
> > +    start =3D text.find("{", start)
> > +    end =3D text.rfind("}", start, end+1)
> > +
> > +    # try catch, pretty print issues
> > +    try:
> > +        ret =3D json.loads(text[start:end+1])
> > +    except Exception as e:
> > +        print("Error: {}\nLocation: {}\nData: {}\n".format(
> > +              str(e), context, text[start:end+1]))
>=20
> This prints an error, but the caller ignores this and carries on
> as normal.
>=20
> After applying this series, we still have multiple errors being
> printed on console

The first one is a easy to fix error. The other two are more
related to metadata inserted in valid examples, see:

> Error: Expecting ',' delimiter: line 12 column 19 (char 336)
> Location: query-blockstats at ../storage-daemon/qapi/../../qapi/block-cor=
e.json:1259

Indeed.
=20
> Error: Expecting property name enclosed in double quotes: line 7 column 1=
9 (char 264)
> Location: query-rocker-of-dpa-flows at ../qapi/rocker.json:256

    251 #                   "mask": {"in-pport": 4294901760}
    252 #                  },
 -> 253 #                  {...more...},
    254 #    ]}

>=20
> Error: Expecting value: line 28 column 15 (char 775)
> Location: query-spice at ../qapi/ui.json:372

    365 #                "tls": false
    366 #             },
 -> 367 #             [ ... more channels follow ... ]
    368 #          ]

It would be good to have some sort of annotation for a valid
example, to express this is a long list and we are not putting
all of it here.

> If we have errors detected, we need to terminate the build by
> making the generator exit, to force fixing of the problems.

I agree. We just need to decided what to do with the above
mentioned extra metadata.

> This patch then needs to be moved to the end of the series, as
> we need all the fixes applied to the schemas, before we enable
> validation, to avoid breaking 'git bisect' build tests.

Makes sense. The rest of the series is not really dependent on
this one, so it can be applied if one wants it.

This patch needs rework at very least to not break the
test-suite.

Cheers,
Victor

> > +        return {}
> > +    else:
> > +        return ret
> > +
> > +
> > +def parse_text_to_dicts(text: str, context: str) -> List[Dict]:
> > +    examples, clients, servers =3D [], [], []
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
> > +        else:
> > +            end =3D len(text) - 1
> > +
> > +        message =3D next_object(text, start, end, context)
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
> > +    return examples
> > +
> > +
> > +def parse_examples_of(self: QAPISchemaGenExamplesVisitor,
> > +                      name: str):
> > +
> > +    assert(name in self.schema._entity_dict)
> > +    obj =3D self.schema._entity_dict[name]
> > +    assert((obj.doc is not None))
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
> > +    random.seed(name, version=3D2)
> > +
> > +    for s in obj.doc.sections:
> > +        if s.name !=3D "Example":
> > +            continue
> > +
> > +        if module_name not in self.target:
> > +            self.target[module_name] =3D []
> > +
> > +        context =3D f'''{name} at {obj.info.fname}:{obj.info.line}'''
> > +        examples =3D parse_text_to_dicts(s.text, context)
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
> > +        self.schema =3D None
> > +
> > +    def visit_begin(self, schema):
> > +        self.schema =3D schema
> > +
> > +    def visit_end(self):
> > +        self.schema =3D None
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
> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 316736b6a2..cf9beac3c9 100644
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
> > @@ -54,6 +55,7 @@ def generate(schema_file: str,
> >      gen_events(schema, output_dir, prefix)
> >      gen_introspect(schema, output_dir, prefix, unmask)
> > =20
> > +    gen_examples(schema, output_dir, prefix)
> > =20
> >  def main() -> int:
> >      """
> > --=20
> > 2.41.0
> >=20
> >=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--dlsyvw2tfaaxubwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmT6F58ACgkQl9kSPeN6
SE/yuw/9Fy4hZwmdIg5aBqawtmFONm9nUnW1htCmrUCK3jRpPkIc1ArX5pQbqYUL
p2TrdvaUUpRnFwZXgqT91z8ADlHCL4Xe2v5ymcAwTr3dcfYsQVrL1iFj2nJZNviF
xs0Rgx9ctMA0CSTUSQfZDh59IkHcoxWiTy22ZIG/y+VTXV1WKioUOrq0LbFGFRHO
o6nvY8Fp9n69gPuQvsrIEpJ45l8jUOuaP6Ku0H89gAhZ4WiDqVn0VaL/UZS3aCol
k2LgCvHY5670U+NYiBk8DOZE0i+8GPZCHH13JoCMqbiN5zCj5eiO1A4l5m1fXYdg
p5XI5zJyLxRe52jbTwgUqEPXwidHcZPNQV9tI7WHCoFVhZ1UkVN4YJnGNGSab+dZ
Zay5zqf5GmFCLGVT5tVfcXSCBSfS3iAc5bsCfXyFGsgacSFS+CPGep5ApDaT2ZEd
tDRCl6Uxv/M2/0BMEX8jQbzKmTtCvTi9uCsPapkutY9zvhsec34uRCPQYac0Wso+
WrPpCEUuEurgrl9+m5boEPgaWzWfjlw67U11EKnEXaZKnemDRpiAu5MjZZwS2gRd
jBkGsX2/U8s9ebvfXoC8HEHdUGgITaPGJ46CDRoKjta4+p3QK7Z/27/+D63oeFYD
YdkgMYBj7WhN84MXNSPkUpe/WdNB3PnhQiWxHILekwCbfo+yZ10=
=8SsK
-----END PGP SIGNATURE-----

--dlsyvw2tfaaxubwt--


