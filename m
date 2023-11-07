Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B87E4A20
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0T01-0006e6-8e; Tue, 07 Nov 2023 15:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szv-0006bc-Jz; Tue, 07 Nov 2023 15:48:31 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Szu-0006TU-1F; Tue, 07 Nov 2023 15:48:31 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d319933f9fso3683696a34.2; 
 Tue, 07 Nov 2023 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699390108; x=1699994908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LA7zqqCSSp/grUHtdG2jb7l1ICp+1C84x01i7sVE+a0=;
 b=Wo5rSW/ddjN1ifNId2+1qheqjXefuG/ZPpW7a7+o3NcPuRZjpv8YxthANSQdhX/6X+
 NfSGVK9UjZaRJweYnYz/2kUNaGvkcDBauQ+IPcCV2feONgV9+SqkWejrS7cKGToTS2lG
 HGV01kWtdEQyMSYn4VYtS81zvPZrXNDcOod9S8+aLXUUWt2qYnMLSKimhc0qUvgp8Ho/
 AtPXXFFLGrZTInzFHhsEHGA/w5Re9l654WPvXf2j6JDuMuF/4ouVxhINL5hFoQOZFarH
 M/hgVBJlWQImhlGJ4qFTEjT5Tj+TV5hNsEfOJbAUhBpIDK4qAnFP5ulFWrqHS5pJ9eca
 C2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699390108; x=1699994908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LA7zqqCSSp/grUHtdG2jb7l1ICp+1C84x01i7sVE+a0=;
 b=XOFxcWGWxw7n1HnMcDyhl2WdQr6KhXGtuf8YjExjLG/DGib5CDnAfITK2GFFamS0zA
 vMKoPVU8CpAeQnkEm7AR8iX65kf7GePjVh4Cfzyexzp7U+U4DAu8FJaTv9ke4TOy+VBl
 +U30xtiRZxYcH/QDrB2Ig04jCPZXFfCnBwfk9jObfF5yFwZ4nI491bmABPTZ+/B8CUFL
 blSC0kQ7eMtZJ2zcwq220OYp8USkfKf7XtlPg4AxuEQ2U0fZatckA88NGr+cpMkr6sI/
 +ERAbYSAz7B9IPQo0ka+pjTHbToZdR1nU2ztwsWK/1LL08DGvJgQvMYh91fiAZzqTL6h
 A+8A==
X-Gm-Message-State: AOJu0YwIfwg1dDz6lsH/ZVKRMb0v98F+h53myITtcqSQQVtuIjcteh7Q
 lEKg1/lvyJtfcT8XDw3rXkdUbEf5wYc=
X-Google-Smtp-Source: AGHT+IG+CvdxMTskSJxyhanBitmIuacx1pFEBr2eJbkurkn1nJGoZGysvFi3mH3xKkJrfp0nqcScgg==
X-Received: by 2002:a05:6830:4492:b0:6cc:d4f7:e37d with SMTP id
 r18-20020a056830449200b006ccd4f7e37dmr705688otv.5.1699390108532; 
 Tue, 07 Nov 2023 12:48:28 -0800 (PST)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b0041eb13a8195sm48946qtq.61.2023.11.07.12.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:48:28 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 9/9] ppc: qtest already exports qtest_rtas_call()
Date: Tue,  7 Nov 2023 17:48:06 -0300
Message-ID: <20231107204806.8507-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107204806.8507-1-danielhb413@gmail.com>
References: <20231107204806.8507-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Juan Quintela <quintela@redhat.com>

Having two functions with the same name is a bad idea.  As spapr only
uses the function locally, made it static.

When you compile with clang, you get this compilation error:

/usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in function `qtest_rtas_call':
/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1195: multiple definition of `qtest_rtas_call'; libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536: first defined here
clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.
make: *** [Makefile:162: run-ninja] Error 1

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20231030163834.4638-1-quintela@redhat.com>
[dhb: remove 'spapr_rtas.h' include from spapr_rtas.c]
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_rtas.c         |  5 ++---
 include/hw/ppc/spapr_rtas.h | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)
 delete mode 100644 include/hw/ppc/spapr_rtas.h

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 26c384b261..f329693c55 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -38,7 +38,6 @@
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
-#include "hw/ppc/spapr_rtas.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
 
@@ -531,8 +530,8 @@ target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_PARAMETER;
 }
 
-uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t rets)
+static uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
+                                uint32_t nret, uint64_t rets)
 {
     int token;
 
diff --git a/include/hw/ppc/spapr_rtas.h b/include/hw/ppc/spapr_rtas.h
deleted file mode 100644
index 383611f10f..0000000000
--- a/include/hw/ppc/spapr_rtas.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef HW_SPAPR_RTAS_H
-#define HW_SPAPR_RTAS_H
-/*
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, uint64_t args,
-                         uint32_t nret, uint64_t rets);
-#endif /* HW_SPAPR_RTAS_H */
-- 
2.41.0


