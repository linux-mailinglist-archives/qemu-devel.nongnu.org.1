Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0527CC9B9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnje-0004us-Uw; Tue, 17 Oct 2023 13:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnjV-0004pB-Pf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:19:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsnjP-0004Av-GO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:19:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso5479685e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697563184; x=1698167984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hdv1QGcQquHUfS6KKbJt8qrZI9q9oxSm67P2iVi590Q=;
 b=cR2DzsJfN0TRiBuqbNxk+W0HjjzIiBOt/NyRwWZ7B0GCZeQ/1Xl/4LRPuzhmfPg8Ot
 0aziTiQxmzvFLTeZ4+2774SMpEmq1ujIWDDyeT3J+U+vEmuBmWHwRolGcakV0CiNS4So
 LRLQ1E4SsvzuX+N2XJevJLQ26ZKA/3RUl6hua2EHZ/U/yNxc7+hNA+As4yWr+oI5Pr7h
 DGpdMEiXyaubGHQaJ96S9oJr4w/s4JGxcdpbY5jrZ99ZsP5ZBh1iuOYqMd2IMHkiEhkY
 +fW+WMRAW02Q2YvPwDPMlIaJUElUJtnrCDtvVhxhg0BfNRNpsaAIsYbq8xdinooFDSh2
 ntZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697563184; x=1698167984;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hdv1QGcQquHUfS6KKbJt8qrZI9q9oxSm67P2iVi590Q=;
 b=drFcXyXlA9XxBMvLbWyRua+xxN0A2VKwIY/3fkmf/PTj3lGtfYaOR38ez6WTjNeln6
 +sEXGInN6+Nj1FSWF5YmaXR1GmyUAjP64erBO7VVmnWo1SaUSQ5v4z0/ibVjURKugY36
 GuKoONnIoUtteP7PhlZzrEt3HurlkLL85zgxRkNAys4qEZKG4dxVUezzCN+b+37OSmBP
 wbLspuQCgoaZJ+tGpOtC2qoZEpHHV746pm40T5pK9jks1s7VamwluKhWWVAHkTg2Vd81
 +ME2u/DVqMhl+lDoein34bNgrRWpNGgAu9CEtqEBeWjzg662qly3fNWycCoq1OQpiw88
 d5zA==
X-Gm-Message-State: AOJu0YwfU0NEZ3OXH3CBTWJECpezjEdMroM+MbsYoMyCsJonTXN8NLB+
 QDIKVYVk4Sm/d+0R24+f3RswZw==
X-Google-Smtp-Source: AGHT+IEMni6BdgCHcHwNsyMQwbW0x+/3yDtudfUz3cumY5kSUU89QQo2FT4P+Y4F4lzwPIxUKwdStw==
X-Received: by 2002:a05:600c:3146:b0:406:51a0:17ea with SMTP id
 h6-20020a05600c314600b0040651a017eamr2560496wmo.10.1697563184310; 
 Tue, 17 Oct 2023 10:19:44 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c19d000b00407754b998dsm2429187wmq.27.2023.10.17.10.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:19:43 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:19:22 +0300
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
Subject: Re: [PATCH 3/7] hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
User-Agent: meli 0.8.2
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-4-philmd@linaro.org>
In-Reply-To: <20231017140150.44995-4-philmd@linaro.org>
Message-ID: <2oo4t.qv8sufbzi8x0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>Access QOM parent with the proper QOM VIRTIO_DEVICE() macro.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/display/virtio-gpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>index 93857ad523..51cb517999 100644
>--- a/hw/display/virtio-gpu.c
>+++ b/hw/display/virtio-gpu.c
>@@ -1132,7 +1132,7 @@ static void virtio_gpu_ctrl_bh(void *opaque)
>     VirtIOGPU *g = opaque;
>     VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
> 
>-    vgc->handle_ctrl(&g->parent_obj.parent_obj, g->ctrl_vq);
>+    vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
> }
> 
> static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
>-- 
>2.41.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

