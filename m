Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22979963E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfr-000191-8D; Sat, 09 Sep 2023 00:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfg-000189-Uw
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfT-0002yU-OX
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:34:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso28587345e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234037; x=1694838837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX+7Sbgns+rSwompoLBGZfd8MuLrC9uQYC/4gYAWdEU=;
 b=LYA/rNFNXzhJRTDHnP/VJxaSaexsM3SHSUXsASn9gXfxdAZ1XTFaOANZQDC3dwq4bu
 4OAPY2Vrh+pTUOo4hxYPDGruIHKWquVZih68l2kgIeotZKBP5EFgePafbsfYsIP7KUpm
 uIPeanMiLb2SppEE9oWTOwRs9RnBgpE+xyHJFfnO2gTbIbqPAjg766YGKVihZouTNqHc
 L+6piRS3IqNlgYvduLc5A7Uxo3wbLXLwYaGoEsUUqfo9C9kJypb6Ha8eyImUwzzCOdsY
 /7iVBOn4fraCsfm8lc8ETlaG2FTuJCGCjo8u4DAlDlgaICs+2srMUJMTfuzLt0IqTrja
 QRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234037; x=1694838837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX+7Sbgns+rSwompoLBGZfd8MuLrC9uQYC/4gYAWdEU=;
 b=JxaSKyfe9uivjXUlK09TXuboiqHJoZrkofxriTLh0KCA6U3RmjjRF7nEQ9/caHd2CD
 j77NvprzVQ/jBF63ibXJTTtiKIr4S7cxDzOWGH7gvrTGdHKiuLDbo+MQh/P/33yzvC1C
 8ZfrhjVJBmmBZn0lm3YCQkp4H1M03Zbvi+jSKsZffmZH4FWb+w0TXL6krAp1TsAUee5F
 TSQcshLCuEE4ggitbeMyWOV7tKa5WbR+QNuHTPPrlLNLz8yo691VKbxTZf18XIDeC8Dn
 0ny3FoCuirYhkJulU3fb93bC5SxxE7w8Om4hIrvKVQgL36xmOQ+foYl67KhAAxd0CSpe
 ptoQ==
X-Gm-Message-State: AOJu0Yzmyg8MhUSeF0sCc04HxShTExn+JCU/wlRMNPyPIhJGoGbJ+QbM
 K97Pywp32yWOmoemTA611dqofJOkXfU=
X-Google-Smtp-Source: AGHT+IE29SppKtWAP1cO+4FAqCktDotOi8aTc8gXwhUiH+BZvULziqU9qhLN1EPEnaEjOTvGYwCOrQ==
X-Received: by 2002:a7b:cb8a:0:b0:401:73b2:f039 with SMTP id
 m10-20020a7bcb8a000000b0040173b2f039mr3661124wmi.7.1694234037201; 
 Fri, 08 Sep 2023 21:33:57 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 19/23] bsd-user: Implement shm_open(2)
Date: Thu,  7 Sep 2023 09:42:58 +0200
Message-ID: <20230907074302.79234-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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


