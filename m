Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3A7B751B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnov7-0003w3-Gw; Tue, 03 Oct 2023 19:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov5-0003vK-JC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov2-0006gk-4X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:15 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79faf4210b2so57687839f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376110; x=1696980910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRg9pwrrUdH7ek792cGQPFuJ+z7VOTPX+WRxVjZhFoc=;
 b=BprEymcq4J/buBWwmvCYsFvX3z86nNBh93UcKSzGdtGOYvmgCMBTKhJevYtz4DQri9
 6i/VVY0jd3/ZHnsAN6N5c5kOWKE/DFikzNSzMgAP50XE8IDPaRoa+iZdXnfRnNk+j4By
 4ukGXmHi9yBZUQkwH2Le/y9+GHR9cd3vQ6j11eQhZm8klN/q5d6Kwj9Jk07cW2A6SFKz
 Fvw1/c2wiiK6kZsNFlVcb9CosiHfd+6u4g3tF8Yq2CRLSUcy07DkfpV0tGdO/ZlCYTVn
 BLkNtw+kYJgi1sy12CcQQED9G3OGIXYN8HLnPfetiv010ig++lk6dWdQWPpnILdlgOnS
 oiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376110; x=1696980910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRg9pwrrUdH7ek792cGQPFuJ+z7VOTPX+WRxVjZhFoc=;
 b=PCTDT2AiXvZY8/XDK5XJci97cVnheupsjOzG8flNH2hK9OQNdgRXSTTkTnjlrHMEkZ
 7t7W/UTwRqo6Y6l0QB634JXg1TVlPV+Zd8/b+XyxyMw7CjN4SS9DXGzaapxAnvm8roVZ
 ETN8qsCvp3oTzcQ0feJpLCBEVq4pIWArzrHUH7AmIxeP7YUVxohTiPEAt+1M7VsBsRnN
 N7qD6DS0OBe9ahv6JV2Bm7tbZpekHA01rRDSQJN9rdO/bYrUtYDIGyJ1CkPv3FJR2EZJ
 ihX7iJs2nBcTg7uJjWJ7lrHPUfrRLrrwYxPeTP5rou8EAGw4XzANPuA2ZQ18jfo/ssBb
 laHQ==
X-Gm-Message-State: AOJu0Yx6EhOPMW/o7xxElXkbENNYyNY3CUGBTh1EM5TIAGuzat97OjVy
 UwJpPj7f99j8xgPZEY+vFXRnT16flBPFqA5SPdlwtA==
X-Google-Smtp-Source: AGHT+IFfBD717TINbasu/Asf5Ff90RhANH8U6G4QpdRPE6inx0tgqIKTOOiMk2Z2CnY0Ppoam7h/3A==
X-Received: by 2002:a5e:c24d:0:b0:79f:e9ac:f60a with SMTP id
 w13-20020a5ec24d000000b0079fe9acf60amr861018iop.20.1696376109717; 
 Tue, 03 Oct 2023 16:35:09 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/51] bsd-user: Implement host_to_target_siginfo.
Date: Tue,  3 Oct 2023 17:31:27 -0600
Message-ID: <20231003233215.95557-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20230925182425.3163-4-kariem.taha2.7@gmail.com>
---
 bsd-user/signal-common.h | 1 +
 bsd-user/signal.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index c044e811653..77d7c7a78b7 100644
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
index b6beab659e1..ea82241b70b 100644
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
2.41.0


