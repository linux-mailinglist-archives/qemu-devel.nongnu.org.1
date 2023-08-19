Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BAE78189D
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZx-0008Dl-Sn; Sat, 19 Aug 2023 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZq-000895-Nd
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZo-0004Mw-7j
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe2ba3e260so16620865e9.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438538; x=1693043338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7/wy2dOrFP6M6dk0v3scBILrw/gLVb9Blae0ntr5oA=;
 b=ncE+zDEfu7sHQP56suY5yzTZn3fZR3PbM8vMOz+t07GWoJtsQuyZMyQw2T93KjaVAt
 /sByLQLPZW42yX6OhfTEP5UNT6BZRdfxnMrYzlM/HO0sv2f/yU6Om6CiYw0pUBlqHf18
 UOkFrr8BfJY2F68f/jVl83T92BQpd7mN32iyGl9fs32M3qP97I+p27dEaXrV+2ubvaDx
 zG2R2v7Jc0JsTV50n06hO0aMO8GQY0Vtu41YmU/tXHEfEp/l0wyjY89B8MdpUQEBwdIq
 iGxQs6qMQXXs46SaywT0U29h7XwlbPKbHJsk7as+wvlUAu27WyI18cRDboDL71z8VqTX
 +72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438538; x=1693043338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7/wy2dOrFP6M6dk0v3scBILrw/gLVb9Blae0ntr5oA=;
 b=bZyZtwS2fnvB/p0583r91PTbryq4LVXcM1Zu4xRV0agyaH+llnCs4V5ZdeQ2EKrcbx
 gHXJj1XueppqTZSBprimUmQHzA/3RVcG6BxY5scotnP8ZWDZF49eR4RAufEO3BQLCoA1
 WMKdO44hV7Z4tuU8mD01melTBSakoK5FK6toLu4LI2Iqih6E9tF5rZfXU5dsWw9Nhl78
 hdWke8VZHBHCTvsCHj8cVbX+c9C/ir8XNz39Gq6q5r7ugxTnh5MilOCdPAMKrZsSYmcp
 74oKoiVVpLQw3OhtC/5MkM+b1n6sJ2yFQ1QHJyOUiNMgU5YLlKuWc4lUxD7J+7rxxgg+
 UrkA==
X-Gm-Message-State: AOJu0YzBNWKmCdNGdU82AFeoD/RmcF3TpKhKeMu5vZXgrKYbOvU8O0RL
 IaTQ7DmiRygKmD6kEv5htAH5IAPgrrY=
X-Google-Smtp-Source: AGHT+IEcsoea8x5RVgjug44bU+BJNKfMRmP65n5XyECXt0orT9CQ4Fc2ta74bWKZp7BSYQhHXSDu+w==
X-Received: by 2002:a05:600c:2807:b0:3fd:30f7:2be1 with SMTP id
 m7-20020a05600c280700b003fd30f72be1mr1060532wmb.39.1692438538320; 
 Sat, 19 Aug 2023 02:48:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:57 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 10/22] Implement shmid_ds conversion between host and target.
Date: Sat, 19 Aug 2023 11:47:54 +0200
Message-Id: <20230819094806.14965-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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
 bsd-user/bsd-mem.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index e69250cc0d..4446c94725 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -77,3 +77,49 @@ abi_long host_to_target_ipc_perm(abi_ulong target_addr,
     return 0;
 }
 
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+        abi_ulong target_addr)
+{
+    struct target_shmid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    if (target_to_host_ipc_perm(&(host_sd->shm_perm), target_addr)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_sd->shm_segsz, &target_sd->shm_segsz);
+    __get_user(host_sd->shm_lpid, &target_sd->shm_lpid);
+    __get_user(host_sd->shm_cpid, &target_sd->shm_cpid);
+    __get_user(host_sd->shm_nattch, &target_sd->shm_nattch);
+    __get_user(host_sd->shm_atime, &target_sd->shm_atime);
+    __get_user(host_sd->shm_dtime, &target_sd->shm_dtime);
+    __get_user(host_sd->shm_ctime, &target_sd->shm_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+
+    return 0;
+}
+
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+        struct shmid_ds *host_sd)
+{
+    struct target_shmid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    if (host_to_target_ipc_perm(target_addr, &(host_sd->shm_perm))) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_sd->shm_segsz, &target_sd->shm_segsz);
+    __put_user(host_sd->shm_lpid, &target_sd->shm_lpid);
+    __put_user(host_sd->shm_cpid, &target_sd->shm_cpid);
+    __put_user(host_sd->shm_nattch, &target_sd->shm_nattch);
+    __put_user(host_sd->shm_atime, &target_sd->shm_atime);
+    __put_user(host_sd->shm_dtime, &target_sd->shm_dtime);
+    __put_user(host_sd->shm_ctime, &target_sd->shm_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


