Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B37B6D7D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhjR-0002Z9-Em; Tue, 03 Oct 2023 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qnhjK-0002Yr-5c
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qnhjH-0005hx-Cw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696348474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APVq2mol78SbW4w9umedeH/49m77cUFzemikkJ/hFs4=;
 b=EKVf+a8/WQB01JfdDDvQpvgxissfnXLReL0KhmmkLPPyWO9h+u/9hiDET3rKy60wG69IOb
 8l3NM67SvEUsHgvNH4+TNrKbhwCpma+bc6EJn/2v1eY15oQt9AOZ225HIxTy26/fakNmt9
 jhik7R6Ir2gny2BATdMQS4xrD5fScys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-yvYV0S26OQyd7SsEqKnByA-1; Tue, 03 Oct 2023 11:54:31 -0400
X-MC-Unique: yvYV0S26OQyd7SsEqKnByA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42DD828BCF;
 Tue,  3 Oct 2023 15:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77E8240C6EA8;
 Tue,  3 Oct 2023 15:54:29 +0000 (UTC)
Date: Tue, 3 Oct 2023 16:54:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
Message-ID: <ZRw5Myc/joWb6why@redhat.com>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Fabiano,
> 
> [+Alex & Daniel]
> 
> On 3/10/23 16:19, Fabiano Rosas wrote:
> > We have strict rules around migration compatibility between different
> > QEMU versions but not a single test that validates the migration state
> > between different binaries.
> > 
> > Add some infrastructure to allow running the migration tests with two
> > different QEMU binaries as migration source and destination.
> > 
> > The code now recognizes two new environment variables QTEST_QEMU_SRC
> > and QTEST_QEMU_DST. Only one of the two is expected to be used along
> > with the existing QTEST_QEMU_BINARY, which will automatically be used
> > for the other side of migration.
> > 
> > Usage:
> > QTEST_QEMU_DST=./build-8.2.0/qemu-system-x86_64 \
> > QTEST_QEMU_BINARY=../build-8.1.0/qemu-system-x86_64 \
> > ./tests/qtest/migration-test
> 
> I like it as a first step, but I'd rather run $QTEST_QEMU_SRC
> directly from a docker image, i.e.:
> 
> $ docker run -it opensuse/leap
> # zypper update -y && zypper install -y qemu-x86
> $ docker run opensuse/leap qemu-system-x86_64 ...

In theory this does not need any support in libqtest at all

$ cat myqemu.dkr 
FROM fedora:38

RUN dnf -y install qemu-kvm

$ podman build -f myqemu.dkr --tag myqemu .

$ cat > myqemu <<EOF
#!/bin/sh
exec podman run --volume /tmp=/tmp --security-opt label=disable myqemu qemu-system-x86_64 "$@"

$ chmod +x myqemu

$ QTEST_QEMU_BINARY=./myqemu.sh  ./build/tests/qtest/rtc-test


Except we fail on the last step, because bind mounts don't make UNIX domain
sockets accessible. So we can see the /tmp/qtest-$PID.sock in the container,
but it can't be used.

UNIX domain sockets in the filesystem are tied to the mount namespace, and
podman/docker inherantly creates a new mount namespace making the UNIX
domani socket inaccessible.

UNIX domain sockets in the abstract namespace, however, are tied to the
network namespace, so if you used podman --network host, they should be
accessible.

libqtest could be changed to use abstract UNIX domain sockets on Linux
only, and likely unlock the use of podman for QEMU.

