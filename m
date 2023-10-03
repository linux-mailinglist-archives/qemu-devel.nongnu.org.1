Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33387B6FD2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFF-00008o-Kp; Tue, 03 Oct 2023 13:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF6-0008Td-7V
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:32 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF4-0007X2-Fy
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-578d0dcd4e1so778944a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354288; x=1696959088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGnA2+8FT9jUoy0rKnwNzcAoA8JDcvTIIwq4HoZ/A1w=;
 b=f+PSZy/P0tHAzqru2VNrltFtFUZTLZB7nW32D7rGfaa45Em1wdYAa3X4PVYwMCXU1m
 W6jEZPCo2HBW72w4sPy6SVGP6QyCuICnb/VS6v0PXyjy6VxMWW+vtsfZoitO8Kmdj5/z
 tTX12sEb7ngaFKi4eVZ1tkANBGg6vFdrEWNLYu/lKS8ICQvDf8wu5PIwDNfmKGAKNhDl
 7bGrPd5tenUtwLdGoDyRET/xBNFfYXA/A0ohDOSB2P7pu0p3/mc4PA4pLsO9AVVILoiY
 Abi0v89TptCbI/M6owkWxyM0mKQKfU+z7gXGKth0KAp0qlGSQ4KJ4gy577wOVJYvufBs
 Fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354288; x=1696959088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGnA2+8FT9jUoy0rKnwNzcAoA8JDcvTIIwq4HoZ/A1w=;
 b=glUZWZOtatRhRhoh/IQYgNb80QK319lVST3zeZgTlNfqoCn14N4eRALMjg7DyWvKEQ
 7y8exstkC1GpnRwrR++A7ceW/s1YGS5hp8BDFoQOKemvYv/eVvJLqdNxIg2nu1gBRLak
 QDpFkLhJrwpNp8NGUt6cV5BbNtxuY8NHs/TAdRPFOTRi/QYGIfAJytZy8YD2rgG2uVOM
 0uUT/MB4JrGG/vStHCnjDmKsNWIDXCaSFQZeT1M7gv6GW24YqOZHDCqcN/GoJ1ST+7Ku
 RAHGjB1r/35oNSyE+qxBu0tpLfg9UWcHi/2ReuedF8kuH/eyLrxp5Vip7zdNbQrm7L5e
 IQPQ==
X-Gm-Message-State: AOJu0Yxpi8KAuvwVld1eL/bFAf4du4eF0yDoEueIrJIxCM6KNPTyXkff
 KUicaM/f2R/Ue8cg1Y/cFZEuuSIwkSzjB76l5+Y=
X-Google-Smtp-Source: AGHT+IHsyEwVLbK2LxzJR9oQSFPGv+sIpH28ZQQdLHMh2+RdI493URZc85g+CcQPTLFeH8wLLDFl4Q==
X-Received: by 2002:a05:6a20:4305:b0:15e:2d9f:cae0 with SMTP id
 h5-20020a056a20430500b0015e2d9fcae0mr135812pzk.10.1696354288146; 
 Tue, 03 Oct 2023 10:31:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 31/47] exec: Make EXCP_FOO definitions target agnostic
Date: Tue,  3 Oct 2023 10:30:36 -0700
Message-Id: <20231003173052.1601813-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The EXCP_* definitions don't need to be target specific,
move them to "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 7 -------
 include/exec/cpu-common.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 17c7420543..b14255923b 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -26,13 +26,6 @@
 #include "hw/core/cpu.h"
 #include "qemu/rcu.h"
 
-#define EXCP_INTERRUPT  0x10000 /* async interruption */
-#define EXCP_HLT        0x10001 /* hlt instruction reached */
-#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
-#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
-#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
-#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
-
 /* some important defines:
  *
  * HOST_BIG_ENDIAN : whether the host cpu is big endian and
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41788c0bdd..360b8298a4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -7,6 +7,13 @@
 #include "exec/hwaddr.h"
 #endif
 
+#define EXCP_INTERRUPT  0x10000 /* async interruption */
+#define EXCP_HLT        0x10001 /* hlt instruction reached */
+#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
+#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
+#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
+#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
-- 
2.34.1


