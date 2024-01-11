Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7175382AD17
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:13:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssR-0001RC-RQ; Thu, 11 Jan 2024 06:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss6-0001Kr-Tm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss3-0004NS-Ci
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33770772136so2385590f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971109; x=1705575909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g2GtSaJUPBG1REo0r/4JXTUdrbWAUpzKuEobonnT25Y=;
 b=qYaM8sqNLWi8H2MFqYYUhDiScUhuE//McLJoxPbjJNCqJphldMUfJZ1CY2ZB4I0FVC
 c5CR2X+XOxTytwRS3srGOvxKsUsvVfxJFzPXmlskipLW2gstKo57dzX5TfgstLtmvHor
 O9IkaLzfNSG40shtM94Z0VszUDLoi64G89h+JTz5De4OxZiWJhhnmp19wLpPm6s4gXP/
 QIa0doB/1M6keWxC1nwo2gB/5KCfk6CslQZZOpCYDHWv5iY0w4ld6jPVohvTZWiiM7/Q
 Pkq8at9AlAw4CiyiEWn/sSJPKFOpSPNOYtyTLVEyVi4psgMKxqAES2StkPkgbTWWsqBS
 WKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971109; x=1705575909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2GtSaJUPBG1REo0r/4JXTUdrbWAUpzKuEobonnT25Y=;
 b=AP82yo8t77/NDu34QF7jUEHTy3s0y+cOVugPmdH4ZoEHvjYGMGUEWE8Z80GVCO5ITD
 tIN5DuB6KzB83Z10afP156wBMyRlKltbyFLWIP9cwG/2UPuzd2vLMKvpV764X4KQ5ypG
 60FbWoFduHcrCt5bQyHW4YYfUxifzmlFrOIVQlqQ5lIE95+YiAb66sIKZbJatk8NTXOu
 jRWSTGX8P22YZw7lBkG8UdY/7Hxng4F9Nn4PlllvGf0NjLLnxoGyYRBDBxKWqR5rXL83
 1EMAHkAI6EYo3KY4Rh02qekd8+9OF4ABuhkG2taoB+OGnVzksU154/7PEoKNBRD5mLfC
 DYcw==
X-Gm-Message-State: AOJu0Yx6WAM7oNpeYy8AbyQKRbWVHq+sK44v7OrchrYn2PFwjufvv6qq
 ztnUxas6DQJYnS9xXovXmHXctzlbBFPBvl66I5tRAWrqUx4=
X-Google-Smtp-Source: AGHT+IGMaCLXrbm5ykW3ggtsPTpGy4r/th2CNp5naCekEa95oE86U/Pif2f1TV4VYMBy+FMWYQqQCQ==
X-Received: by 2002:a5d:62c8:0:b0:336:62f7:2304 with SMTP id
 o8-20020a5d62c8000000b0033662f72304mr503943wrv.49.1704971109374; 
 Thu, 11 Jan 2024 03:05:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] hw/arm/armv7m: alias the NVIC "num-prio-bits" property
Date: Thu, 11 Jan 2024 11:04:29 +0000
Message-Id: <20240111110505.1563291-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

A SoC will not have a direct access to the NVIC embedded in its ARM
core. By aliasing the "num-prio-bits" property similarly to what is
done for the "num-irq" one, a SoC can easily configure it on its
armv7m instance.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240106181503.1746200-3-sam@rfc1149.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h | 1 +
 hw/arm/armv7m.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e2cebbd15c0..5c057ab2ec9 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -43,6 +43,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(ARMv7MState, ARMV7M)
  *   a qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
  * + Property "cpu-type": CPU type to instantiate
  * + Property "num-irq": number of external IRQ lines
+ * + Property "num-prio-bits": number of priority bits in the NVIC
  * + Property "memory": MemoryRegion defining the physical address space
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
  *   devices will be automatically layered on top of this view.)
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index e39b61bc1af..1f218277734 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -256,6 +256,8 @@ static void armv7m_instance_init(Object *obj)
     object_initialize_child(obj, "nvic", &s->nvic, TYPE_NVIC);
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq");
+    object_property_add_alias(obj, "num-prio-bits",
+                              OBJECT(&s->nvic), "num-prio-bits");
 
     object_initialize_child(obj, "systick-reg-ns", &s->systick[M_REG_NS],
                             TYPE_SYSTICK);
-- 
2.34.1


