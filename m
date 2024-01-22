Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46496835F68
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 11:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRrQh-0000XL-SP; Mon, 22 Jan 2024 05:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRrQd-0000X7-8P
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRrQb-0002Cu-6A
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705918875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkQZ97UlUSHsiaCbt7H/2htNgqsk5fiHfglAVbVJKLs=;
 b=Fv23BmOW2hledNxrtiI6K3qFbesmncvgVfHqwUPr8lyM+gTJP9EVJbsYO0Hbrx1BJ2z1b/
 wd1yvgNBdkvlle2leydDr9LV3GXgE3AA5I3uYnOPRxcrTXspiEYWetpR2KK6AgnGxycutC
 H2zsBlfSj7zx5YzmhBTaFlASGfq8i9A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-ee0jANoHOw64SnRS0d2h1g-1; Mon, 22 Jan 2024 05:21:14 -0500
X-MC-Unique: ee0jANoHOw64SnRS0d2h1g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so212324a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 02:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705918873; x=1706523673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkQZ97UlUSHsiaCbt7H/2htNgqsk5fiHfglAVbVJKLs=;
 b=Q7gyNgHbzsCRwX1Frd41FDtLb66GCh/TkF7Ad1knH4uU2u5lrqCTC2joKcgYmIWAz/
 tDy0Gbe4CquUbIvpPatgTLuMHP9HtPJN5fZOtVb42smzdkTYlDx4nJAxPs51zDTlc3X2
 5uE0EX+62/GOOQ25kD4mo3BMqtf7j5xFL9EsuuzO0XsQloE1NJTs4vuecaenQGN1tKEG
 VwoRQ8rqrgqKwWwaj3x24TDqGWlCpuI3NPx0+bOUfEXHb2WXUG5xCa9YmuFqW5C6j13F
 0qlIGJqf1TOYWdauHArDQ+htWW3QsLVItAbrte2Tlx9/1s3vHdkPMOIJlaSJM9FpdW2T
 sEmg==
X-Gm-Message-State: AOJu0YzSi251IvAI2wwxXsoW89aFIPG82Pw6TebaI+3bb1WDz9aU5sYa
 rV5EEt43JqKN/nNeE0TIOZmz8bMTNa84OYOOTaPGXz6nEs+Rug+3MLY7JZVqwqn/W2PhhGcVGti
 M4awRW3vwjPfpjiAqCx+kFD4LOYHfrvItZBai/1smBiUHyK/L69xN
X-Received: by 2002:a17:902:a3c7:b0:1d4:e1d7:3740 with SMTP id
 q7-20020a170902a3c700b001d4e1d73740mr8106035plb.3.1705918873139; 
 Mon, 22 Jan 2024 02:21:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERZzRNshT2XfJkEX2tnwtHtfqUJRyyKR8cO9NcQbuLy+Sh61NHKavci9PT8SA5fwQ7JxMHVg==
X-Received: by 2002:a17:902:a3c7:b0:1d4:e1d7:3740 with SMTP id
 q7-20020a170902a3c700b001d4e1d73740mr8106021plb.3.1705918872800; 
 Mon, 22 Jan 2024 02:21:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 kv4-20020a17090328c400b001d5b93560c3sm7023377plb.167.2024.01.22.02.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 02:21:12 -0800 (PST)
Date: Mon, 22 Jan 2024 18:21:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] migration: Fix use-after-free of migration state
 object
Message-ID: <Za5BkH5au-5h0imh@x1n>
References: <20240119233922.32588-1-farosas@suse.de>
 <20240119233922.32588-2-farosas@suse.de> <Za46DZfpCGe9rdLs@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Za46DZfpCGe9rdLs@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jan 22, 2024 at 05:49:01PM +0800, Peter Xu wrote:
> On Fri, Jan 19, 2024 at 08:39:18PM -0300, Fabiano Rosas wrote:
> > We're currently allowing the process_incoming_migration_bh bottom-half
> > to run without holding a reference to the 'current_migration' object,
> > which leads to a segmentation fault if the BH is still live after
> > migration_shutdown() has dropped the last reference to
> > current_migration.
> > 
> > In my system the bug manifests as migrate_multifd() returning true
> > when it shouldn't and multifd_load_shutdown() calling
> > multifd_recv_terminate_threads() which crashes due to an uninitialized
> > multifd_recv_state.
> > 
> > Fix the issue by holding a reference to the object when scheduling the
> > BH and dropping it before returning from the BH. The same is already
> > done for the cleanup_bh at migrate_fd_cleanup_schedule().
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/migration.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 219447dea1..cf17b68e57 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -648,6 +648,7 @@ static void process_incoming_migration_bh(void *opaque)
> >                        MIGRATION_STATUS_COMPLETED);
> >      qemu_bh_delete(mis->bh);
> >      migration_incoming_state_destroy();
> > +    object_unref(OBJECT(migrate_get_current()));
> >  }
> >  
> >  static void coroutine_fn
> > @@ -713,6 +714,7 @@ process_incoming_migration_co(void *opaque)
> >      }
> >  
> >      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> > +    object_ref(OBJECT(migrate_get_current()));
> >      qemu_bh_schedule(mis->bh);
> >      return;
> >  fail:
> > -- 
> > 2.35.3
> > 
> 
> I know I missed something, but I'd better ask: use-after-free needs to
> happen only after migration_shutdown() / qemu_cleanup(), am I right?
> 
> If so, shouldn't qemu_main_loop() already returned?  Then how could any BH
> keep running (including migration's) without qemu_main_loop()?

Hmm, I saw a pretty old stack mentioned in commit fd392cfa8e6:

    Original output:
    qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown process>)
    =================================================================
    ==31958==ERROR: AddressSanitizer: heap-use-after-free on address 0x61900001d210
      at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
    READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
        #0 0x555558a535c9 in migrate_fd_cleanup migration/migration.c:1502:23
        #1 0x5555594fde0a in aio_bh_call util/async.c:90:5
        #2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
        #3 0x555559524783 in aio_poll util/aio-posix.c:725:17
        #4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wait.c:71:5
        #5 0x5555573bddf6 in virtio_blk_data_plane_stop
          hw/block/dataplane/virtio-blk.c:282:5
        #6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/virtio/virtio-bus.c:246:9
        #7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/virtio/virtio-pci.c:287:5
        #8 0x5555589e22bf in virtio_pci_vmstate_change hw/virtio/virtio-pci.c:1072:9
        #9 0x555557628931 in virtio_vmstate_change hw/virtio/virtio.c:2257:9
        #10 0x555557c36713 in vm_state_notify vl.c:1605:9
        #11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
        #12 0x55555716eeff in vm_shutdown cpus.c:1092:12
        #13 0x555557c4283e in main vl.c:4617:5
        #14 0x7fffdfdb482f in __libc_start_main
          (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
        #15 0x555556ecb118 in _start (x86_64-softmmu/qemu-system-x86_64+0x1977118)

Would that be the same case that you mentioned here?  As vm_shutdown() is
indeed after migration_shutdown().

Even if so, two follow up comments..

(1) How did it help if process_incoming_migration_bh() took ref on
    MigrationState*?  I didn't even see it touching the object (instead, it
    uses the incoming object)?

(2) This is what I'm just wondering.. on whether we should clear
    current_migration to NULL in migration_shutdown() after we unref it.
    Maybe it'll make such issues abort in an even clearer way.

-- 
Peter Xu


