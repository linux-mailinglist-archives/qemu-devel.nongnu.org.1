Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC857091E9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvl1-0003GZ-Al; Fri, 19 May 2023 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzvkx-0003CY-9G
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzvkv-0006Z8-Qs
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684485992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YEL2y9nbWEymaZC5VtAMnGiLPQ/RQ8cB14tNAAAKQbE=;
 b=jBoGE+yhDyJU8tn+oBFSf7CVe1KuktwUqE9E9yw3502zY2mq3YU3nCnKqhFdU2TSW2YUJE
 hjfukVqOEiwJBeZvM0kV4mE79XqcEjq2hc3sW+VK5raG8BiL0w0zU8oMsl5VVEo/+rGbUE
 MCwEZbuH26sF58sf5Sg3wt/7FHAqzNk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-KfXMMNtFN8C6D4_GSEsMYA-1; Fri, 19 May 2023 04:46:30 -0400
X-MC-Unique: KfXMMNtFN8C6D4_GSEsMYA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-510d8e4416cso3230962a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684485990; x=1687077990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEL2y9nbWEymaZC5VtAMnGiLPQ/RQ8cB14tNAAAKQbE=;
 b=JaYHWM/HuCNE7EdsrdxVg5EyE655f8cmshZUgTmfXi1O9Mq+HRorqGUWbB3qa7euAF
 Dh0EkWpX/sZUnhDAqBth8p7DITrMzg3cx4FB5Fth/VArWFs7ZhYkP3jWNvAigdtyIes3
 9qCT3suCXWSC+FUAvOHNE7/3vv/GYxPbFBsx/iwmFkDRbGcZYbEqq0/ImIRzvcdITofK
 V1oBvSuETAikz0oL9u0PoJDH0Hwil1Mj+nCzXSvMbSGoO3S8LDHoipw/ovRIIBahO4TW
 TJ9ob5JDke4PBjCLAIXBtWNbxJ4aQW2RdXSn2hLwlhxp0QMc+C8VS/JxwRMJVbMOj2eB
 IFkw==
X-Gm-Message-State: AC+VfDxmIjzF7ssc+hqOFm3Uwk3i68VgD6WOx8OY/QdksnV6U6CtLzPm
 6xobrQSlzT0DEn6x+0lu+mnw+NBYQJyNJfhTSOfsd3UoLx9lBb2Pz25Grc5p5UBE46Gz7mC+cNi
 q975TfU3gEGE9EXA=
X-Received: by 2002:a17:907:6d26:b0:957:2e48:5657 with SMTP id
 sa38-20020a1709076d2600b009572e485657mr888538ejc.68.1684485989854; 
 Fri, 19 May 2023 01:46:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5SxN5pRvFk0iFfnDnDMghNaM1OvyjcQaMREZ/NtKawPbRiFV6lVdDqQ5/uyeE2nKgNGlLyqw==
X-Received: by 2002:a17:907:6d26:b0:957:2e48:5657 with SMTP id
 sa38-20020a1709076d2600b009572e485657mr888509ejc.68.1684485989512; 
 Fri, 19 May 2023 01:46:29 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a1709066c9700b0094f4d2d81d9sm1996669ejr.94.2023.05.19.01.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:46:28 -0700 (PDT)
Date: Fri, 19 May 2023 10:46:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/6] block/nvme: convert to blk_io_plug_call() API
Message-ID: <utuievutol5cux2axpym7x3t4tueresl4tbqadizc36f5yblpi@ndpva7u6croa>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230517221022.325091-3-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 17, 2023 at 06:10:18PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> block/nvme.c | 44 ++++++++++++--------------------------------
> 1 file changed, 12 insertions(+), 32 deletions(-)
>
>diff --git a/block/nvme.c b/block/nvme.c
>index 5b744c2bda..100b38b592 100644
>--- a/block/nvme.c
>+++ b/block/nvme.c
>@@ -25,6 +25,7 @@
> #include "qemu/vfio-helpers.h"
> #include "block/block-io.h"
> #include "block/block_int.h"
>+#include "sysemu/block-backend.h"
> #include "sysemu/replay.h"
> #include "trace.h"
>
>@@ -119,7 +120,6 @@ struct BDRVNVMeState {
>     int blkshift;
>
>     uint64_t max_transfer;
>-    bool plugged;
>
>     bool supports_write_zeroes;
>     bool supports_discard;
>@@ -282,7 +282,7 @@ static void nvme_kick(NVMeQueuePair *q)
> {
>     BDRVNVMeState *s = q->s;
>
>-    if (s->plugged || !q->need_kick) {
>+    if (!q->need_kick) {
>         return;
>     }
>     trace_nvme_kick(s, q->index);
>@@ -387,10 +387,6 @@ static bool nvme_process_completion(NVMeQueuePair *q)
>     NvmeCqe *c;
>
>     trace_nvme_process_completion(s, q->index, q->inflight);
>-    if (s->plugged) {
>-        trace_nvme_process_completion_queue_plugged(s, q->index);

Should we remove "nvme_process_completion_queue_plugged(void *s,
unsigned q_index) "s %p q #%u" from block/trace-events?

The rest LGTM!

Thanks,
Stefano


