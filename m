Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554074B832
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGI-0004kH-MJ; Fri, 07 Jul 2023 16:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGG-0004jY-Vl
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGF-0004eV-92
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso25947465e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762462; x=1691354462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv8+woMvmELVOwJANlOof4wFWPUartGkqI3cjtir6qk=;
 b=jgq+Io+3ZRmvY500Cz+kTrgl96r6l5zpE7ly+hb9a8UiLxmY6Zg2eB8nAafyaVD+ZV
 4jiJWraPuu7ega6zgsKS3Ra9H8J015a8YFhU4CfConc0Qu5aMTFyai+gUoXOgGN3qe44
 IY89oUatrLM+XLmqlbuCSDYqdmmyDcKxLnbenbq5rj6J1zs9XZ4dw9TsmKNZ2VnhhYy1
 HFCDtTONHgiKONFi6a8+IZewBtkwW4qTOWmuFbNJFxxFzCALaYbtrU7Gb9T/oZS6SCQP
 Dus2CmIwPbNngaEbWwvsiJBqSPJJk5axq21Ewc9EN+eHAZEEqfi91AIuAlDV2pmsXhAI
 Lqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762462; x=1691354462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uv8+woMvmELVOwJANlOof4wFWPUartGkqI3cjtir6qk=;
 b=iSlo7M4WNFzUsXx7FPaeAWfFX1oZ49KdffUjmj+aywLyGuk8nrbcRTxq+j+wlqSxxh
 ZtRBYIAOaa9rLKKcD67yMFCfpSnZmvvfk2D2ABpMHIiiV+3+5xrXmiIRjxTBW7NrfQ22
 S7HnlBbSkMcjPILqVsOzm3Li9nM+nmGxZkWUfxiviDlbNFm9lt1M4sFdN84u+O5Kh9Iz
 m+5Z9MFqS9dMmIX5oqPB2CQ7dyRnr0GYK1/0mZtfSQseG+xxri40pX3oMsEWIsIRZeqe
 YtRzlBd3NpSHwHG+EJF92YS8XSD9HN7mVRqlFJl/Gwj3a/qn+PhTLiO5IhYBuosPqpwK
 DReA==
X-Gm-Message-State: ABy/qLZ9QmqiD6/VIIZ2GlsKWmjtp2llDkivrqDzctOU8MTLI6CfnCAu
 H86nA7CXLwtH07ntXLtnU/zAZ02DaMNBMHdlD1S1xQ==
X-Google-Smtp-Source: APBJJlELThOywDRVYIwenEdHpcFxvJoGb4kmEQG9kg/8sUorDTumFAv2KYNcxqEVK1DYUHz2Db4YQA==
X-Received: by 2002:a1c:6a03:0:b0:3fb:a576:3212 with SMTP id
 f3-20020a1c6a03000000b003fba5763212mr4554412wmc.39.1688762461946; 
 Fri, 07 Jul 2023 13:41:01 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 07/24] accel/tcg: Introduce page_check_range_empty
Date: Fri,  7 Jul 2023 21:40:37 +0100
Message-Id: <20230707204054.8792-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

Examine the interval tree to validate that a region
has no existing mappings.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 12 ++++++++++++
 accel/tcg/user-exec.c  |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 472fe9ad9c..94f828b109 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -224,6 +224,18 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 void page_reset_target_data(target_ulong start, target_ulong last);
 int page_check_range(target_ulong start, target_ulong len, int flags);
 
+/**
+ * page_check_range_empty:
+ * @start: first byte of range
+ * @last: last byte of range
+ * Context: holding mmap lock
+ *
+ * Return true if the entire range [@start, @last] is unmapped.
+ * The memory lock must be held so that the caller will can ensure
+ * the result stays true until a new mapping can be installed.
+ */
+bool page_check_range_empty(target_ulong start, target_ulong last);
+
 /**
  * page_get_target_data(address)
  * @address: guest virtual address
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d95b875a6a..ab684a3ea2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -598,6 +598,13 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
+bool page_check_range_empty(target_ulong start, target_ulong last)
+{
+    assert(last >= start);
+    assert_memory_lock();
+    return pageflags_find(start, last) == NULL;
+}
+
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-- 
2.34.1


