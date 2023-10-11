Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FC7C5750
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaWI-0007Th-5W; Wed, 11 Oct 2023 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqaWD-0007SU-0T
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqaWB-0008QW-4V
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697035737;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ShzrsV0C7PydKaVLE3XQKuwVCWjaf4W8BBeEIo4wCLU=;
 b=RWoliH7g0lqAsjpt4accOBG5aTosLR/x2V1Tc1+gbEpBMIXvcCGGvaQAPI6KTiOkmJBxfw
 bDm+FyA4h+awXIUhTwrswaSUu3fM79BD/gujxS94PZQf37SCni00iQVKadGguiitTrhM2N
 lTp6a9WlPvCch7L3zGtsdgqIxMkZAwA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-Le7QrRnQMX-Cm1kMePVtbw-1; Wed, 11 Oct 2023 10:48:55 -0400
X-MC-Unique: Le7QrRnQMX-Cm1kMePVtbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 880D31C0BB54;
 Wed, 11 Oct 2023 14:48:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5FCB9A;
 Wed, 11 Oct 2023 14:48:52 +0000 (UTC)
Date: Wed, 11 Oct 2023 15:48:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/9] tests/qtest/migration: Define a machine for all
 architectures
Message-ID: <ZSa10rRmlqLCl+MX@redhat.com>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-8-farosas@suse.de>
 <87h6mx8c86.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6mx8c86.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Oct 11, 2023 at 04:28:41PM +0200, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
> > Stop relying on defaults and select a machine explicitly for every
> > architecture.
> >
> > This is a prerequisite for being able to select machine types for
> > migration using different QEMU binaries for source and destination.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  tests/qtest/migration-test.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 46f1c275a2..7c10ac925b 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -746,6 +746,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >      const char *kvm_opts = NULL;
> >      const char *arch = qtest_get_arch();
> >      const char *memory_size;
> > +    const char *machine;
> >  
> >      if (args->use_shmem) {
> >          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> > @@ -758,11 +759,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >      got_dst_resume = false;
> >      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> >          memory_size = "150M";
> > +        machine = "pc";
> 
> I would suggest:
> 
>       if (strcmp(arch, "i386")) {
>           machine = "pc";
>       } else {
>           machine = "q35";
>       }
> 
> New development is happening in q35, so I think this should be the more tested.
> 
> > @@ -774,10 +777,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >                                        "'nvramrc=hex .\" _\" begin %x %x "
> >                                        "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
> >                                        "until'", end_address, start_address);
> > +        machine = "pseries";
> >          arch_opts = g_strdup("-nodefaults -machine vsmt=8");
> >      } else if (strcmp(arch, "aarch64") == 0) {
> >          memory_size = "150M";
> > -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
> > +        machine = "virt";
> > +        arch_opts = g_strdup_printf("-machine gic-version=max -cpu max "
> 
> Does this double -machine command line works?

Why not just call the variable 'machine_opts' and here you can
do

 -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
 +        machine_opts = "virt,gic-version=max";
 +        arch_opts = g_strdup_printf("-cpu max "


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


