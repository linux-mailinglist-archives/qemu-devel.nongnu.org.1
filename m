Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5437818AC
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIa0-0008Et-E5; Sat, 19 Aug 2023 05:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZy-0008Dv-Mk
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZw-0004OV-H9
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:49:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3197a71a9c0so1805506f8f.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438547; x=1693043347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKLohNJ4jsfkvSt12B7Pqd7PyvArnsguuWML93IEGns=;
 b=KDZ2CVer4/5IPR3eN3lUPDZtsqLTLDYl4WR51H7/rgHTQYimX5CIPDQcMTf2+k7apM
 cvaDcEseiMgP3nUlmMBZTkpYyT8LdVj0/hQqkpU/pD+PW6IwbHe2zYYOXKfuntnXPykS
 oaNXvPo7JNLfSNww2ctHPfiJ9bJjOZokOYNMYQwyNW1b32QnRJmmaY3Jn3jZwwy6pMYN
 qOpG+QOa+1qBiioUMbN4QbHtH/m72xxfkFIxOcMcVwWetMCMl/yK9U/NEriv8AIgRnyv
 RkUOfoe8hTG0qcAjkGKMLD1fZ6QlgPhL05JoWRALJbcJwxYiTznA1HX+PfRP0IY/RN+J
 fwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438547; x=1693043347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKLohNJ4jsfkvSt12B7Pqd7PyvArnsguuWML93IEGns=;
 b=j4I9oUobFS7Lhd8qdO+oOXdSfCuVlJO0wzJVFxxqkHKGWWNEfe+HPE8Q3rasl2kIes
 TJMGJBvKLmz6RQqS5xZo/iZUjMyr1TjNUij4+oQicK62Hws9R/GhGKg6LvPPYfghL/AA
 NvkIRLRn4IckJXJrfcCj66K32hB6/fCFJ4FHqhxEAG+VBtWk2Ldi9ZhgCr6WLmzWCvdm
 H05WRFfH6Qn0fkq2kGmWuYf7qMyN8jmF1ch+HVoyXQPsF6+uaWP2yGO/Ra7gRgMbT0L0
 F2XDkgQ3ZGSpgTAw4DO7WJZgztTrJTKuQfkr9EAGQalZ/a9vCedlrv+aXToWBhv8lf3V
 ySww==
X-Gm-Message-State: AOJu0Yxv3NZEP1zVYbX6EhLFLrIEXvcdsyUt1x3A5tWQWRhRgwcCb1GR
 DBb9nuuExUtYUU4nmOPBHiUb0y/rKuk=
X-Google-Smtp-Source: AGHT+IH53Wp5SGXIdqYZj2zjQXTTS3rM9bAjU9ZZ1tQPF46XfhnTACXDKhyi81qpas35fQQ1imRmew==
X-Received: by 2002:a5d:4ac2:0:b0:319:70c8:6e90 with SMTP id
 y2-20020a5d4ac2000000b0031970c86e90mr925306wrs.24.1692438546758; 
 Sat, 19 Aug 2023 02:49:06 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:49:06 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 12/22] Implement mmap(2) and munmap(2)
Date: Sat, 19 Aug 2023 11:47:56 +0200
Message-Id: <20230819094806.14965-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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
---
 bsd-user/bsd-mem.h            | 20 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index fed7b7cd80..057c995a6e 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -62,4 +62,24 @@ extern abi_ulong bsd_target_brk;
 extern abi_ulong bsd_target_original_brk;
 extern abi_ulong brk_page;
 
+/* mmap(2) */
+static inline abi_long do_bsd_mmap(void *cpu_env, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6, abi_long arg7,
+    abi_long arg8)
+{
+    if (regpairs_aligned(cpu_env) != 0) {
+        arg6 = arg7;
+        arg7 = arg8;
+    }
+    return get_errno(target_mmap(arg1, arg2, arg3,
+                                 target_to_host_bitmask(arg4, mmap_flags_tbl),
+                                 arg5, target_arg64(arg6, arg7)));
+}
+
+/* munmap(2) */
+static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
+{
+    return get_errno(target_munmap(arg1, arg2));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7e2a395e0f..3525d39d7b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -486,6 +486,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * Memory management system calls.
          */
+    case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
+        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+           arg8);
+        break;
+
+    case TARGET_FREEBSD_NR_munmap: /* munmap(2) */
+        ret = do_bsd_munmap(arg1, arg2);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.40.0


