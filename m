Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE5723E63
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIz-0007pg-CY; Tue, 06 Jun 2023 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIl-0007gS-KI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004mn-Ja
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30af20f5f67so5836366f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WirQNMYCiGFxNrxNM5kRYUkPdHgGD3/H9+UOE0lJ/sM=;
 b=WAyYpTYuFci3UhQ/t+RomnirvDWX5aWL7Usnhe8b90YAUEVqqpyofUiBaVmTpFfUgO
 UgPhOQskRk6GeRApJRNSaj329xoYllZvDacDtSeoLuRrCar5dwRDIB03TJV7yZJ3vGRF
 al7U6Nv5+mQG6GsEJGCnK9LlPyZ+BhfGUTGTu16ChhmkqXlKVXAUnGwGluCwTHnVBXfo
 wNvsTBU0WevvHkLax/OzRqOJMYii8u5j6vNxFNDUVG1glruVkfOubw32dKL5I9o5xtts
 59doQbRbtpzxI5dEFvhsfvFNaM3gYmy3cNn8hD4vm5ohBDpHpcGs+RHinsAnnglSXrG9
 2J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044906; x=1688636906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WirQNMYCiGFxNrxNM5kRYUkPdHgGD3/H9+UOE0lJ/sM=;
 b=VwYiKFb6fYzFCTnrghzquyfiF2ix2SW6aXqdQe6equEsRdK8v/IE1G9UAPdKq1gGOn
 80uV6rprmzDbycvNYlNr8ZMiIStsBZoc7Bo6A//Vpts+2wzoTbEVCSZRm3zOxIA7plp+
 O+PHS+OAnK/w9gvBYfAin4Hqun77w6D1yafvo/eRFHP8iiQvu/hgqylSYMqdVMmWeKYJ
 Akgd5/UgY2EaL5AVTC6vN592SfYl7pi7Td8wcJY51vpM2rhLzzE7CqqV3ojJdW/SSBfI
 YW3dzl4QvyI1z9T1cba5V3kuuubSdUOURW3Tgdbas1OghtDNQIVsQc0xRYmCT25k9U/s
 M2KA==
X-Gm-Message-State: AC+VfDyaZlwPhEnlkuqFMIcJJiyWY7kUxm1Mgs+ULL1N5G3a9EL1ryER
 oEsTTNgF8BfyIB9ZIvGTd2LIBjZxzpTCJtqvaiI=
X-Google-Smtp-Source: ACHHUZ6G6AkQ2Yeuj9pvQtKE6nSRQ4d/KUSVH85LIa+jX6MAkmYEwyGZQJg6cpm5XgIgQ4bjhDFHeA==
X-Received: by 2002:a05:6000:1151:b0:309:3bc3:7d1f with SMTP id
 d17-20020a056000115100b003093bc37d1fmr1133640wrx.70.1686044906304; 
 Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/42] target/arm: Add feature test for FEAT_LSE2
Date: Tue,  6 Jun 2023 10:47:53 +0100
Message-Id: <20230606094814.3581397-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 81c0df9c259..c1db26b2998 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3851,6 +3851,11 @@ static inline bool isar_feature_aa64_st(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, ST) != 0;
 }
 
+static inline bool isar_feature_aa64_lse2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, AT) != 0;
+}
+
 static inline bool isar_feature_aa64_fwb(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, FWB) != 0;
-- 
2.34.1


