Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3367CC9BB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnkA-0005dE-3V; Tue, 17 Oct 2023 13:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnk4-0005Ww-VQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:20:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnjz-0004Ue-TH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:20:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso5073495e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697563222; x=1698168022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pJajnUNuQ8B5vQu51xkWmU+KD+1VOFyYtfMHMOHhv9M=;
 b=pQgsaW3hVjMelmupI96gifG+lcmYD0TsHgxbg9NmTHU3CbI/kjxgtMoY54h/HBwj8L
 6yRqIm6xozEyvbfMcw9WUa2t0LMvOUcTLAGIjUhS8KsF3fL2yYO7VIVEJGRSlUjzpYeg
 ZCtuIq9+6JIf6c82xoXqIU/u9M/kl9vtOR6vmdWNPiTmwqvSzG0w8Rhi+uQaRkbtwN53
 tn10p3GLNvRFVE3DxeVLnB6uywl/pSWaANf/Zem1u/zEYZKg5yk1zCSFk4KCDr3USTc9
 79oNpPH2qdnSq3IltcqETrCwljhdHTP9aj9djOr5bbfWJV3aYJdp32+mtIZ+yNKZpiCN
 uGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697563222; x=1698168022;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJajnUNuQ8B5vQu51xkWmU+KD+1VOFyYtfMHMOHhv9M=;
 b=fLYTl40vgs9ElFvNfJZHBHBr9VBfGFKssDVSLAPPOsMvR0t+kD1/G8KwbH2ic2EFGj
 sdaaIjjiS2ixx4J6YDpW2eIRivKIoET7jDXh2dHYEPCAEMOybpwSU4gr8MiTl1R3lmPa
 S/NqxpyEcZoy8K3h7IkR3NbtR9X19jKoOlYNid6kk5Ne6IqA84XS1XAZiv2AgUKwqkPX
 HbmQNjbvWKOZC/nkftzxMVArU1VjQzKKgngcTwdo/ejHUObIscE3nzQ6LlXDwVekQ7Ba
 kuUtssIWJmlvDQ37Q7EKWPzlt57uNRlb4cyD1HlrE72pnYNpCFdTPvGd4ezjNA5rVH0Y
 IyjA==
X-Gm-Message-State: AOJu0YxcdHSdnVJH+w0wGIjIu6hsyXkO64xZlz1iIF4IHdTA4bebqk2D
 62tZkSTjHA8HYwrxYfOxTehvNkzuXdLBPFQ+SA0=
X-Google-Smtp-Source: AGHT+IHLeqyQfckdqxZCj4FBvy8W4JGfGlrVwl32BNi2cCaP3PfjcsBICEXi4DYjr45aX/qm8eBrlA==
X-Received: by 2002:a05:600c:1c26:b0:404:7462:1f6f with SMTP id
 j38-20020a05600c1c2600b0040474621f6fmr2144359wms.8.1697563222292; 
 Tue, 17 Oct 2023 10:20:22 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c470600b004054dcbf92asm2294632wmo.20.2023.10.17.10.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:20:22 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:19:48 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 4/7] hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
User-Agent: meli 0.8.2
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-5-philmd@linaro.org>
In-Reply-To: <20231017140150.44995-5-philmd@linaro.org>
Message-ID: <2oo5v.5h3xlfdx66bx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Oct 2023 17:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Access QOM parent with the proper QOM VIRTIO_SCSI_COMMON() macro.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/scsi/virtio-scsi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>index 45b95ea070..fa53f0902c 100644
>--- a/hw/scsi/virtio-scsi.c
>+++ b/hw/scsi/virtio-scsi.c
>@@ -761,7 +761,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
> 
> static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
> {
>-    VirtIOSCSICommon *vs = &s->parent_obj;
>+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
>     SCSIDevice *d;
>     int rc;
> 
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

