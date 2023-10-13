Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12777C8136
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDzi-0003Fd-Hg; Fri, 13 Oct 2023 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrDzd-0002um-UG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrDzc-00031t-2L
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697187478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kjVljzrfkacdyjBIt7VzqqqVwZXwsPmhN7VJ+gJC0zo=;
 b=E1CoZH7mUeboFJffLy2Dho+jFbB6SZxmjMQ2vg8FnVbrqMZL20Jv9ME781yoMdacnWUtNr
 WeK4B3x/YLNavfdSxQsqr8fJIsGygW6JWma7bhPoErNrpa24MB1mOk2Mb/t8fxiCNsT9i4
 xFpC/kCQFpvLu6WrErk2fUBmNQ2Yen0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-2lu-G9T9Oi-beMJmDMo0WQ-1; Fri, 13 Oct 2023 04:57:57 -0400
X-MC-Unique: 2lu-G9T9Oi-beMJmDMo0WQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so13251795e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187476; x=1697792276;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjVljzrfkacdyjBIt7VzqqqVwZXwsPmhN7VJ+gJC0zo=;
 b=mqfCCXpFhlurUPBr7vUVg94BsXvwfECFNNZqB3933/JXu0tDOqNTLaIVOL7ksHqsGr
 5VES5ahDKXb2lQBZg7tPQK4i3siJGFnPOzNbYNhGLkujQR2dHDIxDUe91Fa+L/S4k9aH
 S9hw4l118TDiHWbSFOjrDbz4W5hsQUU82IhzUN9QjAT5AOwLRdAX9kb945Ysxp1CRlxk
 uOVSOd5ljsnnesqfytbSDZ+M4BEbc9gv4RQPuqjA4cb3gVFawDSjd7vyCNOFQmkgEsw7
 +ERNDTQoWIpG0M8Mi2+5BKnpcLMpwVVmIuzYUV6ckPI8tNzE4eCxwxnSkABRjTlWYt2m
 KbQg==
X-Gm-Message-State: AOJu0YxQf9dRkxyTZaHSyC7RLq7V+qN2NjvZ1PL3DHop35TbwtiZcZJj
 Qm7v7jIDm3fDyULgYQTVQ9gkhwc6OfMZMq+ahPSH+wCXIptEAPQsuLxpORtzpkhzOfWZYVPouRu
 ZrYgadp9Ks55Km+s=
X-Received: by 2002:a05:600c:1e0b:b0:407:462a:7e9f with SMTP id
 ay11-20020a05600c1e0b00b00407462a7e9fmr14272704wmb.27.1697187475905; 
 Fri, 13 Oct 2023 01:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEclJxGyw5l5hjqs93cEFdwawve/gZLaaShJyJ+Y78kbU3lJFM+TGquSzNMTKYGBsx7YwbZbw==
X-Received: by 2002:a05:600c:1e0b:b0:407:462a:7e9f with SMTP id
 ay11-20020a05600c1e0b00b00407462a7e9fmr14272686wmb.27.1697187475551; 
 Fri, 13 Oct 2023 01:57:55 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c469300b00407752f5ab6sm638802wmo.6.2023.10.13.01.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:57:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  fam@euphon.net,
 stefanha@redhat.com,  jsnow@redhat.com,  vsementsov@yandex-team.ru,
 eblake@redhat.com,  leobras@redhat.com,  farosas@suse.de,
 peterx@redhat.com,  pbonzini@redhat.com,  t.lamprecht@proxmox.com
Subject: Re: [PATCH v4] migration: hold the BQL during setup
In-Reply-To: <20231012103307.371092-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Thu, 12 Oct 2023 12:33:07 +0200")
References: <20231012103307.371092-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 13 Oct 2023 10:57:53 +0200
Message-ID: <87pm1i6gry.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> wrote:
> This is intended to be a semantic revert of commit 9b09503752
> ("migration: run setup callbacks out of big lock"). There have been so
> many changes since that commit (e.g. a new setup callback
> dirty_bitmap_save_setup() that also needs to be adapted now), it's
> easier to do the revert manually.
>
> For snapshots, the bdrv_writev_vmstate() function is used during setup
> (in QIOChannelBlock backing the QEMUFile), but not holding the BQL
> while calling it could lead to an assertion failure. To understand
> how, first note the following:
>
> 1. Generated coroutine wrappers for block layer functions spawn the
> coroutine and use AIO_WAIT_WHILE()/aio_poll() to wait for it.
> 2. If the host OS switches threads at an inconvenient time, it can
> happen that a bottom half scheduled for the main thread's AioContext
> is executed as part of a vCPU thread's aio_poll().
>
> An example leading to the assertion failure is as follows:
>
> main thread:
> 1. A snapshot-save QMP command gets issued.
> 2. snapshot_save_job_bh() is scheduled.
>
> vCPU thread:
> 3. aio_poll() for the main thread's AioContext is called (e.g. when
> the guest writes to a pflash device, as part of blk_pwrite which is a
> generated coroutine wrapper).
> 4. snapshot_save_job_bh() is executed as part of aio_poll().
> 3. qemu_savevm_state() is called.
> 4. qemu_mutex_unlock_iothread() is called. Now
> qemu_get_current_aio_context() returns 0x0.
> 5. bdrv_writev_vmstate() is executed during the usual savevm setup
> via qemu_fflush(). But this function is a generated coroutine wrapper,
> so it uses AIO_WAIT_WHILE. There, the assertion
> assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> will fail.
>
> To fix it, ensure that the BQL is held during setup. While it would
> only be needed for snapshots, adapting migration too avoids additional
> logic for conditional locking/unlocking in the setup callbacks.
> Writing the header could (in theory) also trigger qemu_fflush() and
> thus bdrv_writev_vmstate(), so the locked section also covers the
> qemu_savevm_state_header() call, even for migration for consistentcy.
>
> The section around multifd_send_sync_main() needs to be unlocked to
> avoid a deadlock. In particular, the function calls
> socket_send_channel_create() using multifd_new_send_channel_async() as
> a callback and then waits for the callback to signal via the
> channels_ready semaphore. The connection happens via
> qio_task_run_in_thread(), but the callback is only executed via
> qio_task_thread_result() which is scheduled for the main event loop.
> Without unlocking the section, the main thread would never get to
> process the task result and the callback meaning there would be no
> signal via the channels_ready semaphore.
>
> The comment in ram_init_bitmaps() was introduced by 4987783400
> ("migration: fix incorrect memory_global_dirty_log_start outside BQL")
> and is removed, because it referred to the qemu_mutex_lock_iothread()
> call.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I don't have a better solution for this problem, if nobody complains in
the next couple of days, I will pull this change.

Thanks for the effort.