> 
> > This code also works for when debugging with GDB to pass the same
> > binary, but different GDB options for src and dst.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   tests/qtest/migration-helpers.c | 168 ++++++++++++++++++++++++++++++++
> >   tests/qtest/migration-helpers.h |   3 +
> >   tests/qtest/migration-test.c    |  52 ++++++++--
> >   3 files changed, 216 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > index be00c52d00..e84360c3b3 100644
> > --- a/tests/qtest/migration-helpers.c
> > +++ b/tests/qtest/migration-helpers.c
> > @@ -12,6 +12,8 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/qmp/qjson.h"
> > +#include "qapi/qmp/qlist.h"
> > +#include "qapi/qmp/qstring.h"
> >   #include "migration-helpers.h"
> > @@ -180,3 +182,169 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
> >       g_assert(qdict_get_bool(rsp_return, "running"));
> >       qobject_unref(rsp_return);
> >   }
> > +
> > +static char *query_pkg_version(QTestState *who)
> > +{
> > +    QDict *rsp;
> > +    char *pkg;
> > +
> > +    rsp = qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-version' }");
> > +    g_assert(rsp);
> > +
> > +    pkg = g_strdup(qdict_get_str(rsp, "package"));
> > +    qobject_unref(rsp);
> > +
> > +    return pkg;
> > +}
> > +
> > +static QList *query_machines(void)
> > +{
> > +    QDict *response;
> > +    QList *list;
> > +    QTestState *qts;
> > +
> > +    qts = qtest_init("-machine none");
> > +    response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
> > +    g_assert(response);
> > +    list = qdict_get_qlist(response, "return");
> > +    g_assert(list);
> > +
> > +    qtest_quit(qts);
> > +    return list;
> > +}
> > +
> > +static char *get_default_machine(QList *list)
> > +{
> > +    QDict *info;
> > +    QListEntry *entry;
> > +    QString *qstr;
> > +    char *name = NULL;
> > +
> > +    QLIST_FOREACH_ENTRY(list, entry) {
> > +        info = qobject_to(QDict, qlist_entry_obj(entry));
> > +        g_assert(info);
> > +
> > +        if (qdict_get(info, "is-default")) {
> > +            qstr = qobject_to(QString, qdict_get(info, "name"));
> > +            g_assert(qstr);
> > +            name = g_strdup(qstring_get_str(qstr));
> > +            break;
> > +        }
> > +    }
> > +
> > +    g_assert(name);
> > +    return name;
> > +}
> > +
> > +static bool search_default_machine(QList *list, const char *theirs)
> > +{
> > +    QDict *info;
> > +    QListEntry *entry;
> > +    QString *qstr;
> > +
> > +    if (!theirs) {
> > +        return false;
> > +    }
> > +
> > +    QLIST_FOREACH_ENTRY(list, entry) {
> > +        info = qobject_to(QDict, qlist_entry_obj(entry));
> > +        g_assert(info);
> > +
> > +        qstr = qobject_to(QString, qdict_get(info, "name"));
> > +        g_assert(qstr);
> > +
> > +        if (g_str_equal(qstring_get_str(qstr), theirs)) {
> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> > +/*
> > + * We need to ensure that both QEMU instances set via the QTEST_QEMU_*
> > + * vars will use the same machine type. Use a custom query_machines
> > + * function because the generic one in libqtest has a cache that would
> > + * return the same machines for both binaries.
> > + */
> > +char *find_common_machine_type(const char *bin)
> > +{
> > +    QList *m1, *m2;
> > +    g_autofree char *def1 = NULL;
> > +    g_autofree char *def2 = NULL;
> > +    const char *qemu_bin = getenv("QTEST_QEMU_BINARY");
> > +
> > +    m1 = query_machines();
> > +
> > +    g_setenv("QTEST_QEMU_BINARY", bin, true);
> > +    m2 = query_machines();
> > +    g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
> > +
> > +    def1 = get_default_machine(m1);
> > +    def2 = get_default_machine(m2);
> > +
> > +    if (g_str_equal(def1, def2)) {
> > +        /* either can be used */
> > +        return g_strdup(def1);
> > +    }
> > +
> > +    if (search_default_machine(m1, def2)) {
> > +        return g_strdup(def2);
> > +    }
> > +
> > +    if (search_default_machine(m2, def1)) {
> > +        return g_strdup(def1);
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> > +/*
> > + * Init a guest for migration tests using an alternate QEMU binary for
> > + * either the source or destination, depending on @var. The other
> > + * binary should be set as usual via QTEST_QEMU_BINARY.
> > + *
> > + * Expected values:
> > + *   QTEST_QEMU_SRC
> > + *   QTEST_QEMU_DST
> > + *
> > + * Warning: The generic parts of qtest could be using
> > + * QTEST_QEMU_BINARY to query for properties before we reach the
> > + * migration code. If the alternate binary is too dissimilar that
> > + * could cause issues.
> > + */
> > +static QTestState *init_vm(const char *extra_args, const char *var)
> > +{
> > +    const char *alt_bin = getenv(var);
> > +    const char *qemu_bin = getenv("QTEST_QEMU_BINARY");
> > +    g_autofree char *pkg = NULL;
> > +    bool src = !!strstr(var, "SRC");
> > +    QTestState *qts;
> > +
> > +    if (alt_bin) {
> > +        g_setenv("QTEST_QEMU_BINARY", alt_bin, true);
> > +    }
> > +
> > +    qts = qtest_init(extra_args);
> > +    pkg = query_pkg_version(qts);
> > +
> > +    g_test_message("Using %s (%s) as migration %s",
> > +                   alt_bin ? alt_bin : qemu_bin,
> > +                   pkg,
> > +                   src ? "source" : "destination");
> > +
> > +    if (alt_bin) {
> > +        /* restore the original */
> > +        g_setenv("QTEST_QEMU_BINARY", qemu_bin, true);
> > +    }
> > +    return qts;
> > +}

IMHO, we should just create a new qtest_init_env variant, that is the
same as qtest_init, but accepts an environment variable name to use as
an override.

eg

   qtest_init_env("QTEST_QEMU_BINARY_SRC", extra_args)

it would look for $QTEST_QEMU_BINARY_SRC and if not found automatically
fallback to $QTEST_QEMU_BINARY.

I don't think there's any need to explicitly forbid setting both
QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST at the same time.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


