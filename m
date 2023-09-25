Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542347ADEE0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKB-0008PQ-QT; Mon, 25 Sep 2023 14:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK8-0008L5-Mj
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK6-0007nF-T7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:48 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3231df68584so3245042f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666525; x=1696271325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=E0HPPmMWBSd1C9D2I5yb+Upmu3NEFp9mGkqhdk9+pOM//XxdXr3fDWSlZTZ/awce4e
 Wx1RQ8x7h2mEN4KgSAhAivo3qAbESnBcE2nPC14ZPxDGXTBdmso/pYCa9phuck0+Wt5M
 AauQPDbXse+miXekxKsqtMyBIiYpF/UYB9FUT3zTlGUX7BcWiKNth9Rr7SXU5zgJS+gB
 x9RvRxHoT1f7SiNJToZPAZTH1mYpEBFJGUcUfnsJpDmxZSlknJ5cGxPdB1Y4lQHqHzuC
 DnQAMv7jf/+agr9dZrhYoMfJ/cfRLfc1R7jsJZIFslbiBI8fSJb3OMsDWmewyM7frs9x
 gy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666525; x=1696271325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTuAkybq2jfJV9OdRT1tDzyr/5NPWRVF8sB4olFps3M=;
 b=HDvELEgzk+xLP3MMLDEVbTMnAh5Ao2bLj1vKAvVIznzmmV02PPDdjEIZhQmvfoPwwE
 22ivXr0tNuzK+J3XHy029tTHqowOFF/X+KM8ubxV1G8mW11sCg3Gn4PXztnfjZwDjL2H
 SZ2TzXHoTEQ1BOGXgt1fduY/BK/Pgh/0PDacu3huPi/6xZVOrhf0FwzVQGy7N4H1cuJf
 8m5t+ccmzibhOhLjwI6fhZuZKYJWT1Mu6Jg8t3EA3kLhoxfNpRZB3PZ9FPnZBDO+Bu3I
 t90EjxzlaX1xdFl7VXhHE7htVQHN/tx4Nc6VLGZGwX9qxk/L8JgwqZ0buS2HhKE2TBIC
 ccnw==
X-Gm-Message-State: AOJu0YwLKCBB2udJKJ57+wxetPXRXY0NPDINfHkoMMsRl8eazDXuv6Yx
 my2qbRKjm9hjD78gSVypBG2XDzC5xr8=
X-Google-Smtp-Source: AGHT+IHivWivVSH8HfaUJ4yStCzwwkqNHF5jPLxMuVDAzjLgNKO65GMhxUmwRqr19PfNpuMsvaNPgQ==
X-Received: by 2002:a5d:6101:0:b0:31f:e761:d47c with SMTP id
 v1-20020a5d6101000000b0031fe761d47cmr7052108wrt.32.1695666524915; 
 Mon, 25 Sep 2023 11:28:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 10/23] bsd-user: Implement shmid_ds conversion between host
 and target.
Date: Mon, 25 Sep 2023 21:26:56 +0300
Message-ID: <20230925182709.4834-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
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


