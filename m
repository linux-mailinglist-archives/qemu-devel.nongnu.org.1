Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4B799AA6
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n3-0005xn-AW; Sat, 09 Sep 2023 15:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n0-0005x7-S0
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mx-0003Dr-0b
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-403012f276dso8463245e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288317; x=1694893117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzQYgtfeBusD4Se7U5wLMSY61hrlabGlXjvWtWADjxo=;
 b=H2QRQkN3A+taOvckRM5zfZjXhVi9Ee6eZiSCrlljQU8w1nWGienE26Uzw+y0bJb/KG
 DYO6+XyceuDUE+7xgHPryRBQf5Gl5Wm1rx0j9fRk7XC4n4pqPKqp2PH0uiceMinUdVdw
 +IkFIXFtw/lcRCe3F7gum/6H+JgPi1WWGU4p2IHleeI3LRcqGk1OtR+ujnblDqzPWhXL
 dsd2/kGpJMr3NqJ1TLXCoViBTta21XHrZRdd+qq/KnQBzUxaF2ZTneL/R3OniZWOyT6j
 YuE7P+379ylAmEnxry0HaNqZSa5S7MCuEbJs4BGBXgfedBo3xNnRZumccfa6HIxuCs1o
 DtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288317; x=1694893117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzQYgtfeBusD4Se7U5wLMSY61hrlabGlXjvWtWADjxo=;
 b=nGNQZvvVmDzZTwjigPAmFH8hYIc+8eYT6GIF7qN+T0OufzdgT/UppoDtcldg+f8PJo
 f6u30afKrVbYiy8PFVIIYRx2aC9YsVXWLhUoBGOKuQOVxt5WMA2K8ZID2YsTcrhhUoAQ
 f+YSSlaYQvzyhDRdV+7jIZtw+TSFBb11mcYkUpqWBuG3NF3RzbyoDo516zNKNzJDi4pt
 ewXoLsSa5GAW9uQR7Fw56ZQoMeoj0fwl4+g9gsiIQdt2k2G/DjRFgNMM08L2l4qEvWdt
 gBiZUCy0GXm5qgYr3bh3iesM9q0Bc8+ZHLdFwOWSTz3HZfuIrvqiz+Y3FqwcWdLLlhAc
 o1GA==
X-Gm-Message-State: AOJu0Yykrt/4SgSLdGT6FkRD/jCiu10YGctBZRV9RTiR4VZjw2BAcIHY
 M07FEXz3GCNaBXXliV/XYi/ZrjU8CIM=
X-Google-Smtp-Source: AGHT+IFJBu0JduF3Vm15j8ORPbOOBZxACpqfn7sHpMpAU52HRqb1tOPJ99VHJvQzuzy42pJkQMY0oQ==
X-Received: by 2002:a05:600c:218f:b0:401:b2c7:34a8 with SMTP id
 e15-20020a05600c218f00b00401b2c734a8mr5089642wme.7.1694288316916; 
 Sat, 09 Sep 2023 12:38:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 10/23] bsd-user: Implement shmid_ds conversion between host
 and target.
Date: Sat,  9 Sep 2023 22:36:51 +0300
Message-ID: <20230909193704.1827-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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


