Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A270D774101
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDW-0001z9-P2; Tue, 08 Aug 2023 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDT-0001oJ-Hm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDS-0003GS-34
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313e742a787so34679f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514592; x=1692119392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bYRjSj2J130dLImDFJiF4YPlkBi+KBGFOgVgJZX32M=;
 b=V6OZgUvXfAPCNORzMUXxIGYZNDUGGL4SWJIXbZO9nOZBjSjiU2z2dy2hS6RJZC4Of3
 JqMpfEEVa1y+aQVmWrYBtFGvnHF0cFwLmb7YvqyzRW+ubjCm+S2B5lVERRyQXlvu1Yur
 N1R5oIEn1XTP49HfQo5TjHMY/fWO6jCFtUK3N4o5zPZQamRmQqBuMkyiDldz1eckYLsR
 cqI3JSOQodBbjfg+vREhCxWIuvMiU6zjooOrAwOz2KTMC3J6ZJJDwSSwewJucvPJd1vA
 XPtgrtqquipPPsaSbzkItGMBsyNm43FbeqLwkV03Pai/mpWpb6MoGp7RYXKDkstf5iah
 rEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514592; x=1692119392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bYRjSj2J130dLImDFJiF4YPlkBi+KBGFOgVgJZX32M=;
 b=LNumLFn01NUilSeMaf5X4/jX4HiTFjgZ5coMD+8pgSpGawDt/NqExCT18PqLo8NAH8
 uD1A2PdakeBSK1qDuTyr4b9hw1KZUPQHeWEFSejuK5HAW+iBV6IN5fdYEKl54ukLDUME
 cLfDPy7F1sIjdiVDPXw4defG3RrJJhSQPxu7SCT2hVWd2IJIclXShttnsYZo9eORTrk2
 U3D1ZRmWNiQza9hqBTHAhtnnOI0rhfakUN8z21nRRduuNDpN00Ws9czJ3vEN/aLa6nBU
 9HPysFHqWhsoWXjketfQz5ZC/Kcvo/lf6twXnu9iIlx6raEdY0SXbtf4GybVWGpUCdtG
 fRcw==
X-Gm-Message-State: AOJu0Yyn5kuyUetIuDKz85od6j/Bd63X0a+Oe9JGa1IfFp+qE6CNUWd1
 U4TlsOKKQQNOxXpE7dySYBwjGz5/BQ5w0g==
X-Google-Smtp-Source: AGHT+IEK5lAOXCewFXBXrn6hYWnb0p78ocia/6yCa85NmKxxTpxqBrsV6e4MTa66H5Ex5nEFVBKq/A==
X-Received: by 2002:a5d:63c2:0:b0:317:e9d7:9387 with SMTP id
 c2-20020a5d63c2000000b00317e9d79387mr339108wrw.25.1691514591932; 
 Tue, 08 Aug 2023 10:09:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:51 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 12/33] Rename target_freebsd_time_t to target_time_t
Date: Tue,  8 Aug 2023 08:07:54 +0200
Message-Id: <20230808060815.9001-13-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Warner Losh <imp@bsdimp.com>

This is necessary for future code using target_time_t, in
bsd-user/syscall_defs.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 52ebadbe2c..b1d753e9d8 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -45,9 +45,9 @@
  *
  */
 #if (!defined(TARGET_I386))
-typedef int64_t target_freebsd_time_t;
+typedef int64_t target_time_t;
 #else
-typedef int32_t target_freebsd_time_t;
+typedef int32_t target_time_t;
 #endif
 
 struct target_iovec {
@@ -102,7 +102,7 @@ typedef abi_long target_freebsd_suseconds_t;
 
 /* compare to sys/timespec.h */
 struct target_freebsd_timespec {
-    target_freebsd_time_t   tv_sec;     /* seconds */
+    target_time_t   tv_sec;     /* seconds */
     abi_long                tv_nsec;    /* and nanoseconds */
 #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
     abi_long _pad;
@@ -120,7 +120,7 @@ struct target_freebsd__umtx_time {
 };
 
 struct target_freebsd_timeval {
-    target_freebsd_time_t       tv_sec; /* seconds */
+    target_time_t       tv_sec; /* seconds */
     target_freebsd_suseconds_t  tv_usec;/* and microseconds */
 #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
     abi_long _pad;
-- 
2.40.0


