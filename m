Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2D8CA8A9
	for <lists+qemu-devel@lfdr.de>; Tue, 21 May 2024 09:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Ji2-0003O0-BU; Tue, 21 May 2024 03:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9Jhz-0003NQ-VE
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9Jhu-0000Nz-8u
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716275684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEd7FRkXslgXzA7Y+2kVaGouw371phQR7Z7EUKc3fiM=;
 b=EBzWIExaDXcnU05X6oKd3+B5XvRcEvAscjMQGNgBZk5JU9LPz/agG4uSYqNEpMgbj24Xa3
 ktvlSX5EgBZCi7m4F/jGDEvT1Q7LOwBDKvgIIFXjNyNOWx6VKxFQj2Q1vcsFUgL8UKe3Zp
 dED9icifJoDcQhm4h+mfQd9Z39rFh8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-UmtJ_4C1NciagOzKDb1NEg-1; Tue, 21 May 2024 03:14:38 -0400
X-MC-Unique: UmtJ_4C1NciagOzKDb1NEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5925B8058D5;
 Tue, 21 May 2024 07:14:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31F2A492BC6;
 Tue, 21 May 2024 07:14:31 +0000 (UTC)
Date: Tue, 21 May 2024 08:14:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 24/26] seccomp: cpr-exec blocker
Message-ID: <ZkxJvkHVBD9XPdXa@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-25-git-send-email-steven.sistare@oracle.com>
 <Zj3SyzYMJzluwKoQ@redhat.com>
 <00db254b-2e0e-4699-8d0f-df0e64853a23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00db254b-2e0e-4699-8d0f-df0e64853a23@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 13, 2024 at 03:29:48PM -0400, Steven Sistare wrote:
> On 5/10/2024 3:54 AM, Daniel P. Berrangé wrote:
> > On Mon, Apr 29, 2024 at 08:55:33AM -0700, Steve Sistare wrote:
> > > cpr-exec mode needs permission to exec.  Block it if permission is denied.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/sysemu/seccomp.h |  1 +
> > >   system/qemu-seccomp.c    | 10 ++++++++--
> > >   system/vl.c              |  6 ++++++
> > >   3 files changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> > > index fe85989..023c0a1 100644
> > > --- a/include/sysemu/seccomp.h
> > > +++ b/include/sysemu/seccomp.h
> > > @@ -22,5 +22,6 @@
> > >   #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
> > >   int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp);
> > > +uint32_t qemu_seccomp_get_opts(void);
> > >   #endif
> > > diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
> > > index 5c20ac0..0d2a561 100644
> > > --- a/system/qemu-seccomp.c
> > > +++ b/system/qemu-seccomp.c
> > > @@ -360,12 +360,18 @@ static int seccomp_start(uint32_t seccomp_opts, Error **errp)
> > >       return rc < 0 ? -1 : 0;
> > >   }
> > > +static uint32_t seccomp_opts;
> > > +
> > > +uint32_t qemu_seccomp_get_opts(void)
> > > +{
> > > +    return seccomp_opts;
> > > +}
> > > +
> > >   int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
> > >   {
> > >       if (qemu_opt_get_bool(opts, "enable", false)) {
> > > -        uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
> > > -                | QEMU_SECCOMP_SET_OBSOLETE;
> > >           const char *value = NULL;
> > > +        seccomp_opts = QEMU_SECCOMP_SET_DEFAULT | QEMU_SECCOMP_SET_OBSOLETE;
> > >           value = qemu_opt_get(opts, "obsolete");
> > >           if (value) {
> > > diff --git a/system/vl.c b/system/vl.c
> > > index 7252100..b76881e 100644
> > > --- a/system/vl.c
> > > +++ b/system/vl.c
> > > @@ -76,6 +76,7 @@
> > >   #include "hw/block/block.h"
> > >   #include "hw/i386/x86.h"
> > >   #include "hw/i386/pc.h"
> > > +#include "migration/blocker.h"
> > >   #include "migration/cpr.h"
> > >   #include "migration/misc.h"
> > >   #include "migration/snapshot.h"
> > > @@ -2493,6 +2494,11 @@ static void qemu_process_early_options(void)
> > >       QemuOptsList *olist = qemu_find_opts_err("sandbox", NULL);
> > >       if (olist) {
> > >           qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
> > > +        if (qemu_seccomp_get_opts() & QEMU_SECCOMP_SET_SPAWN) {
> > > +            Error *blocker = NULL;
> > > +            error_setg(&blocker, "-sandbox denies exec for cpr-exec");
> > > +            migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
> > > +        }
> > >       }
> > >   #endi
> > 
> > There are a whole pile of features that get blocked wehn -sandbox is
> > used. I'm not convinced we should be adding code to check for specific
> > blocked features, as such a list will always be incomplete at best, and
> > incorrectly block things at worst.
> > 
> > I view this primarily as a documentation task for the cpr-exec command.
> 
> For cpr and live migration, we do our best to prevent breaking the guest
> for cases we know will fail.  Independently, a clear error message here
> will reduce error reports for this new cpr feature.

I would expect the QMP command that triggers the sandbox to report a
clear error when getting EPERM.

> Would it be more palatable if I move this blocker's creation to cpr_mig_init?

Not particularly, as I don't think other code in QEMU should be looking
at the sandbox impl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


