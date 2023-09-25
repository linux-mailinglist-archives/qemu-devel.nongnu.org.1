Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779557ADEEE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKr-0001vh-1H; Mon, 25 Sep 2023 14:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKM-0000Ve-J4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKK-0007rL-Mm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:29:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32179d3c167so6069488f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666539; x=1696271339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlFBXfrUelyZD113NpgkyEi3DkcrK5mWFFpJAPBaArs=;
 b=fl54vCKeifTHrJddr30yWPdphbuoBH7siJhgCYzEvWXXEMn3+dT/VkwXKFczWUYfik
 UQQoAxTXy9ZUbOpafZCC4IMs/LkiSwOsgCH5IbfT1IdsOy4QlGFQNSCxFqNQdsgxwwC7
 NrFAjWyJoimNHRGGp2aUgfcUtPDuTA7mkmL+U5FpkT6DhjSRnOEXPtXDrb9g0Yo2hxho
 cmxm/GUqPNbLbmqsLHa0OG/nQXfQ0LeHCQGZvDslcABFgYVheeTLTiJzZpmL1vm1YXyP
 VUw/qhyjfhIOlXJBhVh03M6VfP+QV3AES4G/oK0TZrVwESqAOxo9qlL0uAfPvwchGJ7t
 0T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666539; x=1696271339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlFBXfrUelyZD113NpgkyEi3DkcrK5mWFFpJAPBaArs=;
 b=nWzvMPXajwHCHfR7nPICXQ73bFd1w98HGWeKANfACIo0aeWuL9g5bMej7syQnHBPLi
 x4igeGIQuE8+rQdX7XXQOJrkxbGIOC7GSlMqS8P24dgSMEIz2Y01zaF7pd3PeJvdJqLL
 Q8YmJj4NQ70Ku9M0n72I1hET2i1i6z0zOP7EIelpIFUNeMjhptmlbfi1dYBV/gYz50Vl
 QJB3k8VWGxr8eJp510IKy6xtM1R8gvhW35HZARA8GGb/uVyavqwxPoC0M5YHP978bZyW
 7oRZEU+oHELgdJ4KBBYlcNWMiOCnnkn1vAUqA83T8Zvl3uQh+ghSWGhuKRLHulH0JKyN
 JkVg==
X-Gm-Message-State: AOJu0YzxrYUUgytQMka8ih86Yx7zhnKoWwibneV9xogQtlxpemfMAJ6k
 uFgfphNZSKim0eidHgA5J71/XGEF7pw=
X-Google-Smtp-Source: AGHT+IHLw8wRzELDxA3JFOshkstWvRG8m5NOqqzSit33sFLynbF2whI2R2o6bSGjvgXN1BnzKiww2g==
X-Received: by 2002:adf:ed12:0:b0:31f:f65f:74ac with SMTP id
 a18-20020adfed12000000b0031ff65f74acmr6908736wro.70.1695666538950; 
 Mon, 25 Sep 2023 11:28:58 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:58 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 21/23] bsd-user: Implement shmctl(2)
Date: Mon, 25 Sep 2023 21:27:07 +0300
Message-ID: <20230925182709.4834-22-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
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
 bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c362cc07a3..b82f3eaa25 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -305,4 +305,43 @@ static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
     return get_errno(shmget(arg1, arg2, arg3));
 }
 
+/* shmctl(2) */
+static inline abi_long do_bsd_shmctl(abi_long shmid, abi_long cmd,
+        abi_ulong buff)
+{
+    struct shmid_ds dsarg;
+    abi_long ret = -TARGET_EINVAL;
+
+    cmd &= 0xff;
+
+    switch (cmd) {
+    case IPC_STAT:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        if (host_to_target_shmid_ds(buff, &dsarg)) {
+            return -TARGET_EFAULT;
+        }
+        break;
+
+    case IPC_SET:
+        if (target_to_host_shmid_ds(&dsarg, buff)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(shmctl(shmid, cmd, &dsarg));
+        break;
+
+    case IPC_RMID:
+        ret = get_errno(shmctl(shmid, cmd, NULL));
+        break;
+
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f0ccd787e5..664b8de104 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -663,6 +663,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmget(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_shmctl: /* shmctl(2) */
+        ret = do_bsd_shmctl(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


