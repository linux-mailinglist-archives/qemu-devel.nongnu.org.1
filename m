Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7977740EB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQE5-0004mD-Uz; Tue, 08 Aug 2023 13:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDv-0004ZW-4x
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDt-0003tY-FR
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso50275055e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514620; x=1692119420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+AZdeVO8wAJh8eKQIpeCWqrlRi5ecKqsWauTeqUKBE=;
 b=CSWihtO6yRaxQbLSqQCTA8t+j4/vJ7/4BfIQ7ZmfiiYWBYSUUXke5NxBlzSZWREh36
 363Xrc1XIkp88hjsHrE1OyxVt/rsXVSHzuhD8lxglfWbITiZUBb+S651hRNW/v7f5cNZ
 stca4ShSNBwxT3D/55RbWptxvfZ59t40A3lFKdkG+Uv/kPl5MAANW7zB3G2UbLh4ZJer
 ZzxMNkgjpGfCZawDrQli7VeerTKzCozY0n0e9omu+PKx6NPHvnbQNy47vDnVujshpc9j
 2thELsXShhBnXM1w+r/USbEcWWFIkV+jG0uLyASWQn/GB4qWNmLhA36FXKAFLw5DwVYl
 SPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514620; x=1692119420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+AZdeVO8wAJh8eKQIpeCWqrlRi5ecKqsWauTeqUKBE=;
 b=WV8w7ve+uNatb5GXU7F5wbmJtzGCSoLzD0Qu2hodW4XvFtkkypbOS4j5pBWeMwTp2O
 GUPHa8wcgZFvhF1C9Aa9ZlThAmVy0nQsK1jgdJPeNeUhFuHvmn/FpDqBuJ8BxZSMooc3
 OniAwAZQDtl+o2Fl1KYQ9p6mupuj1aD61sIwo6G6nKQGofs9W0BemWgXupnFb77IjOBO
 6CnInLHVWdpIkx4SpZR4fmD49uWUhAY83bmd+VT4ivMX4ZObnpODB+p3mrmIY+oGIvY0
 QvgXKwrf4jNrK9UEprsUF0rksgl5ZAYqV/NPsN6MDQhfT1Jamx5E6GfZS+nWjFNYP3UA
 Kwag==
X-Gm-Message-State: AOJu0Yx1hKnAjZpq8PGFir+sbZcBzIhxWaVzNqyhtwDFkFYQ/0Z7AWBr
 N16tywT46eyDFyijwNie3rl4x1QWN6J57A==
X-Google-Smtp-Source: AGHT+IGedRQEncCm+RQQrg7lpFW5PkGQj7xUhq4mQQxFD/kmNqFqTZX/Yex6EvoMnD6kP9yq+7+SWw==
X-Received: by 2002:adf:db05:0:b0:311:142d:5d97 with SMTP id
 s5-20020adfdb05000000b00311142d5d97mr47309wri.31.1691514619884; 
 Tue, 08 Aug 2023 10:10:19 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:19 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 32/33] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Tue,  8 Aug 2023 08:08:14 +0200
Message-Id: <20230808060815.9001-33-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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

freebsd11_statfs
statfs
freebsd11_fstatfs
fstatfs
freebsd11_getfsstat
getfsstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-syscall.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 73616a5be0..916a754bf8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -552,6 +552,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fhstatfs(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.40.0


