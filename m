Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DA7F504D
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:13:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s5b-0004nc-DJ; Wed, 22 Nov 2023 13:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s5Z-0004nS-If
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:36:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s5V-0005Sp-MY
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:36:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so417725e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700678196; x=1701282996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ud3zX2bU4EqVfLW+4Sdcoocw+g/25vvatzdQD66NIk=;
 b=nMbdMEJjz6/DW5dukQNhqFwRl5/yR4FS4pBHnX+oDt8aFDdqUijK00zbEKXaA41Sti
 51Zh/zHmG9Iw88gXlJ5v8sZQ76K2tW9pX8H+/8G6x53A8A6uyS8P84bAOtlD81nSnwB5
 PY+hSDziouzMTGbRcoVSgU4KjKdtMXqSLWdq1dkP5HI4DTB1RanmrOFzOIBPR8yqPfrY
 ZLMq5e29iWZqeoInGIwvZL6myYNbKQCJBK50NRCYkjSx3daRl0EZb0CS7LYucDE7MZEw
 uZDYd4psbpPQXMQZ8W4JTHSdt8ZJq3yBMT/GQRk6dyVNZ4S2I4Hc8i7k4R9L0EpZGORM
 2wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700678196; x=1701282996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Ud3zX2bU4EqVfLW+4Sdcoocw+g/25vvatzdQD66NIk=;
 b=rGlQCClkZr4iMT9cMtbhctXV80+cpxuY4VGwOgdJni5GwRyZ1g/f0Q+PEnpICQPoqo
 AyDhxdum4YkeQQBkYnZBjBgBIarFZL/j41EMG5JfDP6P7BLSHmuvOuSQ3p+AuJ+Zlymd
 ODTmLwdDMnUZmojQzJ5YzewRanBRfj9cLmKtb+76SCnOPXCigjO8TgNlm7P9tu4GYyHp
 /9rC5dZU2w9wKodwJ7k4MIAUMGN+NcK4uvg9jVqQTtE6qIFivNe2EP8FgrAyjDdQZ5MK
 AM4bM/tAQ5jz7BGXQA9ggI5yNXx72immTxeVjIGyQL7TzDA8wEkENQbAkfFHeBZ4/oWj
 gaMQ==
X-Gm-Message-State: AOJu0Yx+dy4ZP+sjn9Pv9RtyknSK5u9Y4xyGNh0dM8eXT33dLdMuKtpa
 KX6sryelqvYof9SddjytpyCAlTBTDpRpMohgfIE=
X-Google-Smtp-Source: AGHT+IE4NcwlHDrFeSNvvFvo2mikaiI6G8QZ53B8RzBNx+L3Djqy98aZY3snn6tCnxqaZ/DYXp8wgA==
X-Received: by 2002:a5d:610a:0:b0:332:cada:84a with SMTP id
 v10-20020a5d610a000000b00332cada084amr2167029wrt.61.1700678195733; 
 Wed, 22 Nov 2023 10:36:35 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 d2-20020a056000114200b0032fbe5b1e45sm65216wrx.61.2023.11.22.10.36.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:36:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-9.0] hw/mips/cps: Simplify access to 'start-powered-off'
 property
Date: Wed, 22 Nov 2023 19:36:33 +0100
Message-ID: <20231122183633.17676-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Since commit c1b701587e ("target/arm: Move start-powered-off
property to generic CPUState"), all target CPUs have the
'start-powered-off' property.

This object_property_set_bool() call can not fail. Use &error_abort
to simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/cps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index b6612c1762..4f12e23ab5 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -78,10 +78,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         CPUMIPSState *env = &cpu->env;
 
         /* All VPs are halted on reset. Leave powering up to CPC. */
-        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
-                                      errp)) {
-            return;
-        }
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
         /* All cores use the same clock tree */
         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
 
-- 
2.41.0


