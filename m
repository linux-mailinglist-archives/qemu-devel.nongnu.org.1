Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7D27ADEF2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKW-0000U2-5x; Mon, 25 Sep 2023 14:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKF-0000Am-3y
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKD-0007pw-92
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so6846724f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666531; x=1696271331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1y3QJ3NO1OpevaAaEL6gS3rKqXE25lyRwf0WEycZtJA=;
 b=k+BB9sDiPQcdPRHJYaBUbx9FD6FUTbSGHLI3hnMjcojfcMsxnuDAaRzYroXyD5d9lK
 9tUatAVamKCg0IqSILQbY6HsyGeBPdpbGCDakFOBvROPivVcNoOAndlUUJuA+ER2wl2t
 SVws5Ov5C+sFi6VYdQj1VtJ7jpKv88TYLNNSnkHLSeMCgxfPB35CBOioipJkrus31nS9
 amp+L0YX5svCqT7SuwufMWm9/M7RFx7Xx54nrg/l4kQk1lz4NzAQrB1hS2ViTwgPVM+D
 1bxE81jgRlQlGqB0ukVNYLMYz2tgo5XAXx5/Cz0a8PxDRpbWhMNhtfWuN6PSvZPdPjuK
 l9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666531; x=1696271331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1y3QJ3NO1OpevaAaEL6gS3rKqXE25lyRwf0WEycZtJA=;
 b=ICkdaNJ1wMUtyKJu4BNUsfekoPYajE4BmakVI4ybvhsGT4SMKyUrfXpyX8dpPRgeIx
 wfg4twWhEUjd/NmRX12L0wAIxCHW9OvFRWmERPcNro0a4vYM/2OZ9/jHYenqjWuJGCKy
 Mlo0aMexOThwWencnH2axTZpkiiwT1KUDSJWfg2g4PZ0n6D7yizahypJx5yRxtto7vdi
 GyvWPQFFYlwGrL6xqvp5q7GjgNhi5BkCQXIVm17GBmKKvRLKIzugTY4TNtydkLfiyhlS
 2rMQ6aFR+o0vRdS6i1Lb9KHIO359IHibumL/3beIM4h1QnduH6mMaNr4i7w3JU9Be1TT
 lmhA==
X-Gm-Message-State: AOJu0YwXkTomjlt5s7kdWpWgyXVNOI02me3j1T2wkEM7v79hUjkfkRu2
 Lf+5VsmcIcw+AbpfutK91FOU0jJvyFk=
X-Google-Smtp-Source: AGHT+IHFqZue869k7pgkCQ3FhCcmijp+r3RLuCJ5KWFWV6p7753WbaNht+15d3PAKjbSEESZNjXm7w==
X-Received: by 2002:a05:6000:1148:b0:319:6caa:ada2 with SMTP id
 d8-20020a056000114800b003196caaada2mr6809319wrx.47.1695666531371; 
 Mon, 25 Sep 2023 11:28:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:51 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 15/23] bsd-user: Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), minherit(2)
Date: Mon, 25 Sep 2023 21:27:01 +0300
Message-ID: <20230925182709.4834-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
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
 bsd-user/bsd-mem.h            | 37 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 20 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 5e885823a7..16c22593bf 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -99,4 +99,41 @@ static inline abi_long do_bsd_msync(abi_long addr, abi_long len, abi_long flags)
     return get_errno(msync(g2h_untagged(addr), len, flags));
 }
 
+/* mlock(2) */
+static inline abi_long do_bsd_mlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(mlock(g2h_untagged(arg1), arg2));
+}
+
+/* munlock(2) */
+static inline abi_long do_bsd_munlock(abi_long arg1, abi_long arg2)
+{
+    if (!guest_range_valid_untagged(arg1, arg2)) {
+        return -TARGET_EINVAL;
+    }
+    return get_errno(munlock(g2h_untagged(arg1), arg2));
+}
+
+/* mlockall(2) */
+static inline abi_long do_bsd_mlockall(abi_long arg1)
+{
+    return get_errno(mlockall(arg1));
+}
+
+/* munlockall(2) */
+static inline abi_long do_bsd_munlockall(void)
+{
+    return get_errno(munlockall());
+}
+
+/* minherit(2) */
+static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
+        abi_long inherit)
+{
+    return get_errno(minherit(g2h_untagged(addr), len, inherit));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5aebb18805..553578708b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -611,6 +611,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_msync(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_mlock: /* mlock(2) */
+        ret = do_bsd_mlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_munlock: /* munlock(2) */
+        ret = do_bsd_munlock(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_mlockall: /* mlockall(2) */
+        ret = do_bsd_mlockall(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_munlockall: /* munlockall(2) */
+        ret = do_bsd_munlockall();
+        break;
+
+    case TARGET_FREEBSD_NR_minherit: /* minherit(2) */
+        ret = do_bsd_minherit(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


