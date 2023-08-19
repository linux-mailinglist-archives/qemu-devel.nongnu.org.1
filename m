Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0277818B0
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZx-0008DI-7F; Sat, 19 Aug 2023 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZo-00088F-TA
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZm-0004Kv-O0
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso2195395e9.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438534; x=1693043334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC9QfRGLuG6b7Lw7VS826b9rKt2FAmv6aiZlfH5TGvE=;
 b=Svr8cV+1ay0HI6RqefiBgsdpiRXT2OC8xhWCOLGEU0cA0kf0ruswpbYlNz3uqtAieI
 GD9FnDx4Zn/MMjoJO0ZW14YOxEkQPDPiE3wmYL4oxTWn7ibA3EQo4ipYuU5e7g482CkN
 oJcS+QJJEg70Fc2PTiOi0Ua0fMtDrP7CkHYs2JYJOWafIhzStqp3p5cN303vdRXZLnPQ
 OAUBMpaII0aDzikzBWHklAt5+zOa9yt44sG+tVznvsw2nSP+lj3c0d+7NeOhK5HH5Jh5
 Lhy0Z0nHa0LPzd0XLW63Xi+3Hw7b9f0r0jDGKf90KJ68geKYHtKnjPB5WNFhxxmBAiRp
 H1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438534; x=1693043334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC9QfRGLuG6b7Lw7VS826b9rKt2FAmv6aiZlfH5TGvE=;
 b=PRJH8uhEM+TZ0/2gqf2PIACoIQ19WG22/axRX8ozRZiv8SW4xm+vc1hNAx7cgX/JAs
 6QA3V+vDmkxX5Mm/Dhg3wKtKc//2WKhKybR2jL79gryHwOZKZOAZubve5Sn7wjF0AOXr
 1+GcvT0wcYOgGMgPgXdDSybJdlziAyTAll4EU0SzrJ+lSQK1LtlbD/W5Ij1pllLu9tCp
 i59O3Wb6N3HJmlnFB7de6/R7FcpCC6hcJB3jXN48A76HHEhSKPfnUjvIRGhsCPuy4ReE
 rhCyuOZsWyNdWl3JyN82LNy1cMRew/NfoJIPEmAwrW+5seuV2jvCwnPW1UEAhx/RR+Yn
 26Mw==
X-Gm-Message-State: AOJu0Yz39FxQea0nB/pLX2fL/78YMn9Oxp9NrFxXLwZmEyv85UOy3MXY
 EX0MyS8VA6J05PXbwNkIhUACygf7s4c=
X-Google-Smtp-Source: AGHT+IHIDNpKTe/Tku1PvKCzIHgwJD2I+Cf54Bk9i2SRHSVMQp7AdlQopjOUnwr0l32v+vmxlArijA==
X-Received: by 2002:a05:600c:28d:b0:3fd:2f8e:2c69 with SMTP id
 13-20020a05600c028d00b003fd2f8e2c69mr1206195wmk.32.1692438534537; 
 Sat, 19 Aug 2023 02:48:54 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 09/22] Implement ipc_perm conversion between host and target.
Date: Sat, 19 Aug 2023 11:47:53 +0200
Message-Id: <20230819094806.14965-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32e.google.com
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
 bsd-user/bsd-mem.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 6c123abf04..e69250cc0d 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -36,3 +36,44 @@ void target_set_brk(abi_ulong new_brk)
     bsd_target_original_brk = bsd_target_brk = HOST_PAGE_ALIGN(new_brk);
     brk_page = HOST_PAGE_ALIGN(bsd_target_brk);
 }
+
+abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
+        abi_ulong target_addr)
+{
+    struct target_ipc_perm *target_ip;
+
+    if (!lock_user_struct(VERIFY_READ, target_ip, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ip->cuid, &target_ip->cuid);
+    __get_user(host_ip->cgid, &target_ip->cgid);
+    __get_user(host_ip->uid, &target_ip->uid);
+    __get_user(host_ip->gid, &target_ip->gid);
+    __get_user(host_ip->mode, &target_ip->mode);
+    __get_user(host_ip->seq, &target_ip->seq);
+    __get_user(host_ip->key, &target_ip->key);
+    unlock_user_struct(target_ip, target_addr, 0);
+
+    return 0;
+}
+
+abi_long host_to_target_ipc_perm(abi_ulong target_addr,
+        struct ipc_perm *host_ip)
+{
+    struct target_ipc_perm *target_ip;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ip, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_ip->cuid, &target_ip->cuid);
+    __put_user(host_ip->cgid, &target_ip->cgid);
+    __put_user(host_ip->uid, &target_ip->uid);
+    __put_user(host_ip->gid, &target_ip->gid);
+    __put_user(host_ip->mode, &target_ip->mode);
+    __put_user(host_ip->seq, &target_ip->seq);
+    __put_user(host_ip->key, &target_ip->key);
+    unlock_user_struct(target_ip, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


