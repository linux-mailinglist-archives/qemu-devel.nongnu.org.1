Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380983802A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 02:57:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS61u-0001nX-9s; Mon, 22 Jan 2024 20:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS61s-0001n8-0s
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 20:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rS61p-0003x7-Qa
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 20:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705975000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QViKObKhBtFsiMvwSHTpkc/SVlGCk92309LM2q37kQ=;
 b=Bx4urzX5toGe8KgpiR1q31XMrr+1HBj4E/89WMV8+gVPxNdcZOxwpYvn37IkZxULcOccnH
 O5Mz2ehHKPtVk1ZceMiyLQRcAIeI8BrlIFa7NDSBYDI5luqxcV5G+VLgz/2coMCLcTgdxA
 xoug8Gi3yet6333LkY8jqJUdCxqAgsk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-nKmHg-A5Oe6HoQT8n7Ek6Q-1; Mon, 22 Jan 2024 20:56:38 -0500
X-MC-Unique: nKmHg-A5Oe6HoQT8n7Ek6Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso1172216b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 17:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705974997; x=1706579797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QViKObKhBtFsiMvwSHTpkc/SVlGCk92309LM2q37kQ=;
 b=JCkJPIlwawjlbjzg2GOk9cIQLQKSv/ZMb18ft6Qp4fAKAQh8oNn8t12Up3W5DeHfJt
 H45qsWNXN3Yl8TEJAtOwDM0thKsoVyYptyVcNntG5YdfJknrFnxwv5P7faJvn+5SVXtP
 j/M5y/iD+c1x8I/DFTNTi2gIq5bHHrGHDag28HqzSv/XbC3qN2STB9aRMC72lX08Ao6A
 OoGabKEy4ASOjFINCMhug4MmLbBCzypiStMXKOuY7g7nMn+yXfUQ+pQOjubKbFR+TaoF
 l/nNmGTjXiWdFA2xDmFwmaARteJLQQ+MD1VCDDB7e9/XIR08/hgiqV2UjonyOcJa7CCo
 1NYQ==
X-Gm-Message-State: AOJu0YzzAeUUz8jnBoT67ROL+Vl4jHEhfiX5Lvj9B3JeOYnDfqcRNGN6
 xLOOwiyHzH/P0GXeYVpO2n9z/KZRk4nRSsiNB/WcvSfF4zZ6UgIGcZRtZxf9b2WNEAh73hJyAm0
 H8HN1Io1q/BgYTffln7b1ahedtwh7kw2hWbRnak9ZhZ8f/kkL5XpofBrAcRWKrRs=
X-Received: by 2002:a05:6a20:43a1:b0:19b:7147:f7df with SMTP id
 i33-20020a056a2043a100b0019b7147f7dfmr12014840pzl.0.1705974997229; 
 Mon, 22 Jan 2024 17:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1jos0+S/1ViHz7lF/XM2AQ3RRnC7BgzUTvYktrmeJx5RBXieyUntwFiWcgK4wTlkwanO39g==
X-Received: by 2002:a05:6a20:43a1:b0:19b:7147:f7df with SMTP id
 i33-20020a056a2043a100b0019b7147f7dfmr12014826pzl.0.1705974996848; 
 Mon, 22 Jan 2024 17:56:36 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 nd11-20020a17090b4ccb00b00290d1528f21sm132691pjb.28.2024.01.22.17.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 17:56:36 -0800 (PST)
Date: Tue, 23 Jan 2024 09:56:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] migration: Fix use-after-free of migration state
 object
Message-ID: <Za8czmyifs5tkR5s@x1n>
References: <20240119233922.32588-1-farosas@suse.de>
 <20240119233922.32588-2-farosas@suse.de> <Za46DZfpCGe9rdLs@x1n>
 <Za5BkH5au-5h0imh@x1n> <87le8hgve6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le8hgve6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 22, 2024 at 01:55:45PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jan 22, 2024 at 05:49:01PM +0800, Peter Xu wrote:
> >> On Fri, Jan 19, 2024 at 08:39:18PM -0300, Fabiano Rosas wrote:
> >> > We're currently allowing the process_incoming_migration_bh bottom-half
> >> > to run without holding a reference to the 'current_migration' object,
> >> > which leads to a segmentation fault if the BH is still live after
> >> > migration_shutdown() has dropped the last reference to
> >> > current_migration.
> >> > 
> >> > In my system the bug manifests as migrate_multifd() returning true
> >> > when it shouldn't and multifd_load_shutdown() calling
> >> > multifd_recv_terminate_threads() which crashes due to an uninitialized
> >> > multifd_recv_state.
> >> > 
> >> > Fix the issue by holding a reference to the object when scheduling the
> >> > BH and dropping it before returning from the BH. The same is already
> >> > done for the cleanup_bh at migrate_fd_cleanup_schedule().
> >> > 
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > ---
> >> >  migration/migration.c | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >> > 
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index 219447dea1..cf17b68e57 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -648,6 +648,7 @@ static void process_incoming_migration_bh(void *opaque)
> >> >                        MIGRATION_STATUS_COMPLETED);
> >> >      qemu_bh_delete(mis->bh);
> >> >      migration_incoming_state_destroy();
> >> > +    object_unref(OBJECT(migrate_get_current()));
> >> >  }
> >> >  
> >> >  static void coroutine_fn
> >> > @@ -713,6 +714,7 @@ process_incoming_migration_co(void *opaque)
> >> >      }
> >> >  
> >> >      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> >> > +    object_ref(OBJECT(migrate_get_current()));
> >> >      qemu_bh_schedule(mis->bh);
> >> >      return;
> >> >  fail:
> >> > -- 
> >> > 2.35.3
> >> > 
> >> 
> > I know I missed something, but I'd better ask: use-after-free needs to
> > happen only after migration_shutdown() / qemu_cleanup(), am I right?
> > 
> > If so, shouldn't qemu_main_loop() already returned?  Then how could any BH
> > keep running (including migration's) without qemu_main_loop()?
> 
> The aio_bh_poll() -> aio_bh_call() sequence doesn't depend on
> qemu_main_loop(). In the stack you found below it happens after
> aio_wait_bh_oneshot() -> AIO_WAIT_WHILE -> aio_poll().
> 
> The stack I see is:
> 
> #0  0x00005625c97bffc0 in multifd_recv_terminate_threads (err=0x0) at ../migration/multifd.c:992
> #1  0x00005625c97c0086 in multifd_load_shutdown () at ../migration/multifd.c:1012
> #2  0x00005625c97b6163 in process_incoming_migration_bh (opaque=0x5625cbce59f0) at ../migration/migration.c:624
> #3  0x00005625c9c740c2 in aio_bh_call (bh=0x5625cc9e1320) at ../util/async.c:169
> #4  0x00005625c9c741de in aio_bh_poll (ctx=0x5625cba2a670) at ../util/async.c:216
> 
> here^
> 
> #5  0x00005625c9af0599 in bdrv_graph_wrunlock () at ../block/graph-lock.c:170
> #6  0x00005625c9aba8bd in bdrv_close (bs=0x5625cbcb3d80) at ../block.c:5099
> #7  0x00005625c9abb71a in bdrv_delete (bs=0x5625cbcb3d80) at ../block.c:5501
> #8  0x00005625c9abe840 in bdrv_unref (bs=0x5625cbcb3d80) at ../block.c:7075
> #9  0x00005625c9abe865 in bdrv_schedule_unref_bh (opaque=0x5625cbcb3d80) at ../block.c:7083
> #10 0x00005625c9c740c2 in aio_bh_call (bh=0x5625cbde09d0) at ../util/async.c:169
> #11 0x00005625c9c741de in aio_bh_poll (ctx=0x5625cba2a670) at ../util/async.c:216
> #12 0x00005625c9af0599 in bdrv_graph_wrunlock () at ../block/graph-lock.c:170
> #13 0x00005625c9ae05db in blk_remove_bs (blk=0x5625cbcc1070) at ../block/block-backend.c:907
> #14 0x00005625c9adfb1b in blk_remove_all_bs () at ../block/block-backend.c:571
> #15 0x00005625c9abab0d in bdrv_close_all () at ../block.c:5146
> #16 0x00005625c97892e4 in qemu_cleanup (status=0) at ../system/runstate.c:880
> #17 0x00005625c9a58081 in qemu_default_main () at ../system/main.c:38
> #18 0x00005625c9a580af in main (argc=35, argv=0x7ffe30ab0578) at ../system/main.c:48
> 
> > Hmm, I saw a pretty old stack mentioned in commit fd392cfa8e6:
> >
> >     Original output:
> >     qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown process>)
> >     =================================================================
> >     ==31958==ERROR: AddressSanitizer: heap-use-after-free on address 0x61900001d210
> >       at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
> >     READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
> >         #0 0x555558a535c9 in migrate_fd_cleanup migration/migration.c:1502:23
> >         #1 0x5555594fde0a in aio_bh_call util/async.c:90:5
> >         #2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
> >         #3 0x555559524783 in aio_poll util/aio-posix.c:725:17
> >         #4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wait.c:71:5
> >         #5 0x5555573bddf6 in virtio_blk_data_plane_stop
> >           hw/block/dataplane/virtio-blk.c:282:5
> >         #6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/virtio/virtio-bus.c:246:9
> >         #7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/virtio/virtio-pci.c:287:5
> >         #8 0x5555589e22bf in virtio_pci_vmstate_change hw/virtio/virtio-pci.c:1072:9
> >         #9 0x555557628931 in virtio_vmstate_change hw/virtio/virtio.c:2257:9
> >         #10 0x555557c36713 in vm_state_notify vl.c:1605:9
> >         #11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
> >         #12 0x55555716eeff in vm_shutdown cpus.c:1092:12
> >         #13 0x555557c4283e in main vl.c:4617:5
> >         #14 0x7fffdfdb482f in __libc_start_main
> >           (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
> >         #15 0x555556ecb118 in _start (x86_64-softmmu/qemu-system-x86_64+0x1977118)
> >
> > Would that be the same case that you mentioned here?  As vm_shutdown() is
> > indeed after migration_shutdown().
> >
> > Even if so, two follow up comments..
> >
> > (1) How did it help if process_incoming_migration_bh() took ref on
> >     MigrationState*?  I didn't even see it touching the object (instead, it
> >     uses the incoming object)?
> 
> We touch MigrationState every time we check for a capability. See the
> stack I posted above: process_incoming_migration_bh() ->
> multifd_load_shutdown().
> 
> void multifd_load_shutdown(void)
> {
>     if (migrate_multifd()) {        <-- HERE
>         multifd_recv_terminate_threads(NULL);
>     }
> }
> 
> The bug reproduces *without* multifd, because that check passes and we
> go into multifd code that has not been initialized.
> 
> side note: we should probably introduce a MigrationOutgoingState to pair
> with MigrationIncomingState and have both inside a global MigrationState
> that contains the common elements. If you agree I can add this to our
> todo list.

