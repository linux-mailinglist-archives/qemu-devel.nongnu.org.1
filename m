Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9C754909
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfly-0001QQ-Qp; Sat, 15 Jul 2023 09:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflY-00014o-GC
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflW-0003TS-Vy
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so3055696f8f.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429413; x=1692021413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxD0O4grkQ8OinpyCeKP/3HLPLmkFCEiNXIpS5ZyOiE=;
 b=Urm2+Pzf5cJoCZypvWz2GQ96EIZ+cr+s340R01E/qvquJkOysghVaNYEKjHz/Kmrd/
 SH7U3EyAVofJaAoTJYQkx2WH3kYBYEA344ut00DKtJx0Xy73HhDl6c19UpZTBPDjUw8Q
 LQ2kfhVkyZxoT67GZaaSKaV5VJOQs59c5SknfQsKtJtPY2TMq2ZthUV3b/y/a+5H1Jkj
 Ilpzl+AYplYYMM6AvLDUoxXFmYMKDZFrJ5nM3DsaIzCqNH6vCFuDZRHk3YAuauCUGRLV
 3jQb+Hhd70WflTnvI8DrpQ0YbXZY5hp/xp3l/hR0mK1VUgckVYi/rTuiNE7pOtx5LJxE
 VEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429413; x=1692021413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxD0O4grkQ8OinpyCeKP/3HLPLmkFCEiNXIpS5ZyOiE=;
 b=gY2PtQKD2Ga5yuryJ7/xY65WJuO5LmyJGo92OTTex7gkq6InkA53sbvh6EfUqbG0JI
 jVZaFv+6rmToybonoeGPcXjPNU4phY+H3u+POw9DTKP9zCxBo/zxfABLfDMfgwmONTn8
 j0iEL1KErKYEbpCWAG9R9drdN1JpRz6ytnzzT/YoxFdw8y40hcHkhWq8m/H4ziwFkQ/S
 lJkLTacG28lLBaUcDsxPxLVWE5DsDeWeZJG7Cb2W9dJK3rOCmvunOtpYheM+vKrRN/K4
 +JAxEcjxJEKTfFAWgS12xJDBHHiquPvbnwUpiyzEVVtGAOb382/vHQJlyiHN5rmCkGd1
 44Xg==
X-Gm-Message-State: ABy/qLaEmwOLlu55xAnoMOtc0alaiOPpgoB19f7OfZsbwPtblllur0Fd
 KwjfdLvySlEwQthfATv+HV9iPIwVnjVAIPxs1dTgUw==
X-Google-Smtp-Source: APBJJlHfgrE4yBqdTLzFcPH46Xo9OAQBwgKEBH+H2x4A5so0IeZFII3yD064LJPlW2Im3Z+aYDcGrg==
X-Received: by 2002:adf:e644:0:b0:316:ef23:9276 with SMTP id
 b4-20020adfe644000000b00316ef239276mr4886194wrn.52.1689429413496; 
 Sat, 15 Jul 2023 06:56:53 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/47] linux-user: Drop uint and ulong
Date: Sat, 15 Jul 2023 14:53:14 +0100
Message-Id: <20230715135317.7219-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

From: Juan Quintela <quintela@redhat.com>

These are types not used anymore anywhere else.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: <20230511085056.13809-1-quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 33bc242e6a..1464151826 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -309,16 +309,16 @@ _syscall0(int, sys_gettid)
 #endif
 
 #if defined(TARGET_NR_getdents) && defined(EMULATE_GETDENTS_WITH_GETDENTS)
-_syscall3(int, sys_getdents, uint, fd, struct linux_dirent *, dirp, uint, count);
+_syscall3(int, sys_getdents, unsigned int, fd, struct linux_dirent *, dirp, unsigned int, count);
 #endif
 #if (defined(TARGET_NR_getdents) && \
       !defined(EMULATE_GETDENTS_WITH_GETDENTS)) || \
     (defined(TARGET_NR_getdents64) && defined(__NR_getdents64))
-_syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, count);
+_syscall3(int, sys_getdents64, unsigned int, fd, struct linux_dirent64 *, dirp, unsigned int, count);
 #endif
 #if defined(TARGET_NR__llseek) && defined(__NR_llseek)
-_syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
-          loff_t *, res, uint, wh);
+_syscall5(int, _llseek,  unsigned int,  fd, unsigned long, hi, unsigned long, lo,
+          loff_t *, res, unsigned int, wh);
 #endif
 _syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
 _syscall4(int, sys_rt_tgsigqueueinfo, pid_t, pid, pid_t, tid, int, sig,
-- 
2.34.1


