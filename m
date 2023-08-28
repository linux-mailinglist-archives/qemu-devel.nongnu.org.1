Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592978BBB2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrp-0003i1-Ez; Mon, 28 Aug 2023 19:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrn-0003hn-Ie
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:55 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrl-0006jJ-CH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:55 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so43865939f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266111; x=1693870911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWjexX3tTM1dvknP8K4al217e8HKfI6QYA9Z4MD5OIU=;
 b=FaWRy8/3kmnFNhTXtcRqjnB5v8pdqrZD+jxr2TfE6hApaacTSG95ixoEdibZHUqQ9S
 cKSaAJnN41w802lxxsQxTWNXXptne4O94JWpTCa5KuF/0XCPthJBgC0eBYN0qiLGq2A3
 jDoWshXr9Asn+nTp0G6NlRyMXNIVSCf8RwrGyBwFZsvTnYXvgMze52xyeHMKV9DOzF+D
 ecKTVGFw1JLU65+8CbZ6dU9Oh308xX5Tr5HhwzQ/dJZYC8IA+ulXER9hD0KUms7+B0uH
 v+EuwFd2Mfoft4fEUQ+T81rQ9WxmoyBsKCK8cyYo3+R3j/Jlz+DShEz5xPeXQaBaKSjX
 dhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266111; x=1693870911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWjexX3tTM1dvknP8K4al217e8HKfI6QYA9Z4MD5OIU=;
 b=CU9kNXXOtlzx98N/ckZI1znJvQnMABwqqNgAzxXOJjsrroXWefJrH+Ku6KiuPryp6t
 zuEOvjUjxtPFyze6Z1ymYYx9tITpVjLYJi8DD0Ull6ka+nkvKcI4p9FLimipk5Mue5jj
 affih1/G6yUlTAANgdwXMsRt78hGjqciUhvVYuesJ1oM5YLG6sufzTHEby9qPfdVc2TJ
 qo6XaYmQg6SbPA+IGp6RqXJ1045B7JiOiZDq6cYHgMhpelEd9R456u48Hjn5drkVnxVv
 2dka1YWqCVm7+nMDRL/iqecijd0W3ILiv3AWgoIPZfPW3Ndjyn8dKHoRHu2hPLxw/3K5
 b0Wg==
X-Gm-Message-State: AOJu0Ywj3hVZwl//sET9PH5WxXJuYt2qW8g0Ue+FTmg+d4eu8hrWTlxa
 BmWuHikxJaQsQav2+YjCcCIbYUKxeBVdHv9L3Fg=
X-Google-Smtp-Source: AGHT+IHstBNGu6l6iEnsu5Bea8DGg5jcKUtsG9kbaKmcjDGgon7vaZvhNpqODuhFr342sxYiLpPGUw==
X-Received: by 2002:a05:6e02:1607:b0:349:978e:78d8 with SMTP id
 t7-20020a056e02160700b00349978e78d8mr23679182ilu.2.1693266111447; 
 Mon, 28 Aug 2023 16:41:51 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/36] bsd-user: Rename target_freebsd_time_t to target_time_t
Date: Mon, 28 Aug 2023 17:37:59 -0600
Message-ID: <20230828233821.43074-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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

This is necessary for future code using target_time_t, in
bsd-user/syscall_defs.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index c6699c9943e..9c90616baae 100644
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
2.41.0


