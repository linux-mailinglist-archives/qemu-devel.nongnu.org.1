Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B33716D48
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o0-00068y-OF; Tue, 30 May 2023 15:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ns-0005xi-5a
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nq-0004bm-Bn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so5595468b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474081; x=1688066081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+TYNNzW8iqKYogWvG6qM6ASiJ8Nk4m8jlgOtvWjt84=;
 b=ma/dtkOEDPpQreXY8gMYkTjSEVDqX2/YCANXPIj+Gp0owpOKo/ioXt1pe11gdmYd8S
 2uwE/y+NlOiTQF7DZPEQYR1JFYGgcZLVAXSULKlF8FJtPxN/xUo7W2/FY3yUz/qAWq9P
 kFFASK1myDlNeSSiY7uajgAKEYxCDpPQlCCnmbnz1oeVYzbsCM5WZSaRWl8Oeov2+frX
 q8+99LV+FVwNTTzs/HkSluCwgZ7lRcL1vT39W5+yTqENKxEmz7y0G+L+k/ldVQX4PUni
 OPQSAUMP6bpNBd77O0bcDMbuXDBW2t/+Eygy6pU2x7NwEDiTdYoCRUVGuqgoVhdOwFzb
 0Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474081; x=1688066081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+TYNNzW8iqKYogWvG6qM6ASiJ8Nk4m8jlgOtvWjt84=;
 b=CbXipUXyo+wTZChKKRfm+oayAp4J0DPRWjoXFX0Bbn7CQzrFqvqpQ96DtWdP3cXVU/
 nctFfT685UWPjH1dE9gBbxFWsf3cuYwgvzVgFfMi8j3a6qJm3CcJcb0ysq0/kEApshUS
 rd8TXgarxhMKl3jBEgeV0PTsPLjMP56IOO/V8Q0Zm20k48/31QPthdt0DYm8to/uN0qK
 rFOaUW4csi9tZn6RFHZWnrotkrEtDiW4/E3znNLqorGmSILfD1wDND0M6wocQVvtDMNm
 le5OG8bifqfgh+7AAJVkIukGrjzUkOEwKlWmaBp+VbIXGiycOYGRK/yV4bp/ysMaTyu4
 Es0Q==
X-Gm-Message-State: AC+VfDytPD5Y/p2VcsrLZo739hYkKGeu79zldxep/06FyKa+RJkJ5DOj
 45p8MKWEDH2btG0yRdccQ4aDWpy4ch2HSTHFI+w=
X-Google-Smtp-Source: ACHHUZ5cCLiA7xcuLgd1zu75ShUlElnw4UxC4IJUgXbgfLp/eVU2nLrG9iLJs9SlYyaIkANT5roiSA==
X-Received: by 2002:a05:6a20:1590:b0:110:a7da:b980 with SMTP id
 h16-20020a056a20159000b00110a7dab980mr4124298pzj.12.1685474081047; 
 Tue, 30 May 2023 12:14:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 02/20] target/arm: Add feature test for FEAT_LSE2
Date: Tue, 30 May 2023 12:14:20 -0700
Message-Id: <20230530191438.411344-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 81c0df9c25..c1db26b299 100644
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


