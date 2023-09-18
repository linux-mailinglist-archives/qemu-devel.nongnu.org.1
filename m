Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C67A4769
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBhr-0002c9-3W; Mon, 18 Sep 2023 06:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhk-0002Zz-MP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:14 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhi-0003np-Fw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:12 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50300e9e75bso2850524e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033728; x=1695638528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1v7pQRjeJMsEcoQRcYTaf7jB60FlNSE8+h962wr3Pk=;
 b=SHbwMVNCS5RNUitpnjOJBODHzXRQyQ4CEq9WPsZlKEnFOYbfoDW2oL66xGZa0QgLc0
 T+AIpRPIQu+yXUcQeBqgdSb0yMvuSzqiDufXOuS49/OYVU+sUOepq1yY0BLiaNiekQFJ
 fpxlb6r5+QlOWjfP0LupkK14K2Ny1sD0k0cbYVTsw2U8vyTQBbPsHoc7a7hwjXOCiTi8
 I7gsny4UzPnGy8zKW01TsWySxG+0mYuzpQQ3XcoXFo7lUz0SH2GtcgirGRu+bw4/l+wE
 h5AO0TRxhPuzP4OLzTmXRihxqduCRAULjIpZrLxvs3fEaFq6N+1Xk6+CzpU7SahtykrF
 lqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033728; x=1695638528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1v7pQRjeJMsEcoQRcYTaf7jB60FlNSE8+h962wr3Pk=;
 b=bPR6RdMTdzsU3U1BaJ/8uCNVh5sBAdoRejxoQ98WOexk1Z1yf86e1ixYJuEYfx7amv
 0nraqgK0Kq41eI8QmseX3r/Hjbu26mmjRX+VIaa6LOCDQWJelWz4wZnom2ab22r/TVKU
 yz/TfwJWxfvXzFa4ce9uX5/4djyWQFzlMO/HhO1J3zzQMWFXrm10w/NSXQY8alzxFmUp
 BDdij5Ms8NqJGNX9nHVrYR2Nn3dHmbHhrptCv67JnCD2OFF6g4xmtIkiF1gU7LrB7geX
 zZQqu6b04fC5Sop7llbeJ2oswg12iEJopWJDF2aI/Evb2y0INQb7iuvHZg0iksQXbV/6
 CaDA==
X-Gm-Message-State: AOJu0YwBMuR3u4GIlfwaCS6yjAvYLSjAimY52MTi1yDoIqMflTeg/8TJ
 AbMDnl3FcmYrf5pGCAzf4zsocZ3/+c0WjTgx7awJ9Q==
X-Google-Smtp-Source: AGHT+IF/0ITVInb3zP966Pc9cMZYKmVr/r+GDWnP6iElDu4wy7KVf56WEUcW5GE2f66cRTF9gFAQmg==
X-Received: by 2002:a05:6512:971:b0:501:bee7:487b with SMTP id
 v17-20020a056512097100b00501bee7487bmr6570861lft.11.1695033728282; 
 Mon, 18 Sep 2023 03:42:08 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003fefcbe7fa8sm12155307wmo.28.2023.09.18.03.42.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:42:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/3] accel/tcg: Declare tcg_flush_jmp_cache() in
 'exec/tb-flush.h'
Date: Mon, 18 Sep 2023 12:41:50 +0200
Message-ID: <20230918104153.24433-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918104153.24433-1-philmd@linaro.org>
References: <20230918104153.24433-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

"exec/cpu-common.h" is meant to contain the declarations
related to CPU usable with any accelerator / target
combination.

tcg_flush_jmp_cache() is specific to TCG, so restrict its
declaration by moving it to "exec/tb-flush.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 1 -
 include/exec/tb-flush.h   | 2 ++
 accel/tcg/cputlb.c        | 1 +
 accel/tcg/tcg-accel-ops.c | 1 +
 hw/core/cpu-common.c      | 1 +
 plugins/core.c            | 1 -
 6 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 41788c0bdd..1eff233565 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -39,7 +39,6 @@ void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
 void tcg_flush_softmmu_tlb(CPUState *cs);
-void tcg_flush_jmp_cache(CPUState *cs);
 
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index d92d06565b..142c240d94 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -23,4 +23,6 @@
  */
 void tb_flush(CPUState *cs);
 
+void tcg_flush_jmp_cache(CPUState *cs);
+
 #endif /* _TB_FLUSH_H_ */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c643d66190..b220c4536c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -24,6 +24,7 @@
 #include "exec/memory.h"
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
+#include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 #include "tcg/tcg.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3973591508..748539f289 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -34,6 +34,7 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
+#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 
 #include "tcg-accel-ops.h"
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ced66c2b34..b3b5ce6702 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -27,6 +27,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "exec/cpu-common.h"
+#include "exec/tb-flush.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
diff --git a/plugins/core.c b/plugins/core.c
index 3c4e26c7ed..c95c00a830 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -21,7 +21,6 @@
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
 #include "hw/core/cpu.h"
-#include "exec/cpu-common.h"
 
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-- 
2.41.0


