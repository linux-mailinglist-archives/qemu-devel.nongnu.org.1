Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527C7E0797
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8p-0005Lk-Rz; Fri, 03 Nov 2023 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8N-0005FV-OG
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8F-0003Vh-OJ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:58 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5b9a456798eso1628135a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033134; x=1699637934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hV535+ZsVPNVTyyGsz8sKP3/7RTFgq3VTGjCiMWUEiI=;
 b=YWpYzp4YZWhqcBay3FXkPYaNgWVZK4/qtp1xqS5btpFn5jCgpGeJOh0QxTUXMLBawS
 DJpgzR+SU9FK3B+vtvegTFhhnlNMkfDne++0M8RiPKUX4l16+/YaCT7+3vI1qiHx5E70
 d2t9tBKHh8alAapYNeEfpclDPE44DsTTn7Q2iXKbQO2gX7c1Y+/cVKUMvezou9SzWLxu
 /XFefubbEeDuLh8lX9gwaYuaP97PGBpVfkIKkbqFdZf4BpScWws7OoRdCENtBtdPEfCc
 rQ1ObXdn1rc5tBVeoZE+H+zRTDdPTfVqv5/u3EhXEhjCmTPGm1Zivi/4tw7d9b4uPMXT
 U/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033134; x=1699637934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hV535+ZsVPNVTyyGsz8sKP3/7RTFgq3VTGjCiMWUEiI=;
 b=MT8lUwV6cwWDukzaofekKvORhBJ/6xPRTCqDDsll0B+IUypLu0PFMyoeUzB5/6ujSX
 4sjgEzIhz8vMlMoOqjQQC8qD9QUpHdXLvm6aI04BeAjBJKMSxfZ8+U019jkxjyJhJTsW
 iWJLm3km2ToyC6Y/DdqmEkGp/0xlZMkh80OG9T79VMKpIPZYRIK5T9x7SojiBd0HQSUv
 cIIl23z01WMGHwmkTbF6BKtmg7l87Xi4NZJAdpr1JS7KDcwiu6ykJAWrkHM0iyhuMRe9
 U0+fdgu709f0TpA7JYLAGRdlSz6yHwaeSFfgQErFonjd6HYvz5mxNtc7LooN+vLdxtwl
 fF6w==
X-Gm-Message-State: AOJu0YzvYCd3av5rRd5hCtPeqY+M1OIsnM30Eig/JWxmXoWUtPqxTBf/
 lKuxw0ElmwYfmFgQ8R1++kg0pxzoEVRTOTkiI0Q=
X-Google-Smtp-Source: AGHT+IFBWqcgKGow5C6BCoqmf7ehbH0bm++KYJRCXxuNum5z0ERfy64v30QqtyKOOkQP4kq47kGMCw==
X-Received: by 2002:a05:6a20:3d8b:b0:137:514a:984f with SMTP id
 s11-20020a056a203d8b00b00137514a984fmr23938310pzi.35.1699033133893; 
 Fri, 03 Nov 2023 10:38:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 14/22] target/sparc: Remove qt0, qt1 temporaries
Date: Fri,  3 Nov 2023 10:38:33 -0700
Message-Id: <20231103173841.33651-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

These are no longer used for passing data to/from helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h         | 2 --
 target/sparc/fop_helper.c  | 3 ---
 target/sparc/ldst_helper.c | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3e361a5b75..446b38f3df 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -509,8 +509,6 @@ struct CPUArchState {
     uint64_t mmubpregs[4];
     uint64_t prom_addr;
 #endif
-    /* temporary float registers */
-    float128 qt0, qt1;
     float_status fp_status;
 #if defined(TARGET_SPARC64)
 #define MAXTL_MAX 8
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index cd9b212597..7353a61237 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -23,9 +23,6 @@
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
-#define QT0 (env->qt0)
-#define QT1 (env->qt1)
-
 static inline float128 f128_in(Int128 i)
 {
     union {
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 09066d5487..fe984d44d7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -66,9 +66,6 @@
 #endif
 #endif
 
-#define QT0 (env->qt0)
-#define QT1 (env->qt1)
-
 #if defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 /* Calculates TSB pointer value for fault page size
  * UltraSPARC IIi has fixed sizes (8k or 64k) for the page pointers
-- 
2.34.1


