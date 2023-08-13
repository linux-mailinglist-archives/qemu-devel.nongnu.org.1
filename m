Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9477AAF5
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzi-0007os-PS; Sun, 13 Aug 2023 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzf-0007o1-6F
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzd-0002Om-J0
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:18 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so32837675e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955796; x=1692560596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifoCtKg1yGM9PYJTvZyGZBbRR1jmyTpgo6v/+2GRTtI=;
 b=YzhCEmm7BF5SNyzz3ETB8spvmGorVBRwhSrVTVBvfiwaMs+pFVNarn5AaP+N7CRFKZ
 J6auRnVudonAjSGhfHLupxSJ6m6dVkQ6pNZo8hJPFA8EcZBaHM7Sp9LI6MNCjktWeB2Q
 Utw/ZGwyd3SFKFDzwy3PpN7YTH9ZhZNMdLuRD3YDCQ9c7ZA8dHf9GgYHazC1RR1HbBRI
 zdht5LTQyDa+EE7owkl7UNsFTZeZw+jDMlqyyQkxcJnrVFuPSqXPty0vYBOqsUOH+Lov
 o9xGprGEQx4Y/DZrtO0lj8nZSxBX9pd8pFZwpN2EkQaP8QBSMhaBID2N854WGKQ2CWH8
 eXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955796; x=1692560596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifoCtKg1yGM9PYJTvZyGZBbRR1jmyTpgo6v/+2GRTtI=;
 b=Hz3G8grY91N3yOgUKDTprkL83gE+hSSWVuCewsOBrDIZAzp43CB7qLk05eyXOlUgeu
 o0fksS6WQkZXb7r0jEU9dSfY3gNhQGpR5JIyBvzte7BEoVf7FXQk1gu15PZLdmXZHPcS
 t0WlucAu51Qw36lJeVdRzE/uy+4/NX8MnCpWJ98sAL7EFXo2spfJKCe0OyDfET3QhGVF
 QJ1WrEimXbhAE5Z0YGfWl8IU40IOrEKuW0WFjy4hrBcJBQTJrm+YDlihXE/T+EoMazHT
 UiiupjBMPFOUZVMSssiTv8zIya6eEEFhURBFrvjrA/TJlu3kOD9zLvwyCKUo8vop7cuG
 eBTA==
X-Gm-Message-State: AOJu0YwI7kfz45lGSzClTvrH1YbRYIUv39XyF73FciP6Rx0yKuhWKA63
 gpNKm+fh5KVsprWXL0dtD9E0GKR/so8=
X-Google-Smtp-Source: AGHT+IGbaj2wATIqDjuDsjO8jsv4aWJynKL7YSHpv9TjJugN0nIhQBEjYxyNz9xRueALbikPXkwkvw==
X-Received: by 2002:a05:600c:2041:b0:3f7:3699:c294 with SMTP id
 p1-20020a05600c204100b003f73699c294mr5922596wmg.29.1691955795758; 
 Sun, 13 Aug 2023 12:43:15 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:15 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 13/32] Implement h2t_freebsd_fhandle t2h_freebsd_fhandle
 functions
Date: Sun, 13 Aug 2023 10:41:34 +0200
Message-Id: <20230813084153.6510-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat conversion functions:
h2t_freebsd_fhandle
t2h_freebsd_fhandle

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 8c73f7402c..6716cee3e2 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -92,3 +92,40 @@ abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * file handle conversion
+ */
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_READ, target_fh, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(host_fh->fh_fid.fid_data, target_fh->fh_fid.fid_data,
+        TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_fh, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(target_fh->fh_fid.fid_data, host_fh->fh_fid.fid_data,
+            TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 1);
+    return 0;
+}
+
-- 
2.40.0


