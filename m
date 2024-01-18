Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E87831A62
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:18:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSGO-0005XH-Ul; Thu, 18 Jan 2024 08:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQSGM-0005W8-HG
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:16:54 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQSGK-0004DO-OX
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 08:16:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e88012233so21280545e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 05:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705583811; x=1706188611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jXuzdDHoDfS1SMEKlLWllgS9IfT5ukyEOa75Rlj3kHM=;
 b=jqM5mk4oUYoH2mUbwftBX2mwWocmhWGwIVSpSUkESYHgyOWoKoeUIeIHA4pZd1Eq+o
 /7Y9jRTX/tZ8tgGGQuGb+0QsImSC4iDfzgZs/1SJ8MGVLPoNLTwyuca0mjqdCjfQz45w
 pmY0xDa922Shme+9cLL6HI1C1K6rN68eBeJrT/zSUePnZN2BkCbbcORcawgN/9379qZJ
 mf3PlnyKX8nxR6Lrw+ODk3vun/UJyl9g5Cs17yuQXp3rljFtmWBdUSJ9gzPkA7k5EfpJ
 flvXgOclSDmqyEV84OWDgOU86hP2o5MBP+gLEnw+ij0/FMZHrf+tptEP3c4xZYLRymZ0
 x/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705583811; x=1706188611;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXuzdDHoDfS1SMEKlLWllgS9IfT5ukyEOa75Rlj3kHM=;
 b=EyeW2TJLNTUFDlOR70VZ0swzqoCU1iyxhV3p/QkY1T8OcdyTuWIkC+vkHwWK0JhMKO
 GRXf+JpecK23aaTQVGz07GL2/Vz/NJZBFF1LpkcTAc7uvWFw1h1MvAnGbWafMhDaqvE1
 GOIXNLl6z8iFjcFNlsqO5z+s0x2s7mLZBwkiQ24wqVLrB3cttTHimS48MOx9fEradPiF
 +iyezRMdEtpYWNKMcRIVCyR+WsbyYwRNfdlirBohl+ObIyJaYVaDGcGmU2cOaK45aEWp
 2HFfUctwjWFFnwhCspfrFrLOJ/yRcSTer/AXsjfVj7PeHZ4ORKsg+z7gUCwKNciFeES/
 1Gvg==
X-Gm-Message-State: AOJu0YyCqkxVbjtD2KnBOGfKApx560p7nh2VEoK3uEeUDgX/RDWwrCHm
 LuLJSGVVrytnjtStzzFZFKt0tvmir0K46rmFD0HkCl/aj1M0tR3CiXCDMmrjS+I=
X-Google-Smtp-Source: AGHT+IGM5F4tD+gs6ObnZe+CFxDRs6dZGEByR8TOaigtPce4iDJmN2HKgjGb8Zk47XE2D/Ian8+RmQ==
X-Received: by 2002:a7b:c392:0:b0:40e:6a93:1c42 with SMTP id
 s18-20020a7bc392000000b0040e6a931c42mr534135wmj.26.1705583811035; 
 Thu, 18 Jan 2024 05:16:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 jg1-20020a05600ca00100b0040d4e1393dcsm29277526wmb.20.2024.01.18.05.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 05:16:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt.c: Remove newline from error_report() string
Date: Thu, 18 Jan 2024 13:16:49 +0000
Message-Id: <20240118131649.2726375-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

error_report() strings should not include trailing newlines; remove
the newline from the error we print when devices won't fit into the
address space of the CPU.

This commit also fixes the accidental hardcoded tabs that were in
this line, since we have to touch the line anyway.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2793121cb41..da6cea30534 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1771,8 +1771,8 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     /* Base address of the high IO region */
     memtop = base = device_memory_base + ROUND_UP(device_memory_size, GiB);
     if (memtop > BIT_ULL(pa_bits)) {
-	    error_report("Addressing limited to %d bits, but memory exceeds it by %llu bytes\n",
-			 pa_bits, memtop - BIT_ULL(pa_bits));
+        error_report("Addressing limited to %d bits, but memory exceeds it by %llu bytes",
+                     pa_bits, memtop - BIT_ULL(pa_bits));
         exit(EXIT_FAILURE);
     }
     if (base < device_memory_base) {
-- 
2.34.1