Yep, feel free to add an entry.

Though instead of MigrationOutgoingState, maybe it's easier to keep
MigrationState to be the "outgoing state", then move both caps/params (and
anything shared between src/dst) out of MigrationState?  That can be a
separate struct, e.g., MigrationGlobals.

> 
> > (2) This is what I'm just wondering.. on whether we should clear
> >     current_migration to NULL in migration_shutdown() after we unref it.
> >     Maybe it'll make such issues abort in an even clearer way.
> 
> It hits the assert at migrate_get_current():
> 
> #4  0x00005643006e22ae in migrate_get_current () at ../migration/migration.c:246
> #5  0x00005643006f0415 in migrate_late_block_activate () at ../migration/options.c:275
> #6  0x00005643006e30e0 in process_incoming_migration_bh (opaque=0x564303b279f0) at ../migration/migration.c:603
> #7  0x0000564300ba10cd in aio_bh_call (bh=0x564304823320) at ../util/async.c:169
> #8  0x0000564300ba11e9 in aio_bh_poll (ctx=0x56430386c670) at ../util/async.c:216
> ...
> #20 0x00005643006b62e4 in qemu_cleanup (status=0) at ../system/runstate.c:880
> #21 0x000056430098508c in qemu_default_main () at ../system/main.c:38
> #22 0x00005643009850ba in main (argc=35, argv=0x7ffc8bf703c8) at
> #../system/main.c:4
> 
> Note that this breaks at migrate_late_block_activate(), which is even
> earlier than the bug scenario at multifd_load_shutdown().
> 
> However we cannot set NULL currently because the BHs are still running
> after migration_shutdown(). I don't know of a safe way to cancel/delete
> a BH after it has (potentially) been scheduled already.

Indeed..  I am not sure whether migration can avoid using BHs some day.
E.g., I am not sure whether those tasks can be done synchronously under bql
already.

-- 
Peter Xu


