Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7616378B92A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZH-0000FX-6t; Mon, 28 Aug 2023 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ3-0008MH-TC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:21 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ1-0007bD-Fs
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:21 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so486488066b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253417; x=1693858217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30X8xyseiqtr0009VlIfSZJgdjDQukn2S+OSMnNY5VA=;
 b=FMoUmGIfPNIdkTpt6vCEDhMEFxoqY7GIX4/YnfhJkQHJyKckYnPr7QPVSIf+TMfhwq
 NyVkv0QhQHiQOFU2O9ZIWtfpkbprV1MqzwvE02dAoqpZvKLv9f1XHPj7GtEICOtprM5b
 FrpYxTWn1NAMaGSkDdBpyel5nMou5atjBWENPPwd5cPKGEGrgu3PB31i15yCpXtFpO4y
 DpmSHt9cwsQT/bk6CLQMG3E+YxTNK8VdFSizUl9qHSdPInycMrpvejeIMkZd9a7IZKLA
 /bkWhSnhJh2d4Hsfrtq9pZ8Nr6ajlD4nyMp3Z27gKScGeckYWkYou9PyxAefvCG7D6lF
 Y4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253417; x=1693858217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30X8xyseiqtr0009VlIfSZJgdjDQukn2S+OSMnNY5VA=;
 b=cQHZ15NZbIU9SaR5VegvncFTGFil93VQWN1O7O87eXqB0BrEdUqxIgKq86HZ9Ewqkn
 UbnVc1CaiwAHSwx6mwFu+uYQYxAsiqQTX87xkxRUimtbvYqiCPIGq8PWWwfHIfymN36D
 iIlS1jixqZBO/iiVPKVUwFq3BJCs3TXCDQf0AEfibIdaJIR8ddvnUTzvj6FMKqFo6F9M
 HBTFS7/S1eqqxjsCI6nRXI9g3uv6nLNUKAae1w5aZUYpnbsbWYw73DxPIIEbTNamwz5G
 7SCJm6fvD3d9fU/Cuc9gVocoWftE/o7PEsf3BHfFMRIKSpz9DA/548c5TmVGfQ3Jl3dY
 9peg==
X-Gm-Message-State: AOJu0YxdtoaoWvJQP8KgGB5HXENP+lN1zV+KPHJy5LveVgVFZJTCSJe1
 9J/NZmS02UFGJqUzoyIcynUIyTnryxJqAg==
X-Google-Smtp-Source: AGHT+IFPq0EoLbzv5T5HPgl+63Ws4/VWyVIEAiTlERS1+gjvnWNLt/0YuzrfCaFEOBc14n0f76H3Lg==
X-Received: by 2002:a17:906:109a:b0:9a5:c54f:da1c with SMTP id
 u26-20020a170906109a00b009a5c54fda1cmr653164eju.47.1693253416523; 
 Mon, 28 Aug 2023 13:10:16 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:16 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 12/32] bsd-user: Implement getgroups(2) and setgroups(2)
 system calls.
Date: Sun, 27 Aug 2023 17:57:26 +0200
Message-Id: <20230827155746.84781-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62e.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 44 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++
 2 files changed, 53 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b6225e520e..ecd6a13c2d 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -41,4 +41,48 @@ static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
     return 0;
 }
 
+/* getgroups(2) */
+static inline abi_long do_bsd_getgroups(abi_long gidsetsize, abi_long arg2)
+{
+    abi_long ret;
+    uint32_t *target_grouplist;
+    gid_t *grouplist;
+    int i;
+
+    grouplist = alloca(gidsetsize * sizeof(gid_t));
+    ret = get_errno(getgroups(gidsetsize, grouplist));
+    if (gidsetsize != 0) {
+        if (!is_error(ret)) {
+            target_grouplist = lock_user(VERIFY_WRITE, arg2, gidsetsize * 2, 0);
+            if (!target_grouplist) {
+                return -TARGET_EFAULT;
+            }
+            for (i = 0; i < ret; i++) {
+                target_grouplist[i] = tswap32(grouplist[i]);
+            }
+            unlock_user(target_grouplist, arg2, gidsetsize * 2);
+        }
+    }
+    return ret;
+}
+
+/* setgroups(2) */
+static inline abi_long do_bsd_setgroups(abi_long gidsetsize, abi_long arg2)
+{
+    uint32_t *target_grouplist;
+    gid_t *grouplist;
+    int i;
+
+    grouplist = alloca(gidsetsize * sizeof(gid_t));
+    target_grouplist = lock_user(VERIFY_READ, arg2, gidsetsize * 2, 1);
+    if (!target_grouplist) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < gidsetsize; i++) {
+        grouplist[i] = tswap32(target_grouplist[i]);
+    }
+    unlock_user(target_grouplist, arg2, 0);
+    return get_errno(setgroups(gidsetsize, grouplist));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 2224a280ea..17160ab532 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -220,6 +220,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_exit(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_getgroups: /* getgroups(2) */
+        ret = do_bsd_getgroups(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setgroups: /* setgroups(2) */
+        ret = do_bsd_setgroups(arg1, arg2);
+        break;
+
+
         /*
          * File system calls.
          */
-- 
2.40.0


