Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A13799AA1
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3n6-0005zo-OU; Sat, 09 Sep 2023 15:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n3-0005yS-If
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3n1-0003EP-E3
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso34427265e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288322; x=1694893122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31oTqmQfxy5Vixb6rYMspPtmbe4ijKJWcWRToEaaBS4=;
 b=XH+yYszl5V0cpklQPJMWlDokm7ZMM8NHp4OR6L5Kleaw38NMaQ3cvK4m+T/lZ8szti
 IY51jyAemFgaVAHdav7Cn7eXT+jg0xLC8o/7M45ehRhekGiRT0iIht4SM6/bVequBHM7
 HbKft43ogDbgkG3BvhjcHmm/8Ws51XTYM0mx8XXB6R5jgneMc5yez7w/8Mv7pTUiE8B9
 x4M0SiL3RWnyJ5KSR/tGbklqPnkPyQQZxeE8aWIzJVcSnCvfnZnRUsj2oMkYPZDGQcMF
 fVPKCnXMA33+OEr9NUKnKQvjRmnUwEJHRhxVA/+q+GGas/PdB1zJWbKkugcz7TrzQRB4
 pADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288322; x=1694893122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31oTqmQfxy5Vixb6rYMspPtmbe4ijKJWcWRToEaaBS4=;
 b=iP4rxOdte9q8NcoPNQIoE4ofjqWtWqc5mciWKRABayCuVqoApLTNwuhipBL7PrlKep
 lVsGwQ1DZmYxRJc4mX92kzzh/5v8QDNOiPnwOwWY6BSZHQcJ7Ku7DI5BIAbx75lUdPRb
 xH4zL+eiGi35mLlqk1OgwHzdKgB9i+sF0lUq+wQptGlTSj0K3QnyT9QmBThaRUA4R+Bg
 eRxNh773wT/w7FUfe4podig0AImKD3m9CRBfprCPA8fSWpyR6kkYEwZ/qDswkKgqDd6M
 ftTsUUO79j1OFLLhHgHK+L+5/ShqBM4FhGMcy9Hb8nJ6R0gKxcU8s6vVMBkzomcKNBrA
 iRgQ==
X-Gm-Message-State: AOJu0Yyz8S9sfZSC/dVdUDFmHUSbWAP6tti1Q+0VMnGHM2YxKiwU+WB3
 jFr6MG1x/zc/AqGsvueQ5cGtZNmrmPE=
X-Google-Smtp-Source: AGHT+IHmvlO3uA0eZQc9IUn3KmETNwVwdwjMAwImMZS/Hl7VOco248m4JLurp650CeC9hrAtkuSXPA==
X-Received: by 2002:a05:600c:2202:b0:401:cdc1:ac82 with SMTP id
 z2-20020a05600c220200b00401cdc1ac82mr5178705wml.9.1694288321699; 
 Sat, 09 Sep 2023 12:38:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 14/23] bsd-user: Implement msync(2)
Date: Sat,  9 Sep 2023 22:36:55 +0300
Message-ID: <20230909193704.1827-15-kariem.taha2.7@gmail.com>
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

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 11 +++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 0f9e4a1d4b..5e885823a7 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -88,4 +88,15 @@ static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
     return get_errno(target_mprotect(arg1, arg2, arg3));
 }
 
+/* msync(2) */
+static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
+{
+    if (!guest_range_valid_untagged(addr, len)) {
+        /* It seems odd, but POSIX wants this to be ENOMEM */
+        return -TARGET_ENOMEM;
+    }
+
+    return get_errno(msync(g2h_untagged(addr), len, flags));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 127805e079..859492dee7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -499,6 +499,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mprotect(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_msync: /* msync(2) */
+        ret = do_bsd_msync(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


