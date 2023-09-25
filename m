Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F567ADF1C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKu-00023Y-4s; Mon, 25 Sep 2023 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKI-0000LM-Go
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKF-0007qa-FG
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso71193895e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666534; x=1696271334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iih9dJ+hepR7tg2MJ1JLAU9zFKmgRDnfWByt62B4ZM=;
 b=igPvqPHD3tRjW828ye+AYHufd/yDGzORw9to5uF/d1iAjdzu2HnuhoJkhBsj9912zc
 oOdyQxRXbxERXEMAoLAY4qJBJhRCqMvEC5L01GmHDkvk+VZym9rGsTlXjB7xaUzM3qtH
 ZMwP6PAhabYBOJ9d1EP3FnPx6cZSIdyfCmotHbUvtqLr3GyBYcs56P8B2fUfUVsAv8x5
 +ptkR/HjETpcZhAMHWzr+h6q69CBwJU7kg7bgk7O8csmeoIAhzbKAaR3PVrnx0uV6rK1
 saUuJ9V4NdX7zDRSY/ortj5OfX6E1WWbfgtXbAY6a+lLk0FU5jsuEFaE/kTyNhqh3d2s
 gxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666534; x=1696271334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iih9dJ+hepR7tg2MJ1JLAU9zFKmgRDnfWByt62B4ZM=;
 b=pceqb6c8606us71a5guX3nmrBFQ838+f0i4XngUS01B0gaV+HYcczpDnKt7B1wWt0c
 zBOJa7PP6A1G8aVqK924FwIHO6XFpbFqxLHrRaKUVLhyaV9xrFA7uCnNcwaiBt2yKHLq
 77EDKiRwj/qrMGf7dCVudDt9lofGQXG272eHcrGrtyaotmpj+xKA0OAKxphTaYtZxkab
 WPqVwTPGtzyx6XXwHC64tXihu3A85PtD+DkwM4DHR8sM6IUPzsFZq/C+iOQcXZDCXw9P
 Ye5tyzHPJ9TKeKYcNFMDvZyVkwFamtVr7alOqCkDrIIZr1ISiY59yiAU/+p6AoVkjmaD
 OzqQ==
X-Gm-Message-State: AOJu0YxOkMTGNuJYCQs9VqBRfzi+lyfih4wCqI5O89nKS00cJXHCE7Cp
 wHjvks+NC9LX7F7vXHmtzjeFI8NuzwA=
X-Google-Smtp-Source: AGHT+IGFEjgs2cxPzE/iyoRHKsPJgc7iuBtatBFAUPDymP4jLOgP54SWwCWF7aXpeAs3Xkg4Cu3Z7A==
X-Received: by 2002:a5d:6101:0:b0:31f:e761:d47c with SMTP id
 v1-20020a5d6101000000b0031fe761d47cmr7052375wrt.32.1695666533663; 
 Mon, 25 Sep 2023 11:28:53 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:53 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 17/23] bsd-user: Implement mincore(2)
Date: Mon, 25 Sep 2023 21:27:03 +0300
Message-ID: <20230925182709.4834-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b00ab3aed8..0c8d96d9a4 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -189,4 +189,27 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p;
+    abi_ulong vec_len = DIV_ROUND_UP(len, TARGET_PAGE_SIZE);
+
+    if (!guest_range_valid_untagged(target_addr, len)
+        || !page_check_range(target_addr, len, PAGE_VALID)) {
+        return -TARGET_EFAULT;
+    }
+
+    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
+    unlock_user(p, target_vec, vec_len);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 600d048120..8ba5fcc6ca 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -635,6 +635,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_minherit(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
+        ret = do_bsd_mincore(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


