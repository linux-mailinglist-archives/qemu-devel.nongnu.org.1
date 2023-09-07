Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA0779963D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfm-00018f-AZ; Sat, 09 Sep 2023 00:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfT-000138-PJ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfQ-0002xu-Ea
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso27972005e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234035; x=1694838835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVDg2xAqYdL1qO9Pj5OML28yXvjot1xjk5EVQ6V643o=;
 b=gB5wjVuIk+ob99Ksn9aK2uuYeHC2nuSaHJ7feHr5x5GzehmMAjvDvaeAbJWcNgatT+
 SMhtRaE3paWFvTVBq6AieUObnQhxzMfhJYgIPg6nrsNjwBc5Fm7ybrY80+VAEF1HnQzo
 t3ekc55UYAeE1BJ0uNVUB0ztqn/URqoT93biY5mbcF6jkMMFVYo4N6/HfrkUrgJvH5jo
 ydrCyyEZReZ24lIPqju+pZc5Bh1cTXJE+00AOVafVDVVbrlm9KqP1BYnsXhzuZm8lDsO
 WASFthwIWuhuzEmQrXmlk7At9KrkJwjvYiGV0V61RPltN310MRp8ZK8noIddI44uiXIF
 09ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234035; x=1694838835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVDg2xAqYdL1qO9Pj5OML28yXvjot1xjk5EVQ6V643o=;
 b=d1c2gXzj7wkXQZOmD1ZMPHe1J6d7lG16u6T4tWR7YwVkyGQDg50e7iNzP4TwKDoy+r
 sUY0OwAmDMFQn2k0MdpS24b47QCDtJar21e/hPRBvoNyLFRsihzVQtv3PL5rRObskPKh
 S+FpEpQHW2ApsdL2KWyf4WGnat0hAJlGA2bcbsru4kWOk5d7rFsKXHfEaV8dC/Y92ySQ
 ZUyx52+kYMwPbj4bOIqP7vzJRUrh5004fTkq5bSeu7pa/Jv0jHD+Wk+2DqSwO8qZrGyJ
 GQi15m1Hpopc1/ueM6AR4x//TqdJgbRAShBPcde6IPBB1QBdEMfv9Zuq7CA5iltWxRHU
 fptg==
X-Gm-Message-State: AOJu0Yz4kuyiKd8ARzI0tpWHOyIZwpnwrdjoCL2HORJnHzk2l/ufRvml
 w9fG2oFp730StQBgkpLNp2dGfuG3ZcI=
X-Google-Smtp-Source: AGHT+IE2cbNsP7YFaBbMLwBnvcBGZlf2DWntxGCxmMIyw+W4U1p4NgyQawP9UF+Uzh/qMAEqdZlJfQ==
X-Received: by 2002:a05:600c:2943:b0:3fb:feb0:6f40 with SMTP id
 n3-20020a05600c294300b003fbfeb06f40mr3984904wmd.11.1694234034727; 
 Fri, 08 Sep 2023 21:33:54 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:54 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 17/23] bsd-user: Implement mincore(2)
Date: Thu,  7 Sep 2023 09:42:56 +0200
Message-ID: <20230907074302.79234-18-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 22 ++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0e16051418..1dabbe36e6 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -189,4 +189,26 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
     return get_errno(minherit(g2h_untagged(addr), len, inherit));
 }
 
+/* mincore(2) */
+static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
+        abi_ulong target_vec)
+{
+    abi_long ret;
+    void *p;
+    abi_ulong vec_len = DIV_ROUND_UP(len,TARGET_PAGE_SIZE);
+
+    if (!guest_range_valid_untagged(target_addr,len) || !page_check_range(target_addr, len, PAGE_VALID)) {
+        return -TARGET_EFAULT;
+    }
+
+    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
+    unlock_user(p, target_vec, 0);
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f5d60cf902..8d1cf3b35c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -527,6 +527,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


