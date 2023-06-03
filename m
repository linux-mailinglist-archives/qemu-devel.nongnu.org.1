Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C17457213A1
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfS-00075d-PM; Sat, 03 Jun 2023 18:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfP-00073u-VT
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfO-0004yE-Ha
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-65131e85be4so3257540b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831049; x=1688423049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=pKRv036D0eAOAl2TVrOCjcQlY6tWNQ+uBIJBANhOvN+te7I2GZXoKx6UhUdkpSQ7w6
 9Q/elXdzjl7QWZtpLfJjEr/EFt52GJXVpJIFDKPYED58CywLn1tV19nLzg+CQUACJXO8
 SrdBT4aOHepqVA6ZlVzmo2jlfnOBdpZ5R8L/AVBPGmWIm5px3lVQM7LQAvGYrCZnvdzj
 Zpo41N5DAcyunVTd1dJUgMPwGzmS9ZTCE5c8zlxSiu59EGszjQqOY82PMAVSplQTxtfw
 BvtnvqgTpMVbPMlaMIq0pKHE5v8scEFAm+ujGpP2sT488kyNX+lr3bObB/cAktBCxX3/
 V/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831049; x=1688423049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWNck64Rdzbsq9/3XcWJpVmBPzEh5+xH4mb3RyYLiec=;
 b=fPKSywMkc0yQ5drcfDOws07/GW4LW5GMSRoOXd3/IAMdtr8e0mrUqzOozLHiL6FI85
 HxzxdqBxDiPaGglSY7VHmMV/AE/XS0mIpTh3aCwAz/+cKmW64hV8umBR881cv9fJfhw4
 1S/x05K5mbVWH7M1+g4dIdukTbc8jwr81OZQrbMjGo54Dkl//p4TZ2A968QTJKt5d+E1
 1X8K9jzXIL7eU2+UpranEP1Hdn8hA3icO8sWIW1pa+anKuaWS46Fz3iRA8M44pgeZDjw
 nNimWxTc5CKpTOh6cue8w4YKUcarCw0mPyQ3T7ISkwa20zTBHhM8NX2SKCl+6KCqS/M/
 AfyQ==
X-Gm-Message-State: AC+VfDz4rMQfnhA0cEdMjkhgyIfNS2UQAWXyVAF2naNhM1tTnwxnGHpF
 BJSFljvnMBnrm+JIMyZFwzVpZk0rp7YvpuGDTLc=
X-Google-Smtp-Source: ACHHUZ6mFPRlDMRCWSUdSyvfk8rA1hp7wAF/bY//TVjo5IY0+yhHghGbq3N57vNlnaLy2iloDmzpAw==
X-Received: by 2002:a05:6a00:130f:b0:653:e6a9:d2c3 with SMTP id
 j15-20020a056a00130f00b00653e6a9d2c3mr4514366pfu.8.1685831049206; 
 Sat, 03 Jun 2023 15:24:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 15/15] include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for
 nios2
Date: Sat,  3 Jun 2023 15:23:55 -0700
Message-Id: <20230603222355.1379711-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Based on gcc's nios2.h setting BIGGEST_ALIGNMENT to 32 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/abitypes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index beba0a48c7..6191ce9f74 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -17,7 +17,8 @@
 
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
-    || defined(TARGET_MICROBLAZE)
+    || defined(TARGET_MICROBLAZE) \
+    || defined(TARGET_NIOS2)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
-- 
2.34.1


