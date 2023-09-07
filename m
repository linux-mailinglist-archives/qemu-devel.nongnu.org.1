Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06879964C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepg1-0001AQ-2c; Sat, 09 Sep 2023 00:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfu-0001AD-KB
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfZ-00030Y-IL
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c65820134so2491205f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234042; x=1694838842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX9h1C28ifZiwlprRugD1/5aAvqn6UBysQeovDlj5zU=;
 b=IgPL2rDVmgQB3U5nQmHhdQTyJ+jgO7Gii8h56+NQ4z36lKZh6H1cG5XHt3h1l+sdQV
 W/YWLEuNZfDrBU1fJQ5tFE5nkGfHNclrIiKs1wUOeBB7Q91w5U4Y+5NhvPTzBrhKXP0I
 oRMUqdh10YTi5PdeGhlSXhnEXExVXai74Ug4x/aBayfkNLjrsX1WhAeK9JbL52E6py/D
 2fnGTOZ+ulhhVpMMnm5zALfES9LJx4HHtLzzhFAWdfg9qtMoWUQZQjeNicNK/6udqGOk
 OT6MlUyAcWXRw5p8cMCgzEfJL15yU8wLIvE8yvbvynKP1kpsZbgoVjsNOz7fLnLZZoM2
 HLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234042; x=1694838842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iX9h1C28ifZiwlprRugD1/5aAvqn6UBysQeovDlj5zU=;
 b=CUtrUCb5JT808YI+48HvY975tTYF/ZjhlU08CZDlLMwcMgXXD2c/WM8wSsOB0bFtqh
 TpjuARsppWDyYwwIUMjP/m02f9MmTXmO8JDIotQeBwrkSQ4FPAg6Y1WhQbdbrIZYZyrG
 Q7yyUKyrPPczHeWnHdDcxld04vKho+T1wFEaDIjaqSEcHCL2mF+hx1s/QfKOBxt00xZs
 cxkxzQix6FlriX43y8ZuKL727x/Unt8xFbuAxJo0O+PLC7+rXeIycHKq3p6QDoXWb9qK
 WsRGaT6WgesLksMeZmAK0eYdWLhIul0EKuHMzcCPCrhMeiY+tRMro/D88hpHl50tNk9X
 mWRQ==
X-Gm-Message-State: AOJu0YyHuEjS4YwiqTUJSDP38IyeitwAMqwBY4rAFoJV1s4bss10L+Ng
 I2DFL/bU4HGAae0mrXUqto9NVTNu9Aw=
X-Google-Smtp-Source: AGHT+IGinAsuh7hO3fKHK6sD4qZjmI8T42Zwya1+UD4Dfg/GjvRk01+P/79SqNkvqaujiBx0i92Qtw==
X-Received: by 2002:a5d:684a:0:b0:314:124f:12be with SMTP id
 o10-20020a5d684a000000b00314124f12bemr3200954wrw.3.1694234042084; 
 Fri, 08 Sep 2023 21:34:02 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:34:01 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 23/23] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Thu,  7 Sep 2023 09:43:02 +0200
Message-ID: <20230907074302.79234-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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

From: Warner Losh <imp@bsdimp.com>

The above system calls are not supported by qemu.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 18 ++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c01b009326..aea8d65f15 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -413,4 +413,22 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
     return get_errno(shmdt(g2h_untagged(shmaddr)));
 }
 
+static inline abi_long do_bsd_vadvise(void)
+{
+    /* See sys_ovadvise() in vm_unix.c */
+    return -TARGET_EINVAL;
+}
+
+static inline abi_long do_bsd_sbrk(void)
+{
+    /* see sys_sbrk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline abi_long do_bsd_sstk(void)
+{
+    /* see sys_sstk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index fe0968773e..9647249e90 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -567,6 +567,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_vadvise:
+        ret = do_bsd_vadvise();
+        break;
+
+    case TARGET_FREEBSD_NR_sbrk:
+        ret = do_bsd_sbrk();
+        break;
+
+    case TARGET_FREEBSD_NR_sstk:
+        ret = do_bsd_sstk();
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


