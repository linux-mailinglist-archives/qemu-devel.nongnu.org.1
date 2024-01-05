Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E482571F
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:51:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmMr-0005Q5-Kp; Fri, 05 Jan 2024 10:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMp-0005G9-8W
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmMm-0003F6-5o
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:44:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so17368705e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469450; x=1705074250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTyqf1UOhmXWKWjB2kbjbecKyF9tbZD+k3iPAVC8zqk=;
 b=HHmzfCbyDxgSNouK5PFaSTbIUfIyKA5KYDHdhQCM/v59CT/QVijLLoxM9MzIIlI8lk
 bzYTlobLBFs4KVVjenCvEkCw5I5Wy45FprpKkVv8wGc9PflKoqwb0nMU4etKQNytio+L
 pDHcbO3/fXusXREE50o/AH/HCe/n0Ict/ytBu2Y79mxe9HuDmruDJ9OKViQfxCFoaESR
 0r7nsi8wFWRf5zhZMs2TuhZGNijGgN7zjRbdEroqN9KabFo57RNTrmXvdHp3gj9TWXKK
 eWa4SLmc/aJV2Gupw+FYDx0sP14G0nJUBlc+DCE2K3wFg6kM9Upv84+hA3lzkq8TjO8O
 Azkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469450; x=1705074250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTyqf1UOhmXWKWjB2kbjbecKyF9tbZD+k3iPAVC8zqk=;
 b=F8V+YWM7ebVHu0/zG9GMpXeuQibFz1TJxpniONSOa2HkgenoWlP7Ckc79EOJ72S7Dk
 G7zFpS+sfZNNvGt8bNbEf14aFlryWACsDAtmr23NskeZcLXSecmNK1WV1C00HYF7DLTD
 F607kf8Zn4CJ44WwiFRly8Xey7+T0Oe0fkkgokwxkm72CXl0AlbUQLpW3BgqkyR4ejF9
 3TdaV5+Atyr1uwHp6qm21M7zxtFk3G3UpX3rtU7+ZTKOK5btftbyvIc1wA8BByx9rSs5
 4LaREvUc6PP6niGaOsfSonx1E6fQSEqkgaiKKU3kHdFTrwy5iIatkw5S+dUMuD8vnbqw
 gByg==
X-Gm-Message-State: AOJu0Yz5ESHqHZdF4h2cFbQQbdZ6pndC7+v3buXrO3U8xRqsxU9y50dV
 c0WvV2CrB7ZCFykhDxKZlagiPgrto2MHmcpslmwoxUh5FAU=
X-Google-Smtp-Source: AGHT+IHA7oirNe2wIME7aj02ZELRt5Of3egWjhyWldJb1kuaKpK+en2JVra3k52zDOPgZEmv/BRvqw==
X-Received: by 2002:a05:600c:5487:b0:40d:6e2f:da7b with SMTP id
 iv7-20020a05600c548700b0040d6e2fda7bmr1311698wmb.13.1704469450494; 
 Fri, 05 Jan 2024 07:44:10 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 d3-20020a05600c34c300b0040c3953cda5sm1950432wmq.45.2024.01.05.07.44.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:44:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [PULL 11/71] target/hexagon: Use generic cpu_list()
Date: Fri,  5 Jan 2024 16:42:04 +0100
Message-ID: <20240105154307.21385-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

No changes in the output from the following command.

[gshan@gshan q]$ ./build/qemu-hexagon -cpu ?
Available CPUs:
  v67
  v68
  v69
  v71
  v73

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114235628.534334-12-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.h |  3 ---
 target/hexagon/cpu.c | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7d16083c6a..5c11ae3445 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -37,9 +37,6 @@
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 
-void hexagon_cpu_list(void);
-#define cpu_list hexagon_cpu_list
-
 #define MMU_USER_IDX 0
 
 typedef struct {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index aa48f5fe89..c0cd739e15 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -32,26 +32,6 @@ static void hexagon_v69_cpu_init(Object *obj) { }
 static void hexagon_v71_cpu_init(Object *obj) { }
 static void hexagon_v73_cpu_init(Object *obj) { }
 
-static void hexagon_cpu_list_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    char *name = g_strdup(object_class_get_name(oc));
-    if (g_str_has_suffix(name, HEXAGON_CPU_TYPE_SUFFIX)) {
-        name[strlen(name) - strlen(HEXAGON_CPU_TYPE_SUFFIX)] = '\0';
-    }
-    qemu_printf("  %s\n", name);
-    g_free(name);
-}
-
-void hexagon_cpu_list(void)
-{
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_HEXAGON_CPU, false);
-    qemu_printf("Available CPUs:\n");
-    g_slist_foreach(list, hexagon_cpu_list_entry, NULL);
-    g_slist_free(list);
-}
-
 static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-- 
2.41.0


