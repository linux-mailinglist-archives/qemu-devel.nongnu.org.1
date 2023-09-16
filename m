Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A727A32B7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2z-0005Af-P1; Sat, 16 Sep 2023 17:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2w-00058o-1m
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2r-0000SS-2g
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso2359774b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900500; x=1695505300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QVLNJyN2G52bpcFup5Ax4sLOIg8vU0FXaShnSFcJ5A=;
 b=RP0Ao3mFU/fMl9Jvrg3UruhBM3LguDCUmSmf2O9jGZXbCrGFftNNMMLpkuWDYXaS7x
 aZ5yh9ccRByPZDtyn3NXIfcHrVkEOQitg2whNwww+3Kf4FmslHbfKHGWStvSBpZ0k072
 Khk8v2HLZUonH9FoqK/gf24ycixIUZxmIARxZiXgkl5LHldFIeFgBxpYXvw9spVEAK9e
 xFpFjazFkA96MJcLU3ePuTK+uDpCZVnkO2/CDSIACzLzePDxOz8/oi8wFjF+V6sKgV+S
 juFUMj2T3hc79FIgFEJlkPiYLoB8mD58/KKRPbMGMa/jU0oZzW3ySac/9BcZvsABTqfE
 Pe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900500; x=1695505300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QVLNJyN2G52bpcFup5Ax4sLOIg8vU0FXaShnSFcJ5A=;
 b=hC/N1hvv8as0cSpnw9FVp47iCfxpNT3aPnjQs6+BI4oulcg/YKDTir/BuBeYIh9s/0
 9JLvwgdDHpkVoXEMQgsyja4sFB7yzHrI0Vn3km+cWoX5mddWOTkrtSOa4imid607o4rY
 njZuVraCvF1lpiGvNqMnOmM0rEdzjtocz/O/wgZw6OQpqEPSeJQlIBbbqzyuapane2g4
 D2yfQ4U9pOqK8iiBDFcVMrHaMlk9y2fjfiJrpfd6cworEPU/JhHcfhktux1QaEowFN3u
 6sBlqXfuPo+C+NoBsnKrGTuwyaoOP9dRWNH0oKrCDsb0mJ3g1gWvh5xfIx1B7fzplzVg
 CWzg==
X-Gm-Message-State: AOJu0YyX+30U3t7SBo5tEeNsOunkJ2VsmNlv94HspO/jIzIKCCOXS9Ad
 lFRtu+dNNjsU6ZJRP86ElqzCpSBwlvr15quTWr4=
X-Google-Smtp-Source: AGHT+IGC04a1QgIU0shTTJpFrgKqm1nXBn3bvSugf5LNhGqnsBkTs+I4aFJxFfqd43VOQWbJS+2skQ==
X-Received: by 2002:a05:6a00:3014:b0:68f:cdb8:ae33 with SMTP id
 ay20-20020a056a00301400b0068fcdb8ae33mr12517557pfb.10.1694900499894; 
 Sat, 16 Sep 2023 14:41:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 14/39] accel/tcg: Remove env_neg()
Date: Sat, 16 Sep 2023 14:40:58 -0700
Message-Id: <20230916214123.525796-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Replace the single use within env_tlb() and remove.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 477e59b4b3..af9516654a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -451,17 +451,6 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
-/**
- * env_neg(env)
- * @env: The architecture environment
- *
- * Return the CPUNegativeOffsetState associated with the environment.
- */
-static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
-{
-    return &env_cpu(env)->neg;
-}
-
 /**
  * env_tlb(env)
  * @env: The architecture environment
@@ -470,7 +459,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
  */
 static inline CPUTLB *env_tlb(CPUArchState *env)
 {
-    return &env_neg(env)->tlb;
+    return &env_cpu(env)->neg.tlb;
 }
 
 #endif /* CPU_ALL_H */
-- 
2.34.1


