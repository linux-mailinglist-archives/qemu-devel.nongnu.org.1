Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D27E3423
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:18:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPV-0001RL-8a; Mon, 06 Nov 2023 22:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COX-00077v-N0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COH-0000g1-Gi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:49 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc2fc281cdso39189625ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326263; x=1699931063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Exykv+xKuErtsZmUvO9DLpku6Bz9Jw3PAqZ735n9fU=;
 b=qSK2bibzWN9C/aZRNXU4PbuMO1iLdS6pOdeePzlXHJbXqxARKJMafbZxQTE+9nxO5y
 enAy77mI/h0olqaIlGCaoNkEhvvAsbuWo0I7644oWHxIZ+PPv+20TsCuJZpO+LEWGi5A
 dY/JYdnHFHvM+JSNrRsvcZGYPkLe2WVpAv11jjcBkVg6ZW3nwHsrsNgACNNPN4HKGNSB
 DmDVtVZxy7ICCFJYJtz7omDokJQOi4Kk/0IKlfZ4xlkxVjmJRdpSXKMhCeB+wgIfBYv1
 gQ9y8tITdZUd9HFp0lBfhK8W+rx8lhkTUKAZAAT1bLumGTo6bKA/ZfZwYuAHiZEfopk3
 8H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326263; x=1699931063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Exykv+xKuErtsZmUvO9DLpku6Bz9Jw3PAqZ735n9fU=;
 b=gfiNWW47XTxhWkicTNhLcDEvYg++TsV5G8DlNqRASaoRegosdJO9NKpcZljxtn9v4g
 eCdIFCHvqjkG9BKBFFribElNbzdwhgKBDsego8WfbSRDqEp4+VcqaW4PN72E6aMgi+oQ
 ilVDk8c0SBBbuC88ViixudE42DY18xQtiTSFcHO/mz4zfLDw0wZPHj3QzyanV4dYppXs
 rN+Co+x4kbWg6kGCey4Xe5InLQjA8gvlVZ3albVI3wzsOeF4YTNOcqz0RwyBiUdVaZ8P
 e0jZ2B3sMpWdVRXf6ASoOUndonHljz6ZqQ5tcg8KjdYAMNM1jVvIefIeGGe5cMTXU4DL
 qyJw==
X-Gm-Message-State: AOJu0YwOdPlMNIEGEkVGEx+fVh9pDw5RA8P73ys39kfj/7FnEV/nGHV0
 jp/IgqsItX/j4shvxa2RTRYMT2kw1D9/XtbC/FY=
X-Google-Smtp-Source: AGHT+IFicu3IUU7aShvsT2kgoJdysnTMuRDSrCcoAUpNSqzgczWP8QoYoi5Rn+VravryBostfumJVA==
X-Received: by 2002:a17:903:124e:b0:1cc:ae19:6220 with SMTP id
 u14-20020a170903124e00b001ccae196220mr7651557plh.27.1699326263598; 
 Mon, 06 Nov 2023 19:04:23 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/85] target/hppa: Implement hppa_cpu_class_by_name
Date: Mon,  6 Nov 2023 19:03:02 -0800
Message-Id: <20231107030407.8979-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h |  2 +-
 target/hppa/cpu.c            | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index 82b4e9535e..19cae8bd65 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -9,6 +9,6 @@
 #define HPPA_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "any";
+    return "hppa";
 }
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 27c74f0d27..70ce0c3b99 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -158,7 +158,15 @@ static void hppa_cpu_initfn(Object *obj)
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
-    return object_class_by_name(TYPE_HPPA_CPU);
+    g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
+    ObjectClass *oc = object_class_by_name(typename);
+
+    if (oc &&
+        !object_class_is_abstract(oc) &&
+        object_class_dynamic_cast(oc, TYPE_HPPA_CPU)) {
+        return oc;
+    }
+    return NULL;
 }
 
 static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
-- 
2.34.1


