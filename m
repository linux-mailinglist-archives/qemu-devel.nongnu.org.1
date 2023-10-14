Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231E7C9294
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVWS-0004n5-SF; Fri, 13 Oct 2023 23:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWM-0004aC-Gb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:40:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWK-000512-T3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:40:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so796941b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254855; x=1697859655;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0FE0ZMA+9znH6XCbDgXSH/AnzIDJlT/zVV7CkMNJtw=;
 b=SQyGD5XPG3O+WYT7D/CEFd9Cx123G3kp/9yTBo8QxPmt3QCfRPE6TJLaq/nwtf79T3
 QjvsJS7nmeUBuUlq40RkK3pPrucHWaPFauI9x6Rh9ooX7N6oAaGeAt9qRWXdWK3u+VQl
 p+OWWZCLOS9z0bvSt4/dKppYY5teB3kccFlHvu0zV3BZbbv4ib0dAl5TSYSIE1CiN+zC
 7B3zR8DDo3sQG7+aterfPdIXSeSg/MVMnxO5Y4MNeqNWsrWfjF/klefjNzcPZGP16Z9Q
 1YjXxfdpyOcCn6Okn4r6V9H6GG1E+6smRIJvvUg5/5TiVyrtuKlcJU7d2EDuIFBKD8xS
 dhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254855; x=1697859655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0FE0ZMA+9znH6XCbDgXSH/AnzIDJlT/zVV7CkMNJtw=;
 b=PV8EkxAjFRyrLpxDU7CY+ghXCNAZ8VhGYP2j9M8dk/qJS3U8LmhyNWG/NQrZNE+G+c
 rOymjcesimOCWHAqUg62yTCyGdViA8FFerva3z43bbO/acXNATB89bIpz6An0LY+LbgB
 6qSTkjUmbpl0BbNayL745tHMKwjrtw38L32vSQp5h1O7ZVdpWSP5OTEVqRq+qV8l6uwq
 xWl/cfksrFFZhxaXf0qBEMWmStWJfYcKL8rkf4rvrITkNJwo/m0/aTff3/ZjWGbJhVD6
 M3SdloamkVkRBfkhzqJThCIo9b6jKP7X4BvmUJGvcIFtSkeuUKxim0bj6xbEYSYuf8S9
 qbKw==
X-Gm-Message-State: AOJu0Yx6I564fODlhYDn6ZZCbkcQ5ZMdnPC92aEW4PNSkRGKelC1ZqEq
 lrhJh4+2+nAzDkrU0nG3fCZRMYIVAFzaAjbOFV1OFQ==
X-Google-Smtp-Source: AGHT+IHYNPzh1baQbGolaNeudq99JER/kxnVI5tZEM89Sj16ZkvY87mqjbPF5A6OBfXm/Yen3/hOWA==
X-Received: by 2002:a05:6a21:788b:b0:171:4921:f1b7 with SMTP id
 bf11-20020a056a21788b00b001714921f1b7mr14756708pzc.41.1697254855643; 
 Fri, 13 Oct 2023 20:40:55 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 h21-20020a170902f7d500b001b53c8659fesm4603662plw.30.2023.10.13.20.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:40:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v12 14/18] gdbstub: Expose functions to read registers
Date: Sat, 14 Oct 2023 12:39:33 +0900
Message-ID: <20231014033940.15679-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

gdb_find_feature() and gdb_find_feature_register() find registers.
gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  5 +++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 229fa382bc..b85f700c5f 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -71,6 +71,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f8c7f427d7..d216353b9f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -484,7 +484,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.42.0


