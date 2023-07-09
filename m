Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54074C745
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZHN-00048Y-Pn; Sun, 09 Jul 2023 14:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZHA-0003q6-C8
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZH6-000520-DU
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:36:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso41929975e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927806; x=1691519806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3ntvwGeIvPIaD5TgXh48cA42oiiDsy6pVSZ4qqqrPg=;
 b=I6RtJRlYfIX2gkBLiXywdeJkqegBhnkimgH/j7Ms9pzErqrTSoyCtQdhGubAIWGpx2
 L65Kfi5PgggasHSKcQeOj/cNlkG7e6FlFmWDoZnqRjn+/w4qj6QXY5QlTyR4rbnNvm3i
 iqWTLwrpwV8jmhZjEIVJMLCyWdOrDs90gkPqLH9FMwpzGQTjvVcQwLG/TuL2GSCfu6UK
 q4d2UjvXHGKNsiaEwb4xX3UCsuTDn0FonPpBHvnEcxd6bMfBunmYLwDQVu+7CvVhbZ/E
 W1mOgNI4WMHx0WWl+dYrQmBmBUKpAc7Ho9ayy6NESTf0w4cxKpHbtm/V1N2C1T/GJ+7e
 imLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927806; x=1691519806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3ntvwGeIvPIaD5TgXh48cA42oiiDsy6pVSZ4qqqrPg=;
 b=jAlNorE8BM2CuYVRrT0WoktKOgOAB2SBSqeALSXr25rPPNabcAPFFKBKrhtIFwLHq3
 r/kqPhz/YR/gO+ZvLm4NUE4sNGz9HPQKzfqn2YCwbu5pxxHY3DyxYQhUxIlgfIgvee6z
 ZLH2kqOBr6v32GyWtDiiSX20KvA5LGpJCilkQnJOHpKf4tjL2e1sPtiishmWElNvi2QV
 XEmCGKBfu1op+aMd/cjyv1kFb1N5kcCxwlcsW2CvcyoY0kHDj1wlfvbZs5Fj3y9ZVjuV
 Aum8Z/gkHw53tKu2SaCKiQgpwLa3LTGc1lv2W+p1DAxaM+X1bPtczTVATyajtrw+NbhA
 rQ+w==
X-Gm-Message-State: ABy/qLaLH9sT7/a/vMu/GFQsZEDSpV6HDaZzwJWccNPk660AM/+DHTuD
 8YSqT2a4Www5ocKJWa+iKPzxX3YfxSa8naLElN3SbQ==
X-Google-Smtp-Source: APBJJlEOID1psoLQlvGlcjBOGRrLEwhF4TgmdsBzr5OvU9gClbcFhWawjI+04p4AMWZEp6DW24xVmg==
X-Received: by 2002:a1c:cc0d:0:b0:3fb:b1fd:4183 with SMTP id
 h13-20020a1ccc0d000000b003fbb1fd4183mr10007347wmb.12.1688927806067; 
 Sun, 09 Jul 2023 11:36:46 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 i6-20020a5d6306000000b00313de682eb3sm9735832wru.65.2023.07.09.11.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:36:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 44/45] linux-user: Drop uint and ulong
Date: Sun,  9 Jul 2023 19:29:33 +0100
Message-Id: <20230709182934.309468-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
index 5870eb84e5..d2d6cad59d 100644
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


