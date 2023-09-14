Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080727A0EBB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZd-0002vo-Et; Thu, 14 Sep 2023 16:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZa-0002vB-8U
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZY-0001Xa-Iz
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso9534165e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721859; x=1695326659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=nHHnWzgwgKsnc/Y+FOPc4WphBej/Bd4e+mR5QRqQFa/2AESMQWAU0OT6sAfxL523Vz
 tDJXQk7jFuOpm7LVcIM78anEzQAICo66J2dC4UM+vdspMMOiwPVQrG1CuPnnRzelJvU8
 iwPtKzTS/Pn4ix637Uxbk+h5458Nn9lS4kFM1HI7Ae+Q/6XcNCVEAklaAmz/3kfdaADc
 oVv9zFiXdOsBgvx5lEXvdL6yaOC03+/CSPzR6r09EWx7XSE11kGTlc4wdJubWnAdC7N0
 bmnfKsfDCCxUg/ScdzoWZR3vxXFNXkpZx4iY41VBXh4b7VCIN6hYB38BtxkxXReAojSL
 6SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721859; x=1695326659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=q5y8eu4Cnqg1sql4EVOxc5Rti1NpeZTlc12r+UxshQSl/M3W+JmQ/f5pdwraL+A8um
 PsjgTKYnY0aBpj9kWLSF7OB5IO1OXdyNeULML/yz4jcH+XhKZ43h7zRF7peI6lL2JTfd
 RAunt/YqAXZ6SDy2b22MtGNNgMRDPNPFTfg/bz/+T7rO+o2MGf8D9ornXkZyjRhy2xXJ
 6MNC8PcaGBorkJKGdWKRlgjzuvi2FqtuWn9aWHDc7BpGBU6fO5CbjFXH8nrNSV6GfxxD
 azZ/uuMWCgMIuBsTn6u5wE4ebqrUE2TzJb6E0KoI0EYeetfhkegaQNnhEGnIzHNglcuY
 2MHQ==
X-Gm-Message-State: AOJu0YxtkMfTUflV8JkE4te0noN0U1OCY3d2Iqhxb/zg1/bX65xucvKo
 DuOHmXYOKwd3QDAvwJ1qboLjke4ebiU=
X-Google-Smtp-Source: AGHT+IHNgRkjtXB3cdgo96ulCEhIZIJRYZh/3TSEyNwEpT0eMVFOmAZcqGB78VZDvn8qWI+pDktbkw==
X-Received: by 2002:a05:600c:b4b:b0:401:c7ec:b930 with SMTP id
 k11-20020a05600c0b4b00b00401c7ecb930mr2132378wmr.10.1694721858912; 
 Thu, 14 Sep 2023 13:04:18 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:18 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 10/23] bsd-user: Implement shmid_ds conversion between host
 and target.
Date: Thu, 14 Sep 2023 23:02:29 +0300
Message-ID: <20230914200242.20148-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
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


