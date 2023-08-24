Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE16786C0D
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eD-0004GE-DZ; Thu, 24 Aug 2023 05:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e0-00044D-EC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6du-0004xV-0H
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so17945275e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tswNfDLVJW3+gP/uE8SUQjolW4HExHb2Af24QmhcctE=;
 b=mTf67cUpxCi0l+pJ/pxovfAuHgB6d+uLa3Gpb+29MZJrgwrntCKo3WG0w2MDEI6VAZ
 Jq3cGBJBNdR05FyZ0ppBmlpkM8Q4Yz6FLuXLwg/LspYrKZHP07UsUl+OifcBkyieYaKB
 PzCD2fQQMnX+N+boCgzCSWIeoz10k9+1Or650+aOOSCTxWf1rEgFfK9mtfZhSCCPovuM
 dqHZmX+BKKYr2oTTGJ17oJIj7O4fbM2dl5rdhZtLsyR/hRLnjvjqvSAF8e2djuXFPh12
 xl8JjeDuezKF7Oy/eqbbNYDJgDfuPEREcsJVkBA/rImGsUbBCPoNU+QLdurA+tREKc20
 NuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869319; x=1693474119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tswNfDLVJW3+gP/uE8SUQjolW4HExHb2Af24QmhcctE=;
 b=bW7HoxSVnYtvq+kINUXtihjl/GtPHMwoc5AZoKLz1sR7Gerc8T4jCijXYueqDmFO61
 lzPT8njElRdu+S5N1L1r8wOnOU5DAskAfgFKAR2/XfmoKzq9OT59qoJJrUPq5Q4CInIb
 4Di9OuPImMAjnEcbzg+EicFlZMNrRN0Iitc3ah1VTF3uBnaSMxHshFiIzDQlA4ILbzlQ
 Pfhg/vVDWB6BJzBXuaMyxBq5JlO9XirtDVMO/7zFvendMWlYytrLa2ryVtR4ii4P+vHD
 LZaK/2k1Iw6nlbSjhkAU0R54isKDjZ6Vh5PtCyclY4XSvHYZ/r6Tv7Ru7X2mjEnofPgR
 hOgg==
X-Gm-Message-State: AOJu0Yzzai/lY6wMurF4wnRWgM0qc7CAmu+zUySFb2Lq1W8vX1OqlC7F
 yI2GotIEyCelHmKKAQ+dqa/Rcj7THNDanglmtfM=
X-Google-Smtp-Source: AGHT+IF90hwlmIc1yD0c7ZOJ+RGM2fGMfN9qGUHtfPI2/iqBKxVj0FP6EZykUBJ0ZMYxeLSz+cz2fA==
X-Received: by 2002:a5d:51c1:0:b0:317:58a8:baa with SMTP id
 n1-20020a5d51c1000000b0031758a80baamr10406293wrv.28.1692869318661; 
 Thu, 24 Aug 2023 02:28:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/35] qtest: factor out qtest_install_gpio_out_intercept
Date: Thu, 24 Aug 2023 10:28:03 +0100
Message-Id: <20230824092836.2239644-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Chris Laplante <chris@laplante.io>

Signed-off-by: Chris Laplante <chris@laplante.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230728160324.1159090-3-chris@laplante.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 softmmu/qtest.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index f8d764b7190..1b864891629 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -365,6 +365,15 @@ void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
     process_command_cb = pc_cb;
 }
 
+static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name, int n)
+{
+    qemu_irq *disconnected = g_new0(qemu_irq, 1);
+    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
+                                      disconnected, n);
+
+    *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
+}
+
 static void qtest_process_command(CharBackend *chr, gchar **words)
 {
     const gchar *command;
@@ -415,12 +424,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             if (words[0][14] == 'o') {
                 int i;
                 for (i = 0; i < ngl->num_out; ++i) {
-                    qemu_irq *disconnected = g_new0(qemu_irq, 1);
-                    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
-                                                      disconnected, i);
-
-                    *disconnected = qdev_intercept_gpio_out(dev, icpt,
-                                                            ngl->name, i);
+                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
                 }
             } else {
                 qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
-- 
2.34.1


