Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343377ACE33
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSg-0003Ds-J1; Sun, 24 Sep 2023 22:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSd-0003Cq-HV
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSc-0008Vz-0k
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso5392679f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609392; x=1696214192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5fw6mGlVPzW+jBOcRjzUpsuKGCpM/DW3RHR4RG7BrI=;
 b=JdR/jrH62l0oC8NrtpC1QUct7lw0AsgMPyQcAeFop/A9X46cu+KnjNwLGfRvU19eLA
 mk+mE7pzbvJigt1zkI1dEIWaAncvaKKMSZIVzMZKq2TuyqGro6EBxV209ugcfGsTs80u
 oVl+Ow4isNjPtlHC3Np8mBabWneWxBySDenz7es7Uz0h+YFWN1PeY9PDJrEKr3rrVGeY
 v+vTe/HbKC1vYZEEJXu/IaKI+6IuwaEFGqswI1DL9TYTzLc8RlLrazpKiehqLCW3oZcu
 /AcuzcM2f4g8gCFBJMQU7auJtaVSUEKYq/EjTWWNd/xtPaYBc9CoyNq5+DWcbmCn3oJ7
 rrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609392; x=1696214192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5fw6mGlVPzW+jBOcRjzUpsuKGCpM/DW3RHR4RG7BrI=;
 b=t8ufelQTyDz/ZT3NiyJw5GstRNeQMbL5T0uZaqU8zQDG5WgDclUXFxJy7hGiNuaooa
 VwCttKAA0nmJIkjz6ORCPWi/1XnlpLxT6FWP0Of5+GDDQqjAhryOj5yiPVwfXvc+OjoA
 6flANjBnk2Nko+knzZ7c2/u8Em6RoaNoGyi+1kvpWWJ2mDrmr2KzLL6OxFlr4jVdxx1X
 GMQrfUQgsTLhzJbeCNFRZVOB0fpKgJa2ewdEcMvGQEtCWIlMFYu5NyyQ7kgFgGEvHIi9
 FYQWpfCq+hbG50xf7Az91pgWSHBPT2hJn08HlZ12+1o+mjA8Qly/UZVSejorQ3SCJqlt
 Xe0g==
X-Gm-Message-State: AOJu0YyvC+QBbBpnhLh0dMM9xy1AfLqey+Nk8dHYsK0pvq7mGrTAXcwB
 8use4u7Iuyxj1xfeaOGjkoKigvdm5z8=
X-Google-Smtp-Source: AGHT+IER9FeS1LjQWnoQFhGC56xhTQVro5R366QZTWAwd7Rl8LQMAIbXjw7eLLmcMiEqbSuX1NKy9g==
X-Received: by 2002:a5d:4983:0:b0:321:6de4:a1c7 with SMTP id
 r3-20020a5d4983000000b003216de4a1c7mr4834152wrq.29.1695609391905; 
 Sun, 24 Sep 2023 19:36:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 03/28] bsd-user: Implement host_to_target_siginfo.
Date: Mon, 25 Sep 2023 00:01:11 +0300
Message-ID: <20230924210136.11966-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


