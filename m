Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8A47B6E66
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:25:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qniCR-0002iO-SV; Tue, 03 Oct 2023 12:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qniCP-0002i2-KN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:24:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qniCI-00034W-Pc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:24:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 516AD1F38C;
 Tue,  3 Oct 2023 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696350273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRqnDJLezNbCqXdpqEDBKHoSdRMtz2GkH5mw+Z2rnqg=;
 b=zzl/iO+91awXb+QpG4TL5br1RWzpe4qxzPrI02mZw65rY5Z7YhO6e9y2CrfFDiPKrJY5jx
 9iZhLkxC6mG/NZFxLd6cNFkzJmyJ8q/GdUhK7tu5xgYn9f0e4ycnZKzi3Yo+3fTSPeE5to
 FiUwHOUn34q1dazasRbaepWUJhpnrE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696350273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRqnDJLezNbCqXdpqEDBKHoSdRMtz2GkH5mw+Z2rnqg=;
 b=ehZKtNdgKC85ZrsjyZvaXuV+47HXvAh0vjUK3pdngnsr+qQB56ibaohNlAQc1RjUBchrsv
 ovsisiO6xVvcG7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7829139F9;
 Tue,  3 Oct 2023 16:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1307KEBAHGU7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 03 Oct 2023 16:24:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
In-Reply-To: <ZRw5Myc/joWb6why@redhat.com>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com>
Date: Tue, 03 Oct 2023 13:24:30 -0300
Message-ID: <874jj7u11d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Fabiano,
>>=20
>> [+Alex & Daniel]
>>=20
>> On 3/10/23 16:19, Fabiano Rosas wrote:
>> > We have strict rules around migration compatibility between different
>> > QEMU versions but not a single test that validates the migration state
>> > between different binaries.
>> >=20
>> > Add some infrastructure to allow running the migration tests with two
>> > different QEMU binaries as migration source and destination.
>> >=20
>> > The code now recognizes two new environment variables QTEST_QEMU_SRC
>> > and QTEST_QEMU_DST. Only one of the two is expected to be used along
>> > with the existing QTEST_QEMU_BINARY, which will automatically be used
>> > for the other side of migration.
>> >=20
>> > Usage:
>> > QTEST_QEMU_DST=3D./build-8.2.0/qemu-system-x86_64 \
>> > QTEST_QEMU_BINARY=3D../build-8.1.0/qemu-system-x86_64 \
>> > ./tests/qtest/migration-test
>>=20
>> I like it as a first step, but I'd rather run $QTEST_QEMU_SRC
>> directly from a docker image, i.e.:
>>=20
>> $ docker run -it opensuse/leap
>> # zypper update -y && zypper install -y qemu-x86
>> $ docker run opensuse/leap qemu-system-x86_64 ...
>
> In theory this does not need any support in libqtest at all
>
> $ cat myqemu.dkr=20
> FROM fedora:38
>
> RUN dnf -y install qemu-kvm
>
> $ podman build -f myqemu.dkr --tag myqemu .
>
> $ cat > myqemu <<EOF
> #!/bin/sh
> exec podman run --volume /tmp=3D/tmp --security-opt label=3Ddisable myqem=
u qemu-system-x86_64 "$@"
>
> $ chmod +x myqemu
>
> $ QTEST_QEMU_BINARY=3D./myqemu.sh  ./build/tests/qtest/rtc-test

I'm favor of this. I usually set that variable to something like 'gdb
--args ...' and it works just fine.

