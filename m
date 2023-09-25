Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5947ADEF1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKH-00005F-6u; Mon, 25 Sep 2023 14:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKA-0008SW-U0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK9-0007oV-5f
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso6658147f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666527; x=1696271327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz+23oIf5l7ES1zwv+zlawDrL/8dIy3f1vjxlJaYUac=;
 b=nGwdaUZSK0tUXo07Iuk7ATXlN15cFosxN54fTvPFypzsaIASXdl5sd1+Tlm4iEnpr0
 v9xvV7qo+QHada6TQM7NwkZRy91ge0VNsbhTqSkvVE/0Z/D38eBa3vBuKjgjRQkGPe89
 iQ6ghi2uXsIuh1n8IFHbNzJ3vLGbKst47g5BmdKp+YXIqs4qjItxflFUe+VochBMTCs0
 ME6rxc98u+s/hjmIz6xQa5ICGGCtebI7o3PXrOD/5ky5rIKCMq0Nyhz7xT7VbK95X9BP
 BYyNquTs1tpbERjLQa1l07dI4DGYYeH0ikQFlPkxTRZvsqjv0TDOd8zaZJ5c4OeL7APj
 dhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666527; x=1696271327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz+23oIf5l7ES1zwv+zlawDrL/8dIy3f1vjxlJaYUac=;
 b=QL/J0ulSOzV9idXKG/B3lG95PlTMgCc3yDXkDwWh4x0uONLNMn4xKl9Ffwh/bsiF6i
 qIBFxhb0VkcCi4DSB0wlnc1sZwgfH9kE2I0dc4fPKCQnUhnn1ZugouWK9VIpaQM9SXkR
 PAEbNDBpMEqwmoYnMI2WMHx2ktoNfKoyf76me8jxc0s6Ao+dsG3o+XgexPKfn17kQi7+
 DiUbWGotkmAdzq+35sGR9pYLd+x7Xyr5HSenxm1OdgolbSVAIRsa+srZoCHC+oKJiNXI
 RLVdE8C2zeiMNavZwyCp/6scR63gRoY5tm5C4iM4q0uVBRb170Y54feI5DvyAtY13RIJ
 vobw==
X-Gm-Message-State: AOJu0YzVYN+C9F7nfZVQ/K1Ce66NRwcce2Iacgmgg1rdh9GgOP8UA7xF
 xcwC8ggNHuyEPsvAnJx3tbtu7m6ktmI=
X-Google-Smtp-Source: AGHT+IEiNAHsJSsEL0lzWtEV0jlSMoGRwIuXTjt9x8cRvat/Lna+cbvRMZ3cAaoYbQERa3ovYzhSqw==
X-Received: by 2002:adf:fcd2:0:b0:320:fc:97bc with SMTP id
 f18-20020adffcd2000000b0032000fc97bcmr6299753wrs.1.1695666527376; 
 Mon, 25 Sep 2023 11:28:47 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:47 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 12/23] bsd-user: Implement mmap(2) and munmap(2)
Date: Mon, 25 Sep 2023 21:26:58 +0300
Message-ID: <20230925182709.4834-13-kariem.taha2.7@gmail.com>
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h            | 20 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index d865e0807d..76b504f70c 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -61,4 +61,24 @@ extern struct bsd_shm_regions bsd_shm_regions[];
 extern abi_ulong target_brk;
 extern abi_ulong initial_target_brk;
 
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
index 42cd52a406..893881c179 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -594,6 +594,15 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         /*
          * Memory management system calls.
          */
+    case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
+        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+                          arg8);
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
2.42.0


