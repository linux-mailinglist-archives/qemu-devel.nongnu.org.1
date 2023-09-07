Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7579964A
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfY-00015a-K7; Sat, 09 Sep 2023 00:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfN-000123-Nq
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfL-0002xA-GV
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so2623669f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234029; x=1694838829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eYQSo99m8Jb6VuAKy20SyQjPPkVXbzKZOriqtp/fqQ=;
 b=OynJdE8x5GHuF1uiFFOhB4J5phKqbAc87cxI8eA3FHE8yyn3R5izaWP0eLfG4U+kQY
 /QSAoc4PD9LIIy2YnmPyKQ6Cukd4KPyPVvZkx4wKR2D7ipDtSvKx0UxgynZn5HwP/sEd
 fUum+S43lGOiu0iDqqXqyM+RpxtMfmsw2nwb6apBnfNt4JtJMZqb0mzYk1Y+Td18VLP5
 TvRF0IKgHEmTTuPMP1pI/VKopuJ+/1kDAhBl/0OzyVb2LiXxbUPMenOc/G33V4LnAIMi
 g2AdEU7/2ektdXDgjGKMO91i4yeXey1vpxF0rXZYXTimJT1ujDw5e1V74J/ZINnev4yH
 jt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234029; x=1694838829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eYQSo99m8Jb6VuAKy20SyQjPPkVXbzKZOriqtp/fqQ=;
 b=UH2oA10xncID9B0sBTiZKvXxBlQsSXnKM9V0QFB5W1JjBUEcP8S/TYsE6L89sp2Uhq
 VKUMAK5W3D/6cbYX9nNHiRHmFkD04oFvSdIhqFoh39D7/9rzBfNNPRXXw85dG4onzCHg
 Z7OItFFRyK0Y90+3KwqlxqHqCQ8gGTSq/pA3QAevJ8lSizLcEIWgfzfbKmU+P7QCHUdB
 Gnu5wDYzosoBVWVT9+bEcXKsOvG0/1u2LqmOg0R5hP1yTIZ9DHStjLvetVtnhbzc1WZC
 wi3b8TH2VSHLKn/Way6f9m+zud/z3HnZSoOPL5e/nl8Fx7SQGmXlwv3MlnZjGCHRRX4V
 DV0g==
X-Gm-Message-State: AOJu0Yw5FyHOqo6zYJ/TeFOctzRWo7f7IlHO+dpT6XHuyo719TChoQib
 zTMVLPcYO4AwaJTAxdO3HdHDMukXxmg=
X-Google-Smtp-Source: AGHT+IHcjWJgxGM82i/Im8TPp9wyDkUbhY3utdEI+YaZ9GQLSsfY0dPdx8Q32+TAdIy0TyzUPxDL5Q==
X-Received: by 2002:a5d:494f:0:b0:319:8161:ecc6 with SMTP id
 r15-20020a5d494f000000b003198161ecc6mr3172014wrs.63.1694234029598; 
 Fri, 08 Sep 2023 21:33:49 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 13/23] bsd-user: Implement mprotect(2)
Date: Thu,  7 Sep 2023 09:42:52 +0200
Message-ID: <20230907074302.79234-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42e.google.com
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
index d88f62319b..127805e079 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


