Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C04C67A3E71
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Be-0006Td-Q2; Sun, 17 Sep 2023 18:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bb-0006SV-Q5
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BZ-0002tl-AH
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32008e339adso960225f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989451; x=1695594251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AJdtgHq9fYznWnCzA7KoMOc1RO9pIOiwcxEQMuC6hk=;
 b=EzeQ0GcQra1oGT1g2+K7L5PY3vfpkhxF4IT5FEbNYq3vBzjML6qCp0AfossWbbvlKI
 kriPtGMT9LRE1M3fAfZbrr28/KqWaxSp1RDxAW5Dgo8jwPLeUw5XlpDqPyxFQP/DpKlB
 stUqnNOCw2jhV/1Eh/q4A2+G2dhT9PZMyjwXRaUXpGug2N/+QJSNhTqI7VpGksxBCpvh
 bL1aoST8DZf7/4XEmz8E61k/oNcCUjl8rjar61/f22/YIwoNyvR8AmemBaJdrlz2gc+E
 +riUH6IHURsjmBNcPugJMTmgm17bPzit8sG814wxQFwVWvnj/YmkEn+R54v8djHqQAPl
 tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989451; x=1695594251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AJdtgHq9fYznWnCzA7KoMOc1RO9pIOiwcxEQMuC6hk=;
 b=sBa7Cpi4rhTT4Hl8XoZJxDynKo4KU/ycGf2o64oIiQXPkbn43tAII7t0hx1w0rvzXn
 +QKyY5QKWZJo2xGMTBeIXVGKMgryv8jCVOZqobx9SmrC5bDLZeUfd5sfW+IAyt3XpkBR
 DJqmXcef/Ow76VLIlfR6sXKrLQv1IisNXPmvDNE7Qf1tLQ7iIQRmMlmOsYr8mFID+OWB
 gwhkpNJbDqaNP7wTcrPXPtGehbOZDXrBSpq3kBFezAEA1pul8M5PeqVywC0CW3U+dcSQ
 zu6nCTw/bYkvBKO+lDD5OMEckv+2DIJUlPnZIzkz2yNctElgNuv71w4Mcb5bB/vstzgC
 fo5w==
X-Gm-Message-State: AOJu0Yyy4IG/c9gUBEEFBPvtqNtI5bLXwiytQXC7KkrEqpjy5dM4l/XQ
 r3v1bb4yAYgpnP4JpadTVPzwFWw5Z9g=
X-Google-Smtp-Source: AGHT+IFl5WMymWTKkPGkRYGRoPTMTEXCMFoJiP90a26m/K0PFV2h9Q9UA6U2UGT79e9RxKnOSmVPYg==
X-Received: by 2002:a5d:69d0:0:b0:317:f70b:3156 with SMTP id
 s16-20020a5d69d0000000b00317f70b3156mr6469268wrw.28.1694989450821; 
 Sun, 17 Sep 2023 15:24:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:10 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 03/28] bsd-user: Implement host_to_target_siginfo.
Date: Mon, 18 Sep 2023 01:22:20 +0300
Message-ID: <20230917222246.1921-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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


