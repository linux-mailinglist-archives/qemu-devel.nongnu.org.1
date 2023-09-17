Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4F77A3DE8
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUO-0004Se-Dr; Sun, 17 Sep 2023 17:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUM-0004Rd-5X
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUK-0004Ei-Hu
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so43804105e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986771; x=1695591571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AJdtgHq9fYznWnCzA7KoMOc1RO9pIOiwcxEQMuC6hk=;
 b=Yd0t+eH68Za6yLDnVM1Qm1mzGk5g/yX6Wz6PR5DuDk7zApBqP7EUhKv041O4rv+rN2
 UpfOr5WBrmxlr0jfniZUunr0hmiv04On4L7WW+1yzyY7BD5XfBLB2tBZC4Tzbfd/TGxY
 yzAxhBUz+PZj9cfNQZx7IeRzt7Xh55t49nSjTaXiJXIMl4tY1saN/tY2cKIT16K2kTQs
 Gmu8Wn22vUqN6L6sk4I+IKrEsT3CAHoglGmM0ReSrhfFoUwMjT4I6wukE/eOieO8lYd7
 ZdKEJHAZUFr4brG7R1wIwE5wC7aXEKDGY+b0wN3VZfwWMJJ0gLbvTM7ljrHupPtDZ7/A
 zdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986771; x=1695591571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AJdtgHq9fYznWnCzA7KoMOc1RO9pIOiwcxEQMuC6hk=;
 b=V2BbeeIECtLvQK4UJEr67DYLS8GXrpZhQseqGwv8H5xnWPqc192JWUdtFk53HQy7Ge
 sYPjpCeroR14SrQntysbHkg6EQiefrNtMLhi+MJL3UWQuhYW1tGPyyKL7Ruscd5MdHGC
 sDxYQP9mOuvkQMpytBj8RN1J6kCR69CuLcyRYWQAaLDviv8NeM2nR4msstzSeDx7c6u5
 bMuq431cwyRzfo8E8SHh27lv7ymF3BNw1KUScSXbPdK9LSMWRAtVY8REujxPYL6gkhZE
 sVrRSN+ys/tHnW+QNf3VQqAjbKhtvitopnJAvscz7yeuQ+HndrRhYYNkXF+mZvlLh1cE
 +p+g==
X-Gm-Message-State: AOJu0YyxiHUdxTB0PECsjGjkF7KMnL/AnqlIBHOW1Mcstys/FvuJv/1K
 UjhY3zFUYVkyXmvaR4C9p6pL23BHLeg=
X-Google-Smtp-Source: AGHT+IGaXLvFEypDVInQLGBn5jOJQ2LqkDPkqJgJfmfFC9DfG8EIXHrnSmJfD8H1RFik52UC1j0bXw==
X-Received: by 2002:a1c:720f:0:b0:3fb:feb0:6f40 with SMTP id
 n15-20020a1c720f000000b003fbfeb06f40mr6836410wmc.11.1694986770979; 
 Sun, 17 Sep 2023 14:39:30 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:30 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 03/28] bsd-user: Implement host_to_target_siginfo.
Date: Mon, 18 Sep 2023 00:37:38 +0300
Message-ID: <20230917213803.20683-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
---
 bsd-user/signal-common.h | 1 +
 bsd-user/signal.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 6f90345bb2..e37e1c3f9c 100644
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
index 4db85a3485..3ee2ceb910 100644
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


