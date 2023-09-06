Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E3794019
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduH6-0001lu-E7; Wed, 06 Sep 2023 11:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qduH4-0001lS-6D
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qduH1-0005Hb-Jv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694013414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKTLA10DLfgcE1Bm9380NSSH+UIbcWwwGhlqqjHzIrM=;
 b=Zyu+5kYwNaREoar8e1jFrZni3yv2gKj6pJtQgyfKOhwHnLnbqhzgw66LFwNaK1KqA7FqKp
 fkHoIYBpbxWSrjJGHNo9GvvuPAYb2xvMJFYp38liUXXueEi3WqO4eeekRaTtt7HZegn306
 WiYdF4vYDs9HCsrZLRSrItms7s8TcLQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-fIhZUhYtPuqmMkL6EVX8aA-1; Wed, 06 Sep 2023 11:16:51 -0400
X-MC-Unique: fIhZUhYtPuqmMkL6EVX8aA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76f1cc68e65so112567085a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 08:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694013411; x=1694618211;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKTLA10DLfgcE1Bm9380NSSH+UIbcWwwGhlqqjHzIrM=;
 b=EoJVBeXUXRDrNX4Vw4UCkNJzcGYuuWog0Rr6w90IoG2Eic4OTMzlPQJzsPHJPnLziM
 i3vdPZJoEm11/xx4pdBHn7fx8HdS2iFoRTfAvQuXeenlDhRKkxjDLe2yeeLNaVQL26+Y
 CxmT+H3FX5UWYkay5uFV2ARZ7tHXF5DS5FY0bjooTRL5kA8EgyuVTjpArYxaEB6oaUw3
 SbJNcYUpo/rNsIV/yKs5iHkJ3mX5g0WUBjLGyDdXbYEfJ4u1kPc1RchFtzZgRIyB3Cwo
 QzGxb5DUqebElRS850Z9ywJUdZqmKCdrnW42lHUFSgwh9kwUDv9SN2jAtkg2CKVGJqQ1
 Lwwg==
X-Gm-Message-State: AOJu0YwO63IA5Pm1vNJQaF2iGJvOU+0tTU0q7l4VofX88cundwFfsggo
 KNpnI4H2kIsgZigQOkHHCtGkzZ4VVStlB0Yc8RqDm3WmJ0DHPsUoU7vv7LostYE4RiBFlbGr2tn
 Fy9TOCSrLZsObyzM=
X-Received: by 2002:a05:620a:318a:b0:76d:95d3:800f with SMTP id
 bi10-20020a05620a318a00b0076d95d3800fmr17814393qkb.3.1694013410774; 
 Wed, 06 Sep 2023 08:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFyXMulb++q5yffAYcLv9K3MLXDItBxIF2/R8Mtnz8/urzg9AU50gTq+GB9QU3CqrMQA/QqQ==
X-Received: by 2002:a05:620a:318a:b0:76d:95d3:800f with SMTP id
 bi10-20020a05620a318a00b0076d95d3800fmr17814367qkb.3.1694013410472; 
 Wed, 06 Sep 2023 08:16:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0076f15f2918fsm5011376qki.63.2023.09.06.08.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 08:16:50 -0700 (PDT)
Date: Wed, 6 Sep 2023 11:16:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>,
 William Roche <william.roche@oracle.com>
Cc: William Roche <william.roche@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Message-ID: <ZPiX4YLAT5HjxUAJ@x1n>
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
 <e2adce18-7aef-5445-352a-01e789619fac@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2adce18-7aef-5445-352a-01e789619fac@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 06, 2023 at 03:19:32PM +0100, Joao Martins wrote:
