Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A300F8CF5CA
	for <lists+qemu-devel@lfdr.de>; Sun, 26 May 2024 21:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlr-0008DG-Lv; Sun, 26 May 2024 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlo-0008CC-8q
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJll-0007dU-Fy
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso1325105ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752580; x=1717357380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/Kek+OpRexEIhDigfP9w9ns/xyOmoQXE9H2AlFSUfI=;
 b=RgA8aguVq5sdD+K0mym2BGJuazTgrNq+btYogslKQ7Eo57MwuRpkTVG7pKPl9FDZHI
 MK/D86uO0uv6PTX1eze/qm9DP0Yca5lOKb9C5dxAi5yg/cRoTC7G4tsSDIHlB53eoOxD
 F/Ci/IGSZsZnO7gSd/iGCZXMN+FUvzoxa10afHRFCUTR8glWc7iBkeW4Y1QhZ4gqgXI8
 jJVdmuaOLmV47oSuxnVfcIqa+b1YUIupHsxRv2mx7Umxhk6dG10JIFAH0HtBNKQRKByI
 mg+XcEvYtNGcS/GzFOQm2jEyY+6Zv+rFCzMnAI+wkdAgszBBUCInBsvCVRPz9OP/0rZ8
 gVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752580; x=1717357380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/Kek+OpRexEIhDigfP9w9ns/xyOmoQXE9H2AlFSUfI=;
 b=AszVaS+21I1uDM08+rM6rSFNYbnzfJooyRvghoNSoBvtDjUeoVTZM1h1w3j9dhMSGj
 zYZy6KEmmK+habqYnwD4tPP0wLcLVxP+8Jg7HUlN/oChFodzm0OMv7gnrIUR3R1nTTTM
 NEIXqRY+bzPbbAMsX2ziB4FK1Ufv8F1lv4rh1UzTP0cVWA+mzlg3pJDmyrjXBEZapQDp
 vcE3pfmRtLb9J0EC5glC2vdUAhhRdTfe6Dl3Y/SWOGy/PQA1UhbPyuqmqiJdB640znW7
 fdhYtn1pPYNEVhYlMhYlJdzsK9QiXSz0u0L4EzIp2qLp4P4MYKbuaVuFToXVVduifPAC
 5JWQ==
X-Gm-Message-State: AOJu0Yx4icED33AMcZkUn8hOPSPuJwdwvGUxyaNj+sX8XagqfXH9fIY3
 tB9a6Oosyww/C7cvsCo/E39IGK0U/QpyZcjenVBq2YlOEv0rSfyt/tPsIjJQs63Jz2CajBTp0TA
 O
X-Google-Smtp-Source: AGHT+IF9XTda19mDevpvl+aBScAEbnuucSQmAwRDCA8vnm6w4oFrXx7GHxMIkzkFGjB/EdD1Yfc5Dg==
X-Received: by 2002:a17:903:2447:b0:1f2:f8b7:60d4 with SMTP id
 d9443c01a7336-1f4497daf6cmr87578305ad.52.1716752579740; 
 Sun, 26 May 2024 12:42:59 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/37] target/sparc: Perform DFPREG/QFPREG in decodetree
Date: Sun, 26 May 2024 12:42:22 -0700
Message-Id: <20240526194254.459395-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Form the proper register decoding from the start.

Because we're removing the translation from the inner-most
gen_load_fpr_* and gen_store_fpr_* routines, this must be
done for all insns at once.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 220 +++++++++++++++++++++++---------------
 target/sparc/translate.c  |  39 +++----
 2 files changed, 148 insertions(+), 111 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index e2d8a07dc4..02fa505b49 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -26,6 +26,14 @@ CALL    01 i:s30
 ## Major Opcode 10 -- integer, floating-point, vis, and system insns.
 ##
 
