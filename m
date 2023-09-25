Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019F7ADEAF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHR-0001Bu-PR; Mon, 25 Sep 2023 14:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHP-0001B3-Le
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHN-0007HH-3l
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-404314388ceso76762505e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666355; x=1696271155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5fw6mGlVPzW+jBOcRjzUpsuKGCpM/DW3RHR4RG7BrI=;
 b=BKWWWCUGVZYNf/kNl1OOgR9yM9d0l1SpyvXg7XsVz7QezRZe1OuhlaFsVqrh3BqshG
 4dNs/HcSj5/Tw3NwtuB6ypGfcy7GoZ156dpbkIno9uAlyTIlrk60k4Dof1pBMdC8gK5N
 4KbZtt3b2h6PwulaZRgkav0WWcJKbJ/XPTD+vFp2ulXroCtzh5z2Pj3Yi5C0edaR9MHE
 OKyEVNUDuljom/nu8WY8DX5RyPxmFJbKtNam3RUgkcQBmSWU4g2C8qEgCaF4szSDzc+v
 81sdain4wD0/bUwYvrT1t2761U6PePM7IqyWErfRdFhOhfPablyIXCbaYCA3OkElYsHw
 ohNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666355; x=1696271155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5fw6mGlVPzW+jBOcRjzUpsuKGCpM/DW3RHR4RG7BrI=;
 b=djrihBhZnak0leD0Q+4IQFV61VQwLgP4SLenrlm71v1+RsXmtX2AKa/CiDMfYHz6NL
 GDfvdCvMfhcnMjp7uhWJnjO+jRMwlqChQg7yLXoN6LLIXTe+3JydqPSP0Pa4MJ4rk437
 jG8apSqFrxycoeKRHS00xTqBZTkDO79Q1rs6sCEhraWRFFq0S+EJDYoAD9XbuIRcU1zl
 qfDzdXd9J5z9WbNemwPTtDexXJJ5uVXymDF0cHPrLKPgS0srKV0fXbc+7ky/pf/bRbzY
 FXXc5IQD2rJDxgIs5iLWhBjjuc0dGi991EwLedqmNWagcPSvLUWxS9Ni0Ldw0bw9Aw41
 W09w==
X-Gm-Message-State: AOJu0YxDqSTxmiYXr2/H8pBkf2u86In+eD/JRisODSRlaW+S49GKVNGc
 mbivQrUNpXHJs0xBbbvaufYUnwrs7yo=
X-Google-Smtp-Source: AGHT+IEvddGE7Z2lkWHbNfrQSnA3k+5qYjWQqJbVADTJIWA+XSiCbwtRHuRMa+dhFp7hVa8NI9ta9A==
X-Received: by 2002:a7b:ce92:0:b0:405:39b4:314f with SMTP id
 q18-20020a7bce92000000b0040539b4314fmr7193984wmj.24.1695666355238; 
 Mon, 25 Sep 2023 11:25:55 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 03/28] bsd-user: Implement host_to_target_siginfo.
Date: Mon, 25 Sep 2023 21:24:00 +0300
Message-ID: <20230925182425.3163-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Used in wait6 system call

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/signal-common.h | 1 +
 bsd-user/signal.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index c044e81165..77d7c7a78b 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -35,6 +35,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp);
 long do_sigreturn(CPUArchState *env, abi_ulong addr);
 void force_sig_fault(int sig, int code, abi_ulong addr);
+void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
 int host_to_target_signal(int sig);
 void host_to_target_sigset(target_sigset_t *d, const sigset_t *s);
 void process_pending_signals(CPUArchState *env);
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index b6beab659e..ea82241b70 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -311,6 +311,12 @@ static void tswap_siginfo(target_siginfo_t *tinfo, const target_siginfo_t *info)
     }
 }
 
+void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info)
+{
+    host_to_target_siginfo_noswap(tinfo, info);
+    tswap_siginfo(tinfo, tinfo);
+}
+
 int block_signals(void)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
-- 
2.42.0


