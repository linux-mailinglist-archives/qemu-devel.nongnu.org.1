Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F374C704
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAb-0008MY-Ak; Sun, 09 Jul 2023 14:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAV-0008K1-LG
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAU-0000II-6E
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so42003415e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927397; x=1691519397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQ2Bxu/rilowTJXaihrKCWkhFlHMy8pQmQA827CvuAY=;
 b=G7JVMXGbVm27XstsdKY88WV2VaZmw1oClLJbvPs0pIT5I5VXUNVcRCeGkYnSEtJP4y
 624IzqfGLv1tZqrqwVjHnSRk0gM5FaivT8bL/V4CIO8bY74jz4geJeqvF9Zf7AFdvWpJ
 myOnzv26bbZJPIVYLqq79i3JD0Vr9ehuRWDRM7T3xEsUTYlE9Yh/+s4f83BqRkeG9VME
 ZtP9FsKf/paqyj4lJLn09CpXuUfmBnEwCL+KOwm5HvgI/naMYohxcY8ZwAiLsXa4j7xc
 Np8Y9JD+AyjbiUqe/BZRljW9mgNQuqUQ6GMZ85abnJi1hKmfy/sxHbNyAjLt2R9Witbt
 JQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927397; x=1691519397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQ2Bxu/rilowTJXaihrKCWkhFlHMy8pQmQA827CvuAY=;
 b=ehcRJ8BO7lJQ66IjlGMZZE14J+Wf+tpl/+JBci6F4l83xTZe2u/5psgFM6/Gc+bI3V
 vOWWYIrSrvq3Wau+t43SN/+UkYOOGAiDxCCsjzIEVGw2GsORmc1NV8Z1ftLjEtjR049v
 yIWwZJW9LUKHPbKPLwy8m4KmFwiduiwcEissacs9+zZy64tpX/3eIB8L+48cT0aQmcRf
 W8T0Ekymp/i7FJn70OqFdHSn96ylHPIx7+B6lYfTzpXzYx2+iuJiRi9R5UJ0YrpEM73X
 Qbh3J2tevkvYYDQTcjKOSPuo1TQvxb/sbgqJ7b4QSIZJfQfbsY/sT/49xEs1rw9km5BN
 PmHQ==
X-Gm-Message-State: ABy/qLYKP9f4AQ1+NGYywpJ/aVPUcOqISSKBU+TZNRP1384SVaPMpHIs
 E9TdGLf3Qk+i9Z5kyzp+tGkIR354K45TdoMfj4fMoA==
X-Google-Smtp-Source: APBJJlEFeqzaYXjM0zV7G6kWhLfNZE0Py74Yk82rEOCZ6f2hI2d+HXyvrUsO27C4dsLeItbw7SpeIw==
X-Received: by 2002:a05:600c:2143:b0:3fb:e58c:7758 with SMTP id
 v3-20020a05600c214300b003fbe58c7758mr9039174wml.3.1688927397007; 
 Sun, 09 Jul 2023 11:29:57 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/45] linux-user: Use abi_short not short in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:36 +0100
Message-Id: <20230709182934.309468-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


