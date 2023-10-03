Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BF7B751F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovw-0004Z2-KG; Tue, 03 Oct 2023 19:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovm-0004Pd-Jh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:58 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovX-0007R2-0j
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:58 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79faba5fe12so57774439f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376141; x=1696980941;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gu7LXH0KtqoAmWr0NOHNKS6NC88NWxHbhJG+bHoQChE=;
 b=rClnTB0/dqFgMyRzNKcDHMjwD1cWcCo3rX97qVlL8Q0d8EwdFcFHWl3JU6l9S/VASL
 NsE6bZOM4eKGjwXfe640RG+pZaA7N8SF6BVOQmYDClvax52PYXDYBxL87T668HqS+uEL
 k2O1Aitqn7aCIk6TFER/cRqrwdZCluulJ6skjI6EIAPZArHV0trOZOJs3QQVtBai0sh3
 xBcasPbUhvnU+i/zT1Xom3DVeW3NWrGFdbljDl+6qM2MNTQlsazUGpdRqnJl9JN9UETP
 bG9unRyUbFyF/YPZFTsvI6Nm9gkaS1HZEITRd0Ha336T4Bz4qyESXR4A2hrTv8BTYa2W
 lahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376141; x=1696980941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gu7LXH0KtqoAmWr0NOHNKS6NC88NWxHbhJG+bHoQChE=;
 b=Q7fqahNV8i9JarTbJcmSSGwQFu+dirEpGBC/cKbxvjtDxlO/sl0u3POocAVl0Ily3o
 zpIQRAvLmnmmveJVBUXJzX0hBNQ8tU5zyi3HBn3PVTYG4d+WKgVV9hTl8fX76DxbpmD7
 RTa2tnu49IdAVOxQDoPvTjWZoRLdGjQzED7xHDKd6CufO3BkSJdWa+879GMeKA+iDJy0
 SbBueK6OOO0fNrHE/hRFcgSTFLfeEKzAKmP82tEWzr67PLcg/dsBKdwMr4KCCnMvJJRS
 kncKCAEPhBlClh+DdNI7njeAR9gBK/OINAuVHGh+L3/KZjBdiOhvozxTrOnxxvjkVC48
 ODsw==
X-Gm-Message-State: AOJu0Yz+cr/pi+E3DQPne7bLRLFNz6JpdkzrhdbPE2sOtDWUgtKw0ziK
 yYKJyQuWIusIdbWNJc6r7lwbRhfnDl/WOU3T/QfMVg==
X-Google-Smtp-Source: AGHT+IFw9EtrHE1xzilxHySckHYty5OkfbUttYYQ1PHJJOTMfig8QHD+OXPkVpns8NVYJUbC1JJZQA==
X-Received: by 2002:a05:6602:22d8:b0:794:c9a2:5fe3 with SMTP id
 e24-20020a05660222d800b00794c9a25fe3mr977403ioe.4.1696376141497; 
 Tue, 03 Oct 2023 16:35:41 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/51] bsd-user: Implement shmid_ds conversion between host and
 target.
Date: Tue,  3 Oct 2023 17:32:02 -0600
Message-ID: <20231003233215.95557-39-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-11-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 46cda8eb5ce..2ab1334b700 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -43,6 +43,30 @@ void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
     __get_user(host_ip->key,  &target_ip->key);
 }
 
+abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
+                                 abi_ulong target_addr)
+{
+    struct target_shmid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_READ, target_sd, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    target_to_host_ipc_perm__locked(&(host_sd->shm_perm),
+                                    &(target_sd->shm_perm));
+
+    __get_user(host_sd->shm_segsz,  &target_sd->shm_segsz);
+    __get_user(host_sd->shm_lpid,   &target_sd->shm_lpid);
+    __get_user(host_sd->shm_cpid,   &target_sd->shm_cpid);
+    __get_user(host_sd->shm_nattch, &target_sd->shm_nattch);
+    __get_user(host_sd->shm_atime,  &target_sd->shm_atime);
+    __get_user(host_sd->shm_dtime,  &target_sd->shm_dtime);
+    __get_user(host_sd->shm_ctime,  &target_sd->shm_ctime);
+    unlock_user_struct(target_sd, target_addr, 0);
+
+    return 0;
+}
+
 void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
                                      struct ipc_perm *host_ip)
 {
@@ -55,3 +79,26 @@ void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
     __put_user(host_ip->key,  &target_ip->key);
 }
 
+abi_long host_to_target_shmid_ds(abi_ulong target_addr,
+                                 struct shmid_ds *host_sd)
+{
+    struct target_shmid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    host_to_target_ipc_perm__locked(&(target_sd->shm_perm),
+                                    &(host_sd->shm_perm));
+
+    __put_user(host_sd->shm_segsz,  &target_sd->shm_segsz);
+    __put_user(host_sd->shm_lpid,   &target_sd->shm_lpid);
+    __put_user(host_sd->shm_cpid,   &target_sd->shm_cpid);
+    __put_user(host_sd->shm_nattch, &target_sd->shm_nattch);
+    __put_user(host_sd->shm_atime,  &target_sd->shm_atime);
+    __put_user(host_sd->shm_dtime,  &target_sd->shm_dtime);
+    __put_user(host_sd->shm_ctime,  &target_sd->shm_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}
-- 
2.41.0


