Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C87B7015
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjIb-0000Do-NF; Tue, 03 Oct 2023 13:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIC-0000AF-JK
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjI7-0007sB-NR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c60778a3bfso9526095ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354478; x=1696959278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVcU0dpmlXDHvRUkCtSneg79W+0RWTo1KszSl/O8r3w=;
 b=P2YhGbv1mNUnF5ohciGyp+Pf/YER9RtgErgWFQZZfC9uQNuOcRK7ojlxboKaTlhgkF
 nTNKCtxa9lbwDzT3r9MHshhN36N3easCFolhQhILkORXzmWgzCAr87WiNZuCoLXOfMCv
 oX7y0ZlnXrsB4LLjnyCIqvHy3DyWrZ814X+Xae7Dfya3uuH1u0TD1TN7QCE0VAGlwR0y
 2f3Pzl0kfKvZf2L7ni1oULhNv7+edQ1hUsNBJz3aFiw835KGbUBjKN37wemTOCm/4gDh
 x9beoWLm8SmiKJap5EYyYKPmYum+EvGRFLgKRu+gu1C8lNEI/TQjZpvrtQYEQyzh7c4f
 YRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354478; x=1696959278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVcU0dpmlXDHvRUkCtSneg79W+0RWTo1KszSl/O8r3w=;
 b=QXSVSGdI2zUNi7L9K8wxQthPsEk94PW1PgyTqS3wyEZipnFjq9G1L5y/3mVWPw9NfX
 AIkQAZerJLTeEoYjT5Wy2IETBL/90h8bXpaJ+7tXWjlhEVqfKN9rU65bqanvY3vpRI4W
 URq58meSQuduZ4ZA9JP9bJnX8L6YTr980fZApxiEqveZJudLWZt6nEH+E5lLtm9+rs8R
 7pXdyVQtZKMMpKszcX52It/mNKAgboM5GQnqNE4wD74dV/X0FrOjk7kcs/s0evtpeT5W
 hm5b/2nGjnw8BnmrThAM53j0QyOMFq11U8iDzAJgeARW5VrY/4VSdr1P4p+6sIi4gBme
 B/ig==
X-Gm-Message-State: AOJu0Yyk8eyDyJVp0EsoEN5rzjptFQDGw2Uol3WaiVXSPigSazLIV4s8
 YGreMuj56WGQItbRDhJkXiMLgGfCqEZqrT+TXCg=
X-Google-Smtp-Source: AGHT+IEei5L4GCEf6EEA1oOpALo6EXYDNRiCM0tx9sBRZfDw0akUWtL8m+egA5ecWniRNkbNrnA5sA==
X-Received: by 2002:a17:903:25ce:b0:1c6:2acc:62ec with SMTP id
 jc14-20020a17090325ce00b001c62acc62ecmr252152plb.13.1696354478310; 
 Tue, 03 Oct 2023 10:34:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 40/47] accel/tcg: Make icount.o a target agnostic unit
Date: Tue,  3 Oct 2023 10:30:45 -0700
Message-Id: <20231003173052.1601813-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Remove the unused "exec/exec-all.h" header. There is
no more target specific code in it: make it target
agnostic (rename using the '-common' suffix). Since
it is TCG specific, move it to accel/tcg, updating
MAINTAINERS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-11-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                   | 1 -
 softmmu/icount.c => accel/tcg/icount-common.c | 3 +--
 accel/tcg/meson.build                         | 1 +
 softmmu/meson.build                           | 4 ----
 4 files changed, 2 insertions(+), 7 deletions(-)
 rename softmmu/icount.c => accel/tcg/icount-common.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb2dbd967e..78199101aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2906,7 +2906,6 @@ F: softmmu/main.c
 F: softmmu/cpus.c
 F: softmmu/cpu-throttle.c
 F: softmmu/cpu-timers.c
-F: softmmu/icount.c
 F: softmmu/runstate*
 F: qapi/run-state.json
 
diff --git a/softmmu/icount.c b/accel/tcg/icount-common.c
similarity index 99%
rename from softmmu/icount.c
rename to accel/tcg/icount-common.c
index 4527bfbd6e..0bf5bb5e21 100644
--- a/softmmu/icount.c
+++ b/accel/tcg/icount-common.c
@@ -27,7 +27,6 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -38,7 +37,7 @@
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/cpu-throttle.h"
-#include "timers-state.h"
+#include "softmmu/timers-state.h"
 
 /*
  * ICOUNT: Instruction Counter
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 0fb03bd7d3..4633a34d28 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -23,6 +23,7 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'icount-common.c',
   'monitor.c',
 ))
 
diff --git a/softmmu/meson.build b/softmmu/meson.build
index c18b7ad738..3a64dd89de 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -6,10 +6,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'watchpoint.c',
 )])
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: [files(
-  'icount.c',
-)])
-
 system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
-- 
2.34.1


