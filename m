Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298478B936
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYa-00085D-AL; Mon, 28 Aug 2023 16:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYY-00084n-BV
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:50 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYW-0007M9-3r
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:50 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so55539951fa.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253386; x=1693858186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1pQkOPxif6RkQkw16h21pj3Ra8V8ap9FhBipr/WEhc=;
 b=Vw57Euc1jEsX+y3QdbDi+cBMAEntYXQ0kG47dZ6Nsi7XlIYeBoyYOzAxge+G6sRNNi
 9nykmyJOYcEkoYicH1DfkmBEWYpvOutCi0PBBQT/yvJ7aV0aNxtcYLQF8LANdGiRiME5
 dl7IM5ZWv4dPMRIH0DTx5Y35wHK1YyETkaWCDjo5TCf8dTXIq0SA7FSywgRMMZCbJOmC
 iA7rwe02mYDE2IBpSkxgpGniSG9U80X1CfKqlz5NV+e+DlIID5yPf/lRUREXg+Rwy0GY
 LbyM0ICs46DsyJWAVd8CvEfkzzA3lCy6ws64J2mh9NQ5F03CiFqgeWZYhgwayGCPXOT5
 5nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253386; x=1693858186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1pQkOPxif6RkQkw16h21pj3Ra8V8ap9FhBipr/WEhc=;
 b=YLFsSS+puo8SfRMzpZActi59fQzG/Xoqd788FjtL3R9YxApfr8gD/zHQb5yR97j76U
 CQ2hwi+Mzduved0NX+ovIrVObH9/JNWHHx1biQMIuGVblvyCAkCb6NVwjEkkzOtKhusP
 xfcyaa7MRMGEZpTtx7HagcQAVgyzeUOWTVi49noha8tlU5aiB/upS1KqW2krqZSSocaz
 qbY4Xg/3HA7HlikGRMYbZr5bQDxkqSBevY90wVxhpabf68QOgvtEldzffZvPStTT9tW2
 v4b1kgoyFeoe+sEUsS4YS8g75aJmWhTXmOK/wx5/FCVLCLzNPmhaAAv+C6xhnuZvRjq5
 UJgQ==
X-Gm-Message-State: AOJu0YwnZXSxpmuG7DDtqydKs8PeT9CSJ1OkpzmDsa2Mfvm0A7U8JXfi
 2mFbMcxik756Iw+Tdu4Z6Cc1mUSol5AWvw==
X-Google-Smtp-Source: AGHT+IFqGm3metR2WlQBz8nFBf2KY8tcis9CD1DWqj1LTNQPdYNxRXQZ+8jPRefYWstmmQ4J2D7CCw==
X-Received: by 2002:a05:651c:104:b0:2bc:c326:54a2 with SMTP id
 a4-20020a05651c010400b002bcc32654a2mr15433816ljb.50.1693253385616; 
 Mon, 28 Aug 2023 13:09:45 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 03/32] bsd-user: Implement host_to_target_siginfo.
Date: Sun, 27 Aug 2023 17:57:17 +0200
Message-Id: <20230827155746.84781-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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
2.40.0


