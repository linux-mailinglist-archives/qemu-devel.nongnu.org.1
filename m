Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF3797B7B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJZv-0005cG-Hx; Thu, 07 Sep 2023 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qeJZt-0005Uj-Iq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qeJZq-0006c2-Hb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694110679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtK92lei6BcPi6dRi41+QP9ZlFQdZZNU0tBmzaFMt2s=;
 b=HloOIfIzb03lI7CDnC3RIB0ot+ZltoOHB4pAooXw1Mui6/laW2AYV0OzR47F9HgecsBiLF
 oRgjduOTCMzCHjKCk3M+9PWwbNFPwEiFsw5moOVZ7Xe1NxsxXy2JNSqMqiw2eC/6K8cNbS
 uCGiZgeiO3maJG4OhI874Oy4Edmjh4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-BiUjq59KNMis6BbgL3sSjw-1; Thu, 07 Sep 2023 14:17:57 -0400
X-MC-Unique: BiUjq59KNMis6BbgL3sSjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8C0B80523C
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 18:17:56 +0000 (UTC)
Received: from localhost (unknown [10.45.225.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67DA21121314;
 Thu,  7 Sep 2023 18:17:56 +0000 (UTC)
Date: Thu, 7 Sep 2023 20:17:55 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/7] Validate and test qapi examples
Message-ID: <ixihnxsvwqtozpdfb5kavkjymflhdktgiq3bddpqqqjbnwyaid@cjgi7bofphbc>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <ZPhDkJ+RvPauLfG6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lbqp7apl4px7za2e"
Content-Disposition: inline
In-Reply-To: <ZPhDkJ+RvPauLfG6@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--lbqp7apl4px7za2e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the quick review Daniel!

On Wed, Sep 06, 2023 at 10:17:04AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Sep 05, 2023 at 09:48:39PM +0200, Victor Toso wrote:
> > Hi,
> >=20
> > This is a follow up from the RFC sent in the end of 08-2022:
> >     https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04525.html
> >=20
> > The generator code was rebased, without conflicts. The commit log was
> > improved as per Markus suggestion [0], altough I'm sure it can be
> > improved further.
> >=20
> > To clarify, consuming the Examples as data for testing the qapi-go
> > work has been very very helpful. I'm positive it can be of use for other
> > bindings in the future, besides keeping the examples functional
> >=20
> > Cheers,
> >=20
> > [0] https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04682.html
> >=20
> > Victor Toso (7):
> >   qapi: scripts: add a generator for qapi's examples
> >   qapi: fix example of get-win32-socket command
> >   qapi: fix example of dumpdtb command
> >   qapi: fix example of cancel-vcpu-dirty-limit command
> >   qapi: fix example of set-vcpu-dirty-limit command
> >   qapi: fix example of calc-dirty-rate command
> >   qapi: fix example of NETDEV_STREAM_CONNECTED event
> >=20
> >  qapi/machine.json            |   2 +-
> >  qapi/migration.json          |   6 +-
> >  qapi/misc.json               |   2 +-
> >  qapi/net.json                |   6 +-
> >  scripts/qapi/dumpexamples.py | 194 +++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py         |   2 +
> >  6 files changed, 204 insertions(+), 8 deletions(-)
> >  create mode 100644 scripts/qapi/dumpexamples.py
>=20
> After applying this series, aside from the extra broken examples
> mentioned in my patch 1 comments, I also see a test suite failure
> during build

My bad.

> FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h tests/qapi-=
builtin-visit.c tests/qapi-builtin-visit.h tests/test-qapi-commands-sub-sub=
-module.c tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-command=
s.c tests/test-qapi-commands.h tests/test-qapi-emit-events.c tests/test-qap=
i-emit-events.h tests/test-qapi-events-sub-sub-module.c tests/test-qapi-eve=
nts-sub-sub-module.h tests/test-qapi-events.c tests/test-qapi-events.h test=
s/test-qapi-init-commands.c tests/test-qapi-init-commands.h tests/test-qapi=
-introspect.c tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-mo=
dule.c tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c tests=
/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c tests/test-qapi-v=
isit-sub-sub-module.h tests/test-qapi-visit.c tests/test-qapi-visit.h=20
> /home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /home/berrange/src/=
virt/qemu/scripts/qapi-gen.py -o /home/berrange/src/virt/qemu/build/tests -=
b -p test- ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
> Traceback (most recent call last):
>   File "/home/berrange/src/virt/qemu/scripts/qapi-gen.py", line 19, in <m=
odule>
>     sys.exit(main.main())
>              ^^^^^^^^^^^
>   File "/home/berrange/src/virt/qemu/scripts/qapi/main.py", line 96, in m=
ain
>     generate(args.schema,
>   File "/home/berrange/src/virt/qemu/scripts/qapi/main.py", line 58, in g=
enerate
>     gen_examples(schema, output_dir, prefix)
>   File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line =
40, in gen_examples
>     schema.visit(vis)
>   File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 1227, =
in visit
>     mod.visit(visitor)
>   File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 209, i=
n visit
>     entity.visit(visitor)
>   File "/home/berrange/src/virt/qemu/scripts/qapi/schema.py", line 857, i=
n visit
>     visitor.visit_command(
>   File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line =
184, in visit_command
>     parse_examples_of(self, name)
>   File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line =
118, in parse_examples_of
>     assert((obj.doc is not None))
>             ^^^^^^^^^^^^^^^^^^^
> AssertionError
> ninja: build stopped: subcommand failed.
>=20
> not sure if that's related to the examples that still need fixing or not ?

This is related to the script being fed with data without
documentation. In general, asserting should be the right approach
because we don't want API without docs but this failure comes
=66rom the tests, that is, adding the following diff:

diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
index c14ed11774..a961c0575d 100644
--- a/scripts/qapi/dumpexamples.py
+++ b/scripts/qapi/dumpexamples.py
@@ -115,6 +115,10 @@ def parse_examples_of(self:
QAPISchemaGenExamplesVisitor,

     assert(name in self.schema._entity_dict)
     obj =3D self.schema._entity_dict[name]
+    if obj.doc is None:
+        print(f"{name} does not have documentation")
+        return
+
     assert((obj.doc is not None))
     module_name =3D obj._module.name

gives:

    user-def-cmd0 does not have documentation
    user-def-cmd does not have documentation
    user-def-cmd1 does not have documentation
    user-def-cmd2 does not have documentation
    cmd-success-response does not have documentation
    coroutine-cmd does not have documentation
    guest-get-time does not have documentation
    guest-sync does not have documentation
    boxed-struct does not have documentation
    boxed-union does not have documentation
    boxed-empty does not have documentation
    test-flags-command does not have documentation
    EVENT_A does not have documentation
    EVENT_B does not have documentation
    EVENT_C does not have documentation
    EVENT_D does not have documentation
    EVENT_E does not have documentation
    EVENT_F does not have documentation
    EVENT_G does not have documentation
    __ORG.QEMU_X-EVENT does not have documentation
    __org.qemu_x-command does not have documentation
    test-if-union-cmd does not have documentation
    test-if-alternate-cmd does not have documentation
    test-if-cmd does not have documentation
    test-cmd-return-def-three does not have documentation
    TEST_IF_EVENT does not have documentation
    TEST_IF_EVENT2 does not have documentation
    test-features0 does not have documentation
    test-command-features1 does not have documentation
    test-command-features3 does not have documentation
    test-command-cond-features1 does not have documentation
    test-command-cond-features2 does not have documentation
    test-command-cond-features3 does not have documentation
    TEST_EVENT_FEATURES0 does not have documentation
    TEST_EVENT_FEATURES1 does not have documentation
    TEST_EVENT_FEATURES2 does not have documentation

So, not sure if we should:
 1. Avoid asserting when running with tests
 2. Avoid running this generator with tests
 3. Add some minimal docs to the tests

Both (1) and (2) are quite simple. Not sure if there is real
benefit in (3). If we should tweak qemu tests with this, should
be related to using the JSON output itself, to keep examples
correct.

Cheers,
Victor

--lbqp7apl4px7za2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIxBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmT6E9MACgkQl9kSPeN6
SE8/eQ/vSRD7Yi6WE7EjH2d7YdlEEpqnMm9XXMHEA+/fb6MK5EUexkJEr3Q/ZvjZ
NtaZAxjvN0uuXnq+HGEY2I0R+UyC8cUm7pz9eLiZ8+GQlGvrOONuNv3q1twcS1UR
ZXkiQ6N7Z3zY7RcT45DrfnzdfH348gyzmv17hDfpWGEqxAQNj5x4FJkjqNNF093L
pj8erIf2OK9U1RaRwBDl7Br+mv3T4wk5HohAGsUXKTUl1aZCZBrMep3Ihuezp0N5
KO//dQGN6AxBxEHJ8Atjh/O9kdsH1XJqSLRANc0NAYqIG2UgZbx+KXZYFH5mZwY0
rlfgPy3xkXPqo15rXN7RTKX92fr35/qXYGbwAzI0DmNfmMl1HnyIonwHxqXSG8zJ
I8On9Im7zkhoiDHO0F0t8DNLcl09zhPK+k/crWDdGiYt6MjEr75AH8LVB1kqyDS8
RoGV7x7CYzUuvmyRSgG5d4TK1fXMcng5bTUGTyZkfiGrlVVB11Hv9WNKo5A1xYP1
tUFNfo3LrXUHGBRSX/EYhafOi1C1/+DnJvVULDHJoP7nnJFRFoFklFv8B6N5iHji
McHqEyNNKjjtKVOf2WQtO0IoiqQkSQXkmsdL/a5S+OYj/ly/J3r2GVJ2gPTHxBwc
ByS48/LFl8S3jWwpHV+rrJon6VcFXDDSug8/m43+EG1CYhwT
=k5y/
-----END PGP SIGNATURE-----

--lbqp7apl4px7za2e--


