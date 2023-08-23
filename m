Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C82786164
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOk-0000K8-56; Wed, 23 Aug 2023 16:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOZ-0008PV-4C
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005W0-Sz
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:02 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso37627525ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822234; x=1693427034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZ62r5d6+6rV1DUVw8PqW06PxONRPMe2P0kJIV4zocA=;
 b=KM3LhU5LCN57R1cOFntLg2/XXnY8JOilBpcEcQLsmxu9gHGwE/A/pSdBFJ4VIpwf0Q
 6lAtLcXgkehTtWhAnsEHxbzMRE4B6i9Ms4jz4tpwjAf8fsf2MmRhUonUdVx+dC4NadSb
 /uJGB7suvMbywvxH3nuUqhPEJAhS44NYHZDgPW4CxhKmC35LbGu1bFPl78x2PkTA7i8d
 q3VpaDRJK7Hy/tVtrG8VOA5oJTWeqpJz7PNx4Euehpvy/4FSgEDiH5c4pmEv+eeSY6+p
 Vn3syVRRqKnXIcftOPut5iO61iUB63XZW2BF5y6PHtF00TXO27Vvid1TrIrlpKOLBD13
 XXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822234; x=1693427034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZ62r5d6+6rV1DUVw8PqW06PxONRPMe2P0kJIV4zocA=;
 b=bWC5qbtuxhD6jhZ6EW2g4fxKO682spXHrF+DmomQ1jrG+RiIhpvHLjykd5wjsNv1v+
 33oN4BXZtzphNXhEDBalUChUQzGkGrIsdz2HALmeaYSZgcMD/yZSWCgnTjMNdir2G/ro
 PxK8JRiuE1nZkWB7q+Fjl8DNgEqaUylA/twBpSxt243skpYfMQM0Tm5raEpRP8xI6/dk
 lVi75EfNhZKPE/tgfTThS0XTfqHFVOQgHJHhGLBKZ8iTGJiSsMvrmQgTdtLOKFvdRkG/
 IUuvUtboEshRkve5VToVElBEZdOUVn6wOTotZTcJo6SpzO1PkWmZ8Rk5muEwiZk4Dlss
 VXdw==
X-Gm-Message-State: AOJu0YxemaKfD8RZBHvapTUI8iVhsF2mIRGH4ikCz/71q4v4MckKA02b
 dQtYeOzaJBVUN2tZGaXy4aLOmfy1c2ybdV/82zs=
X-Google-Smtp-Source: AGHT+IFJwqg+dEGvzyyno1ZBajEdQkFvo9gN2sCVYc22VBY/iWQKPP7ZCXfRBxl8njdqssCZYpgROw==
X-Received: by 2002:a17:902:d4ce:b0:1bd:f71c:3af3 with SMTP id
 o14-20020a170902d4ce00b001bdf71c3af3mr12932562plg.32.1692822234207; 
 Wed, 23 Aug 2023 13:23:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/48] tcg/arm: Implement negsetcond_i32
Date: Wed, 23 Aug 2023 13:23:06 -0700
Message-Id: <20230823202326.1353645-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Trivial, as we simply need to load a different constant
in the conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.h     | 2 +-
 tcg/arm/tcg-target.c.inc | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index ad66f11574..311a985209 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -116,7 +116,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..162df38c73 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1975,6 +1975,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
                         ARITH_MOV, args[0], 0, 0);
         break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
+                        args[1], args[2], const_args[2]);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[args[3]],
+                        ARITH_MVN, args[0], 0, 0);
+        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(args[3])],
+                        ARITH_MOV, args[0], 0, 0);
+        break;
 
     case INDEX_op_brcond2_i32:
         c = tcg_out_cmp2(s, args, const_args);
@@ -2112,6 +2120,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
     case INDEX_op_and_i32:
-- 
2.34.1


