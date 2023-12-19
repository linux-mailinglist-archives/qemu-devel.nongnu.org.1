Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F0818BC2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:03:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFcYc-0001QZ-5j; Tue, 19 Dec 2023 11:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFcYZ-0001Pq-Ui
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:02:55 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFcYY-000240-CD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 11:02:55 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59171d44b32so2969501eaf.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703001773; x=1703606573; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q1TWWv2MilufGhp96t648R9kBznbl9Ye5+wUQZ0yGzY=;
 b=VvTVbPiEjO+de74aaCjkl90GRGLxTUmIWMRwqwq5li6TzyUCBjXPU6aBIMobXRFQcu
 cOIjG7IxiqYIGqxtcBUAia3ysB8ocfctbwVpgIIs9NH4c3arKM786+rdzDb2O0GMJuoB
 s1RFzWkV5gdP5SnSHiKls6o3HSw26YMi7i3FfretDN9dtNWjF3zbOWLQ0Fa7JvPYysd0
 WSMTOTlEVRkr3xkOqok9QjpBI0fuRcGETYMA/6kpnotzQ5dHzVwFcELZXScCVBAmJrUE
 t8Mc2rqlSIOyEiNKwLRy6Re0zo7mONBapMJhXE2pZc9Om8G3s6dimQKNmoDhEIVCU5hY
 57ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001773; x=1703606573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1TWWv2MilufGhp96t648R9kBznbl9Ye5+wUQZ0yGzY=;
 b=E5fincEpiX2K7Z9uR7LcGrW7aWP3SCci5O16iSdXjDPLLCph50D7VHOlVmTh7IxTDw
 y/+SXgCil/cXtQTVxt5+hogdDqUqSn019368N2pYbTEDZzfVlf/9TnhhZq0xJ7Y8Z3h4
 at+7tlVrzma5CC+UqtOZJ6y1lPOtabtcFdSaPd8InRq2t6K4v9rGgyoU9PzNzowJXeWa
 NZ8RZq9vxxPbZrkVcXAwVMVQRoBgOl97/roWH5l03GNrvhHBexaymXW8kG5kO+A1Kio1
 A1Bf/x2+h++pC7e7m/XZmz8cu+Eq3j0XzGSznoKSsfNcu+ajZaR2SqX1YVQBs6WO3SKg
 i4jA==
X-Gm-Message-State: AOJu0YxrwjWypI0vHu3vWjzNqqJhBuzhc6Eo9+5v3sXtgug6lFWXyheD
 yHxkX8t+hcENTbIc2WI5CUgsfk0bNUE2j/JUU84=
X-Google-Smtp-Source: AGHT+IF933JLqqJnhPDa59I/G9WOI43Ltivpo4o1oHYtUjxVbSZaHQUqM+Zi48C5MTKEddCgqoHR4Jx50KgNni3BocM=
X-Received: by 2002:a4a:5513:0:b0:593:fb56:1206 with SMTP id
 e19-20020a4a5513000000b00593fb561206mr214783oob.17.1703001772774; Tue, 19 Dec
 2023 08:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20231204164259.1515217-1-stefanha@redhat.com>
 <20231204164259.1515217-2-stefanha@redhat.com>
 <ZYGyty5gxE_1caoX@redhat.com>
In-Reply-To: <ZYGyty5gxE_1caoX@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Dec 2023 11:02:40 -0500
Message-ID: <CAJSP0QWEuS21OkiV7ogWcpKDCWc83+=dVXJd2TMLbSO7Lu7mzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] scsi: only access SCSIDevice->requests from one
 thread
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 19 Dec 2023 at 10:12, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 04.12.2023 um 17:42 hat Stefan Hajnoczi geschrieben:
> > Stop depending on the AioContext lock and instead access
> > SCSIDevice->requests from only one thread at a time:
> > - When the VM is running only the BlockBackend's AioContext may access
> >   the requests list.
> > - When the VM is stopped only the main loop may access the requests
> >   list.
> >
> > These constraints protect the requests list without the need for locking
> > in the I/O code path.
> >
> > Note that multiple IOThreads are not supported yet because the code
> > assumes all SCSIRequests are executed from a single AioContext. Leave
> > that as future work.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> This makes qemu-iotests 238 240 245 307 fail for me (tested with qcow2).
>
> The crashes are segfaults and look like below. Maybe the device has gone
> away before the BH was executed? Though in theory we still hold a
> reference to the object.
>
> Kevin
>
>
> (gdb) bt
> #0  scsi_device_for_each_req_async_bh (opaque=0x558b4a2f6e90) at ../hw/scsi/scsi-bus.c:128
> #1  0x0000558b47e1c8e6 in aio_bh_poll (ctx=ctx@entry=0x558b4a518ef0) at ../util/async.c:216
> #2  0x0000558b47e0764a in aio_poll (ctx=0x558b4a518ef0, blocking=blocking@entry=true) at ../util/aio-posix.c:722
> #3  0x0000558b47cb1cd6 in iothread_run (opaque=opaque@entry=0x558b49822a60) at ../iothread.c:63
> #4  0x0000558b47e0a6e8 in qemu_thread_start (args=0x558b4a58d5b0) at ../util/qemu-thread-posix.c:541
> #5  0x00007f992f0ae947 in start_thread () at /lib64/libc.so.6
> #6  0x00007f992f134860 in clone3 () at /lib64/libc.so.6
> (gdb) l
> 123          * If the AioContext changed before this BH was called then reschedule into
> 124          * the new AioContext before accessing ->requests. This can happen when
> 125          * scsi_device_for_each_req_async() is called and then the AioContext is
> 126          * changed before BHs are run.
> 127          */
> 128         ctx = blk_get_aio_context(s->conf.blk);
> 129         if (ctx != qemu_get_current_aio_context()) {
> 130             aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh, data);

I forgot that data is g_autofree. This crash can be fixed by:

aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh,
g_steal_pointer(&data));

> 131             return;
> 132         }
> (gdb) p s
> $1 = (SCSIDevice *) 0x558b4a2f6
> (gdb) p *s
> Cannot access memory at address 0x558b4a2f6
>
>

