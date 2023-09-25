Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FAD7ADEBE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqKU-0000Rv-0n; Mon, 25 Sep 2023 14:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKC-00006V-O1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqKA-0007og-Nk
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so2228771f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666529; x=1696271329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZeOll8BQ09ocoWniNo5vad8KtAP6sMIVNw1ThVgqlQ=;
 b=efZRDnTDJFR1qR0GyUO/Qas6XVSkZyyoTXOrVK6f5iqla7avHGZtqG4ojKYOKdWTXH
 y25BvyO6FkvBDustozxUalR+jHvKz7Qt7rdXra63yU67D0v1HazOMHcxSNJyioVrL0MO
 sbSJJIsVHSSjK2G/kwOyt2Em82u1Uq3Cogj4bwR1trEvdxWLG4g1wi9fE68ou5zFpiq5
 6JNbiZ4S8Gan7lFvgQUp0auuaT/jocLolKnRoc3CXDOoEKJvnHma7JgqT5wapoYDbAtx
 fkkD1YHvh3Df2UA56FScH7tGdLS0JTjktFRa5x1mjCzaREFhAQ4S0Th4pi+CSZLfY01M
 bM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666529; x=1696271329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZeOll8BQ09ocoWniNo5vad8KtAP6sMIVNw1ThVgqlQ=;
 b=W2s+OLoqBNpOaYLaH/OrphuR/UX74PHOgH9HenSG+y4GggBiH+Lf/aY6cVID6XlCTm
 RiCuoIwFIKd8eyLV3Y+D6lOEvOnoiBGfY7zBFsxJQIlllWfbxloPof4Un4AuYy3/44xl
 gRiDklamsj9fJLXnFvShqwnMoly9Rnslrt8HV8dY6extFbIuyUe1V/BUjnL2ns1VE05C
 nPpUMBeYASqb7GkuGf0iUcflYSWi6IpHhokO6BNSGCbyiKIKLc8X4sgmDYtczjPfl8io
 OehMaYU2Ufq959ZjBrfWvb1l1ZczaZ4ZytlUVkHt69RcsY2v9fziP6XvI9U1gF6A77t9
 S1Fg==
X-Gm-Message-State: AOJu0Yx0DAySKqYSO6cthLiFjZf4v6iMNXy9qQq/Ksy30gPNpWq0JDKW
 xPKZ77sqJ22UJzIydDYbhTextJry534=
X-Google-Smtp-Source: AGHT+IE6kLrCyB5Kuu3h7QHMhy9/CeQhuC1ke2xP6mw8LE7N+nbmjLImRJPpoNZM/a8RuMpyxcBBBA==
X-Received: by 2002:a5d:4e91:0:b0:31a:d6cb:7f9d with SMTP id
 e17-20020a5d4e91000000b0031ad6cb7f9dmr6875262wru.24.1695666528718; 
 Mon, 25 Sep 2023 11:28:48 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:48 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 13/23] bsd-user: Implement mprotect(2)
Date: Mon, 25 Sep 2023 21:26:59 +0300
Message-ID: <20230925182709.4834-14-kariem.taha2.7@gmail.com>
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 7 +++++++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 76b504f70c..0f9e4a1d4b 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -81,4 +81,11 @@ static inline abi_long do_bsd_munmap(abi_long arg1, abi_long arg2)
     return get_errno(target_munmap(arg1, arg2));
 }
 
+/* mprotect(2) */
+static inline abi_long do_bsd_mprotect(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    return get_errno(target_mprotect(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 893881c179..74c0624637 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -603,6 +603,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_munmap(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_mprotect: /* mprotect(2) */
+        ret = do_bsd_mprotect(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.42.0


