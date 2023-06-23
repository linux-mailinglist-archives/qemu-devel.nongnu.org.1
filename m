Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123A73B77F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwc-0001H6-BM; Fri, 23 Jun 2023 08:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwI-0001AL-AQ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwC-0000Tr-7w
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f9bece8d1bso7659455e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523450; x=1690115450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBI1EKXYVa+WMuYu7l3ZX5976guHRdH5nUfqC+4pCho=;
 b=TIWrp0BCzxQkJ0LPWHq/g0lwhYCV84al3ki/W6O+bDBF2xprlhhhtZGIhRrJDJ5BNL
 YR4NSNIwiOtoPvSxK1JfDL2zbpA8qN70ZVGN6qc47FoIPgtpKgg6NWxrUt4a264SU2Nq
 Vj1BgPA1FfsWm02/f0ftezMT442ZoB0R/PnGc2N+yw4TpRQ+pUckDIL+PpBrYaXwVXZ0
 2lAYw9r+WqCIr32nMijfkjcQrEqhIME4xTtm8xOSiUNizbSy+lurCPrTosVtdV5njgOs
 j/Lzz1cALP+XNm3WqzKSjE+oa/Z/5GVzFHmEAvI/cZfJykz4JvxMQ6S8U/6p/uLntw8H
 V+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523450; x=1690115450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBI1EKXYVa+WMuYu7l3ZX5976guHRdH5nUfqC+4pCho=;
 b=N7etKSkSYCnkBv8zGIi8rX1WhDd357FX1DzvPSquhwzfUuj6YLAX854PVh2pYDXiTw
 lOSN7cASMs2+OVHC+7V3tw0eZiR3ubRxuAPbxSP+nGv4mcmYAH4zw38iG1Kob4wJgueB
 dbrr72orEK7JnLZFbgdfEJYRiyirIkzMD/lf7/MGInE6P/H98usjmCMWWu7CgYra17Uv
 U+LCWPveS8R6ieOraQcAQY8QmB9mJ7WHUQINEy0Y/sTOMJN7uQBdo9aVjW7JJccFWAu7
 MkdyDad3fW1BNWU9RNHrnb0r9uqQyPkEvVvOKsSVie4YxCSFTmDkvuX2cg3xhMWP93c7
 Ulfw==
X-Gm-Message-State: AC+VfDx9EeHSo4Okrl7gkXS9AknE0a6bnzMrIsOgmPtZGxgM5Xlk/jo/
 kKnbkZLKqSLZveQkmratBi6sug==
X-Google-Smtp-Source: ACHHUZ5x6y5RHg+K7hI4o4mRHhrA5yl7dHn5D5WFAt9joyXX5aypT5hoWX+zjQTK1eJme4/5Umk66g==
X-Received: by 2002:a05:600c:22c1:b0:3fa:7c4f:1f18 with SMTP id
 1-20020a05600c22c100b003fa7c4f1f18mr1343311wmg.21.1687523450542; 
 Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c00c800b003f70a7b4537sm2207963wmm.36.2023.06.23.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0DC71FFCB;
 Fri, 23 Jun 2023 13:21:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 20/26] plugins: update lockstep to use g_memdup2
Date: Fri, 23 Jun 2023 13:20:54 +0100
Message-Id: <20230623122100.1640995-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The old g_memdup is deprecated, use the replacement.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index e36f0b9562..3614c3564c 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         }
     }
     divergence_log = g_slist_prepend(divergence_log,
-                                     g_memdup(&divrec, sizeof(divrec)));
+                                     g_memdup2(&divrec, sizeof(divrec)));
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-- 
2.39.2


