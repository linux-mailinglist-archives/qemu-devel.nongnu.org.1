Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988BD7DC1D1
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:22:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZe5-00015c-PI; Mon, 30 Oct 2023 17:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdj-0000z2-MY
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZde-0006Tn-5L
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc2f17ab26so18676805ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700651; x=1699305451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLZnYG6gB4JjRwsSZMPasIhTWijR/jDuID0FZ6WSuAE=;
 b=njytOOws06NJGKXzL2npjNOWR5Md0KE+QBFC/Mfgegqr1eFWZGMuIxlbLHm0odGWMv
 N2pKduU39uiWKq1DFu2qKyrkHQRGmEsHbDurW5988U8FaHMubW6ZWxQT1FSPL7AUMo+F
 Zduqq1mvFzi6O9Lh5QnsWDY2fJ45LcfCDZaLijkSr7sBtt3faI3vhAPwYJbnv07WUa8d
 FrKQA+XZezTLzcnU2I76bbD9Um2yOAQHxotF0AOgljLL6BbE1HTtB46r/xwrn892YH1T
 ZvE3j2r3SW5ieuQGyW510GkDudnOng0EPAWwHUMP4xj/ZdZys85oF1Q4Evui/jeJ2kE/
 TlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700651; x=1699305451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLZnYG6gB4JjRwsSZMPasIhTWijR/jDuID0FZ6WSuAE=;
 b=CuLovq88fxdc29adpSTdF+oT7HOF14PVpg7Y2cmdXczrW8aGvkWj22NecogA027rTF
 DrRD6l3r82i98PxNmjcHaEPyTmodLDvk9jAJLCDJvzSZRh2M7Hd3zXvbN0VlsHGq9opH
 CU0XgTF5+cpsRmvaGRf3mG9flt2M9hnPSnPnOxLjls6MPZCpLPomL2h4tUJ8qIDqv0S9
 yRA1BrcE8oEd8JA2NrVp67ys2fMesuVpbXHm+bj/fHyvMYQHL31m7UAWyernMCBDkAt3
 Z93554MmZmmWQjjfI1s9tZpKLk+CPOCiQdNFweIEAv47QBQ1cEO3ij61SQR5xMoRB2Kt
 8pRA==
X-Gm-Message-State: AOJu0YzG1BcOb/9DKwKRcfFe/IfHsQIQnfiVaeEvBoPMSiO4DXd74Rhj
 HerhWhiDR1LjZtC4Ilo3jfawNXAb9EsijqZ7sHM=
X-Google-Smtp-Source: AGHT+IGMr3VzfUkSkMbE8I6SnAzkK5v8haNinkeS944kju1v9nnWxRm6s7BUiy0MKV4x/AqAFF8yyg==
X-Received: by 2002:a17:902:6b0c:b0:1ca:2ec4:7f38 with SMTP id
 o12-20020a1709026b0c00b001ca2ec47f38mr7698634plk.17.1698700651016; 
 Mon, 30 Oct 2023 14:17:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PULL 03/21] linux-user: Tidy loader_exec
Date: Mon, 30 Oct 2023 14:17:09 -0700
Message-Id: <20231030211727.165090-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reorg the if cases to reduce indentation.
Test for 4 bytes in the file before checking the signatures.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/linuxload.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 3536dd8104..5b7e9ab983 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -154,31 +154,31 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 
     retval = prepare_binprm(bprm);
 
-    if (retval >= 0) {
-        if (bprm->buf[0] == 0x7f
-                && bprm->buf[1] == 'E'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, infop);
-#if defined(TARGET_HAS_BFLT)
-        } else if (bprm->buf[0] == 'b'
-                && bprm->buf[1] == 'F'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'T') {
-            retval = load_flt_binary(bprm, infop);
-#endif
-        } else {
-            return -ENOEXEC;
-        }
+    if (retval < 4) {
+        return -ENOEXEC;
     }
-
-    if (retval >= 0) {
-        /* success.  Initialize important registers */
-        do_init_thread(regs, infop);
+    if (bprm->buf[0] == 0x7f
+        && bprm->buf[1] == 'E'
+        && bprm->buf[2] == 'L'
+        && bprm->buf[3] == 'F') {
+        retval = load_elf_binary(bprm, infop);
+#if defined(TARGET_HAS_BFLT)
+    } else if (bprm->buf[0] == 'b'
+               && bprm->buf[1] == 'F'
+               && bprm->buf[2] == 'L'
+               && bprm->buf[3] == 'T') {
+        retval = load_flt_binary(bprm, infop);
+#endif
+    } else {
+        return -ENOEXEC;
+    }
+    if (retval < 0) {
         return retval;
     }
 
-    return retval;
+    /* Success.  Initialize important registers. */
+    do_init_thread(regs, infop);
+    return 0;
 }
 
 bool imgsrc_read(void *dst, off_t offset, size_t len,
-- 
2.34.1


