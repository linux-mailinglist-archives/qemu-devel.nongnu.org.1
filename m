Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A979764F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:06:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHUA-0000zh-1X; Thu, 07 Sep 2023 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU8-0000z1-LZ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:04:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTz-00022H-Mq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:04:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so1073165f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102630; x=1694707430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cSrp0+T26ckOWOwCscXY14LUMBYTRcsC4SLHwpwRt8Y=;
 b=YBkWMyExSaf5RyMzrDlqzitTrL0LjIpn9luKJOiYP62O3WnQNsF+RmR4bF13CFITXH
 X7TQWgHbCZ0hh1ek0V9zAmVBsV2VnGZjT2pRtbWf8cZwI+6nWkM2HkaIgGk4BWIyMh6/
 /IfHCXmho40sOGo2z2Flz+V9xWKpVHf4yV9BBrHAOv2Y9TLG+bGT6XJMCeRPoVH7koM/
 mZW8k1QJyh9gG0TnZIGKIlpeUEBsWeXxJ10LA5uYdI/16chHJAnsvnQgkJwJlzf5mo70
 7hrU/3Ev5KZ/yKswW902kUFcLCy7CAQsODnyaGCyyi4qefiPK3Kj/50JhmZxkJROAJNh
 8+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102630; x=1694707430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSrp0+T26ckOWOwCscXY14LUMBYTRcsC4SLHwpwRt8Y=;
 b=KFyVyiCiuudnT3YRrnusgTXgzCoRjeGUIEP1Kpk239/tyl7jcFW3V62DtzKP2uFiiM
 INbVFEp0cshiCy0yG3/R7idxUTYBbtTwaBMwxJecDZPIE1FtsTHZwNvj8ZDKcYU7Q2nC
 L1mX7DNzIp7w4w0EFzaY5IScSnqwBnVwMd1Y1AniIYF81Vo0hEcm2US0+A7l5JVu3xnT
 iMhBLlhoP9wkThPmgWxCHRljwoE9hOMGAzMtvc8DzLTj17ARxkdDJb4zKFtBAoiax6h8
 8zu+J7rKaenaUuC2RGF+hU9n5omE/k95ztffGjb5JNpigrOEEl2i3nf5UOf1Ng/YqAqe
 zmPw==
X-Gm-Message-State: AOJu0Yw8UVV50bugtuOKmGiKnGP8qHnPOnBch2F9ost0Y2dDLKMu3Aaj
 DtSlviVgmmdKc4oKiIFmh7BU6Q==
X-Google-Smtp-Source: AGHT+IEhLhnqc0mxRZxiCPbhWe4i42RyHD8vrCDX60wRHbLP5M/iG1tjiOW/2r/LCLgvKD/4jm8r/g==
X-Received: by 2002:a5d:6b51:0:b0:319:841c:ae7a with SMTP id
 x17-20020a5d6b51000000b00319841cae7amr5160271wrw.41.1694102630387; 
 Thu, 07 Sep 2023 09:03:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/14] target/arm: Enable FEAT_MOPS for CPU 'max'
Date: Thu,  7 Sep 2023 17:03:40 +0100
Message-Id: <20230907160340.260094-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Enable FEAT_MOPS on the AArch64 'max' CPU, and add it to
the list of features we implement.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2e6a7c8961e..8ce2f714517 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -54,6 +54,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0f8972950d6..0ccd759a2c4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -814,6 +814,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     cpu->isar.id_aa64isar1 = t;
 
+    t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
+    cpu->isar.id_aa64isar2 = t;
+
     t = cpu->isar.id_aa64pfr0;
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
-- 
2.34.1