> On 06/09/2023 14:59, “William Roche wrote:
> > From: William Roche <william.roche@oracle.com>
> > 
> > A memory page poisoned from the hypervisor level is no longer readable.
> > Thus, it is now treated as a zero-page for the ram saving migration phase.
> > 
> > The migration of a VM will crash Qemu when it tries to read the
> > memory address space and stumbles on the poisoned page with a similar
> > stack trace:
> > 
> > Program terminated with signal SIGBUS, Bus error.
> > #0  _mm256_loadu_si256
> > #1  buffer_zero_avx2
> > #2  select_accel_fn
> > #3  buffer_is_zero
> > #4  save_zero_page_to_file
> > #5  save_zero_page
> > #6  ram_save_target_page_legacy
> > #7  ram_save_host_page
> > #8  ram_find_and_save_block
> > #9  ram_save_iterate
> > #10 qemu_savevm_state_iterate
> > #11 migration_iteration_run
> > #12 migration_thread
> > #13 qemu_thread_start
> > 
> > Fix it by considering poisoned pages as if they were zero-pages for
> > the migration copy. This fix also works with underlying large pages,
> > taking into account the RAMBlock segment "page-size".
> > 
> > Signed-off-by: William Roche <william.roche@oracle.com>
> 
> You forgot to CC the maintainers; Adding them now
> 
> ./scripts/get_maintainer.pl is your friend for the next version :)
> 
> > ---
> >  accel/kvm/kvm-all.c    | 14 ++++++++++++++
> >  accel/stubs/kvm-stub.c |  5 +++++
> >  include/sysemu/kvm.h   | 10 ++++++++++
> >  migration/ram.c        |  3 ++-
> >  4 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 2ba7521695..24a7709495 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -1152,6 +1152,20 @@ static void kvm_unpoison_all(void *param)
> >      }
> >  }
> >  
> > +bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
> > +{
> > +    HWPoisonPage *pg;
> > +    ram_addr_t ram_addr = (ram_addr_t) offset;
> > +
> > +    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
> > +        if ((ram_addr >= pg->ram_addr) &&
> > +            (ram_addr - pg->ram_addr < block->page_size)) {

Just a note..

Probably fine for now to reuse block page size, but IIUC the right thing to
do is to fetch it from the signal info (in QEMU's sigbus_handler()) of
kernel_siginfo.si_addr_lsb.

At least for x86 I think that stores the "shift" of covered poisoned page
(one needs to track the Linux handling of VM_FAULT_HWPOISON_LARGE for a
huge page, though.. not aware of any man page for that).  It'll then work
naturally when Linux huge pages will start to support sub-huge-page-size
poisoning someday.  We can definitely leave that for later.

> > +            return true;
> > +        }
> > +    }
> > +    return false;
> > +}
> > +
> >  void kvm_hwpoison_page_add(ram_addr_t ram_addr)
> >  {
> >      HWPoisonPage *page;
> > diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> > index 235dc661bc..c0a31611df 100644
> > --- a/accel/stubs/kvm-stub.c
> > +++ b/accel/stubs/kvm-stub.c
> > @@ -133,3 +133,8 @@ uint32_t kvm_dirty_ring_size(void)
> >  {
> >      return 0;
> >  }
> > +
> > +bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
> > +{
> > +    return false;
> > +}
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index ebdca41052..a2196e9e6b 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -580,4 +580,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
> >  bool kvm_dirty_ring_enabled(void);
> >  
> >  uint32_t kvm_dirty_ring_size(void);
> > +
> > +/**
> > + * kvm_hwpoisoned_page - indicate if the given page is poisoned
> > + * @block: memory block of the given page
> > + * @ram_addr: offset of the page
> > + *
> > + * Returns: true: page is poisoned
> > + *          false: page not yet poisoned
> > + */
> > +bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
> >  #endif
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 9040d66e61..48d875b12d 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1145,7 +1145,8 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
> >      uint8_t *p = block->host + offset;
> >      int len = 0;
> >  
> > -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> > +    if ((kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) ||

Can we move this out of zero page handling?  Zero detection is not
guaranteed to always be the 1st thing to do when processing a guest page.
Currently it'll already skip either rdma or when compression enabled, so
it'll keep crashing there.

Perhaps at the entry of ram_save_target_page_legacy()?

> > +        buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> >          len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
> >          qemu_put_byte(file, 0);
> >          len += 1;
> 

-- 
Peter Xu


