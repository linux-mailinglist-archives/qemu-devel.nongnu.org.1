Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B087174AD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3x-00077s-Q1; Wed, 31 May 2023 00:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3r-00072v-LD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3p-0006Bc-Bj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-38dec65ab50so3435990b6e.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505824; x=1688097824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WPQBaswIL5gnAeFH0J21sek4FINXtGXGMKXaBWTmSWg=;
 b=mAxQqR/UHq4XAHBzNIV6ge/SexI52on3Ean2QmgOciLAUN9UrKYCY8vzNAPVLOZZzS
 ycgZMaY7OLQ7PRR5JlOMxbSf06J0u4VKfBGbu9dGNhQ/4B63IJhIrMUbMN8O/CRj7uLW
 XXYAH+qYeSOz3cwUE2BrICIRXLSnJ6H1VTgRRr1YkFuCFt0qfGv7waabIPCV296+PtTN
 cTFUU/+xbWe6lqn/PsXdWaIH3vCms0M/Y1LW9Le1ppxhG3WMx8/7r6h+p/TCvuvwlA+a
 Ui5v03s1uSUd5fLoJ7d2ir9kokeIfyIT5QVAmhA7ZipLtYXJIZj3gAOhNuE205RqGN80
 pB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505824; x=1688097824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPQBaswIL5gnAeFH0J21sek4FINXtGXGMKXaBWTmSWg=;
 b=PCpNiCwoL4DsF2eOPDjGHTxy2zqpvDk8EiUn/peqAGmLdatILzEMaj7zvpMNEnWePO
 16rGMCtgX7guk/hSWBCf5hj7iQUV6DSyUS7WUETmCLaG5fCM149VFw08RUJ5M2yN2nU1
 r3hqqnqyBdUVHNDafs2gVuYAh6oN6taB91gBmcC4mntZ6rLuqiGmirNvx+B/VNu+mJet
 csL8P6bcXZONiARl2bHtYKcwyzi3TRVBjlhkgeiMfuqOd/uSfRgrzVOwqGgB6VzCCJix
 lDtEdRoXpR0J3AhRHlnyESkPCQWSuLl6FXZcc2In0t/XAcIg6LLptuT/adlpJTKCP3fL
 bPfQ==
X-Gm-Message-State: AC+VfDyzd3+iZjFzOM7Nue7PvCykq6dnPhAAWTsVLcG/MSms5f1flGKh
 eRPDSOhXV21dcjksd+aDRmrH31pc4WZHE/wwdTw=
X-Google-Smtp-Source: ACHHUZ4mVaI5WUIk6/sf/cNuo7BJz5znHTjmMUbsSSKW+V0h9LBFBuVkoW8eYf2wRYAMcixp7ozyWw==
X-Received: by 2002:a05:6808:2123:b0:398:5a2a:2219 with SMTP id
 r35-20020a056808212300b003985a2a2219mr2869124oiw.33.1685505823875; 
 Tue, 30 May 2023 21:03:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/48] target/arm: Include helper-gen.h in translator.h
Date: Tue, 30 May 2023 21:02:58 -0700
Message-Id: <20230531040330.8950-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

This had been included via tcg-op-common.h via tcg-op.h,
but that is going away.

It is needed for inlines within translator.h, so we might as well
do it there and not individually in each translator c file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 1 +
 target/arm/tcg/translate-a64.c | 2 --
 target/arm/tcg/translate-sme.c | 1 -
 target/arm/tcg/translate-sve.c | 2 --
 target/arm/tcg/translate.c     | 2 --
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..868a3abd0d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,6 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "exec/translator.h"
+#include "exec/helper-gen.h"
 #include "internals.h"
 
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..bc0cb98955 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -29,8 +29,6 @@
 #include "qemu/host-utils.h"
 #include "semihosting/semihost.h"
 #include "exec/gen-icount.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e3adba314e..b0812d9dd6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,7 +23,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "translate.h"
-#include "exec/helper-gen.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 92ab290106..106baf311f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -27,8 +27,6 @@
 #include "arm_ldst.h"
 #include "translate.h"
 #include "internals.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..c89825ad6a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -30,8 +30,6 @@
 #include "qemu/bitops.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 
-- 
2.34.1


