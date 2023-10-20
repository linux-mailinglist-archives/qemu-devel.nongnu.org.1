Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A957D1778
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwPZ-0002O6-4c; Fri, 20 Oct 2023 16:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwPI-0002IK-LY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP3-0001EQ-3w
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso1507152b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834847; x=1698439647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=YgzFjKpzx9qaaY4kgnyLh0p1qxddSikeSGexGxeFWVG+kFsdBrj1/QLVXWH15wNHIq
 fIyoSMIF6UJR3FBKfAH+F7Z6w94XrpQ7PnbuZfXMaOPEbyujyn87F8cXKs6C1MD5PSfo
 ei8iebG9+Bv/9Qcb5ca0Ws2GZsD1IjTcv6LUSW1j/aZMYk+kqjwmBVDgejmYcttG0kXa
 NFZjsZReTuvAIQ3x7a08bpzOxB2hU4aLii28gp3/XsRwRRpFDbINC30scX/b+LDq4Ja0
 8kHmrKn8QtUyMvFLNy9n299FP/RXBRJSJlgdqzi10l8YUYEvDvwrj9DbdqHJw29kwNYm
 REiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834847; x=1698439647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=wZVP/OpBePFTL77dEBA6pBQWvOJFNBHlqyov5OZFAWyLai5NAUNaSdsts+gxk1Hfbj
 BTH78iW6pl16wP4gpVaROR3WCCOckXyMvuBQkjODoYS6w2s5pRxEdQ/QjV0pEV7ZnTGa
 X/vzhbgzZWWzhfxdYqBEKotrjO1d/ogFznoCc5F8AoOO8uE9O2i9eY24xRUlD7OF2gxR
 tGmJkwn5fzGqkg8Yf6d6amZzdtLauLxCRe5BYcGjp06ffzRrCsQdRToPoBxnamKF/J36
 yPoNK8CtY4v2TrXjhL2lFMEY39sb+vsbpOoDXjsCa7N5WTLMKWODJYbEog6RVtjGr22x
 PX7w==
X-Gm-Message-State: AOJu0Yzmq49NlNRR3xLGEGM5tTVFhAvYo7+1o6j0NckrEDWoNaaRjAhK
 Pjx8GH/7DkEWxgS4lTSwhHbiIp1nrnH7L/Zl6as=
X-Google-Smtp-Source: AGHT+IG9vSh9day8Fd1+MXBsukDZ/+jwv9twec7U1ZjAKP3bwLhJrlAxbcsq9YRrLZ9njAW+e/C2dw==
X-Received: by 2002:a05:6a20:7f8e:b0:14d:e615:277c with SMTP id
 d14-20020a056a207f8e00b0014de615277cmr4756602pzj.11.1697834847658; 
 Fri, 20 Oct 2023 13:47:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 63/65] include/hw/elf: Remove truncating signed casts
Date: Fri, 20 Oct 2023 13:43:29 -0700
Message-Id: <20231020204331.139847-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

There's nothing about elf that specifically requires signed vs unsigned.
This is very much a target-specific preference.

In the meantime, casting low and high from uint64_t back to Elf_SWord
to uint64_t discards high bits that might have been set by translate_fn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/elf_ops.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index dffb0e73d2..0a5c258fe6 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -385,10 +385,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
     }
 
     if (pflags) {
-        *pflags = (elf_word)ehdr.e_flags;
+        *pflags = ehdr.e_flags;
+    }
+    if (pentry) {
+        *pentry = ehdr.e_entry;
     }
-    if (pentry)
-        *pentry = (uint64_t)(elf_sword)ehdr.e_entry;
 
     glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
 
@@ -610,10 +611,12 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
-    if (lowaddr)
-        *lowaddr = (uint64_t)(elf_sword)low;
-    if (highaddr)
-        *highaddr = (uint64_t)(elf_sword)high;
+    if (lowaddr) {
+        *lowaddr = low;
+    }
+    if (highaddr) {
+        *highaddr = high;
+    }
     ret = total_size;
  fail:
     if (mapped_file) {
-- 
2.34.1


