Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C547740F2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDs-0003zi-Il; Tue, 08 Aug 2023 13:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDo-0003Y4-3N
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDl-0003kQ-OK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so50418995e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514612; x=1692119412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N72zN3LJii0x8MjnAtEVjcjpdVlbQi/8GCr75AB+WVg=;
 b=UtHqeFUYBBoO4yQ6S+bIibGF/z8u29k0LFkqpOb3ImI/vPjR/vo6jvnDPG0p2bAUOR
 uecYfKgvIAZIhk8yNmgAtx9LQRp71KoSMTFUKKhgoDMqy/yxdKxedHuXcpFQ4LXSRuFG
 7MVrj7XZsfPMeZPe314IC6ofiQVqSfYtHcNSeb5aHT7XB0l8O78de21ksWGfw/j2L0+y
 6oZvpbK5T4zJIqtu5gTZaba+FE/vxtKry3DUP5Jp0Rhqc15mlKF/jhfoz3VNhW94SEkG
 bB75WKtsmxF+Jxxs06l6Sw9MSc32mjj03gt01GKHFovqlB5Z6Fjr86nujHQKrCkL/Cvt
 GuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514612; x=1692119412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N72zN3LJii0x8MjnAtEVjcjpdVlbQi/8GCr75AB+WVg=;
 b=f8+yptIQBO8vpTrPl9971LKM1utNwAi4e1Fj7YPKDQfj4KACG7EINjvf/FR5z83cFs
 gFxJ2CRjFnO76swgjFSQUipXdd4Ncp0gCdyOrT4BEjhAIAaS2JrKNZf9J22hsrShZFb6
 wOA2LzuXgtbc70LvYkz1ClLse3dgmtHL946l3PcqnS/zmnhmz2aX81Ng/KpVJi+nTd62
 NOQ7IJFMdZQ15cIQTWI9Ws8xMJ9tQwNkmZ5UWFQVEViae16DzaRAJ30j2s/KpRZFrNBi
 gdGjegsXlAbLUN0fHiKmYqVdxvabBNFBu45I8uruDkT93+zcCh0k6H9jRdoF/ozPB3lI
 o5ew==
X-Gm-Message-State: AOJu0YwofVGHsgoVNS87fEVrVfYuPiNTylgfE2TziW7lrxUY7uGHtpkP
 1UgK2oN46/S27NrF5+3AmM3LfSrrvFCj+g==
X-Google-Smtp-Source: AGHT+IEyyY2CREggX/1C9QxSIoSXhy7UZfyLQZaIXvMK33+ppa6HlrJaA/NocB9RpjtTHxvEblOWpA==
X-Received: by 2002:a05:600c:108b:b0:3fd:3049:9496 with SMTP id
 e11-20020a05600c108b00b003fd30499496mr351798wmd.33.1691514611768; 
 Tue, 08 Aug 2023 10:10:11 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 26/33] Implement freebsd11 stat related syscalls
Date: Tue,  8 Aug 2023 08:08:08 +0200
Message-Id: <20230808060815.9001-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Implement the freebsd11 variant of the following syscalls:
getdirecentries(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 04a61fabd1..26909af455 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -41,6 +41,11 @@ __sym_compat(statfs, freebsd11_statfs, FBSD_1.0);
 int freebsd11_fstatfs(int fd, struct freebsd11_statfs *buf);
 __sym_compat(fstatfs, freebsd11_fstatfs, FBSD_1.0);
 
+ssize_t freebsd11_getdirentries(int fd, char *buf, size_t nbytes, off_t *basep);
+__sym_compat(getdirentries, freebsd11_getdirentries, FBSD_1.0);
+ssize_t freebsd11_getdents(int fd, char *buf, size_t nbytes);
+__sym_compat(getdents, freebsd11_getdents, FBSD_1.0);
+
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -468,6 +473,45 @@ static inline abi_long do_freebsd11_getdents(abi_long arg1,
     return ret;
 }
 
+/* getdirecentries(2) */
+static inline abi_long do_freebsd11_getdirentries(abi_long arg1,
+        abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
+{
+    abi_long ret;
+    struct freebsd11_dirent *dirp;
+    long basep;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, nbytes, 0);
+    if (dirp == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(freebsd11_getdirentries(arg1, (char *)dirp, nbytes, &basep));
+    if (!is_error(ret)) {
+        struct freebsd11_dirent *de;
+        int len = ret;
+        int reclen;
+
+        de = dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                return -TARGET_EFAULT;
+            }
+            de->d_reclen = tswap16(reclen);
+            de->d_fileno = tswap32(de->d_fileno);
+            len -= reclen;
+            de = (struct freebsd11_dirent *)((void *)de + reclen);
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+    if (arg4) {
+        if (put_user(basep, arg4, abi_ulong)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 /* getdirecentries(2) */
 static inline abi_long do_freebsd_getdirentries(abi_long arg1,
         abi_ulong arg2, abi_long nbytes, abi_ulong arg4)
-- 
2.40.0


