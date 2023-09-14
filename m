Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0579F864
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLY-0000cS-Fl; Wed, 13 Sep 2023 22:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLW-0000bk-6e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:46 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLU-0000g2-M0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf7a6509deso3459415ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659483; x=1695264283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oj3ja2p6t6YlQeSetVdrsmS/5dm/IsdRtlVuWzZbHeY=;
 b=d0bX9k0XIxK/QlC0N7O/j4/iE0sxt9zgYZ5R3aRJn5qs4O9kX1v/9DH5fGYCitNEwJ
 /nCJPLeO4rmd8GRASHv3VCQ7EQSI1boFKZeG7HV2SuHYSrBqIzOlg8TES9jYflaRK7H5
 O3MUWFMIDo1m/OJQlLp5tHBiD0RU/DdHr3yc9y3e0PHHdzZcYDzAdsNZhEbjGWUivsDR
 M4BockDdKlynVH7l+eAGOfdJXA6/hRwxj5F15H6yl1QEuK6IxHh0aD9MQoNWeNAxNj4H
 EblRoGcQVJxz4fFyG+W5Mql4EytmGaVnxtyqR31J6dfNIRrrMs2Ma5BaNS89Y+U3zD9y
 k6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659483; x=1695264283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oj3ja2p6t6YlQeSetVdrsmS/5dm/IsdRtlVuWzZbHeY=;
 b=bYYHvJ1DvMRqi37buek1DP/o7guXn+5F21s4RA6aG49+SxEabSpCN0Oxbap4bLGrSq
 nXRaZUK+yjyc8dSdXXBrfGoorEVkcgYwPRWR3tmo4VWf44Uww5y/MmzOaTYeA6I96BRv
 806jZno9+Ip8svK7G5TTUpkyK532qK7rluwr3pCRNRUyGVR0tEGgqcCk1pZHA02OxtiT
 GTbVRFf2JXRXeyyO3989BSsTWS7uiOzFldVIDAQGkGg7Sj0NO657qxudr+sOOZF8zMn0
 RjQAsRXn5Y3yPXnft0eIZxIXIxFQBUhuEOWZKzdxLOids9acgln3rQA1aST1z6u5GjQE
 4yEg==
X-Gm-Message-State: AOJu0YyGq+hkyEtMN9kmLnWvs0qMo34/A2fiZlvr3cVXrJuFb1sBbtKV
 h219kyy1X64cabPsmjT6QqfR2evF39GorNsI+cA=
X-Google-Smtp-Source: AGHT+IFdf5nJ6e2QZY5WdStezX68DQzVUdBmOIqn6IGHbEsMhbXUzchccqD28xC6dQ7YmqrO9MtqIA==
X-Received: by 2002:a17:903:496:b0:1bf:39d8:48f3 with SMTP id
 jj22-20020a170903049600b001bf39d848f3mr4222439plb.16.1694659483229; 
 Wed, 13 Sep 2023 19:44:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 07/24] accel/tcg: Validate placement of
 CPUNegativeOffsetState
Date: Wed, 13 Sep 2023 19:44:18 -0700
Message-Id: <20230914024435.1381329-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Verify that the distance between CPUNegativeOffsetState and
CPUArchState is no greater than any alignment requirements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c2c62160c6..86a7452b0d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -459,6 +459,12 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return &env_archcpu(env)->parent_obj;
 }
 
+/*
+ * Validate placement of CPUNegativeOffsetState.
+ */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
+                  sizeof(CPUNegativeOffsetState) + __alignof(CPUArchState));
+
 /**
  * env_neg(env)
  * @env: The architecture environment
-- 
2.34.1


