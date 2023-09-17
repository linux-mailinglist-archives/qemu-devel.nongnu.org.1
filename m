Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502877A3E80
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Be-0006St-81; Sun, 17 Sep 2023 18:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BY-0006Rg-MZ
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BW-0002tR-DQ
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso44711665e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989448; x=1695594248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xyYvDm6vr5FBlsfvLve2y0GH2jJ4Bm4yKdVTAQCQ7A=;
 b=jGAH27/t1IxsvJLx6O8UJ0Biovn5H4dJBnxOMg5anpc+tMlte0kcSLbPPpre2hCi2U
 YnEtp/pppuVP2aMMk3KP6fw99U4AMqyaeo6QDZRjCP3t7D2ZvQmcrTIHS0yqrpSRSMyL
 JIOqffZL5OIUQ6cPPIk7jxj3KkPuDlSLO+uzt/uf2rF/aj3ryiZLIBgL4ssXuH9pEF1I
 xM1RnJ+UoRLrXBO+ehsvyJxaFT0K6r8dl3ZHRvwU24E30vWu+Fr6jpiWbqZWF9PyYYia
 UY3FCRfl0OEUOHXUJB4NeTeDv/80n7ybs9C+lgQrUQIBRbHvo6oS7RJ3zGgTbuC35Psr
 H2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989448; x=1695594248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xyYvDm6vr5FBlsfvLve2y0GH2jJ4Bm4yKdVTAQCQ7A=;
 b=IDziVLL5I/gpWWk8shSJtL3OSE4lVVexy1tQNtypc8iZrlkqrEFxW2zbut1PwmmMcO
 lker5rkNnV1YLPffC7OwJubUUDVaGYmRTOJtcYmoBVw8g+4nXQlKdKDIM5jwEpaSQpBU
 7eOyPahfwy09i5j/8FK6XRUcTg//XtdoIhMUKMYntKvnZjqLsxtAa8RtShD+xO3cmHhk
 cjno9LGzgzcoXRTRsW/RrbT+4WSmZCmb7Z4xn2Bl+ffhpTo3wLDYqQG8hsdd9n5RmQdu
 f1St2oFqFj7snoEjvLk3xStX8S9wI3Aql+fpkV0sZRUQMDpXUut+1ChlicgJcU3ScUHC
 x6uA==
X-Gm-Message-State: AOJu0YwXo9HPnFSPdQYpbOhh4v9eDdPLbqMQgvSJ7qyGxbrh89MyLJ4f
 3AjPB6tpH8G2nqTGx3ZbBmaOE1TIW10=
X-Google-Smtp-Source: AGHT+IG6aOS3FyfHQowK8dut0fQeLwHyfKPmbFqlaPq2lzZqr58Fl/lK/Sb0WxpK0CvaEp2H3rbNdw==
X-Received: by 2002:a05:6000:1c0d:b0:320:459:5a3 with SMTP id
 ba13-20020a0560001c0d00b00320045905a3mr3233000wrb.33.1694989448392; 
 Sun, 17 Sep 2023 15:24:08 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:08 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v3 01/28] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
Date: Mon, 18 Sep 2023 01:22:18 +0300
Message-ID: <20230917222246.1921-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
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

RLIM_INFINITY on FreeBSD, OpenBSD and NetBSD has value of ~(1<<63), caculated
one way or another.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>.
---
 bsd-user/syscall_defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9c90616baa..ddd38c13e0 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -130,11 +130,7 @@ struct target_freebsd_timeval {
 /*
  *  sys/resource.h
  */
-#if defined(__FreeBSD__)
 #define TARGET_RLIM_INFINITY    RLIM_INFINITY
-#else
-#define TARGET_RLIM_INFINITY    ((abi_ulong)-1)
-#endif
 
 #define TARGET_RLIMIT_CPU       0
 #define TARGET_RLIMIT_FSIZE     1
@@ -390,6 +386,10 @@ struct target_freebsd_flock {
     int32_t l_sysid;
 } QEMU_PACKED;
 
+/* sys/unistd.h */
+/* user: vfork(2) semantics, clear signals */
+#define TARGET_RFSPAWN (1U << 31)
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.42.0


