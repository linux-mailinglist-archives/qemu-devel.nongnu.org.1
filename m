Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866A3799AA5
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n3-0005xw-Kl; Sat, 09 Sep 2023 15:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n0-0005x6-Rz
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mx-0003Dm-0Y
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso33587765e9.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288316; x=1694893116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iussohd3oOsJrjsaObP8RqGbhTo1pjSye6BxeJlFWe4=;
 b=q5CoJV/SDQhvMOV45mOQex9IC8PiVkxgebBSS5Oe1hgFitGBMibzbLDY7yWoaY5Q9l
 tVXIDEtM8qxhHxBiySyx66FGL4DvN7p6HCo/o41ijGOrFq2PKrKb8utTuidZqObXA5HE
 CqjpkfhP6bxn+he5X0e6sM6s02Rzj4AISleaF9Fj2Vffkaf42gfgjKr8LjWWR4w61hvs
 ZxbAP626VBX3Ka9ExTIkzIk/92hoOuG9mSlnn9L7f6AHJjHggvY2Pls1iAZpX27E5Ij9
 12pPWjlq8bIcKI+Zz/TYgJXBAw/s4fNP0M9b3AhgEqQnzdJ1VsDbIUqAQaA2D3KA/EBJ
 bDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288316; x=1694893116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iussohd3oOsJrjsaObP8RqGbhTo1pjSye6BxeJlFWe4=;
 b=Mi8Qc+qGQtoKcxR1+lYUUNScFGKhBo4tixWZNZqZyB3KH48itQHVWak4R6K4+2wFBo
 PzO1n0YpqhSnsh+jR0wNddX7g+SToPn+ciBDPjfM7eNwmasAQnDs3NsdSgcejXtdEtR9
 FVcBsnbGo2AAiROAEkZJcjKS0+JAROZ7b8nJc/4TKIV76a0qCGsz9MCgDJWRKI3pvapR
 YU9MDapqSzkOPnWkVbySg94oDNLWtfQW6jj2Epnvnp6wVnaoQdA2ZKJUfIlKlg1lCRBI
 ZJ8BYc6ahId8Rvkjq84Tul2FZJOYsc6C4ux0FbNeTgm/qADIOefHqFaHixX9TOsBpUzY
 XmRQ==
X-Gm-Message-State: AOJu0Yz8KsVDQlNU/1w/9OcBKKtAwZazTlxkrHSZq2IkNS1BOZxo8LPm
 tb9nNC/6vgo6jtFkHMxIMX1gGZAp/vY=
X-Google-Smtp-Source: AGHT+IFXTwyghCCw0SKozruP043bD099ZAC6iXS5szSmu4XlKfAdcVnxo4dU1KAjOfKTILjWhfQc5A==
X-Received: by 2002:a7b:cbd0:0:b0:3fb:efe2:34a2 with SMTP id
 n16-20020a7bcbd0000000b003fbefe234a2mr4843930wmi.5.1694288315768; 
 Sat, 09 Sep 2023 12:38:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 09/23] bsd-user: Implement ipc_perm conversion between host
 and target.
Date: Sat,  9 Sep 2023 22:36:50 +0300
Message-ID: <20230909193704.1827-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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
 bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 8834ab2e58..46cda8eb5c 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -30,3 +30,28 @@ void target_set_brk(abi_ulong new_brk)
     target_brk = TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk = target_brk;
 }
+
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+                                     struct target_ipc_perm *target_ip)
+{
+    __get_user(host_ip->cuid, &target_ip->cuid);
+    __get_user(host_ip->cgid, &target_ip->cgid);
+    __get_user(host_ip->uid,  &target_ip->uid);
+    __get_user(host_ip->gid,  &target_ip->gid);
+    __get_user(host_ip->mode, &target_ip->mode);
+    __get_user(host_ip->seq,  &target_ip->seq);
+    __get_user(host_ip->key,  &target_ip->key);
+}
+
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+                                     struct ipc_perm *host_ip)
+{
+    __put_user(host_ip->cuid, &target_ip->cuid);
+    __put_user(host_ip->cgid, &target_ip->cgid);
+    __put_user(host_ip->uid,  &target_ip->uid);
+    __put_user(host_ip->gid,  &target_ip->gid);
+    __put_user(host_ip->mode, &target_ip->mode);
+    __put_user(host_ip->seq,  &target_ip->seq);
+    __put_user(host_ip->key,  &target_ip->key);
+}
+
-- 
2.42.0


