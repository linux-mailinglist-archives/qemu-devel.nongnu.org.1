Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AA7A0F38
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAt-0003OW-Vx; Thu, 14 Sep 2023 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAn-0003Jp-KS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAh-0006N0-1q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c7912416bso1263887f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724161; x=1695328961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=DD9Rc4F3rQhuhO0QW8VupBsU6jeyZVi3XL6gRB0/QOYfxPdt4KiHGzCXdzHDkofKXm
 /4hthjEoQFaf/FniTieRdUUffQOiCxKYKi6z9Of9K/vBeosiDEHQ7FQkXSFlw3SXFgeO
 TSx4zok61OspBW4jYp8CEBQwqp3adULevq4RwT66BvfscIQWzOFjbHNA+cZ4SdsfqaNc
 QwbmUTMPjog3HcEAftxS4RFb3pQI9z11G2+1dRjttYMJwEH1UFLhBu8wMQ3yNNrYyC+y
 81t/9KeVaygr4xki4IrskHD6LwvMD/BW6bOEfmkp2SqFqyFja9RIy9FGHuwx6Kw37M87
 Y89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724161; x=1695328961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=QT1ltTT5W1OZPJQT/V3sK/BNf4AQ2w8u5+QfSaGRhLy2gYsIxUmvEx45NFYJswJKYc
 D8LJ/fv0uPkQX2i9omaWAe1ZL04oJzHgDzcJYpUxkT7lzN21rKHS0TupyahpKYIMc2q5
 0lFTNJ4F+dlQj07HdYYfnXenUuPh0jQ3+3bJFaAvf7eeJ1V+2eNYNC1XKF+Fuo3IDyED
 LQV8ce3x+OP3e1YHVifFzxjIAof2m8uoJQm1FWyjn82p3MqajToluT4I7VrwcpxYoKLD
 ePI/sa+eFGOOzqPMg5TYu/tVyWcJUqSvEDxNa84gOOCMo2w1eYbb2K6NSeqHLB8teDhB
 Mtcw==
X-Gm-Message-State: AOJu0Yziy8EN0DE7z1JZAIKhDPGdZk3z+GKkig0rO5l3d3WJJqJy+yac
 UeUpKeBhD48prx+k/nq/eoDVp3ucCRs=
X-Google-Smtp-Source: AGHT+IF++thn8FgbMGBD6WsHrg/ymPILWv55N4sVuG3aNEWmfvPYyV3nOo8rA9+ShToSHJAvlUZraA==
X-Received: by 2002:a5d:4d0c:0:b0:315:99be:6fe4 with SMTP id
 z12-20020a5d4d0c000000b0031599be6fe4mr5853797wrt.69.1694724161197; 
 Thu, 14 Sep 2023 13:42:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 10/23] bsd-user: Implement shmid_ds conversion between host
 and target.
Date: Thu, 14 Sep 2023 23:40:54 +0300
Message-ID: <20230914204107.23778-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 46cda8eb5c..2ab1334b70 100644
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
2.42.0


