Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0C7740F4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDZ-00024h-5e; Tue, 08 Aug 2023 13:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDW-000208-UL
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDV-0003JN-Co
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31759e6a4a1so4429053f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514595; x=1692119395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6FMQxw39lF+gWqvJhrkgTTftm0yHSo/M+RjL0FvL48=;
 b=GbK0NriwK3ktC1k5P24IWif9dYt0SFk52wrNSYj21DHOQpCm+vHsi4f7LBFDLT8Bxd
 UtvHJZOBvxXZk+vS7HC5sgkDmNJSiHbLNfp3X5vzfldBIDLE1iTiZ1TSdG0DO3mYcojD
 y4Ivphdw4jgz95j7DdPLiIjYNjtSsaxUTgvIa3NgxdoFz8HNTH0Ij8golYOR7FzOWpAo
 DB9nPRHux/0cJokLL+z+AYx19RJSWQq/buncmLA5MFDg5l5acLDlN+wmInE3GraweoL6
 72tZRgeeYtxNHt383NLByS9QVksBIdx+wbL2cr5luX30Ql1zO1gVoQTQ01Ru0md1yxIU
 cvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514595; x=1692119395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6FMQxw39lF+gWqvJhrkgTTftm0yHSo/M+RjL0FvL48=;
 b=BZKa5L8aSNDBdg0pP8f+wv5CYhfXIp9LLB+slaK3EwaUe+aL+vW6jC72VphvMe0BL/
 6urR5Bpm5xoDMHbfivIS5fhJruah2g6CPpOyhadhiDG+d+NeulSTl2vX55DT0sfSkdsd
 9eQJJAEsvwNP6fh8spUFy8Gnp+QlLKKxn5gqc87Eat1U63+UNVDjLb/gwpDPlATh5jsJ
 AHdVSX/Z0yllTTZzMGNTRQ5HX2Zw+SlHgoDo7lbjuKYNhcrPDLR2DAx7DLQtMfUPjEv5
 1qyeEa1VCvP6hMyx2LW7P1koz8Jngfhq0v87PFlSsOQXFXuqCTjLcT0IEnC+HfmZyH66
 CoSw==
X-Gm-Message-State: AOJu0Yyazolpu0qn1W7wecFVEs8BBzT/TjX+4XTXcKgh0SPBW6fXT88t
 Kc/MRQmMB6222ZCI0KZgA+WMqQkoE54PJA==
X-Google-Smtp-Source: AGHT+IHHq8MR7f3fnibOqiZr5j5Wg07THLNEeTH5CPNqoOXmpf1nemvE3KBNWjBrMxD/9UjSlppz+Q==
X-Received: by 2002:adf:eccc:0:b0:314:11fe:c72e with SMTP id
 s12-20020adfeccc000000b0031411fec72emr62925wro.46.1691514595472; 
 Tue, 08 Aug 2023 10:09:55 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 15/33] Implement host-target convertion functions
Date: Tue,  8 Aug 2023 08:07:57 +0200
Message-Id: <20230808060815.9001-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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

Implement the stat converstion functions:
h2t_freebds11_statfs

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
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


