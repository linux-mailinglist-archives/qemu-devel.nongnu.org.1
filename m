Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF827D3C09
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxaq-0005f3-00; Mon, 23 Oct 2023 12:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1quxad-0005Iv-Ei
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1quxaa-0002eZ-Vk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40839807e82so20306285e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077735; x=1698682535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpxMMC0Od/uz08PSmYxq/ROkgKU67AYMrN/Jii7P8Qg=;
 b=JEpH9h3h/yzupxI2706NEeeGMHHXBVKDUbay2vARUGzZ6v1x5GuSHqVIWXwXQxBAHe
 oC34OZFjwR+0WsYNe2c9cQpumsOyIRZ9j33FQZIDJ9P36V3DnZlCocgQeCcsiF7HELsr
 69SQZBZBqx+pNhmsoUAiWtD/JjXtRefvU3b1vq7dhP36VFVUIRpQH7yc69q6YCTd5BQ3
 XvbrgkpXUHSeFH88VYgSxzUE4Sq33hqrGBnXLTT6+7/e7LzrkooOZXxglfoZWznJ60KY
 nqFDJ7IodVR5EN/ZlQg8dG5DDhSbi63grPCvnJlElpIUy8+iFei+Ke3x+8MJIRVmESiv
 74dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077735; x=1698682535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpxMMC0Od/uz08PSmYxq/ROkgKU67AYMrN/Jii7P8Qg=;
 b=CajF+gX40cJQPWbbipuE15Lol5ejOxIWBl5gHfpKARNBAfzO0bt9HGwwLjx8iG37lI
 0+4vCkGuwUPkST2CZn7FInyArrPmaYvKwxWr9Q+ovbeHUfzdnnuF0KKJSnRdFL/CJl8a
 5ZHQQCWFQnfo0iipm2jZ7FIMnyQVKQgPh8zl4Z0e5bWt7SjM2VoF5wkNrcN5Zn5ibKYE
 iYM+KK+xFms9zmgcE+/eCrIZdKySnmxNqJHSji5cbx9Z2b/ehTPLamBu63WzZ8YUF/S4
 OwSpqyzCrLUTWGtDuNXHijRdBzN46GBsJX5fq/g6GFVGwsGAvIhoAijT+NqQNe9zr9pJ
 iCRg==
X-Gm-Message-State: AOJu0YxbmhnvBdPk6zks5gQxOp5CzhG6LZwZi/y7DjnBQwkQnYdN2bG6
 LfjlygX+W8STO58e2gN1b9lIcg==
X-Google-Smtp-Source: AGHT+IHBMYz2nru+bmjUTX3k3hWWX/uCtew6SfbETuqxJCTbjJjVBe8x1V6/aOZ06KJm91o8HVoOmg==
X-Received: by 2002:a05:600c:4c21:b0:401:c717:ec6d with SMTP id
 d33-20020a05600c4c2100b00401c717ec6dmr12663856wmp.15.1698077735330; 
 Mon, 23 Oct 2023 09:15:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm14460597wmf.39.2023.10.23.09.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Axel Heider <axel.heider@hensoldt.net>, Laszlo Ersek <lersek@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] hw/arm/virt: Add serial aliases in DTB
Date: Mon, 23 Oct 2023 17:15:30 +0100
Message-Id: <20231023161532.2729084-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161532.2729084-1-peter.maydell@linaro.org>
References: <20231023161532.2729084-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

If there is more than one UART in the DTB, then there is no guarantee
on which order a guest is supposed to initialise them.  The standard
solution to this is "serialN" entries in the "/aliases" node of the
dtb which give the nodename of the UARTs.

At the moment we only have two UARTs in the DTB when one is for
the Secure world and one for the Non-Secure world, so this isn't
really a problem. However if we want to add a second NS UART we'll
need the aliases to ensure guests pick the right one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 529f1c089c0..b714ff1c03d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -280,6 +280,8 @@ static void create_fdt(VirtMachineState *vms)
         }
     }
 
+    qemu_fdt_add_subnode(fdt, "/aliases");
+
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
      * optional but in practice if you omit them the kernel refuses to
@@ -889,7 +891,9 @@ static void create_uart(const VirtMachineState *vms, int uart,
 
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
-- 
2.34.1


