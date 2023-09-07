Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77479964E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfj-000188-CR; Sat, 09 Sep 2023 00:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfK-00011D-2i
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfH-0002wf-Se
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so28285395e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234026; x=1694838826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzQYgtfeBusD4Se7U5wLMSY61hrlabGlXjvWtWADjxo=;
 b=UjEl4pkB+wH1NeQe6ldVKOUpyoJLcmPipIWkxvV2/KIMBCdtbGyiqof81LihLzIJkX
 DDHPQDlS4qWRTpbVCr7xGskUQMMnrhUHvBUkYLLNhRJoeutD4epwMoqM+5cP9H575BEa
 D33t/dFAsRHFRsXK31ymjywMRWXCdJ0E39PDVe+J5s22SY2xzYEjedsgjP2+gR/Myo3S
 oYm+ZX2/CnaRFyr0d7iCajU9vN6dUgdLosU13/LgDBt5DvTwkFrKpcQcM91gUwtw8UtH
 aZj/z53iX4O+kEYTXS4SUYqvMGIhORprtmWGM7rrQVqThQ4fKTmdXlpJ+2iuTlwaneO3
 JKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234026; x=1694838826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzQYgtfeBusD4Se7U5wLMSY61hrlabGlXjvWtWADjxo=;
 b=G1aVE+oKcu69bxpwZLG3kB7fk74WFzvMm1wI1zBkfED+yP0MAQsTUzT4tX91/Ljthk
 a4Hs6QYULNBcRa2hk2yvNlkW+WIHjZjSSQxiH1x9bpAbpxHFy+F97lrlxFFDY0Sm7Yss
 gNolKQxuPzVyAVw0Ifw1tQlnwBunoSx7ZRm9ZkFILyjBqVsNNUZGpdm3LtSl0zbi2b2x
 8lZcTWxRhZN9/Fwme6HV+rMXIc30KZTrFJ2xvInoy45Tq9jMbMMg4x1lJQC6SI2wHYlL
 FmSRjyS0rHzuNpFsYOE9tHi8w18K0237IfAx401GGQeiKtUfcHij1/fY198Yggg9CBCh
 eSqg==
X-Gm-Message-State: AOJu0YyT7snPMvlcKO+9QpryPYk2g+dF973/q1m7eaOvZCbQLZeI2Icq
 6zseZRrmXi9PtMsvOw8sSRAWgkd6k4M=
X-Google-Smtp-Source: AGHT+IE2kHkVeliKAyOLxI+XMv5JoeIIQexO/eakYqK1rFoTYZXVsbRcwMpvltjvCamhiDAYO9SnqQ==
X-Received: by 2002:a5d:6607:0:b0:317:54de:9719 with SMTP id
 n7-20020a5d6607000000b0031754de9719mr2895584wru.70.1694234025978; 
 Fri, 08 Sep 2023 21:33:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 10/23] bsd-user: Implement shmid_ds conversion between host
 and target.
Date: Thu,  7 Sep 2023 09:42:49 +0200
Message-ID: <20230907074302.79234-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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
 bsd-user/bsd-mem.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 46cda8eb5c..eea499a727 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -43,6 +43,28 @@ void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
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
+    target_to_host_ipc_perm__locked(&(host_sd->shm_perm), &(target_sd->shm_perm));
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
@@ -55,3 +77,24 @@ void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
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
+    host_to_target_ipc_perm__locked(&(target_sd->shm_perm), &(host_sd->shm_perm));
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
2.42.0


