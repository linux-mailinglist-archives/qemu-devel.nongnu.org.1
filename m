Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FEF7122A6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2T8M-0004i1-6U; Fri, 26 May 2023 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2T8K-0004hU-5B
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2T8H-0004oV-L6
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685090948;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bVJZ/yFCfppIAAEs4M+JRqoPasQ/93SkVCEvfupkLZI=;
 b=CJh+zxxcWHjjtEI0s9xgLycXuRYasEv1eIXRmADzGkdI1r+FDmOKQtA65q2YcnO91Vi5Vs
 4AH7V+x2NZ5FY4XyVlhaRHKAMI2/dTZ2j0FjenocMIbdoQKjhXJw9D+L0vCCH+BsWhzWWu
 S1H9SA9R4L1o3Gdo51+WgBmN/6M/fv8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-d5sWKwN1MsmKZ8TfKyPBGg-1; Fri, 26 May 2023 04:49:07 -0400
X-MC-Unique: d5sWKwN1MsmKZ8TfKyPBGg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30ac89cc4faso346114f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685090946; x=1687682946;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVJZ/yFCfppIAAEs4M+JRqoPasQ/93SkVCEvfupkLZI=;
 b=MYuzaocAHL13/48jnWCK27gY2V0nfYfNUSHxqQvUz/+7CqbhzWBG8jMYvI790jBDVp
 kFPAW4eRPiOOm6EF1WFbJPJSnC/aM+tPjtnLVI/hxwG4rKgcPTKCDJePL8ne4L7n6U8h
 8LRM/D07fQJgTRsGKUi1kqqmZbU7GcbaNWCihcc9SamSoVJOFWNmze7O+dslhGat4WlT
 cQCdEGO9hknclXSc0fa9Vz9D+nJkScWYXUGd+sebEbDCEKrz3yrjrHSF/NVAF6zSOI6M
 YzUOJhIDDBJpn4HS67nkcfW0OGHMefAT8JcGFpXMIvB6zU3MuLCZvtWJyJpO5gfzz0Pf
 TXEg==
X-Gm-Message-State: AC+VfDy6c7h6UAkhmEQxjkr1tZp2dbapknsS7SWh/BRP3EAKacM7NlFV
 86s8l6f9fW1bLYQt9R+7iofHIky8nagCyfhbKoaaaea9KBxO/fGc3yGhW1eOXMefGfNzvqCyClA
 FPMgu77vN8FFPhu0=
X-Received: by 2002:a5d:6ac4:0:b0:30a:8e6a:3d77 with SMTP id
 u4-20020a5d6ac4000000b0030a8e6a3d77mr921430wrw.1.1685090945954; 
 Fri, 26 May 2023 01:49:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61Y4vYZB103i5DqgZkwMUpewyL39uhFNHJb85dwXGLhNMYnACFvzNMJaurjfl3QewKE//kkQ==
X-Received: by 2002:a5d:6ac4:0:b0:30a:8e6a:3d77 with SMTP id
 u4-20020a5d6ac4000000b0030a8e6a3d77mr921404wrw.1.1685090945674; 
 Fri, 26 May 2023 01:49:05 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 e2-20020adffc42000000b002ff2c39d072sm4347577wrs.104.2023.05.26.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:49:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 eblake@redhat.com,  vsementsov@yandex-team.ru,  jsnow@redhat.com,
 stefanha@redhat.com,  fam@euphon.net,  qemu-block@nongnu.org,
 pbonzini@redhat.com,  t.lamprecht@proxmox.com
Subject: Re: [PATCH v2] migration: hold the BQL during setup
In-Reply-To: <20230525164726.45176-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Thu, 25 May 2023 18:47:26 +0200")
References: <20230525164726.45176-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:49:04 +0200
Message-ID: <87bki732bj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> The comment in ram_init_bitmaps() was introduced by 4987783400
> ("migration: fix incorrect memory_global_dirty_log_start outside BQL")
> and is removed, because it referred to the qemu_mutex_lock_iothread()
> call.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I think we will take this bit, because the problem exist and this is
best solution that I can came with.

Later, Juan.


