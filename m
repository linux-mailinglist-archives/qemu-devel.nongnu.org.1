Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A39FC20A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Dec 2024 21:10:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBEB-00038l-33; Tue, 24 Dec 2024 15:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDZ-00078W-IN
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:26 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDX-0002zB-3E
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:25 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216728b1836so49419825ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070962; x=1735675762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fu0SQWVVGdmrru8Sp2YT+Mtrtw7meBa6dVTFQbMXPPI=;
 b=DNbx3tw/Nbu9RQ4IQEWCHnDHBWIA+mYUAfTf0A76Qq+JgqSFFvkZ0I6FnKGdgPggQ0
 Mq79bHqfWn27dgdkIAEvQNJ3SvTR+55aiE+OYJrPT1MPlOvPYJGO7qw87/RS98RlKJk4
 YGZ7Bvt3NO0FS5tnSmbr0W2hebAPy2N/H+ZjZda2Wbl2V6Y9r44irHYTfcauZvBmPGYS
 s/Kr7w3r3KB3vS0Ol67CnMBle1UbJyZ7T8sn1gC0rmwtx5kSl85bS63FJLSkMIIOvBH/
 sA1hLUaQglwz46QajY3PNiL6z0//NesoPo2tY1+czcC//cn8Al/47BnglCooJHlkus6c
 MUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070962; x=1735675762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fu0SQWVVGdmrru8Sp2YT+Mtrtw7meBa6dVTFQbMXPPI=;
 b=tpuOBLDAWTtyKKyfYi7+t8TdAQD0tkCTnTXnhsoQf7dU0OKtMRPWpa4CxMBb5jZeHh
 DkeRVN8NT6KduSQ7csfvJ+gaWhfog7AAhECWIbfKvLzCBrAEYUjQZrmh8ILjVS7e8odg
 JEmtHTkaJDKZFPBQsDk81iSOeSFlFCxF23+TkPdzpLs0zDMS6+RgvfD9O+ikX/xyigjf
 qLRN3aFbpecTI+Q54S9gaBCwkXmPi0Cd8C33XHUVw4UIlZbKzgpa701I77NUo9i4nWA3
 mUGEXEysuO3/tTAdyEqHwagI2Bpr4tFZf0ZSQYesvjOKx6X5ogfpZz/czXQ6u2TqXdD9
 5/0A==
X-Gm-Message-State: AOJu0Yyg3GIzKB1Gs1cdlNNt8vHnZ9GEqatvd+FTuSJRakRz4IT+PCHn
 JNQymK2iOwAIp+piVpM8W7ZjxQejHGyEiEAIbbbeT21qQTumEPWNgaBWgRtTcETyCMNKGLIczGy
 ta6k=
X-Gm-Gg: ASbGnctNdE6YONXjLwIpNZCkt7ukOCuDWQjHavo3NTl2RUKZrx8pk8+Yg0rPhGCKOrD
 N5GQfT21/KfYl5u1WuJu3kbnN2RUgnWPWe3eiZtVYoJl+fgXB84vl3WPHawiRBV+PSQsBESUvVr
 nMki6d9YqoHhVn4Qbwqa1g51RPKiaCMGb48Vr4zUkQbEGoTQy0CnbUkem9NQnToBqSI2no0Kyn9
 t04UWQTTKX5BxD9HnToy8FGahwnsxPL0EDNsS9IaY/eWrAKWZRaQ6YT4QtPvBAfBdugCRMNi0C3
 lvgBl0ifqANSewhLzBR7/z4D2A==
X-Google-Smtp-Source: AGHT+IFkFnOtCkxQDtnDEio8oml8KRXjDA/gtbi5u8j6rmk8/W+XT4uOxbVgISdNpEXOh3R/TNWg/Q==
X-Received: by 2002:a05:6a20:4394:b0:1e1:b430:19c6 with SMTP id
 adf61e73a8af0-1e5e04600e3mr26564657637.10.1735070961814; 
 Tue, 24 Dec 2024 12:09:21 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 62/72] target/hexagon: Use float32_muladd for helper_sffma
Date: Tue, 24 Dec 2024 12:05:11 -0800
Message-ID: <20241224200521.310066-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

There are no special cases for this instruction.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index d257097091..15b143a568 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1054,7 +1054,7 @@ float32 HELPER(sffma)(CPUHexagonState *env, float32 RxV,
                       float32 RsV, float32 RtV)
 {
     arch_fpop_start(env);
-    RxV = internal_fmafx(RsV, RtV, RxV, 0, &env->fp_status);
+    RxV = float32_muladd(RsV, RtV, RxV, 0, &env->fp_status);
     arch_fpop_end(env);
     return RxV;
 }
-- 
2.43.0