> Except we fail on the last step, because bind mounts don't make UNIX doma=
in
> sockets accessible. So we can see the /tmp/qtest-$PID.sock in the contain=
er,
> but it can't be used.
>
> UNIX domain sockets in the filesystem are tied to the mount namespace, and
> podman/docker inherantly creates a new mount namespace making the UNIX
> domani socket inaccessible.
>
> UNIX domain sockets in the abstract namespace, however, are tied to the
> network namespace, so if you used podman --network host, they should be
> accessible.
>
> libqtest could be changed to use abstract UNIX domain sockets on Linux
> only, and likely unlock the use of podman for QEMU.
>
>>=20
>> > This code also works for when debugging with GDB to pass the same
>> > binary, but different GDB options for src and dst.
>> >=20
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >   tests/qtest/migration-helpers.c | 168 ++++++++++++++++++++++++++++++=
++
>> >   tests/qtest/migration-helpers.h |   3 +
>> >   tests/qtest/migration-test.c    |  52 ++++++++--
>> >   3 files changed, 216 insertions(+), 7 deletions(-)
>> >=20
>> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-h=
elpers.c
>> > index be00c52d00..e84360c3b3 100644
>> > --- a/tests/qtest/migration-helpers.c
>> > +++ b/tests/qtest/migration-helpers.c
>> > @@ -12,6 +12,8 @@
>> >   #include "qemu/osdep.h"
>> >   #include "qapi/qmp/qjson.h"
>> > +#include "qapi/qmp/qlist.h"
>> > +#include "qapi/qmp/qstring.h"
>> >   #include "migration-helpers.h"
>> > @@ -180,3 +182,169 @@ void wait_for_migration_fail(QTestState *from, b=
ool allow_active)
>> >       g_assert(qdict_get_bool(rsp_return, "running"));
>> >       qobject_unref(rsp_return);
>> >   }
>> > +
>> > +static char *query_pkg_version(QTestState *who)
>> > +{
>> > +    QDict *rsp;
>> > +    char *pkg;
>> > +
>> > +    rsp =3D qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-ve=
rsion' }");
>> > +    g_assert(rsp);
>> > +
>> > +    pkg =3D g_strdup(qdict_get_str(rsp, "package"));
>> > +    qobject_unref(rsp);
>> > +
>> > +    return pkg;
>> > +}
>> > +
>> > +static QList *query_machines(void)
>> > +{
>> > +    QDict *response;
>> > +    QList *list;
>> > +    QTestState *qts;
>> > +
>> > +    qts =3D qtest_init("-machine none");
>> > +    response =3D qtest_qmp(qts, "{ 'execute': 'query-machines' }");
>> > +    g_assert(response);
>> > +    list =3D qdict_get_qlist(response, "return");
>> > +    g_assert(list);
>> > +
>> > +    qtest_quit(qts);
>> > +    return list;
>> > +}
>> > +
>> > +static char *get_default_machine(QList *list)
>> > +{
>> > +    QDict *info;
>> > +    QListEntry *entry;
>> > +    QString *qstr;
>> > +    char *name =3D NULL;
>> > +
>> > +    QLIST_FOREACH_ENTRY(list, entry) {
>> > +        info =3D qobject_to(QDict, qlist_entry_obj(entry));
>> > +        g_assert(info);
>> > +
>> > +        if (qdict_get(info, "is-default")) {
>> > +            qstr =3D qobject_to(QString, qdict_get(info, "name"));
>> > +            g_assert(qstr);
>> > +            name =3D g_strdup(qstring_get_str(qstr));
>> > +            break;
>> > +        }
>> > +    }
>> > +
>> > +    g_assert(name);
>> > +    return name;
>> > +}
>> > +
>> > +static bool search_default_machine(QList *list, const char *theirs)
>> > +{
>> > +    QDict *info;
>> > +    QListEntry *entry;
>> > +    QString *qstr;
>> > +
>> > +    if (!theirs) {
>> > +        return false;
>> > +    }
>> > +
>> > +    QLIST_FOREACH_ENTRY(list, entry) {
>> > +        info =3D qobject_to(QDict, qlist_entry_obj(entry));
>> > +        g_assert(info);
>> > +
>> > +        qstr =3D qobject_to(QString, qdict_get(info, "name"));
>> > +        g_assert(qstr);
>> > +
>> > +        if (g_str_equal(qstring_get_str(qstr), theirs)) {
>> > +            return true;
>> > +        }
>> > +    }
>> > +    return false;
>> > +}
>> > +
>> > +/*
>> > + * We need to ensure that both QEMU instances set via the QTEST_QEMU_*
>> > + * vars will use the same machine type. Use a custom query_machines
>> > + * function because the generic one in libqtest has a cache that would
>> > + * return the same machines for both binaries.
>> > + */
>> > +char *find_common_machine_type(const char *bin)
>> > +{
>> > +    QList *m1, *m2;
>> > +    g_autofree char *def1 =3D NULL;
>> > +    g_autofree char *def2 =3D NULL;
>> > +    const char *qemu_bin =3D getenv("QTEST_QEMU_BINARY");
>> > +
>> > +    m1 =3D query_machines();
>> > +
>> > +    g_setenv("QTEST_QEMU_BINARY", bin, true);
>> > +    m2 =3D query_machines();
>> > +    g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
>> > +
>> > +    def1 =3D get_default_machine(m1);
>> > +    def2 =3D get_default_machine(m2);
>> > +
>> > +    if (g_str_equal(def1, def2)) {
>> > +        /* either can be used */
>> > +        return g_strdup(def1);
>> > +    }
>> > +
>> > +    if (search_default_machine(m1, def2)) {
>> > +        return g_strdup(def2);
>> > +    }
>> > +
>> > +    if (search_default_machine(m2, def1)) {
>> > +        return g_strdup(def1);
>> > +    }
>> > +
>> > +    g_assert_not_reached();
>> > +}
>> > +
>> > +/*
>> > + * Init a guest for migration tests using an alternate QEMU binary for
>> > + * either the source or destination, depending on @var. The other
>> > + * binary should be set as usual via QTEST_QEMU_BINARY.
>> > + *
>> > + * Expected values:
>> > + *   QTEST_QEMU_SRC
>> > + *   QTEST_QEMU_DST
>> > + *
>> > + * Warning: The generic parts of qtest could be using
>> > + * QTEST_QEMU_BINARY to query for properties before we reach the
>> > + * migration code. If the alternate binary is too dissimilar that
>> > + * could cause issues.
>> > + */
>> > +static QTestState *init_vm(const char *extra_args, const char *var)
>> > +{
>> > +    const char *alt_bin =3D getenv(var);
>> > +    const char *qemu_bin =3D getenv("QTEST_QEMU_BINARY");
>> > +    g_autofree char *pkg =3D NULL;
>> > +    bool src =3D !!strstr(var, "SRC");
>> > +    QTestState *qts;
>> > +
>> > +    if (alt_bin) {
>> > +        g_setenv("QTEST_QEMU_BINARY", alt_bin, true);
>> > +    }
>> > +
>> > +    qts =3D qtest_init(extra_args);
>> > +    pkg =3D query_pkg_version(qts);
>> > +
>> > +    g_test_message("Using %s (%s) as migration %s",
>> > +                   alt_bin ? alt_bin : qemu_bin,
>> > +                   pkg,
>> > +                   src ? "source" : "destination");
>> > +
>> > +    if (alt_bin) {
>> > +        /* restore the original */
>> > +        g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
>> > +    }
>> > +    return qts;
>> > +}
>
> IMHO, we should just create a new qtest_init_env variant, that is the
> same as qtest_init, but accepts an environment variable name to use as
> an override.
>
> eg
>
>    qtest_init_env("QTEST_QEMU_BINARY_SRC", extra_args)
>
> it would look for $QTEST_QEMU_BINARY_SRC and if not found automatically
> fallback to $QTEST_QEMU_BINARY.
>

This was initially intended to be an off-tree patch that I could use to
test migration compatibility, so I avoided touching libqtest. Now that I
learned this might be of interest we can make it less hackish.

> I don't think there's any need to explicitly forbid setting both
> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST at the same time.
>

This is a little biased on my usage of migration-test from the command
line. Adding one of SRC|DST is easier when coming/going from a test that
already uses QTEST_QEMU_BINARY. No big deal, of course.

We'll just have to do something about qtest_get_machines(),
qtest_has_device() and qtest_get_arch(), which expect QTEST_QEMU_BINARY
to be present.

