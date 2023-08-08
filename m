Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70AE7740C8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQE6-0004wp-Cm; Tue, 08 Aug 2023 13:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDw-0004iz-HE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDu-0003vE-S1
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-317b31203c7so5160287f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514621; x=1692119421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGnLUfuVUxE+bq89HsCJFUijzBCNRn3xwow33r6cc7w=;
 b=IiANvJZau/43IAqULXeEorJSSGAD0OETvTFNDvsz/15cq7D1WytldmNI0vjoPgm33W
 N55X2RB9ZBspJoYk2+6PqIiOPQtwK4lkLx3iOsL4liDdTwvPGP4Plu56grYMYLTRs6j4
 8TNl5d482IrVuIS4RBE5SNiLrugVWJvB9nmIaP+GLqcyc4qo4oDvHsePQ2x4hHGmibTo
 AJAWs5zmsWExYWV9ctd1Rsxt5DjPyNJ2CXxpOuaBjMnMnEWId9ciJVSE8Qha8lqcEZxu
 yhQLFEM4Ts2CstTknSfJ1TUskeSp3sLOcTWe7jyM4VAKUrDsw2ptsO5vjVGiIvs9lQme
 T2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514621; x=1692119421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGnLUfuVUxE+bq89HsCJFUijzBCNRn3xwow33r6cc7w=;
 b=lgPyVE1/6JeNAXWgq/jsECVapaPS4yVSgLky6qAePKcs5XPJMxcWNkp2mDE+Sp/NdO
 f+qnW8uFni1tPQy3FfJE2IhloXaOUN7IkvEjZEVSdcMxcDO7zRfwGJUcSYlL1Ls2ceq1
 6xqC21eMefEhI7iCZv+pGLo3sj6D4f9IY85mYPffi8w/KhJRGVf2lJ7kdQpdoSkpAypF
 8WW6D/nofmgFgkJRiQgsIc47JtWuuoXpkuIqm1CRJG6+bE3uVWymz9owC9iXO5LF4euE
 s4zSPbc/MjVSQZ5tGnCNfG86XwX/NwHUNM1gUHBYCp4LXBKTEhUbwrHc9SkP80TEb27u
 Xd2Q==
X-Gm-Message-State: AOJu0YxS0Fr2AC+gLFw5/WmNrmefsqkWEjoKl9yrOjDmCVbZf+vqJ5oF
 a0nf2hNMWcmNj+bUJptQCH3MU/oXrW4Tcw==
X-Google-Smtp-Source: AGHT+IGusMO4FPJ/HQ46AjkV/rOQh333tDp6QhwSQ1GCViGZH029Vv9dHqiZPfcTQ/OAjqrZdEjzSQ==
X-Received: by 2002:a5d:618a:0:b0:317:73d3:441a with SMTP id
 j10-20020a5d618a000000b0031773d3441amr31367wru.46.1691514620816; 
 Tue, 08 Aug 2023 10:10:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 33/33] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Tue,  8 Aug 2023 08:08:15 +0200
Message-Id: <20230808060815.9001-34-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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


