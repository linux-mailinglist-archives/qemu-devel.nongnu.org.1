Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673E77A6BC
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpx-0008H4-0J; Sun, 13 Aug 2023 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpp-0008DQ-U5
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpo-0000vb-HB
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so31521445e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935967; x=1692540767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl/vvZTq7At57smayFXGDxxVD4P17UWOFIucJHnT9y8=;
 b=MrXhyPuNgQ81frC9uVXqUkrdl9nFjgAyn9nbb8wKsQP17+TZg6MnmzTeyVPdHaPIme
 u2ZNrpyVN0IKvENWJ01pRLbiiADThCsIkTBBsp9A02okmXdAQjkT3wf+hrpfKOWOwcYZ
 sxrtN1sTMwIkCByAxEd3AVuYdUA7FZrsCYhO9/Osh8nzocY/UEhxRCFn8cWNIS18SOpP
 NDJqGZo3obIXi38ijN+c3CjT9Kt3r5E+c0ShgT5QQe3ncDoSNoXspoOK6r7/I3ob0lHc
 BrDFMBKcxTyTUQCSbdUYfLdnIq/SGuBycSeFLW7nUgb2QOrPmAdX+tUkWT6H9Hgd68z0
 Y7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935967; x=1692540767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rl/vvZTq7At57smayFXGDxxVD4P17UWOFIucJHnT9y8=;
 b=CvAxZs1nYghNIUKNBjMFASYbiHRlGm/xleRQZgYE1eUAuM1U6DmeDr/6hIH3uEDdfO
 ssy3xWMxA0XcR1YGO/XmiCrKW8xTDldqC7+cMLmUCRrg3+s6GW1+2aDjwYt+wCyWSPKg
 bFMqWIgb1MV5MTDU4iGJUHGF7y2i/JfvgKwgTGxqIEWoWzKqD8h3JPbdjLJ3zgVt3Sqp
 D6ebLOsuxZd2hjKqzNT6pU/K624l15G7Gm6douNwDJ2FwJ+aSnbOzcpKJgoL31Mwoz4c
 esNPlhJXAdt4SY0FcoUvy0rZZBILVk+xK5kqlJs05ZCSiK8ZHgjrPD/EDvyF8MRpDpew
 zDtg==
X-Gm-Message-State: AOJu0YxhMVj9mW4OUhoQUkXRrzqsr3rp8gEAxy4krjflyiwEQrxCvaG8
 HenVeN5mzN/DNyGjO5eXj70Q7EZ7rGU=
X-Google-Smtp-Source: AGHT+IG4LWiNhGXvng5kHGY3UyKDam7XT+10FjETuINtgOGt21/Ms5xtP20U+co2SfuUi5Lavg0IpQ==
X-Received: by 2002:a1c:7208:0:b0:3fe:1548:264f with SMTP id
 n8-20020a1c7208000000b003fe1548264fmr5306372wmc.22.1691935966788; 
 Sun, 13 Aug 2023 07:12:46 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:46 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 32/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 05:10:13 +0200
Message-Id: <20230813031013.1743-33-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Warner Losh <imp@bsdimp.com>

freebsd11_getdents
getdirentries
freebsd11_getdirentries
fcntl

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 916a754bf8..e9b1b663af 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -576,6 +576,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_getfsstat(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
+        ret = do_freebsd11_getdents(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
+        ret = do_freebsd_fcntl(arg1, arg2, arg3);
+        break;
+
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


