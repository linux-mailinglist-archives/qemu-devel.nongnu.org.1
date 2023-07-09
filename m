Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7774C718
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAU-0008JE-Lo; Sun, 09 Jul 2023 14:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAJ-0008EP-9q
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAG-0000E0-PC
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso3573397f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927382; x=1691519382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLgfXZyf9aATX9TfQItUdKukGg6cdQDyWQ8EagJh33A=;
 b=iAUj9O7+LFwt3Zf+ETwt8UG82wsavqE/EP9S3iITcm5ub39DVylbXA/wARxo1Le897
 BtyzUn3DcgjPfqCwm2dkSj4zTWwdk7V0UJ8WzF1T0Xdmkp/VUKEyORUfBPGJY4B++v2a
 M2SmjClicyQfkAORq33hNNTGiKZWsTJ9xHowVjC2fZft1W7iJL9aLVvRFYmvfYBFb0pT
 Xk+BCa9LHmOkjeTCDj4LUaWlm5O4+crXZOVg4qRxIxbL8YbXju/arAL6OJJXvoTVczc1
 netakwK5hgyTq3M2u/5BzTC7cueX+4Agvr/92h7P+/rYI7Iy4OZlFOVOFWW0D7DEtVzl
 Q0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927382; x=1691519382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLgfXZyf9aATX9TfQItUdKukGg6cdQDyWQ8EagJh33A=;
 b=i6TbulDW38I4ZSnFQQm0o3pZFeMHr3IahvjB9niyJU4g9iz3dV/ufoU0pZYTENQA8I
 V1Tz1NTBRfLAFysHQVB8DC0WWmZf6Dp4OYFHLA+JTOOLeMXBxb8BH75S5XUnzgVeP+n9
 qT7QPdKxp8AXkfamdfUWugrh7V+RDmeN+dfoVLDfUiHOmTSFrWL0IpxjgvrlgdkptSR6
 ko1CdR6ehkovBs6qsr23xF/F6FsmDLANE3DbGpQlbutMTvt3k7WpefVu173jEP9O5siN
 R1kElUpLkFGxlB3ft4gnLnPVBjEeT0BhnfEJNhAnVm9zXXlb27sOPnEliBYDBjetPqEZ
 04Dw==
X-Gm-Message-State: ABy/qLboUC69hUbyfJfb6A4aFX26cSXkl5Hepu65jPhjnlTXMjmVcFAx
 rBrH4+mggOVRl2vffFpD6DnuYHpm+5U6xkwCpVqavg==
X-Google-Smtp-Source: APBJJlGNWaL3NELHZbgkp8Wjkz2qm/gdppxjnsHiOJNBPhdZQjtQ34VplyT+gDG96l0Tur+dGOYRKw==
X-Received: by 2002:a5d:5303:0:b0:313:deda:c444 with SMTP id
 e3-20020a5d5303000000b00313dedac444mr7925547wrv.24.1688927382497; 
 Sun, 09 Jul 2023 11:29:42 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/37] crypto/aes: Add AES_SH, AES_ISH macros
Date: Sun,  9 Jul 2023 19:28:19 +0100
Message-Id: <20230709182934.309468-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

These macros will constant fold and avoid the indirection through
memory when fully unrolling some new primitives.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/aes.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 67bb74b8e3..e65c97e0c1 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -108,12 +108,24 @@ const uint8_t AES_isbox[256] = {
     0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D,
 };
 
+/* AES ShiftRows, for complete unrolling. */
+#define AES_SH(X)   (((X) * 5) & 15)
+
 const uint8_t AES_shifts[16] = {
-    0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11
+    AES_SH(0x0), AES_SH(0x1), AES_SH(0x2), AES_SH(0x3),
+    AES_SH(0x4), AES_SH(0x5), AES_SH(0x6), AES_SH(0x7),
+    AES_SH(0x8), AES_SH(0x9), AES_SH(0xA), AES_SH(0xB),
+    AES_SH(0xC), AES_SH(0xD), AES_SH(0xE), AES_SH(0xF),
 };
 
+/* AES InvShiftRows, for complete unrolling. */
+#define AES_ISH(X)  (((X) * 13) & 15)
+
 const uint8_t AES_ishifts[16] = {
-    0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3
+    AES_ISH(0x0), AES_ISH(0x1), AES_ISH(0x2), AES_ISH(0x3),
+    AES_ISH(0x4), AES_ISH(0x5), AES_ISH(0x6), AES_ISH(0x7),
+    AES_ISH(0x8), AES_ISH(0x9), AES_ISH(0xA), AES_ISH(0xB),
+    AES_ISH(0xC), AES_ISH(0xD), AES_ISH(0xE), AES_ISH(0xF),
 };
 
 /*
-- 
2.34.1


