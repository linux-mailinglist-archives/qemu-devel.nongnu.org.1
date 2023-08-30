Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2A78D207
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAtf-00013L-M3; Tue, 29 Aug 2023 22:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbAtd-00012o-PB
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:25:29 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbAtZ-00025I-Vb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:25:29 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-77ac14ff51bso163660539f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 19:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693362324; x=1693967124;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fMqF4JPyjBxdbMqRIVZHqpDolrSgxQrfNo/OPx9hRc=;
 b=M2A5EZxPB2Be+mE9BNT+R8MuyyrlFmqrOvXeIfj1QbzgJS40B6OL+bB6x6W3RFF7h8
 AFcpw5EjEDN1xjWLlqM8mPQ7ftrftn868iN+TtFE5V8CHogqRHJM25MyZMP7hJFzHvcp
 CvkKlZto4dfQxEKLqurgr0O56kg/ZKI7EfYVk/DS3HzXGHFV79q4KMsm1uyCQSY+JNmX
 ULcF9UV6UUiRVQx89H2RHiLyEtE0tIrQmsRDZRZgifHYHr4Ro8g0rdNJCJsU3fPUVdxG
 NCBzYXt+m6h8YHEpqbpySlXLAUG/INoCyPr3q+WQe3uebM4O1KMxdO+EQg2KzWnJ+EGE
 1jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693362324; x=1693967124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fMqF4JPyjBxdbMqRIVZHqpDolrSgxQrfNo/OPx9hRc=;
 b=gymu5n8OHh4Z1VRKIgcLyoj0ZMXRIMbpGuSXGi0FvUtSvEgYN9geWPStEgeXdqMsNQ
 20G8ie1DkWjUIRmzonqqRm9Rsg/qMQEcbyjJDYtcTCyXYH1lXBvq2UR7rxZCMaPlzc6y
 oj1Kg1BJxovQfhoFWQO3Q1vNbLhgTlnpEwfV0oJHh2se5C22B8SX+PEC5fP8LTWEXUTv
 T3AboyHk980x+OLDv2IoKiVhJaYLMFvokE4a0IV8DU6Ssnqs53pB9n34jIrsgTtAiBsQ
 s0UNC2gOp+7m5GixJCsyXrLZiYaLVyB2GAkpF8LvFrrGaG0RlfHxCIUnYQaqr2JaNdgb
 kliQ==
X-Gm-Message-State: AOJu0YzAMiWiNIa+Jvm/sbvXSN5IrWo62JJLYHA+hUlO1E8vUhG3vlP+
 wnZckWylhv/vQz1tQLV40QKsDOeU1mbU4qGRNGY=
X-Google-Smtp-Source: AGHT+IEAjHdy+oIE+wlhmdBUFE8wai4FjH/eJV2s7pysjYtS6kpa0TGVQT377blwThBFl4aduUGn9Q==
X-Received: by 2002:a5d:990f:0:b0:792:792e:6616 with SMTP id
 x15-20020a5d990f000000b00792792e6616mr1227737iol.2.1693362324281; 
 Tue, 29 Aug 2023 19:25:24 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 h16-20020a0566380f1000b0042b61a5087csm3369250jas.132.2023.08.29.19.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 19:25:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/1] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
Date: Tue, 29 Aug 2023 20:22:05 -0600
Message-ID: <20230830022205.57878-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830022205.57878-1-imp@bsdimp.com>
References: <20230830022205.57878-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Replace the slightly older version of this in include/qemu/compiler.h
that was commit as part of bsd-user changes with the newer one from
linux-user. bsd-user has no regreassions with this.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h |  6 +-----
 linux-user/qemu.h       | 26 --------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index b0374425180..0df9febbe2f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -31,17 +31,13 @@
  *   functions than host-endian unaligned load/store plus tswapN.
  * - The pragmas are necessary only to silence a clang false-positive
  *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - We have to disable -Wpragmas warnings to avoid a complaint about
- *   an unknown warning type from older compilers that don't know about
- *   -Waddress-of-packed-member.
  * - gcc has bugs in its _Pragma() support in some versions, eg
  *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
  *   include the warning-suppression pragmas for clang
  */
-#ifdef __clang__
+#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
 #define PRAGMA_DISABLE_PACKED_WARNING                                   \
     _Pragma("GCC diagnostic push");                                     \
-    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
     _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
 
 #define PRAGMA_REENABLE_PACKED_WARNING          \
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4f8b55e2fb0..12821e54d0a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -193,32 +193,6 @@ static inline bool access_ok(CPUState *cpu, int type,
    These are usually used to access struct data members once the struct has
    been locked - usually with lock_user_struct.  */
 
-/*
- * Tricky points:
- * - Use __builtin_choose_expr to avoid type promotion from ?:,
- * - Invalid sizes result in a compile time error stemming from
- *   the fact that abort has no parameters.
- * - It's easier to use the endian-specific unaligned load/store
- *   functions than host-endian unaligned load/store plus tswapN.
- * - The pragmas are necessary only to silence a clang false-positive
- *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
- * - gcc has bugs in its _Pragma() support in some versions, eg
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
- *   include the warning-suppression pragmas for clang
- */
-#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
-#define PRAGMA_DISABLE_PACKED_WARNING                                   \
-    _Pragma("GCC diagnostic push");                                     \
-    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
-
-#define PRAGMA_REENABLE_PACKED_WARNING          \
-    _Pragma("GCC diagnostic pop")
-
-#else
-#define PRAGMA_DISABLE_PACKED_WARNING
-#define PRAGMA_REENABLE_PACKED_WARNING
-#endif
-
 #define __put_user_e(x, hptr, e)                                            \
     do {                                                                    \
         PRAGMA_DISABLE_PACKED_WARNING;                                      \
-- 
2.41.0


