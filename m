Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B3D7A32C3
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2s-00057Y-R6; Sat, 16 Sep 2023 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2j-00054W-Bd
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:34 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2h-0000Qe-ST
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:33 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57656330b80so2100126eaf.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900491; x=1695505291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKFrEK1ybHE5W37yArUxMsWARo+/L2b8HkANYXonYTk=;
 b=iKtLI0pJWOnJhaEyUwWew9kRhbxPWO6N4W9PaXIa4E7d8j/ZwDKI0qTMCsiiotnzKy
 UqoW5shN4oFAeEkzpAiyq5Yb8Y41HBKS6QAY5u4zWz1HpVdVFGr26vrKDc+YMcYCqsH1
 28bY8NfgGV6vb5OLjPsRgwXu9biqOKzxiMukB3jxOe4T00Fh7vcBqf2npiQzFmfg7SuC
 2PTRFzZ/W7P4rpozW/XwBnu3pRJXmx9F3D8/gyC+IcsNeCF1eyeRcepfxiYtMH8YJsjp
 u5j00Kdi9iK/WQZ1pfq0uwWQJ7MEmFhmXqhsVUyEoxrgX4SS8kuM1pt3+9PwfCbXDUEr
 /FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900491; x=1695505291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKFrEK1ybHE5W37yArUxMsWARo+/L2b8HkANYXonYTk=;
 b=Yp1CNEFYopIaui+y7IlOBaHruBtKcDaBmCRoNvFoFeL3WX2jLWeE3lUaIQowvdnSej
 apoA4dKNlyhb1n3IVsH9kTBPxGaessgP6B6+cLiLQFejn3djsgEYT5ZoCTvO0lzGJov4
 jRonKP4dBt6Hh9yxo4fQxyLJITc+lzK9jWUuS7TLa3V6+e6m2FMkhWQKqiCeZlW+INmL
 FhSLt+f5dXPK4Kst5KK2czfk4eyglRr4MCnZNejiR35TgWXxneCLamDXBIxsotO78tom
 ekGabcOc6bVu8u8LVBCEvghJChP8f4l8aObeO/XIFqdd+LJzDbZ9k0UeIeyoNqvZyG+m
 peAQ==
X-Gm-Message-State: AOJu0YzJ6fTMlXX5wbFXHT7UOkZIC4flD9qx3RTwBSHbYB5hFdh80g9P
 rwYbmYB8t5Db61+nYcTJ6UaSZgc5mg7HHbUnzxM=
X-Google-Smtp-Source: AGHT+IFLJ2XtP4OcpAUGcc5Pvgl8XSML/oDCb7v+SRb59UwOjW2g0bOfAwFNJRp3G87m4M2ccNT77Q==
X-Received: by 2002:a05:6870:462a:b0:1c8:c128:c38e with SMTP id
 z42-20020a056870462a00b001c8c128c38emr5936710oao.15.1694900490847; 
 Sat, 16 Sep 2023 14:41:30 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 06/39] accel/tcg: Validate placement of
 CPUNegativeOffsetState
Date: Sat, 16 Sep 2023 14:40:50 -0700
Message-Id: <20230916214123.525796-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
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


