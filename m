Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D9E71958E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4deX-0005p4-P9; Thu, 01 Jun 2023 04:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4deV-0005oo-OZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4deT-0001tX-DV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685608039;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gWRH5Y0tYGBELHExzIDay1qJ7hg0Etnb7ZPBQFKCtrY=;
 b=VK0g4pcu5UYg0zIjCdb6JxKzR/MEdYMrtvv3xca5CYug/FxbZDsOuFkEkLjxFtOfRWfhrq
 4IgdxI8wv1r/GpDmv/1EoBjpfSwRNXm6vz/Sr1k0sd6HZRs7NdeM87tS+EEPYzYMaLRhUv
 CeuPV71urOQBPkjZAYuDvVO4fXe3E3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-q1Lj4Le1NOes34zNj71thA-1; Thu, 01 Jun 2023 04:27:18 -0400
X-MC-Unique: q1Lj4Le1NOes34zNj71thA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2398A101A53A;
 Thu,  1 Jun 2023 08:27:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9897B40CFD45;
 Thu,  1 Jun 2023 08:27:16 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:27:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
Message-ID: <ZHhWXSU3vvobddP2@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
 <87mt1ktdr8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mt1ktdr8.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 31, 2023 at 11:03:23PM +0200, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
> > On 5/30/23 11:25, Juan Quintela wrote:
> >> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
> >>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
> >> into staging (2023-05-29 14:31:52 -0700)
> >> are available in the Git repository at:
> >>    https://gitlab.com/juan.quintela/qemu.git
> >> tags/migration-20230530-pull-request
> >> for you to fetch changes up to
> >> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
> >>    migration/rdma: Check sooner if we are in postcopy for
> >> save_page() (2023-05-30 19:23:50 +0200)
> >> ----------------------------------------------------------------
> 
> Added Markus and Daniel.
> 
> >> Migration 20230530 Pull request (take 2)
> >> Hi
> >> Resend last PULL request, this time it compiles when CONFIG_RDMA is
> >> not configured in.
> >> [take 1]
> >> On this PULL request:
> >> - Set vmstate migration failure right (vladimir)
> >> - Migration QEMUFileHook removal (juan)
> >> - Migration Atomic counters (juan)
> >> Please apply.
> >> ----------------------------------------------------------------
> >> Juan Quintela (16):
> >>    migration: Don't abuse qemu_file transferred for RDMA
> >>    migration/RDMA: It is accounting for zero/normal pages in two places
> >>    migration/rdma: Remove QEMUFile parameter when not used
> >>    migration/rdma: Don't use imaginary transfers
> >>    migration: Remove unused qemu_file_credit_transfer()
> >>    migration/rdma: Simplify the function that saves a page
> >>    migration: Create migrate_rdma()
> >>    migration/rdma: Unfold ram_control_before_iterate()
> >>    migration/rdma: Unfold ram_control_after_iterate()
> >>    migration/rdma: Remove all uses of RAM_CONTROL_HOOK
> >>    migration/rdma: Unfold hook_ram_load()
> >>    migration/rdma: Create rdma_control_save_page()
> >>    qemu-file: Remove QEMUFileHooks
> >>    migration/rdma: Move rdma constants from qemu-file.h to rdma.h
> >>    migration/rdma: Remove qemu_ prefix from exported functions
> >>    migration/rdma: Check sooner if we are in postcopy for save_page()
> >> Vladimir Sementsov-Ogievskiy (5):
> >>    runstate: add runstate_get()
> >>    migration: never fail in global_state_store()
> >>    runstate: drop unused runstate_store()
> >>    migration: switch from .vm_was_running to .vm_old_state
> >>    migration: restore vmstate on migration failure
> >
> > Appears to introduce multiple avocado failures:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
> >
> > Test summary:
> > tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
> > tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
> > tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
> > make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387
> >
> > Test summary:
> > tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
> > tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
> > make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
> >
> > Also fails QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/migration-test
> >
> > ../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 is
> > not an instance of type qio-channel-rdma
> 
> I am looking at the other errors, but this one is weird.  It is failing
> here:
> 
> #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
> OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
> 
> In the OBJECT line.
> 
> I have no clue what problem are we having here with the object system to
> decide at declaration time that a variable is not of the type that we
> are declaring.
> 
> I am missing something obvious here?

I expect somewhere in the code has either corrupted memory, or is
using free'd memory. Either way you'll need to get a stack trace
to debug this kind of thing

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


