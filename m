Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426317818A9
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIa3-0008FW-Vo; Sat, 19 Aug 2023 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIa1-0008F9-Pc
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZz-0004PM-IZ
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fed963273cso5600185e9.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438550; x=1693043350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO8q0y58WgnWuoU0UOPDubyf7LY9zjVTClzFcwjWHJ0=;
 b=hD5vfcVTkDHeZ77AEg1lzbNajUvkRfh36wB3sNTh2ZPsqLeW0xMWqbEFb+zdK6g1MF
 gWtUczD0J0hhF2OGxhx/mh6w88HjHmxikvYd8TNARQ4vNKuMtUJpnLJDm4RxowXqhCBf
 nwwuIzDb3DEcSG+bR8wRph4Yjp8qGTrRecN1wtW0SZvFQQI+s48p+qmtaOcJyr0EpwDo
 g1qAm6uAi/CAlzi73pNE+eLllV2lxnEpmlTH0x+NEcIN7m3Eke1jbNAXDV34DqWMq6Dl
 oQ82f4YJgQKGlXNJMDnb7yMY9pEmCDfLYv/K9Y74j55I4a8potJko3HAAS8vBkgBoTaU
 B7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438550; x=1693043350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO8q0y58WgnWuoU0UOPDubyf7LY9zjVTClzFcwjWHJ0=;
 b=P5iw8lsZIrAUddZ9eMHCzbWRZd6PcsIWqcSzBOkUfC5nu7WZqVYEEBS8ZHEKp5pSGh
 9/1pXzcMkdOwB3mo9y4kLc0Sl+PCD1qG9mwWGE93Dw8vf4ribRpCsA2+MGXo2tH6M+qD
 vB2ZH1IsKc2av8649WDG+gNWbcTXiR81r22FQ4iMFgzgi0TbWYwchOaXi4LVR/9MT5xg
 ecJ+DiqoZvuO9JIi5kWmlk0Opm3LE8nCW6gS80f7sBd6drJ6cCcWnpof49QPNezg1TGm
 VfSFGiDosdd7SWa5sj1EoQaQi8mR8sEcUcSR5R4qKLBT1diVWAt9GBV0uU6ORVSyd7dg
 l2vg==
X-Gm-Message-State: AOJu0Ywy8VJswOnjeZKQPdNmUMTIxAGe4rowFbBBcVkIpbpOUy+5fpr9
 J5rpgmVwaRYiEZ+/M0Fwr1o7odQXIOQ=
X-Google-Smtp-Source: AGHT+IEg/mEoTjk2/EYNQptMeoJOytYbfaYjwSH2bYONGvFG1+AIDJnVbyXKxAZklMCIsBQ1JPr2+A==
X-Received: by 2002:adf:f8c4:0:b0:319:6ed2:a5c4 with SMTP id
 f4-20020adff8c4000000b003196ed2a5c4mr1232439wrq.26.1692438550046; 
 Sat, 19 Aug 2023 02:49:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:09 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 13/22] Implement mprotect(2)
Date: Sat, 19 Aug 2023 11:47:57 +0200
Message-Id: <20230819094806.14965-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 7 +++++++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 057c995a6e..a6446a454c 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -82,4 +82,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
     return get_errno(target_munmap(arg1, arg2));
 }
 
+/* mprotect(2) */
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 3525d39d7b..aea4e337ff 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munmap(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
+        ret = do_bsd_mprotect(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


