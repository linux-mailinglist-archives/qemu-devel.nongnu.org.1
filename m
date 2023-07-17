Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4593756378
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNhQ-0002VT-5w; Mon, 17 Jul 2023 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdo-0008Q6-W6
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdm-0008T3-4H
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-314172bac25so4371172f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598068; x=1692190068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mgagk+e6MpB3ekgnXPZSkT6Pl5UPW0SEYnhBOt/GBFg=;
 b=wzCedMEseK9OTNg8QzVTmoGR9agSjno1fRQ1ZAVtbI77K/AV2mrrOrsVLkAeseCvAz
 fwuT/5ua9E43cEcSRKfI2wRNKLcdCN7/DgpEScZtEwAFbIcdnr6Y2eNkBqodMKoU3wRJ
 QJaoLvkVqVAcIv3MAcKgRbNyjh8Mgdnak4PfCBKwjJ4xveHAW7Z4MjVaurFv+ho3AFbV
 i6LP7byXDBVF3cmlVRqC3WEeO5y7i6+y7T44ClcczX1RofbIy8nvQ+EZw7glVZQFK932
 ImacDfzmJitd7fsvScxs668crL2y5zmWQi7U9HSqF9uNRwRPLD9Tm4i8DsI/YX+fRZun
 Lz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598068; x=1692190068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mgagk+e6MpB3ekgnXPZSkT6Pl5UPW0SEYnhBOt/GBFg=;
 b=J9yegF//1B50ZcEb2hCxwvNzg4dyC8wHvm7xTYHfNhHA6+bjyU225+Sj8WM86U/dsM
 02pTokq+XsIph3wtcZzgPSFtC/0wU46XwONdWNx7vJE73DX7jdsqKRTdOBTbsW8Dit70
 KfCUjS6B5WHxGfxxkX0qs/p4WtexR4ZT8o9B7IBdXWeGD0LZm+O+BVqQaJD06ZghANOa
 aOUlkn8BbhMe4qhac2snM6usiuGFdc85Vm0BbaEzocoaQWcfYmC3HE83L9kvVyKKF/wr
 QoEYHFKUuirNtFWhb0mwAT5jtabFCHrTckZ+HsRmM/INEvGAVyQLZfuJdM6kX2ha1vrq
 dXfQ==
X-Gm-Message-State: ABy/qLaJUo1YexzeLh8QmHIfK3aKPazAnt6XNJchw9beHy2bLtj+TWnE
 Naw+zRL1AMCIghonU9wsmhnQVDHYg3TbFgZcJws=
X-Google-Smtp-Source: APBJJlGOW9EcncmODijF1etGkA8Uu8pvtnwAUGXbJ6fQ+KIxZIhLU5HeSuZ65hATSvONFZSSfbK7Gw==
X-Received: by 2002:a5d:50c8:0:b0:314:20ee:2de7 with SMTP id
 f8-20020a5d50c8000000b0031420ee2de7mr9098085wrt.11.1689598068398; 
 Mon, 17 Jul 2023 05:47:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] hw/arm/sbsa-ref: set 'slots' property of xhci
Date: Mon, 17 Jul 2023 13:47:40 +0100
Message-Id: <20230717124746.759085-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This extends the slots of xhci to 64, since the default xhci_sysbus
just supports one slot.

Signed-off-by: Wang Yuquan <wangyuquan1236@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20230710063750.473510-2-wangyuquan1236@phytium.com.cn
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 64e1cbce171..bc89eb48062 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -611,6 +611,7 @@ static void create_xhci(const SBSAMachineState *sms)
     hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_XHCI];
     DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
+    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-- 
2.34.1


