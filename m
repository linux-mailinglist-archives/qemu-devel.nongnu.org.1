Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49790720BF4
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:32:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DID-0001RB-2Y; Fri, 02 Jun 2023 18:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DHr-0001Km-Jx
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:30:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DHp-0002AJ-AM
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:30:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso26447905e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685745019; x=1688337019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ibR6hnE68PzbDmXZWXPIiPLj4G7Iqx7to/6c3Tlt7HA=;
 b=PVfb5ONXLPWo3rZMjDC4Tz0Sh1L2JUtMGmAXzGbd0hRGy33nvbUrCIqB6kqrXduGqS
 2fDXjDS2vs9HE5e3UAS/K0Hl9c7kdDQQsvvXVxDailNTijYnpOKRvBD8+QEiR6vA/32A
 kRG8lSo7/ItMWR7mRJ4R8cAFeOLqvFqNnMlR98MaH/EF1pOCnoZdAZpC3fplZ9208yqg
 ZyZhSicpWyer/D81LCuEJk8gsVdUbuKFzRR6ha53G5QXc3Amrg5n4L2e3l7mNWRXUV5e
 FwdtjU3tzpvp46qgAK2bY+Y1wTas+kGO6sMjuJNZFt4DXNMbpqB3BJnqvJlccznSPfCe
 g/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685745019; x=1688337019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ibR6hnE68PzbDmXZWXPIiPLj4G7Iqx7to/6c3Tlt7HA=;
 b=YjP7ySmBQQzl6atbyOGUZi+mnEeZi5n6kxwV/uBqYlwcynpk9HGuxF3FQw1cK0jU5A
 Nl717+UZdKbOsTDi0naqR4pMDIyyvT/FQzuO8h+zHoAVAT2FO9iS4ZFjICTy5Fqajo+x
 5lW9UeExx4KZnP6+E4f6dtiI2YH5EVxBL+0mxPOMy/yQd9PunsEhMda6BexDsYItTpK+
 +dY0tHpnS8L5nNbvTOdG8xmZg3/nztk2Tp9kV7eGRfwznt8yvnfXmQ3rHoF8Lz0MJV2s
 v2XC+YH+uLBIReDhgkGpGcPZELZ5QKxZ7w14djGhHD5IwSyn+H/jsmX+SeokCKbfB7Wy
 wyyA==
X-Gm-Message-State: AC+VfDz3yvnw0P2aDSvvszPirHEEi1mknEVDOLBslN7fzQbvEL3sPB78
 ger39Q5h7W5GKXLW+8AFuWyrEYzgfVxxlWCYICM=
X-Google-Smtp-Source: ACHHUZ4leZL64/l5RFDRnHTlzLri7hLJPcjANn3guJUp0jPuacUIdW+jyrM0K2aE3SaaD43cX6D8FQ==
X-Received: by 2002:a5d:4945:0:b0:306:2671:7cad with SMTP id
 r5-20020a5d4945000000b0030626717cadmr851275wrs.55.1685745019162; 
 Fri, 02 Jun 2023 15:30:19 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b0030630de6fbdsm2757095wru.13.2023.06.02.15.30.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:30:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/hppa/meson: Only build int_helper.o with system
 emulation
Date: Sat,  3 Jun 2023 00:30:16 +0200
Message-Id: <20230602223016.58647-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

int_helper.c only contains system emulation code:
remove the #ifdef'ry and move the file to the meson
softmmu source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/int_helper.c | 3 ---
 target/hppa/meson.build  | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index f599dccfff..d2480b163b 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -25,7 +25,6 @@
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
 
-#ifndef CONFIG_USER_ONLY
 static void eval_interrupt(HPPACPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -273,5 +272,3 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
-
-#endif /* !CONFIG_USER_ONLY */
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
index 81b4b4e617..83b1e0ee7d 100644
--- a/target/hppa/meson.build
+++ b/target/hppa/meson.build
@@ -7,13 +7,13 @@ hppa_ss.add(files(
   'fpu_helper.c',
   'gdbstub.c',
   'helper.c',
-  'int_helper.c',
   'op_helper.c',
   'translate.c',
 ))
 
 hppa_softmmu_ss = ss.source_set()
 hppa_softmmu_ss.add(files(
+  'int_helper.c',
   'machine.c',
   'mem_helper.c',
   'sys_helper.c',
-- 
2.38.1


