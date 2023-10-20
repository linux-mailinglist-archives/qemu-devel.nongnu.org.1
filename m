Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F9E7D1751
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLw-0007uq-Sn; Fri, 20 Oct 2023 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLY-0007jd-2Y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:59 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLU-0008Ao-VV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5aaebfac4b0so854638a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834627; x=1698439427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ctFFMD0i4UBxb8cY/h6EWp2LE3DVdzDCEH3soxezJg=;
 b=A0sRakxqQFl7yfixQ3EG/Fvq2FLgA+y/9L/W5+WgGO2kuoDq+wFeASq0ZitjQbU5Qc
 C9SBJhlL2WHZWidS252JcdmJI91EKbT3f5cVkOJFpKS+2fal02nKjKo51/+xd2CkT4hA
 /s/lCiuM2qRGHEhusLCWvbtNLJPVsDGSPZ5QMuqDki4zO95IEwd5wssUlh0vdtG8H3+v
 kF01kYabU7kRY3NSd98o2H4e+GumQwSMdizEhlZMhFO9dM9brK9FgzBZrGAvW7ApzRIt
 sslVqLF96sZjSA1PqMTvpQVXXgDFutCkESHMoxmVD2XiN3tT9wC7OnnW4XaWXvDGQQox
 8Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834627; x=1698439427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ctFFMD0i4UBxb8cY/h6EWp2LE3DVdzDCEH3soxezJg=;
 b=cK7ILpzwE/nt6FF7Pu+5n8TNxOdAA7xjhyX3HlXvKfsrANEowIYL0qDglouUh5eayi
 3Az0ayHE5rml3AscU6k9ZpJuUkoZKh/Ofszxak0pUviYdspJzOEneeKhvPkEmfSADFY4
 PqylSN7/K+a2oym9wIaCBrG7ICBV+PvUznQ9nvbSAzmlk3DsEMrMU4C0I6aPB+oy/O7T
 s7YpfPD50H/O1jC6sjyvVphDPfeyOi6LPDZbwBhbDZFXZJwplrs37IfPYgIZOVxBaBQk
 7Z30zaKZ2/RKgeBUu0X+V5Hha5ZJgoNaZ8RxPNVW7a5i1noVRCIfymyAD9Ot7fS7PXsk
 Paow==
X-Gm-Message-State: AOJu0YzFeU2LfQ997MLiC3+OSSUVVPwaPsXs+O9n1C3RT03xnKuQOsj8
 7pMvz5wM8J40xBtczmEtN/86UzjHATKiiucpUK4=
X-Google-Smtp-Source: AGHT+IFHyipZ4X2WN7N0VFetkI44OgEjlwbo2ehhgibGLJTBkuSA6MKefQWSQFNH9+0mp2rpyEiOng==
X-Received: by 2002:a05:6a21:3282:b0:17b:689e:c757 with SMTP id
 yt2-20020a056a21328200b0017b689ec757mr3344562pzb.11.1697834627673; 
 Fri, 20 Oct 2023 13:43:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 16/65] target/hppa: Implement hppa_cpu_class_by_name
Date: Fri, 20 Oct 2023 13:42:42 -0700
Message-Id: <20231020204331.139847-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
index b063255b30..81d51e98b6 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -159,7 +159,15 @@ static void hppa_cpu_initfn(Object *obj)
 
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


