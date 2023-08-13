Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B277AAE9
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVH03-0007yn-Ck; Sun, 13 Aug 2023 15:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVH01-0007yO-0a
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzz-0002UQ-Hg
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so33672145e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955818; x=1692560618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl/vvZTq7At57smayFXGDxxVD4P17UWOFIucJHnT9y8=;
 b=ruonNH7Zc2ExNsbr3jQzEwmcJs+XfRUDZkTGnnPy5wRzmYTrRB/BLRMPAd5GUpAOx6
 jYoioF+2Wk6Y6lWp9jqejV+1vZtsz15/Md8Kf1xo0SuwxEnv6Kj7lAUzl1LXJ2FZfNa/
 +58yMObe/qE/4OrXTVB69fBOhLbnaA4wd880YwPnageOdq5goZYcIFiGLZirIJLXxqpe
 vPhDAagWgnBvoUhTemm/uyfmTmTczxfbGcsWnt2wVAfwuq65uGAWv3ZkJKZ0N0zUctaE
 nYEsXmtTzrBwDg0S5Rr7VHtdLVQI7kbtOLhLLan/akLxp8ts3ozoWr0WdugfdUmciPDV
 7bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955818; x=1692560618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rl/vvZTq7At57smayFXGDxxVD4P17UWOFIucJHnT9y8=;
 b=Yf//syZ9qaAxzKitM16KZLtI4xo9DZpaNAU8uU4VDwCWiCA+lKo4YtPYjxn+KHjTRo
 AkqwjFE32CwVqlOepRKMmqF2j/sTKFOm2eUNsc/l4NpMXN9kES0YGpKKs47/Ubn6e/PT
 QpLAm1AF7VAN+x2kWnhCgJxAjxsBUBi+szOFEbrRjSFlIp0J8arBX8PGw97wElWkNKMD
 PLUvW5746fFO5bbYGg312WzEWcYfvHPd/JXFFKJIC8/OyiJqzmU9+KAEm3D+IuCbI/as
 0CfhtUA9ot1GHrPb3wATxzGtt+LQqQyuigNIqAb8yshX1bFkFTZ83srM4Qv505iI7VBL
 l9UA==
X-Gm-Message-State: AOJu0YwTQm4rbYziYM6nG37aq1Cgw+OJDqSruKcuiu1dbejYMDsU9BoR
 Oq93/Q2rBgL9+6DjGj5YHN2nVY4YNIU=
X-Google-Smtp-Source: AGHT+IGTk64h38p4maj8+r4d/KoeukKguxDdKR3fPm6yOCgvstvb/eUh520T3IURJ5EZtt0807Yfxg==
X-Received: by 2002:a7b:ce0b:0:b0:3f8:2777:15e with SMTP id
 m11-20020a7bce0b000000b003f82777015emr6174138wmc.31.1691955817911; 
 Sun, 13 Aug 2023 12:43:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 32/32] Add glue to call the following syscalls to the
 freebsd_syscall function:
Date: Sun, 13 Aug 2023 10:41:53 +0200
Message-Id: <20230813084153.6510-33-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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