+%dfp_rd     25:5 !function=extract_dfpreg
+%dfp_rs1    14:5 !function=extract_dfpreg
+%dfp_rs2     0:5 !function=extract_dfpreg
+
+%qfp_rd     25:5 !function=extract_qfpreg
+%qfp_rs1    14:5 !function=extract_qfpreg
+%qfp_rs2     0:5 !function=extract_qfpreg
+
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
 @r_r_ri     .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri
@@ -37,11 +45,40 @@ CALL    01 i:s30
 
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
+@d_r_r      .. ..... ...... rs1:5 . ........ rs2:5         \
+            &r_r_r rd=%dfp_rd
+@r_d_d      .. rd:5  ...... ..... . ........ .....         \
+            &r_r_r rs1=%dfp_rs1 rs2=%dfp_rs2
+@d_r_d      .. ..... ...... rs1:5 . ........ .....         \
+            &r_r_r rd=%dfp_rd rs2=%dfp_rs2
+@d_d_d      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%dfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2
+@q_q_q      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%qfp_rd rs1=%qfp_rs1 rs2=%qfp_rs2
+@q_d_d      .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%qfp_rd rs1=%dfp_rs1 rs2=%dfp_rs2
+
 @r_r_r_swap .. rd:5  ...... rs2:5 . ........ rs1:5         &r_r_r
+@d_d_d_swap .. ..... ...... ..... . ........ .....         \
+            &r_r_r rd=%dfp_rd rs1=%dfp_rs2 rs2=%dfp_rs1
 
 &r_r        rd rs
 @r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
 @r_r2       .. rd:5  ...... ..... . ........ rs:5          &r_r
