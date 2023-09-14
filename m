Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B851E7A0F36
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtB0-0003YY-IP; Thu, 14 Sep 2023 16:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAx-0003WS-QH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAv-0006Rh-PG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-404571cbb8dso12249925e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724176; x=1695328976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EwEtIsp5qS7pkISguftTlvIQuUZ+Ff4kRu6nEkFX1U=;
 b=ViUiuZdbHRc5fi4m45yRcPJudfCKvmizwBk0X/iu3V/7M97PGzdu+v5GKC9KEt0IsZ
 C8f7MncABQx4Mbp3gUTeIglxHe+ZmGf0Oe5zaITY+fJp6/gw/WuCQ4sAIlx2rYyp1NqS
 a4B53OKDp1w3TJB+BpVawW19csbk7jandro8817KfnZUhwhylD0BzKStdOQNWAFF1QS2
 Wi+oN3yUiSBOcVM1FNNdHRx2v+tF2NcVJINg49Z4z8T6I0pZ2Ni3cJScwjXNMrzE6VzF
 Xp5zmj2SJ3UQBAcfdBydONCgnuo3JwRuwE1SwzkxZXNopdGon9Jpr4aNOWN7Y3Wo7IWm
 ByTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724176; x=1695328976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6EwEtIsp5qS7pkISguftTlvIQuUZ+Ff4kRu6nEkFX1U=;
 b=HYPSRtteKMDoI3EP3w46jgxsHsXiDgnsqMMxSPZmlfKkn0pCfpXR7E5pUpeyJPLyUI
 +pWdG0TcVKiern8BFKGOp32wXYlsfvAHEFl2uFtD7S5Ku87xt6dC/CK4i5aChLtKxZ4H
 m4q0di09JGkGCCYt4swT9WzI8iro6ZSzNecUs/qiP0OGmTHtSBYFprOWp8wPgXhLOsyC
 YHUTJRU04acYVMJROWV+4Y4HMvfkHvX4fKxL+ydGITHUQYUpFhxkr6oMCiYPFjAwNg2j
 m+0fPX3UIjoELhB+RULwsaPsSlEpeoG1NbajP+i3vDplbNH9sXLyOn1CnUG1T0s+QStE
 ZHyA==
X-Gm-Message-State: AOJu0Yyrw9/O2JJuwi4eUP/1oib2olQTE6qUasiJq3+jF3//mu5T6yuA
 //8lCDszfzSdpKiVSMqgYqIC557F1gc=
X-Google-Smtp-Source: AGHT+IHgqXdpQlw4X14EsLMT9TmQZFcj7LCXbCttavMZrq+4rh6fMfFMdhEw+w+UWWVpcy1DrC3JAg==
X-Received: by 2002:a05:600c:221a:b0:401:d3dd:c3c with SMTP id
 z26-20020a05600c221a00b00401d3dd0c3cmr5346668wml.39.1694724176063; 
 Thu, 14 Sep 2023 13:42:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:55 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 20/23] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Thu, 14 Sep 2023 23:41:04 +0300
Message-ID: <20230914204107.23778-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f8dc943c23..c362cc07a3 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -282,4 +282,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
     return ret;
 }
 
+/* shm_unlink(2) */
+static inline abi_long do_bsd_shm_unlink(abi_ulong arg1)
+{
+    int ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_unlink(p)); /* XXX path(p)? */
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* shmget(2) */
+static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
+        abi_long arg3)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index effa6dac54..f0ccd787e5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -655,6 +655,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+    case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
+        ret = do_bsd_shm_unlink(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_shmget: /* shmget(2) */
+        ret = do_bsd_shmget(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.42.0


