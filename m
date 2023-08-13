Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576277A6C7
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:16:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpt-0008Ey-7B; Sun, 13 Aug 2023 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpV-00088h-Et
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpT-0000qx-4p
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31965c94001so1339398f8f.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935945; x=1692540745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZm7KAKyPJJ5GYxiMh2TRpYvzF8zdBBBHB1AfPsS1dk=;
 b=DElqQqCft77jqeaKsLmRgHxTy4UzaGCHG/16q7zXqNIXwyZL6+8N9I56JjpWfAto50
 K0tZgif7ZZGmol14nSWt4BdsXxUy4zpw6ST7QVJ+XXpobiE3JWNU2JdjcvbN8EVGXgrW
 RCE34vZ/kH7ljcWnsEUYgpXRtI5OceS9ZuLFbHSL5Ss60BwPbSC+B+G/l537yYXA4yPu
 CeqvHX5gDSxFoNgW3F0AjhXaXPCgMTlf9aP8CohRwZbMI1u+haxbbmGDLu5l5UNfqoRZ
 eJUI2+L6Q97GfcYVlDwiT6466KftSUBD4aDDe9WlR0Jz1cKFFOHAsAOpACg13W01Nn0h
 GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935945; x=1692540745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZm7KAKyPJJ5GYxiMh2TRpYvzF8zdBBBHB1AfPsS1dk=;
 b=A5+qucwk+FP27pUey5+cQ4or7TN3mTNj6JXTs/xAmx1uyzN/9WRiVlk6yED8oNEFX6
 vJHeSu595+6Sk7XdL4jrOKigEo7LEqkgeQPfMFA6plsxl8QIeBCxsB+Y3uhKqEkCctHB
 LSRgRgCAApLGdvPRTcUe+0knWgWEhBxJaP8+YcpUs0fQIuAcOS250+pd3t5Rb/906Hrh
 GCKnOWnR7u7QMLy6mDLUitoERGY65B+YcVm5m9f/i/g26HlwPopiTo+kRMhl7sHfqQBx
 xgtT13UGl6UppCJsKuOwXp5Av5zDrFDAlFBw0TanMs+IFrUJD+0jdoZL9jaaUo8uRwC8
 U/cQ==
X-Gm-Message-State: AOJu0Yyf9mtMQLEJ2l7D+tQyqXAiNtZXwdnagQTf+jP+kVJnSgZ5A1U+
 0Fcpxpn1549OJuPsGpDi6RjqBnEQJmA=
X-Google-Smtp-Source: AGHT+IG15sw1WVjqhpVl+gxffdp00ycavhpo73wa15Dkv4RMxlpwFA1OtWH3G5pD6G2XaSubDj7/mg==
X-Received: by 2002:a5d:4082:0:b0:317:6ebe:d7c5 with SMTP id
 o2-20020a5d4082000000b003176ebed7c5mr4819508wrp.51.1691935945462; 
 Sun, 13 Aug 2023 07:12:25 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 14/32] Implement h2t_freebds11_statfs
Date: Sun, 13 Aug 2023 05:09:55 +0200
Message-Id: <20230813031013.1743-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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


