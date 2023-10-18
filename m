Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D727CEAF1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:05:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESj-0001nA-Gk; Wed, 18 Oct 2023 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESF-000171-Qu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:52 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESE-0004P1-AX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:51 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6cd0964a994so634634a34.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665909; x=1698270709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuwEn/6tALxgxX8K5Z/25NI6Kvm0qV/PZyiXdtk4l3g=;
 b=cS4i09oyx+YNPo+afAne13vVJfcog+vH08H05bAPOhfcRFFY7LU66CDv1GrNe6oTe2
 eUQuC6m6PXCUV8OfKTGmEREklFCLe+jvlQrOCUDx3s4IOcAAj2lkRenJ+AunZc30ZwbD
 5iaRCnvJ7ZX/SiNAEt3cCLY5+1y0r2QkxefunOD0wNB8pBh5rVfCZGKtIbdHXPbcuWZ1
 5/ACpGyM6hiuV9nIDFG5lUjWdso1gBakKG0Mifqp7bS0jgBZ5uthqGC5yTJQBI7DQrXd
 jSRlBA+gB2c4u96J3//jVWEBQIYHyZeuliyaO9uyDViEF4MhLeeaDCP/GdH6fdCG+/cr
 0OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665909; x=1698270709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuwEn/6tALxgxX8K5Z/25NI6Kvm0qV/PZyiXdtk4l3g=;
 b=W6WzgdAh0pY9qNORNPyEuAUQ48wpdfVvmIdwMK3oeTy2/kcDS5+2c4irccHjyexeb+
 ga/oQV2AF+1R6XqdgcPhPpFZg25WAj+7zTeSWHh9/i5QGnkfgK4vwqXztItYZXrR2S1/
 d+YhW3aP50mOpJikhuCUvu5tj4TVpNqNtr5V6iYJyaVvrGOjtvQqsg1eaDf/Ed/+aSyh
 93ij8UQoyy7DDI2zmBapBgBBksply/lY4U4jX8kx4UENxt5kLm+cLsj4kM7KZ1yeyGJo
 Kksnaw7BMOqDj/txcCuHiSpbwq63dOqzCUd33iZddOKOvq/ZCvTSTOokMWK7BB+RKthb
 B2zA==
X-Gm-Message-State: AOJu0Yz6XWNcSN5dWgrwpiEEE8w+vDCrvzUWBZkj1ahUf8X9USweb2hF
 goLNvn/yf+TYJdFFuvivtz+nS28ZwlcCLHzM47Q=
X-Google-Smtp-Source: AGHT+IHYHnK3atizDl6phSRbdyOQL15QChj5TNvOEetpYj1HN9Z95r5Vpa3tS4B3vehxwT8p6suAwg==
X-Received: by 2002:a05:6830:3493:b0:6b9:bd9d:e333 with SMTP id
 c19-20020a056830349300b006b9bd9de333mr831791otu.3.1697665909039; 
 Wed, 18 Oct 2023 14:51:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 15/61] target/hppa: Implement hppa_cpu_class_by_name
Date: Wed, 18 Oct 2023 14:50:49 -0700
Message-Id: <20231018215135.1561375-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
index 82b4e9535e..9bb865ae92 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -9,6 +9,6 @@
 #define HPPA_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    return "any";
+    return TYPE_HPPA_CPU;
 }
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1975aa9621..6bf415139f 100644
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


