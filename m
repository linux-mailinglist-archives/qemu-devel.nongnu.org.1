Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5237F3F2E
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hxD-0001tD-6l; Wed, 22 Nov 2023 02:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hxA-0001sP-Bf
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:47:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hx8-0004VY-Ks
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:47:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b2979a74eso11537145e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700639237; x=1701244037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YehAvXc4EQJyJQya1v7MbTAaXaMsR4wDVzXUCfk80rc=;
 b=fp28/7YNzrmV2c+BI/QdmyBMGCc/WtsBadm1AXsCs3Da2z28cd+KyY90f511+wJFNa
 HmtJBBaaxLvmI65E/ZGdN9aEr5z074EhOOiieAMQAXUV3F5LgBbqXn+SAtmUDeU0Y9kI
 d/1MTdTF07WwdoICk+zA3k9kR7CgALKtD98SdPoSgxEYvhfn1/1SC3BMz7eatcyTGjpv
 zWNNGUVaEC0mpNC3ZdLRRKG3upfB0swZx1ABHCyy1yOxR49isRERzYS4daoku8kkP8hH
 6xR+ABwIA6PbUbjniPhelrmPzmGwxuW8UYjkaQlZi5U113GgCpYw9goagQ5jOKCC7cOi
 0YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700639237; x=1701244037;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YehAvXc4EQJyJQya1v7MbTAaXaMsR4wDVzXUCfk80rc=;
 b=E/YMCROWtS/xGfyW2xkI/9Rth8mMwIvWOP6/DybtTBBV519v/58chudkB3VSRcu0xg
 WZt7w30fzezJ9k9ae4YK8S9D9T19o9QHJyvTSkt2xXzOCDjsOml8bMrchA1PlkS9KWO9
 EAXKKYIbDOLxr7dRvKSrb49VzB+YdvO4UEpfyLJ83pESxzANTp/HpJ/zlqqB0BdxSl8i
 UtEKGblROfS/riOamPtbCpl/yXmqO1+MRW43xiSVU5hQh3wil13yB9P4KsbDWkpqPhyN
 OFPcrcxDhWnsa1DO8jD98pKZ73FoGXhGgOLNgAfYLvDyOe/KjZCFopqoV/UIwHl25ZuQ
 aQ7g==
X-Gm-Message-State: AOJu0Yz1lhx4/Sx36OyxEOu4N82MacdiO45DOhcz0LrXKbv4VE4PrD1V
 qtjgQlgY+6pr6bbv37LbxTOPQw==
X-Google-Smtp-Source: AGHT+IHD4fcn+Lf1d34JS5okWR2qDscpOTAS35J2jyZe3aQAOS0WMXFC0F/xloUi7uhU1+KIPdBr/w==
X-Received: by 2002:a05:600c:3ca0:b0:406:c6de:2bea with SMTP id
 bg32-20020a05600c3ca000b00406c6de2beamr1175098wmb.17.1700639237203; 
 Tue, 21 Nov 2023 23:47:17 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a05600c474a00b0040b2c195523sm1268259wmo.31.2023.11.21.23.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:47:16 -0800 (PST)
Date: Wed, 22 Nov 2023 09:46:43 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH-for-9.0 24/25] hw/nvram: Simplify
 memory_region_init_rom_device() calls
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-25-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-25-philmd@linaro.org>
Message-ID: <4ilmq.kfqrve6jtfy@linaro.org>
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Mechanical change using the following coccinelle script:
>
>@@
>expression mr, owner, arg3, arg4, arg5, arg6, errp;
>@@
>-   memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp);
>    if (
>-       errp
>+       !memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp)
>    ) {
>        ...
>        return;
>    }
>
>and removing the local Error variable.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/nvram/nrf51_nvm.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
>index 7f1db8c423..7b25becd49 100644
>--- a/hw/nvram/nrf51_nvm.c
>+++ b/hw/nvram/nrf51_nvm.c
>@@ -336,12 +336,9 @@ static void nrf51_nvm_init(Object *obj)
> static void nrf51_nvm_realize(DeviceState *dev, Error **errp)
> {
>     NRF51NVMState *s = NRF51_NVM(dev);
>-    Error *err = NULL;
> 
>-    memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
>-        "nrf51_soc.flash", s->flash_size, &err);
>-    if (err) {
>-        error_propagate(errp, err);
>+    if (!memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
>+                                       "nrf51_soc.flash", s->flash_size, errp)) {
>         return;
>     }
> 
>-- 

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



