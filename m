Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8427ADECF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKD-0008PF-DB; Mon, 25 Sep 2023 14:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK7-0008Gj-ME
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK5-0007my-RJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3231df68584so3244995f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666524; x=1696271324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=koXJJ+L0QVqolx11GBZeb9W6QCFbFl0rpZOg5VAkug02p0am7cb/OZmxvwt+40yDjT
 gQUgMTPhfyCtzohNCONoooDg+tbPvabhSmV0APuksrm7dOZ8VXRmxn7pXxFlAX07ZeKp
 +JNyM3d0aN/68xvsEGf6NvGMP6bY12zS88l8VMq1EmOJo1cZczQTf6a6mmN8bGzLjks2
 TevRgpXzDR0OTEIfIknvaUuDw56vhH+BtinWPsmq9wRqJ57aCHvqTWMRGmuSkoJt5RjS
 s0YLDyMJm/n6E88t69PWoyo1uTQgB6W/BweOB2LFr+wpwYIB2NawIWXmRSWVVW/YNQCj
 /2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666524; x=1696271324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=EqNp1pzen+JpTR+WO2p3ysMBz48i7oq/S6ftNo1Ae6PhFZufpdrYA4N4z+g/xKgyXu
 yZo/AdxByWL9J5lbmRh+0CZLnmF9XRCoYXzXyj2SPZXOxgXLdK3Rt1Ca245aN9W3NpT3
 ozQEFjzcy9CdW3KU15CFjD9mvAUsfyhqm7MWzx5Gy5817uKDpUWWT+hwlljgxBdzfiEV
 g1xD4LM6QQRfNw3H1Y/Kt7GaPl9kuwenUzn3VD3Tk9Sj2lZYEjcmR32jc+xadl6WJXXg
 3yn0Lpw+xnOg6FUgJ61889UYzZfddLcw6/S85nkdWmnEquRiH3t8aiQKMZEl7OW0yOwi
 1/ng==
X-Gm-Message-State: AOJu0YzjMtQ6vU9I7i6iLFnhMb9zeNrfwVwS/W+hkeI/Pe27fLIerpL3
 RzShjr+dypfhNDCcuww+KSBOANOdwe0=
X-Google-Smtp-Source: AGHT+IF45hvB6I+03aukcjIygyddafw4yWMGQp+Vd1vissT6yRY8wfVhbqP0jg04ObT5GKDGRigBfg==
X-Received: by 2002:a05:6000:a19:b0:323:1d8a:3d87 with SMTP id
 co25-20020a0560000a1900b003231d8a3d87mr6378052wrb.4.1695666523668; 
 Mon, 25 Sep 2023 11:28:43 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:43 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 09/23] bsd-user: Implement ipc_perm conversion between host
 and target.
Date: Mon, 25 Sep 2023 21:26:55 +0300
Message-ID: <20230925182709.4834-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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


