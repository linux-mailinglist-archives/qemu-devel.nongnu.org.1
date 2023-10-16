Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D677CB013
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQgM-0004FW-Uc; Mon, 16 Oct 2023 12:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsQgC-0004DS-SN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:42:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsQg3-0004Le-Bn
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:42:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso3919784f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697474564; x=1698079364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BKmqz6rtUUntrbdALxrGCYPIOal8cYf8H9FLm0YLPvo=;
 b=n0kfKWyEpFtXHWSYecMQQ3AqvD15eeqCrbGOZYdrXiu2o4D2G00hM3eAelox7dyaeS
 g7Ai+bLKOIJLVRq8GF3iTUqK8LvoM0KlnV85wIyBX9nxYFKXbmBdCFC15HM9jrIrGw7c
 pMdRIL9wVNNCi3Q18qRRwFwJpCN4/qkKziCP4+NuZfRnqMKq+Le67iYi/2KYyLNNqQ1z
 1j904s2vjz2KJ71JyTNYuEk+cW0K2/wnhp6U3xFXz+3Gbded8dBbMla21jqKQms515Gq
 iuKkP0+Lf47+Lz2ujFWbcEaerYP1FyHCsgLvJ7sX0Ky6bDoZCyJPmV1Y29xuXWmRsW4z
 zaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474564; x=1698079364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKmqz6rtUUntrbdALxrGCYPIOal8cYf8H9FLm0YLPvo=;
 b=Rd+vuA9u/9AfceO9slcFzTy4ZkyI7T2A4ALxQAC+JGcZRQ3FQftSF3SL3q3d67bSXN
 yJ7ief53xaJULKI9PQ+AKftJweF3bSn5MfloA4i3Bop+BeV8FWU+sGyR0dVp/gMvXIdS
 Y8nLy5SQblyQ4TYdHb5115/txR+G1hGgGhhSLZlmUnbR5bGvwtXoCKxq9Ar9JnewyCK9
 uzfmB6MgMzBG4/FSKP8XeuHCeRXhj7hEgkWGx9+wvuAoqEtjileO1HkHMQClUzdJQxeu
 0udPJmF+9MWwahhjvJOPB+pOaxYgCZ51H23rVp/o7/+oN4OyLhlUL8tnLv6ijjWR4+Fx
 Cb2g==
X-Gm-Message-State: AOJu0Yxclyj+TW5+MEu/QfWkdHyKuBgAl7au4dBhmAltJQCMKHqTF5JS
 J62TMG9g38dZC/w+eHQjDgjd498cABx3n0b8a+E=
X-Google-Smtp-Source: AGHT+IEo0DtvUJqs3/4+n116xzkgJDY6lCVjbA6n7X47CMTSQxTqHtcV1/RJOWjmPgZ1P9zTXtDD3Q==
X-Received: by 2002:a05:6000:b84:b0:32d:a49c:dfd1 with SMTP id
 dl4-20020a0560000b8400b0032da49cdfd1mr5832352wrb.48.1697474564643; 
 Mon, 16 Oct 2023 09:42:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u12-20020adff88c000000b0032d9a1f2ec3sm8728159wrp.27.2023.10.16.09.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 09:42:44 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C65981FFBB;
 Mon, 16 Oct 2023 17:42:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [RFC PATCH] hmp: implement hmp_ram_memory_dump
Date: Mon, 16 Oct 2023 17:42:35 +0100
Message-Id: <20231016164235.2179049-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

While reviewing the tb-stats series I was confused by the different
between physical and ram address. This implements the RAM dump so I
can replicate the disassembly of "info tb". Whether or not that is a
good idea remains to be discussed.

Based-on: 20231003183058.1639121-1-richard.henderson@linaro.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp-target.h |  1 +
 monitor/hmp-cmds-target.c    | 10 ++++++++++
 hmp-commands.hx              | 19 ++++++++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 730507bd65..a3fa7dc089 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -50,6 +50,7 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict);
 void hmp_info_via(Monitor *mon, const QDict *qdict);
 void hmp_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_ram_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_registers(Monitor *mon, const QDict *qdict);
 void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 476cf68e81..21ce790502 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -253,6 +253,16 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, MON_DISAS_GPA);
 }
 
+void hmp_ram_memory_dump(Monitor *mon, const QDict *qdict)
+{
+    int count = qdict_get_int(qdict, "count");
+    int format = qdict_get_int(qdict, "format");
+    int size = qdict_get_int(qdict, "size");
+    hwaddr addr = qdict_get_int(qdict, "addr");
+
+    memory_dump(mon, count, format, size, addr, MON_DISAS_GRA);
+}
+
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
 {
     Int128 gpa_region_size;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index e1d78ab69d..5a9ecefdcb 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -471,7 +471,10 @@ ERST
 
 SRST
 ``x/``\ *fmt* *addr*
-  Virtual memory dump starting at *addr*.
+  Virtual memory dump starting at *addr*. See xp/ for physical memory and xr/ for ram
+
+  *fmt* is a format which tells the command how to format the
+  data. Its syntax is: ``/{count}{format}{size}``
 ERST
 
     {
@@ -530,7 +533,21 @@ SRST
     0x000b8090: 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720 0x0720
 
 ERST
+    {
+        .name       = "xr",
+        .args_type  = "fmt:/,addr:l",
+        .params     = "/fmt addr",
+        .help       = "ram memory dump starting at 'addr'",
+        .cmd        = hmp_ram_memory_dump,
+    },
+
+SRST
+``xr /``\ *fmt* *addr*
+  RAM memory dump starting at *addr*. See xp/ for physical and x/ for virtual memory
 
+  *fmt* is a format which tells the command how to format the
+  data. Its syntax is: ``/{count}{format}{size}``
+ERST
     {
         .name       = "gpa2hva",
         .args_type  = "addr:l",
-- 
2.39.2


