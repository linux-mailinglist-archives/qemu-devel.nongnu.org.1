Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58C711AA0
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLj-0005zQ-Nn; Thu, 25 May 2023 19:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLe-0005vE-Mh
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLY-0005qf-VF
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1afbc02c602so11983255ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057176; x=1687649176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dWxpkriL89hdVCzkPxCT8S4I2dcQ51ihNaTFHcE9jo=;
 b=GIS7GXDcYWW+HuFG94328LSD+e96Nwuq8mKeQLBJjTeDvRGMT+eNs/ILNn3TZnuZCm
 r1AlS1ma2ZyYDCD0Nst4uuSfBSw1plXP8pipyFIlE+z2cWgc//2AGAbF278bRQvkkFz+
 0i0/7S2mqf2bU01B02Tzt49xbdQrSQwEDAzW0AHPJ3pejEuHKzHFIbKX8sEldAxzbCuw
 oVUQTmvXXylVSFz5ISqfOPdQ56FWkswt2kjau7kqgGQbQl41zZtHVkTGI54II1MLoKiF
 17IWsUaHxv6mjO2FxogfZ8W7EIixFl3dhSgq9HpH9iYglsouigptA9IMP+twp9ik5GfB
 qMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057176; x=1687649176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dWxpkriL89hdVCzkPxCT8S4I2dcQ51ihNaTFHcE9jo=;
 b=lYPDd/05FOVY3Qmth2HVGMZp/YcrdcUC0vE8KdZT7XtvLU0aNDy6wxdNSP+00qLVSY
 KYtSA8EyIMASQIH4TOxJDsN+WSOP5VMGKp6Hjh7hp36zhGe0pfVcZ7CP4/5CcL1eNpUU
 o/ExhtQFVoxb7d8dFfxE1daph+eUa5MevqVGTrckPdE1J6ZrWdF5MRtn5qmfzXtx8SxC
 XkhGX70evZ+XuKBfYPzIYer5a3RExX6J4DNhkmCvCPx29mUl0qWAwFDFnxBl+ImVzOBH
 meSUSZ7guo4PmWtYlcuk3ZltsB/DP6lnTL+9ac139KpV5+qQ/7iLNJODVHfSZ0LTfbo9
 SRlQ==
X-Gm-Message-State: AC+VfDxS0BiFNolf/2HqPAkPd7q5VzHWn/TppD6pTfwagc8fjgad+Ib0
 1VH1kZpAsRgxlsM7DMLdHlSEG8xZACZ4PrDLphY=
X-Google-Smtp-Source: ACHHUZ6SYQ2KE7NzwKKaefMb6eXN3CqB8CosFjY/9Er+n82cTigvwuFnJveuYSf+kbEqmezjBqPDdA==
X-Received: by 2002:a17:903:1ca:b0:1a1:d54b:71df with SMTP id
 e10-20020a17090301ca00b001a1d54b71dfmr3306831plh.0.1685057175701; 
 Thu, 25 May 2023 16:26:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 20/20] target/arm: Enable FEAT_LSE2 for -cpu max
Date: Thu, 25 May 2023 16:25:58 -0700
Message-Id: <20230525232558.1758967-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7338987875..ecbbd63adf 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -50,6 +50,7 @@ the following architecture extensions:
 - FEAT_LRCPC (Load-acquire RCpc instructions)
 - FEAT_LRCPC2 (Load-acquire RCpc instructions v2)
 - FEAT_LSE (Large System Extensions)
+- FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 886674a443..2976f94ae4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -644,6 +644,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
     t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
     t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* FEAT_S2FWB */
     t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* FEAT_TTL */
-- 
2.34.1


