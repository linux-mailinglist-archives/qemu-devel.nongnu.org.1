Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4006818AEA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:13:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFblZ-00043m-PY; Tue, 19 Dec 2023 10:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFblW-00043Y-C0
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFblI-0001Qh-Ox
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702998719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQQvgGmKkHjIMgJTYI8r7fpnUXAzuKXK7BJPy4aM7Bg=;
 b=RUfmRz/G2H3iBLvCbqHJrmJVwK4XmKw5BRMXvIk8bk7qcRjmljQf/qtUbWY/6fPYUe6cmc
 R9KtECsAKH/2rd/k/LoMos0FSAk50TGU0//azxhix7X67y12j7f18ZigI/on0f3fh9tzPD
 jecE/dccEAPyoVoLc63JNFcPnTIeDCE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-YAvM-_oYMX6h2BDYcODUkw-1; Tue, 19 Dec 2023 10:11:54 -0500
X-MC-Unique: YAvM-_oYMX6h2BDYcODUkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBC0A8489E2;
 Tue, 19 Dec 2023 15:11:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8759D40C6EBA;
 Tue, 19 Dec 2023 15:11:52 +0000 (UTC)
Date: Tue, 19 Dec 2023 16:11:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/4] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <ZYGyty5gxE_1caoX@redhat.com>
References: <20231204164259.1515217-1-stefanha@redhat.com>
 <20231204164259.1515217-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204164259.1515217-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am 04.12.2023 um 17:42 hat Stefan Hajnoczi geschrieben:
> Stop depending on the AioContext lock and instead access
> SCSIDevice->requests from only one thread at a time:
> - When the VM is running only the BlockBackend's AioContext may access
>   the requests list.
> - When the VM is stopped only the main loop may access the requests
>   list.
> 
> These constraints protect the requests list without the need for locking
> in the I/O code path.
> 
> Note that multiple IOThreads are not supported yet because the code
> assumes all SCSIRequests are executed from a single AioContext. Leave
> that as future work.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

This makes qemu-iotests 238 240 245 307 fail for me (tested with qcow2).

The crashes are segfaults and look like below. Maybe the device has gone
away before the BH was executed? Though in theory we still hold a
reference to the object.

Kevin


(gdb) bt
#0  scsi_device_for_each_req_async_bh (opaque=0x558b4a2f6e90) at ../hw/scsi/scsi-bus.c:128
#1  0x0000558b47e1c8e6 in aio_bh_poll (ctx=ctx@entry=0x558b4a518ef0) at ../util/async.c:216
#2  0x0000558b47e0764a in aio_poll (ctx=0x558b4a518ef0, blocking=blocking@entry=true) at ../util/aio-posix.c:722
#3  0x0000558b47cb1cd6 in iothread_run (opaque=opaque@entry=0x558b49822a60) at ../iothread.c:63
#4  0x0000558b47e0a6e8 in qemu_thread_start (args=0x558b4a58d5b0) at ../util/qemu-thread-posix.c:541
#5  0x00007f992f0ae947 in start_thread () at /lib64/libc.so.6
#6  0x00007f992f134860 in clone3 () at /lib64/libc.so.6
(gdb) l
123          * If the AioContext changed before this BH was called then reschedule into
124          * the new AioContext before accessing ->requests. This can happen when
125          * scsi_device_for_each_req_async() is called and then the AioContext is
126          * changed before BHs are run.
127          */
128         ctx = blk_get_aio_context(s->conf.blk);
129         if (ctx != qemu_get_current_aio_context()) {
130             aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh, data);
131             return;
132         }
(gdb) p s
$1 = (SCSIDevice *) 0x558b4a2f6
(gdb) p *s
Cannot access memory at address 0x558b4a2f6


