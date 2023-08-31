Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E278EDED
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHY-0005FX-JU; Thu, 31 Aug 2023 09:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhFB-0002xk-Ov
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhF2-0005LG-71
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-307d20548adso641299f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486661; x=1694091461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEBOMsh/2YnVXzixxLDyYqxUdUQOvziVNTmEZMBX0zo=;
 b=q7gXQi51bkl/faqbG5DeWykzANSO+dP0F+d7XfJxrzOdVly4o1roQGyTdru02vHDEP
 2Epwcn2T6N95iwOKH96OVRpXswy4bkE+G7x9dKR1LkymX6UTaPqp0sEAJhh2s3AmlBZ+
 L4L6ubkQ1UwsC50F0h/nQzi6i61GbkJxr+crpx6Uji96IGlWb921sXTeMFnjyj9lyH/h
 aXzcbg8QH4MFhQpy2zirkHME6QpW6AMAoEVcYcHnYeBCYJsPblVJaFD6Ji7gqj6c7od7
 m7f9yGIVdrNA3Ue4FN6n/cY6xyiZWj8872G/Q5BQqc1QWq1URvgylGURo1BwwNKW5V3F
 A71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486661; x=1694091461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEBOMsh/2YnVXzixxLDyYqxUdUQOvziVNTmEZMBX0zo=;
 b=K/4kWhkUjb2rb4/7t1hlKpnN9o3aktkE329+sN6e2BzyGhu/T/Rpy+jhsQyzkEHxuh
 sApqULUIKaFvrt3LSh8oXyVPd+/++QIdbVe/k4GojcU5hxaEq5RBqhpP9GNH1GTogiS6
 30gMZaxN8UIroaoL8gLOvxbxFi+2GDYeLk3F2+f7NmyfIDFZl2sBes0gcWw2sFRuBRGH
 lLrU3pqeq8GMK2imQJ6Xo67KrNTekcwG/l2rWE3u5R0RPRfyjYhmwDfwC8l3dniJNxWY
 +vswTgjOWiVOQmWZv14rPVthu6Gaol7CSYz0Jp4MPdQtyQz+QuC5lFbHpEe7Q/G0LiIO
 mNlw==
X-Gm-Message-State: AOJu0Yyl3PY8Xiyq53kof0UDoGaJWBqieOKF6IS14phfQy95Pc59lZzT
 2zye6lh9kWdyK52QdIALIJUXpFSdqcdsV9XVTsA=
X-Google-Smtp-Source: AGHT+IGLd09qYyb4/3kaqCrC5REt7mc9FS2sDslJG6mJAYhCIMYt2pVEe6AZW+Rku8HX3jErKIKnWg==
X-Received: by 2002:adf:e6ce:0:b0:319:74d5:a2d7 with SMTP id
 y14-20020adfe6ce000000b0031974d5a2d7mr4511339wrm.32.1693486661117; 
 Thu, 31 Aug 2023 05:57:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 h18-20020adff4d2000000b003141e629cb6sm2158792wrp.101.2023.08.31.05.57.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 09/41] target/riscv/pmu: Restrict 'qemu/log.h' include to source
Date: Thu, 31 Aug 2023 14:56:11 +0200
Message-ID: <20230831125646.67855-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Declarations from "riscv/pmu.h" don't need anything from "qemu/log.h",
reduce it's inclusion to the source.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230828221314.18435-3-philmd@linaro.org>
---
 target/riscv/pmu.h | 1 -
 target/riscv/pmu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 0c819ca983..d2be06a133 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -16,7 +16,6 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/log.h"
 #include "cpu.h"
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index db06b3882f..36f6307d28 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "pmu.h"
 #include "sysemu/cpu-timers.h"
-- 
2.41.0


