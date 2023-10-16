Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A437C9F63
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsGuq-0000Nt-34; Mon, 16 Oct 2023 02:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsGud-0000Jz-1J
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsGuZ-000334-7s
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G/x+QlMrNmwuu009JLUT5ogUV4i1hzzRdhfK+9fHQ0I=;
 b=ZfJlEPMfEalK9PDLsrPLK/NbjvGlymxHouEZ44azDKyfCQq7m7TuVSCgppZW64S8LMFMtA
 B3oXRonaCwhF71Us9svkV7WPNjUWDYMB9NZHtfAUQeBmY9vFiaC4pA7aXZzSHhH2jWzYW0
 yGPH8YZAppce1t5WbUHR/f1Vd3l8sZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-FNRaRmygMCy6HH-RYRK3lg-1; Mon, 16 Oct 2023 02:17:03 -0400
X-MC-Unique: FNRaRmygMCy6HH-RYRK3lg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so346665f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437022; x=1698041822;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/x+QlMrNmwuu009JLUT5ogUV4i1hzzRdhfK+9fHQ0I=;
 b=wGH15sSp68zGSHtEabhuNS+0j0S0yKCnuEMQ5x76eBVIpntNc0sy4yB+bHBVYzBlX8
 GY+fTJ+McKkWNLiog+oXsdxU2gM193oOu7oCtSDeDM4g1dsjTOIsHon/UVNlAzoerLZU
 /fpTBKMoPKL+NL6mf/crx3G8jm8s3smh4PS2ba3prdlPSNEv9CMdDhgCu5VrF8HB4ktd
 inU9aDbTG2b8KVkBZB226pX+mQWFvSQ79tRmWnk9KvwgjS518MBeokhtlx1m6DKgJVxy
 J3Jd2FozfLSifJrUb8T/yDCNKUfUgnzDkb6CzPAkuWZsEx9sGAupZ5wPn/sR8hhYNN+u
 eSbw==
X-Gm-Message-State: AOJu0Yyis7I03fKO3qUUXrWHlJ9zzuuZwwsTOYd578Ge3dRjCB1KgWLL
 ATPjmDXIFlX/S4VwD9XPt0G2geyvgmL51Yd4bYaylIkIYAvKBkhmIg/19oSlXPjGxMO0NFftBVB
 oKG7QcjJEQ6urL6g=
X-Received: by 2002:adf:fd0e:0:b0:31c:804b:5ec3 with SMTP id
 e14-20020adffd0e000000b0031c804b5ec3mr30265213wrr.67.1697437022379; 
 Sun, 15 Oct 2023 23:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHilLscyICQSc9qS5HBBDpXXV7wtD9c9TZ67bv858ptPrp4vN0/fu9HB2OrRQ++a4IVsbj2QA==
X-Received: by 2002:adf:fd0e:0:b0:31c:804b:5ec3 with SMTP id
 e14-20020adffd0e000000b0031c804b5ec3mr30265194wrr.67.1697437022051; 
 Sun, 15 Oct 2023 23:17:02 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bg12-20020a05600c3c8c00b00405959469afsm6288453wmb.3.2023.10.15.23.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:17:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  fam@euphon.net,
 stefanha@redhat.com,  jsnow@redhat.com,  vsementsov@yandex-team.ru,
 eblake@redhat.com,  leobras@redhat.com,  farosas@suse.de,
 peterx@redhat.com,  pbonzini@redhat.com,  t.lamprecht@proxmox.com
Subject: Re: [PATCH v5] migration: hold the BQL during setup
In-Reply-To: <20231013105839.415989-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 13 Oct 2023 12:58:39 +0200")
References: <20231013105839.415989-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 08:16:59 +0200
Message-ID: <87il775bxg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> wrote:

queued.

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
> qemu_savevm_state_header() call, even for migration for consistency.
>
> The section around multifd_send_sync_main() needs to be unlocked to
> avoid a deadlock. In particular, the multifd_save_setup() function calls
> socket_send_channel_create() using multifd_new_send_channel_async() as a
> callback and then waits for the callback to signal via the
> channels_ready semaphore. The connection happens via


