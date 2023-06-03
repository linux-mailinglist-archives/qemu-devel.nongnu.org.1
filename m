Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713417213A9
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfR-00074q-5v; Sat, 03 Jun 2023 18:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfO-00072u-A0
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:10 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfM-0004xk-2I
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:10 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-33b1da9a8acso16822605ab.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831047; x=1688423047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYqHT0su2ajyqUfCgbUvE6ShwnSvW7bpTufjv04Vqyk=;
 b=sMqfj5Gd5bItoC+HVUEvidJ/FAsxiOftYuKT0semFaziZ5qEvolFKLIQ0psnvFI2QA
 lULxxlR8cXYTn8jEUWcj6TrsdAkMeLUUFT5imbUgfZ12MNYMFgwnRwthhKjrFXtL57u1
 ZGnY8MuDiCYSVo7sXLHbh5QVpSbdOQbIyFs8PqdVgPFJ+xJ6+pyNrzrWbmrvYmob/LHP
 EghBDpViPrlkxbRxZAXwHOZFv2vOY0YoiKb3lQhLWrDWByiYlvDdagKH/BfsUdeU1YU2
 1FjxC3xG6iU61rMg4odfLYlIWxWQp4UbTxnT3BABdlU3wlq39GYe0nwQT+XdxKiOGTov
 oDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831047; x=1688423047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYqHT0su2ajyqUfCgbUvE6ShwnSvW7bpTufjv04Vqyk=;
 b=Uve9cFbpGgxfsvd0luaEjtcJwngaDcmo2DbAjqkfKYN4P5dOhVkwVGWu2/OrWkXVfC
 AFzqX6lMy5LuarvTa9HQwjrrHRmdV/dtsS06dTGpNmRyUQ0gEcYXeLZrto79sj6QHRm2
 p6Ss50aQah73ADEBZd6TKEEoGxYu/GSa8sZBXk23I9ahP3fmXJ4/ziw4YDiJvcKTg5cK
 8yNIK6BM7KXlQsfBXxRTNLJg79nHpaqvEOuw1NlCu2FWi/z49EqI/6wnSwln3uWHGGq4
 nyO9Pmfk185vjyzGeYkBcGrE0hbmVfcUOaco3KsWY1+zluDJqGF/M0StYsBrazsXUi14
 TyTA==
X-Gm-Message-State: AC+VfDx1udUzrfgEAuoIuXsYEhWZHKPCn1h3sXjTz79MeuBT1tis2J67
 G9AQ4bE34IUd4jUw+njre3uNfHyA3W9veBESVko=
X-Google-Smtp-Source: ACHHUZ51uso7HvcC4dwNMTgpKQZmvXpLQE0Yf1Nf5VQXPWtF5avZgUzFB9fYOPw8aS4XeoA01Dabbg==
X-Received: by 2002:a92:c708:0:b0:33b:abaf:d493 with SMTP id
 a8-20020a92c708000000b0033babafd493mr14883969ilp.16.1685831046873; 
 Sat, 03 Jun 2023 15:24:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 12/15] linux-user: Use abi_short not short in syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:52 -0700
Message-Id: <20230603222355.1379711-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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
 linux-user/syscall_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 21ca03b0f4..9dc41828cf 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -702,8 +702,8 @@ typedef struct target_siginfo {
 
 struct target_pollfd {
     abi_int fd;       /* file descriptor */
-    short events;     /* requested events */
-    short revents;    /* returned events */
+    abi_short events;     /* requested events */
+    abi_short revents;    /* returned events */
 };
 
 /* virtual terminal ioctls */
@@ -1480,7 +1480,7 @@ struct target_stat {
     abi_ushort      st_dev;
     abi_ulong       st_ino;
     abi_ushort      st_mode;
-    short           st_nlink;
+    abi_short       st_nlink;
     abi_ushort      st_uid;
     abi_ushort      st_gid;
     abi_ushort      st_rdev;
-- 
2.34.1


