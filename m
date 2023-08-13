Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ABC77AAF3
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzi-0007oh-0Z; Sun, 13 Aug 2023 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzg-0007oU-E3
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGze-0002P0-Ge
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso33078545e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955797; x=1692560597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZm7KAKyPJJ5GYxiMh2TRpYvzF8zdBBBHB1AfPsS1dk=;
 b=m+BPXfCBjyoYVP+Z9fqPtBZdNmlXQrr7ESkMX21NEnwqakOzNRXPNAqP0IhEjUVDZR
 sAnAIUBuABMhMkMEl/qWDiONJq3vbXVa5Otz7kX7dF5B5vvV26grT5S15J/nrwNvVGZi
 vx2/YYvBG1NNRux8smN84Y5RyAJmKeK8I+orkLhKl1vk/u2HQJd2ZdoKv0a//BDtPUjN
 EQ31/EgPYqicxvdpOlhKHJA4ih4rnbx5ptluPZrmtQtfv+8pq6roZoahlJzecqBwVPfe
 nJlRbNqlgGPCkh82I9CUophtIi5z6ZxdT6RCVucirQWU2zRVPO9UeVJSxvJPIst/QeZg
 icIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955797; x=1692560597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZm7KAKyPJJ5GYxiMh2TRpYvzF8zdBBBHB1AfPsS1dk=;
 b=P1jc41DyCRo14pR1P+ysmzwr2dUBgJuxQKicLxMfeJ3I2sbzSEK0rhiKX5RBYbw1YV
 DxscUjnm+PZg8UdhuwQ8H5kja7a1YsIaf2mtAq4Ig1p9o9In21RIJcsMqW2QdoG3gGO1
 cQPlDK5/uQ2qEMi3YrvPl+jP81Km2i+iBKu3toQITtpj02JxaBOjgl4lseeGaHkkoHUt
 4l1IMTlcX8MpavEXRwTCWJTXIMv3AebiW7M8XTzhbJjynRbUAR2+tgWkyhBiB7KSeuKu
 879LLsD8SPm1KaI6j+eg0eC8fGBzrt7r2jwAIc+nw57nkT/onOIivk6oZmxqB3aifVHq
 OUtQ==
X-Gm-Message-State: AOJu0YxsX9eyywDxKoEP/E+uUlksDmCm+UTxp3KQsHlSjdLPeOwPCowO
 jF68LLgQKym6m5bQCfktVk8wS5L512Y=
X-Google-Smtp-Source: AGHT+IGHoxxhwJ3OM/uuusWTb9iuE8VaJ6WS5pMGaNagr5qKS/xP5lxjB5LQAoSz8z1jNPB8nxkrwA==
X-Received: by 2002:a05:600c:2983:b0:3fc:dd9:91fd with SMTP id
 r3-20020a05600c298300b003fc0dd991fdmr5286747wmd.40.1691955796847; 
 Sun, 13 Aug 2023 12:43:16 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:16 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 14/32] Implement h2t_freebds11_statfs
Date: Sun, 13 Aug 2023 10:41:35 +0200
Message-Id: <20230813084153.6510-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
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
h2t_freebds11_statfs

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 6716cee3e2..9eb01bf664 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -129,3 +129,44 @@ abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
     return 0;
 }
 
+/*
+ *  file system stat
+ */
+abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
+        struct freebsd11_statfs *host_statfs)
+{
+    struct target_freebsd11_statfs *target_statfs;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_statfs, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_statfs->f_version, &target_statfs->f_version);
+    __put_user(host_statfs->f_type, &target_statfs->f_type);
+    __put_user(host_statfs->f_flags, &target_statfs->f_flags);
+    __put_user(host_statfs->f_bsize, &target_statfs->f_bsize);
+    __put_user(host_statfs->f_iosize, &target_statfs->f_iosize);
+    __put_user(host_statfs->f_blocks, &target_statfs->f_blocks);
+    __put_user(host_statfs->f_bfree, &target_statfs->f_bfree);
+    __put_user(host_statfs->f_bavail, &target_statfs->f_bavail);
+    __put_user(host_statfs->f_files, &target_statfs->f_files);
+    __put_user(host_statfs->f_ffree, &target_statfs->f_ffree);
+    __put_user(host_statfs->f_syncwrites, &target_statfs->f_syncwrites);
+    __put_user(host_statfs->f_asyncwrites, &target_statfs->f_asyncwrites);
+    __put_user(host_statfs->f_syncreads, &target_statfs->f_syncreads);
+    __put_user(host_statfs->f_asyncreads, &target_statfs->f_asyncreads);
+    /* uint64_t f_spare[10]; */
+    __put_user(host_statfs->f_namemax, &target_statfs->f_namemax);
+    __put_user(host_statfs->f_owner, &target_statfs->f_owner);
+    __put_user(host_statfs->f_fsid.val[0], &target_statfs->f_fsid.val[0]);
+    __put_user(host_statfs->f_fsid.val[1], &target_statfs->f_fsid.val[1]);
+    /* char f_charspace[80]; */
+    strncpy(target_statfs->f_fstypename, host_statfs->f_fstypename,
+        sizeof(target_statfs->f_fstypename));
+    strncpy(target_statfs->f_mntfromname, host_statfs->f_mntfromname,
+        sizeof(target_statfs->f_mntfromname));
+    strncpy(target_statfs->f_mntonname, host_statfs->f_mntonname,
+        sizeof(target_statfs->f_mntonname));
+    unlock_user_struct(target_statfs, target_addr, 1);
+    return 0;
+}
+
-- 
2.40.0


