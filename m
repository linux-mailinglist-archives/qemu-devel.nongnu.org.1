Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC6073E3E5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKs-0001Q8-5r; Mon, 26 Jun 2023 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0000KP-Bi
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJq-0002ry-NP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so5071570f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793997; x=1690385997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdcPgGZK5Ze4ssDxbt8lIE06Laz0GGq6nWn0S1GfEkQ=;
 b=i6TDJ76LnzLipAeOCgPk9wpJja1m7gJ61TFNr9571GATudcYU4xc1PGDW59E5U2uqr
 xrS4BMI8Jh2/19cIwmOmDnyjRYFDvzQokNoKUZKmroCSVWlHTHib3d13hGB3ZLS8V9Qs
 PLmLZxZ/ocIp8Lmpp81dvi8TKAhQiHdiUayhb9/Da/p6iREHRiTq0pWA/lOQVZiyyCTX
 Y05h3K2HQxBNYVmsu3n1q38U5JnXsnQP1QDFr0Cut1yHYB3L47ekCymyKEJPU2+AQ4T2
 aVVb9lenpmciubmdFVloY6WTbH9ambktfJaL1isL3nTREhTalu0AIeeXNJnApKf3+b3s
 Z1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793997; x=1690385997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdcPgGZK5Ze4ssDxbt8lIE06Laz0GGq6nWn0S1GfEkQ=;
 b=QgEwHSj/OE2as5m47yQ5qTB7NtS5XIUBytsSByQZ9TrZswBHKNy3RpGX+Lvuw1dIQs
 BRRMyAjVm9Q8V7tOKSwBRdI7ixWOmGOlMMa+jvzYdOLbUDtULZmaG28957xr5sOhvKNJ
 TPhsY+blpmR3o9JK5IDmRXiniilGBmtFuQj1fJOWT5PX87dHcPmiNwvTttjY0budPHYJ
 X7YaMv6rIsK0WAtGHxaBVEQie9wiGMNr8osf1fyhq3oEZ0GCxiz8jm7mqxkbIMeUyPXv
 ynWI7cYGPXO2gGvOA8lmDmCTcCKKu64MiHoVFTJdguuGE00l5x0bhsTvi5UvVyra3gH+
 UuaA==
X-Gm-Message-State: AC+VfDxmrrng1A3hYnJBdRNuLnS9wlH9Kjh0qWdWk77ENbGLGkUxNg1C
 qkAKLEz0giTck07mAkXKStnf5bVC/TMiluS7ut7G1hIf
X-Google-Smtp-Source: ACHHUZ7t7jC5tNii/EXmxDu/uQK3U4hkWjVfJzO6m8bgDdjl4KVh/MQhXsUQqtRoKMDjGO+Ytoclhw==
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id
 s17-20020adff811000000b0031117afdf96mr31474435wrp.44.1687793997453; 
 Mon, 26 Jun 2023 08:39:57 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/22] tcg: Do not elide memory barriers for !CF_PARALLEL in
 system mode
Date: Mon, 26 Jun 2023 17:39:40 +0200
Message-Id: <20230626153945.76180-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

The virtio devices require proper memory ordering between
the vcpus and the iothreads.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c07de5d9f8..7aadb37756 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -102,7 +102,19 @@ void tcg_gen_br(TCGLabel *l)
 
 void tcg_gen_mb(TCGBar mb_type)
 {
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {
+#ifdef CONFIG_USER_ONLY
+    bool parallel = tcg_ctx->gen_tb->cflags & CF_PARALLEL;
+#else
+    /*
+     * It is tempting to elide the barrier in a uniprocessor context.
+     * However, even with a single cpu we have i/o threads running in
+     * parallel, and lack of memory order can result in e.g. virtio
+     * queue entries being read incorrectly.
+     */
+    bool parallel = true;
+#endif
+
+    if (parallel) {
         tcg_gen_op1(INDEX_op_mb, mb_type);
     }
 }
-- 
2.34.1


