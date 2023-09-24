Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D67ACE32
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSi-0003Fu-8M; Sun, 24 Sep 2023 22:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSf-0003De-2B
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSd-0008WG-IX
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405497850dbso34381575e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609393; x=1696214193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtr4AZcHHxXXmu6rDPP2dwqMNgqNWW0hP+jIdi1BnOc=;
 b=GbEkQ/O44iH3uaMfPa1lpCYVV9KP4nfcNXMVpncw/P+qVHwoXPYI0zGAfJ8p3bwg9m
 OKpoZnLyGOrsbSyAd0J//+dmMwWLGw5GPP03SIMsJXd/QEGwJRKgOkCjkTSyOgeMNtFF
 80OZuRBro0GF4jM1uzFxYh7TH857K5EzJxT+g/6o4/gh/Ffr+EHSdi6YbmAnkBpgWxHh
 xLDbiNCGevpO2tHUOptnEw/FAZ0WkkZ37fH6j5st3MMgBQko6HnI3ed24JA4ylk46Xx4
 DZJMNgeaG1oUkSvV+4fu5MDaElQCfnSxDLd0EugTui50w5ugsCuZfwOTF5ki6BrFoBz9
 G5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609393; x=1696214193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtr4AZcHHxXXmu6rDPP2dwqMNgqNWW0hP+jIdi1BnOc=;
 b=qA3QVUPwSMRFpLCG5Q/mz9UzBwUNIJ86Y+EyfdTA59F0MGgNm9wyzRXG2lcg5x0OYY
 ZBrDjZPbpw90XRQAbrXNxZo/P3JgMNijXbXH9JNgIrhc0YolGCfdudMv7zBD7lpZIjB0
 pSC04QQDBlZM0gPIzWmHcmsIqPGrDE8SVLZjBpYYjOFLfMF3Ep8x5m6Tc4q48/60BUdu
 lBuAOeXz9Ip1pyQihFJcSPoGH0tkfvaVZT0xg9XXqAaGqYKrclFv4azujkr9Is7FKooh
 QM3BULFMgTYqo8gKaNPe4QtSAIAt1Km6jfwfdUhMOnZv26Gmb35l3cu0FFo5PIWAgf7s
 BCgg==
X-Gm-Message-State: AOJu0YxnxY5F5dgnY+0C+2xrxkpvsvZ8S2el99TCUd10p4rB0l9RU6nl
 okqetK65c3FNZC6pA0BJHkzGVooLc/0=
X-Google-Smtp-Source: AGHT+IFXWIfKMUS013e28TQheRHg9FtD4cITd50981UVFVjStfKMGT9/aK3r9yRXZazReFBVqfpuAg==
X-Received: by 2002:a5d:458c:0:b0:321:5e2f:37e1 with SMTP id
 p12-20020a5d458c000000b003215e2f37e1mr4808182wrq.19.1695609393298; 
 Sun, 24 Sep 2023 19:36:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 04/28] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Date: Mon, 25 Sep 2023 00:01:12 +0300
Message-ID: <20230924210136.11966-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d9507137cc..41c7bd31d3 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,12 @@ abi_long get_errno(abi_long ret);
 bool is_error(abi_long ret);
 int host_to_target_errno(int err);
 
+/* os-proc.c */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec);
+abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
+
 /* os-sys.c */
 abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
         abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);
-- 
2.42.0


