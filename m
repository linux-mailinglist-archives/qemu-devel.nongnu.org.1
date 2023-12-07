Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A040A808562
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBBat-0004hN-I7; Thu, 07 Dec 2023 05:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBar-0004gm-QZ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBan-0001Zo-DL
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso8173445e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701944810; x=1702549610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgIxy79UZseNDiD3U1SZgYUkivqTyyMr1op/QHIJsqs=;
 b=CZ9nnxAB1PxCVyCIfUFYXuO1DiAWPsnNNBoh4BC8+Mz7KWd7PFLD6GaC1Zd0QYuv4r
 W3fO8fqcwSwkbtbI97/raIMOwwLGhxY0/p1Jv1HQn368EtQ6nq0W5voAfk3QbzJVV4mQ
 MotgY6Dpng8Uq/dELkCndU+LCscYSTF6D/UmoQNs+OSdrlFT1L+41VNAgIQfvdXyQVdj
 KVoAG83ikKyqsQD6rrIbKIwUO1xP0OreeS3Er+qu+pDPwiRAxSQ8zxsDw+lANDOzC/PL
 o0OLmZH2uCuIT9OArV0ZIIE5TPsoX+jf35Nj8/U7A80c2GMNbK6jVNwTTSNfsfb50ZPr
 01wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701944810; x=1702549610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgIxy79UZseNDiD3U1SZgYUkivqTyyMr1op/QHIJsqs=;
 b=uQ0vIU/nEqkwpPnQnoHGBxo+S/bfgKY3ApExPFoRA4GHb1tVl7w0EvklxPa6xYRG2c
 4Ga1A9nRg2aKuOiGDpNhaHBWLCBNg/OZ3d6B/GHnB2pGPXWvdFj6IuXNkG0STymDJSkU
 wcxGZVniZMRPdeXuScDCvWKsP80DdnBeRGby2XCxUqLPDZwP3ScLPPPITfbZNJT0u24d
 v76K8W33xzxH1OGJqEA4ohMQryEEfDgif0w5UCYwXiHTk2XPm5vTGhfI4Fx1kZtZ3txn
 BVI2uCYY2/xPGXG14C8HqVX7oa6W7hXSon55eo5xDrTR5CmLT/yEs/7tIg8phDcXLKGZ
 OTSw==
X-Gm-Message-State: AOJu0Yw6ttlh2BUQb6ETND33n50QjuwgsKUZ3vTRqzOPZRKA3v+lKOwS
 wfuL5gSxxArysMaGGn/D3u1ezJzL5c/tNdPlmxg=
X-Google-Smtp-Source: AGHT+IFMD9QGCCZ+aQx2wpdruPVnMiBAQQhdXj/4nx5YQo1ZuayqCd/rs6oOWCR92l1VHUlY7bmsVw==
X-Received: by 2002:a05:600c:4fd5:b0:40b:5e21:d351 with SMTP id
 o21-20020a05600c4fd500b0040b5e21d351mr1394153wmq.90.1701944810654; 
 Thu, 07 Dec 2023 02:26:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 fa11-20020a05600c518b00b0040b360cc65csm1443849wmb.0.2023.12.07.02.26.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:26:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] sysemu/replay: Restrict icount to system emulation
Date: Thu,  7 Dec 2023 11:26:31 +0100
Message-ID: <20231207102632.33634-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207102632.33634-1-philmd@linaro.org>
References: <20231207102632.33634-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/cpu-timers.h |  2 +-
 include/sysemu/replay.h     |  9 ++++++---
 stubs/icount.c              | 19 -------------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index 2e786fe7fb..188f67ee90 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -24,7 +24,7 @@ void cpu_timers_init(void);
  * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
  * 2 = Enabled - Runtime adaptive algorithm to compute shift
  */
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 extern int use_icount;
 #define icount_enabled() (use_icount)
 #else
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 02fa75c783..8102fa54f0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -1,6 +1,3 @@
-#ifndef SYSEMU_REPLAY_H
-#define SYSEMU_REPLAY_H
-
 /*
  * QEMU replay (system interface)
  *
@@ -11,6 +8,12 @@
  * See the COPYING file in the top-level directory.
  *
  */
+#ifndef SYSEMU_REPLAY_H
+#define SYSEMU_REPLAY_H
+
+#ifdef CONFIG_USER_ONLY
+#error Cannot include this header from user emulation
+#endif
 
 #include "exec/replay-core.h"
 #include "qapi/qapi-types-misc.h"
diff --git a/stubs/icount.c b/stubs/icount.c
index c39a65da92..ec8d150069 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -5,30 +5,11 @@
 
 int use_icount;
 
-void icount_update(CPUState *cpu)
-{
-    abort();
-}
 int64_t icount_get_raw(void)
 {
     abort();
     return 0;
 }
-int64_t icount_get(void)
-{
-    abort();
-    return 0;
-}
-int64_t icount_to_ns(int64_t icount)
-{
-    abort();
-    return 0;
-}
-int64_t icount_round(int64_t count)
-{
-    abort();
-    return 0;
-}
 void icount_start_warp_timer(void)
 {
     abort();
-- 
2.41.0


