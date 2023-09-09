Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A8799A94
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3nB-00061h-Ev; Sat, 09 Sep 2023 15:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n9-00060L-57
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n7-0003Fp-1t
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401b393df02so36663995e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288327; x=1694893127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX+7Sbgns+rSwompoLBGZfd8MuLrC9uQYC/4gYAWdEU=;
 b=aLhzMTnhyq/D0x/8Eh/Kk8hZBHp8Afb98AioJ5nqj6EcHiNJ4yje6WmIZ9mDLC25Tz
 z7D+LC2nSPRWKoq9VjaaTJd8w6/RceVDsDFpIdh7hYhoEK+GgWbAgpzknIzhpe3JZd+L
 rpnj4iyV3aZI/qPhXO8fDizqHq8G+HUf3n2P7GwBuC6vqNwytRglpWmS29BhGmSVTUtz
 WI0VyP0lU6BmjCE/Gmi5WSVhbVN8OCtwX1h0F3oZfFWh0+DhfOGVw/30F5cHqb0J4t0J
 R4SsJ8gdF9B3yQoGySwfktDN570bOXSwlG/UkQhN7qAqJvUQrm8rp+/7ZDtmXNkttm3I
 tnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288327; x=1694893127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX+7Sbgns+rSwompoLBGZfd8MuLrC9uQYC/4gYAWdEU=;
 b=SjzlUqrGf3hR86PYNE7iewi8+mEftmOYcvIHnWhwXDObTvsIstUNBPQ2ENPacEq07e
 2VpVCwsDuU4Paug/ZGw8djS2ra5vGNyk92cpRzcTVqpQB/vh1lxIJG77zm0Xl1hC0khe
 4ytd94kuBBjzBHekFfed8Opq5FnA8pEmLv5zK95/8OBkEZsXuaLXYT2T6UKq+AascfFr
 yX6M0H6/OimgPwQPbvnwJtklIvLcmZizAHfs7zyCAtTm9JJKYVOGBYbTzopd770MHbLw
 XtorL2VHgbPMFfv2l74yn+xtRctD1dEYCJDHVRcDbdjflp+nEBJrBcBUmijQyt4eclnJ
 GIKw==
X-Gm-Message-State: AOJu0YzmdOiQnXYl62626gRpwN54XmXoRV6GH11PHEjIggdiitTQbXMN
 3Iv4MWnXtoSk7+M3UNRqYUi7XSWyadQ=
X-Google-Smtp-Source: AGHT+IHwNZ2hC7mSO/L0lsTDeyD39tZCfwGD7GYs7oH1qevJtMibSHcp9zRwQeNtF37Hh2pt0ylWqw==
X-Received: by 2002:a7b:cbcf:0:b0:3fb:fa9f:5292 with SMTP id
 n15-20020a7bcbcf000000b003fbfa9f5292mr5006345wmi.25.1694288327369; 
 Sat, 09 Sep 2023 12:38:47 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 19/23] bsd-user: Implement shm_open(2)
Date: Sat,  9 Sep 2023 22:37:00 +0300
Message-ID: <20230909193704.1827-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 25 +++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 563f82996b..a48f919ff2 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -256,4 +256,29 @@ static inline abi_long do_obreak(abi_ulong brk_val)
     return target_brk;
 }
 
+/* shm_open(2) */
+static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
+        abi_long arg3)
+{
+    int ret;
+    void *p;
+
+    if (arg1 == (uintptr_t)SHM_ANON) {
+        p = SHM_ANON;
+    } else {
+        p = lock_user_string(arg1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open(p, target_to_host_bitmask(arg2, fcntl_flags_tbl),
+                             arg3));
+
+    if (p != SHM_ANON) {
+        unlock_user(p, arg1, 0);
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 8dd29fddde..7404b0aa72 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -531,6 +531,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mincore(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd12_shm_open: /* shm_open(2) */
+        ret = do_bsd_shm_open(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