+@r_d2       .. rd:5  ...... ..... . ........ .....         &r_r rs=%dfp_rs2
+@r_q2       .. rd:5  ...... ..... . ........ .....         &r_r rs=%qfp_rs2
+@d_r2       .. ..... ...... ..... . ........ rs:5          &r_r rd=%dfp_rd
+@q_r2       .. ..... ...... ..... . ........ rs:5          &r_r rd=%qfp_rd
+@d_d1       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%dfp_rs1
+@d_d2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%dfp_rs2
+@d_q2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%dfp_rd rs=%qfp_rs2
+@q_q2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%qfp_rd rs=%qfp_rs2
+@q_d2       .. ..... ...... ..... . ........ .....         \
+            &r_r rd=%qfp_rd rs=%dfp_rs2
 
 {
   [
@@ -241,68 +278,78 @@ DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
 FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
-FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @r_r2
-FMOVq       10 ..... 110100 00000 0 0000 0011 .....        @r_r2
+FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @d_d2
+FMOVq       10 ..... 110100 00000 0 0000 0011 .....        @q_q2
 FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
-FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
-FNEGq       10 ..... 110100 00000 0 0000 0111 .....        @r_r2
+FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @d_d2
+FNEGq       10 ..... 110100 00000 0 0000 0111 .....        @q_q2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
-FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
-FABSq       10 ..... 110100 00000 0 0000 1011 .....        @r_r2
+FABSd       10 ..... 110100 00000 0 0000 1010 .....        @d_d2
+FABSq       10 ..... 110100 00000 0 0000 1011 .....        @q_q2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
-FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
-FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @d_d2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @q_q2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
-FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
-FADDq       10 ..... 110100 ..... 0 0100 0011 .....        @r_r_r
+FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @d_d_d
+FADDq       10 ..... 110100 ..... 0 0100 0011 .....        @q_q_q
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
-FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
-FSUBq       10 ..... 110100 ..... 0 0100 0111 .....        @r_r_r
+FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @d_d_d
+FSUBq       10 ..... 110100 ..... 0 0100 0111 .....        @q_q_q
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
-FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
-FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
+FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @d_d_d
+FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @q_q_q
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
-FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
-FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
-FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
-FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @d_d_d
+FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @q_q_q
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @d_r_r
+FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
-FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
-FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
-FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
-FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
-FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
-FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
-FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
-FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
+FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
+FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @d_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @d_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @d_q2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @q_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @q_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @q_d2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
-FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
-FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
+FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_d2
+FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_q2
 
 FMOVscc     10 rd:5  110101 0 cond:4 1 cc:1 0 000001 rs2:5
-FMOVdcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000010 rs2:5
-FMOVqcc     10 rd:5  110101 0 cond:4 1 cc:1 0 000011 rs2:5
+FMOVdcc     10 ..... 110101 0 cond:4 1 cc:1 0 000010 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVqcc     10 ..... 110101 0 cond:4 1 cc:1 0 000011 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FMOVsfcc    10 rd:5  110101 0 cond:4 0 cc:2   000001 rs2:5
-FMOVdfcc    10 rd:5  110101 0 cond:4 0 cc:2   000010 rs2:5
-FMOVqfcc    10 rd:5  110101 0 cond:4 0 cc:2   000011 rs2:5
+FMOVdfcc    10 ..... 110101 0 cond:4 0 cc:2   000010 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVqfcc    10 ..... 110101 0 cond:4 0 cc:2   000011 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FMOVRs      10 rd:5  110101 rs1:5    0 cond:3  00101 rs2:5
-FMOVRd      10 rd:5  110101 rs1:5    0 cond:3  00110 rs2:5
-FMOVRq      10 rd:5  110101 rs1:5    0 cond:3  00111 rs2:5
+FMOVRd      10 ..... 110101 rs1:5    0 cond:3  00110 ..... \
+            rd=%dfp_rd rs2=%dfp_rs2
+FMOVRq      10 ..... 110101 rs1:5    0 cond:3  00111 ..... \
+            rd=%qfp_rd rs2=%qfp_rs2
 
 FCMPs       10 000 cc:2 110101 rs1:5  0 0101 0001 rs2:5
-FCMPd       10 000 cc:2 110101 rs1:5  0 0101 0010 rs2:5
-FCMPq       10 000 cc:2 110101 rs1:5  0 0101 0011 rs2:5
+FCMPd       10 000 cc:2 110101 .....  0 0101 0010 .....    \
+            rs1=%dfp_rs1 rs2=%dfp_rs2
+FCMPq       10 000 cc:2 110101 .....  0 0101 0011 .....    \
+            rs1=%qfp_rs1 rs2=%qfp_rs2
 FCMPEs      10 000 cc:2 110101 rs1:5  0 0101 0101 rs2:5
-FCMPEd      10 000 cc:2 110101 rs1:5  0 0101 0110 rs2:5
-FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
+FCMPEd      10 000 cc:2 110101 .....  0 0101 0110 .....    \
+            rs1=%dfp_rs1 rs2=%dfp_rs2
+FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
+            rs1=%qfp_rs1 rs2=%qfp_rs2
 
 {
   [
@@ -328,74 +375,74 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
-    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_r_r
-    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_r_r
-    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_r_r
-    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_r_r
-    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_r_r
-    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_r_r
-    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_r_r
-    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_r_r
+    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_d_d
+    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_d_d
+    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_d_d
+    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_d_d
+    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_d_d
+    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_d_d
+    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_d_d
+    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_d_d
 
-    FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @r_r_r
-    FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @r_r_r
-    FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @r_r_r
-    FMUL8SUx16  10 ..... 110110 ..... 0 0011 0110 .....    @r_r_r
-    FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
-    FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
-    FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
-    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
-    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_r2
-    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_r2
-    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
+    FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
+    FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
+    FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @d_r_r
+    FMUL8SUx16  10 ..... 110110 ..... 0 0011 0110 .....    @d_d_d
+    FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @d_d_d
+    FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @d_r_r
+    FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @d_r_r
+    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @d_d_d
+    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_d2
+    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_d2
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @d_d_d
 
-    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
-    FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
-    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
-    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_r2
+    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
+    FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
+    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
+    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @d_r2
 
-    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
+    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @d_d1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
-    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @r_r2  # FSRC2d
+    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @d_d2  # FSRC2d
     FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
-    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @r_r1  # FNOT1d
+    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @d_d1  # FNOT1d
     FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
-    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
+    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @d_d2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
 
-    FPADD16     10 ..... 110110 ..... 0 0101 0000 .....    @r_r_r
+    FPADD16     10 ..... 110110 ..... 0 0101 0000 .....    @d_d_d
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
-    FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @r_r_r
+    FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @d_d_d
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
-    FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @r_r_r
+    FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @d_d_d
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
-    FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @r_r_r
+    FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @d_d_d
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
 
-    FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @r_r_r
+    FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
-    FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @r_r_r   # FANDNOT2d
+    FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @d_d_d   # FANDNOT2d
     FANDNOTs    10 ..... 110110 ..... 0 0110 0101 .....    @r_r_r   # FANDNOT2s
-    FANDNOTd    10 ..... 110110 ..... 0 0110 1000 .....    @r_r_r_swap # ... 1d
+    FANDNOTd    10 ..... 110110 ..... 0 0110 1000 .....    @d_d_d_swap # ... 1d
     FANDNOTs    10 ..... 110110 ..... 0 0110 1001 .....    @r_r_r_swap # ... 1s
-    FXORd       10 ..... 110110 ..... 0 0110 1100 .....    @r_r_r
+    FXORd       10 ..... 110110 ..... 0 0110 1100 .....    @d_d_d
     FXORs       10 ..... 110110 ..... 0 0110 1101 .....    @r_r_r
-    FNANDd      10 ..... 110110 ..... 0 0110 1110 .....    @r_r_r
+    FNANDd      10 ..... 110110 ..... 0 0110 1110 .....    @d_d_d
     FNANDs      10 ..... 110110 ..... 0 0110 1111 .....    @r_r_r
-    FANDd       10 ..... 110110 ..... 0 0111 0000 .....    @r_r_r
+    FANDd       10 ..... 110110 ..... 0 0111 0000 .....    @d_d_d
     FANDs       10 ..... 110110 ..... 0 0111 0001 .....    @r_r_r
-    FXNORd      10 ..... 110110 ..... 0 0111 0010 .....    @r_r_r
+    FXNORd      10 ..... 110110 ..... 0 0111 0010 .....    @d_d_d
     FXNORs      10 ..... 110110 ..... 0 0111 0011 .....    @r_r_r
-    FORNOTd     10 ..... 110110 ..... 0 0111 0110 .....    @r_r_r    # FORNOT2d
+    FORNOTd     10 ..... 110110 ..... 0 0111 0110 .....    @d_d_d    # FORNOT2d
     FORNOTs     10 ..... 110110 ..... 0 0111 0111 .....    @r_r_r    # FORNOT2s
-    FORNOTd     10 ..... 110110 ..... 0 0111 1010 .....    @r_r_r_swap # ... 1d
+    FORNOTd     10 ..... 110110 ..... 0 0111 1010 .....    @d_d_d_swap # ... 1d
     FORNOTs     10 ..... 110110 ..... 0 0111 1011 .....    @r_r_r_swap # ... 1s
-    FORd        10 ..... 110110 ..... 0 0111 1100 .....    @r_r_r
+    FORd        10 ..... 110110 ..... 0 0111 1100 .....    @d_d_d
     FORs        10 ..... 110110 ..... 0 0111 1101 .....    @r_r_r
 
-    FZEROd      10 rd:5  110110 00000 0 0110 0000 00000
+    FZEROd      10 ..... 110110 00000 0 0110 0000 00000    rd=%dfp_rd
     FZEROs      10 rd:5  110110 00000 0 0110 0001 00000
-    FONEd       10 rd:5  110110 00000 0 0111 1110 00000
+    FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
@@ -407,9 +454,6 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 ## Major Opcode 11 -- load and store instructions
 ##
 
-%dfp_rd     25:5 !function=extract_dfpreg
-%qfp_rd     25:5 !function=extract_qfpreg
-
 &r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
 @r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
 @d_r_ri_na  .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1eb1a6decf..f3c52c7c48 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -190,14 +190,6 @@ typedef struct DisasContext {
 #define GET_FIELDs(x,a,b) sign_extend (GET_FIELD(x,a,b), (b) - (a) + 1)
 #define GET_FIELD_SPs(x,a,b) sign_extend (GET_FIELD_SP(x,a,b), ((b) - (a) + 1))
 
-#ifdef TARGET_SPARC64
-#define DFPREG(r) (((r & 1) << 5) | (r & 0x1e))
-#define QFPREG(r) (((r & 1) << 5) | (r & 0x1c))
-#else
-#define DFPREG(r) (r & 0x1e)
-#define QFPREG(r) (r & 0x1c)
-#endif
-
 #define UA2005_HTRAP_MASK 0xff
 #define V8_TRAP_MASK 0x7f
 
@@ -240,34 +232,30 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
 
 static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
 {
-    src = DFPREG(src);
     return cpu_fpr[src / 2];
 }
 
 static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
 {
-    dst = DFPREG(dst);
     tcg_gen_mov_i64(cpu_fpr[dst / 2], v);
     gen_update_fprs_dirty(dc, dst);
 }
 
 static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
 {
-    return cpu_fpr[DFPREG(dst) / 2];
+    return cpu_fpr[dst / 2];
 }
 
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
 
-    src = QFPREG(src);
     tcg_gen_concat_i64_i128(ret, cpu_fpr[src / 2 + 1], cpu_fpr[src / 2]);
     return ret;
 }
 
 static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
 {
-    dst = DFPREG(dst);
     tcg_gen_extr_i128_i64(cpu_fpr[dst / 2 + 1], cpu_fpr[dst / 2], v);
     gen_update_fprs_dirty(dc, dst);
 }
@@ -2045,16 +2033,14 @@ static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
-    int qd = QFPREG(rd);
-    int qs = QFPREG(rs);
     TCGv c2 = tcg_constant_tl(cmp->c2);
 
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2], cmp->c1, c2,
-                        cpu_fpr[qs / 2], cpu_fpr[qd / 2]);
-    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[qd / 2 + 1], cmp->c1, c2,
-                        cpu_fpr[qs / 2 + 1], cpu_fpr[qd / 2 + 1]);
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2], cmp->c1, c2,
+                        cpu_fpr[rs / 2], cpu_fpr[rd / 2]);
+    tcg_gen_movcond_i64(cmp->cond, cpu_fpr[rd / 2 + 1], cmp->c1, c2,
+                        cpu_fpr[rs / 2 + 1], cpu_fpr[rd / 2 + 1]);
 
-    gen_update_fprs_dirty(dc, qd);
+    gen_update_fprs_dirty(dc, rd);
 #else
     qemu_build_not_reached();
 #endif
@@ -2086,12 +2072,20 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
 
 static int extract_dfpreg(DisasContext *dc, int x)
 {
-    return DFPREG(x);
+    int r = x & 0x1e;
+#ifdef TARGET_SPARC64
+    r |= (x & 1) << 5;
+#endif
+    return r;
 }
 
 static int extract_qfpreg(DisasContext *dc, int x)
 {
-    return QFPREG(x);
+    int r = x & 0x1c;
+#ifdef TARGET_SPARC64
+    r |= (x & 1) << 5;
+#endif
+    return r;
 }
 
 /* Include the auto-generated decoder.  */
@@ -4253,7 +4247,6 @@ static bool do_dc(DisasContext *dc, int rd, int64_t c)
         return true;
     }
 
-    rd = DFPREG(rd);
     tcg_gen_movi_i64(cpu_fpr[rd / 2], c);
     gen_update_fprs_dirty(dc, rd);
     return advance_pc(dc);
-- 
2.34.1


