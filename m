Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25D77AAFA
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGze-0007nc-2s; Sun, 13 Aug 2023 15:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzc-0007n0-C7
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGza-0002OG-T0
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so36893935e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955793; x=1692560593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDTOrlECkXwtbP3Q8uyO+H9meUZpmn7vqWB6qzJf774=;
 b=YzIR7wwkPhs16ONmCw4wI54gcDFFOzfEFtXFkkVPrnIm851C8map4VdKnDGZCgCE6y
 5twCXJUa7k40tz4N3TMWLDepkirKnFzCV1sGj+ZE09Voi4ArA/dDLSAdgQmpV7C/SSCP
 XRqfJHAy30NaWAwtB47H2QCE7wt34T4Ta541NTg//GWGRNh0LRH0ZAch8eQG90xQjPjp
 80wYGpR9iPsCFXDL77H/Up+X/ZWUgCRRZgIossS4u5Kf7PYAqyUXITjo3RgToQFuSVzH
 M+UcoCGQS7Z4bvvudmV0XNZEj+HuCeyKCTgXyFZaPB65BlQn6TIoq1QNBqi+t3ru7usj
 KTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955793; x=1692560593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDTOrlECkXwtbP3Q8uyO+H9meUZpmn7vqWB6qzJf774=;
 b=j/6ASlIJdaEnpJuDktssNy/OwcG5lRwLEUp/NdO8EOHHs/qTu4z0VLL+HVnNnG5ick
 vJU6Y2JgRh89wVjmC8q78GQpoLhVvzkdI3qVTRw2TSRAsXYtlmrc2k3/nKPh7FAmSYvj
 Y6cnZ9pLuhBMNE+HFkWWZ1ZtxCRnBfX4O5Y9DujCrKRJ2d6ofhZ7I1LCMhkhOcJRxVj1
 sUAvX5dg8T3ZfmXbGyxuxgPAD2I6hGwkzHlAlJpkxRSKXr82LQaO5h/rbEIVhg10mRS2
 KZmvddMMCgJEAxHn8PL4MxUTHNyxYr1CJCHcvF+uKUF1azUZWHBEg+uvRs+BXgqHCjkG
 fu3w==
X-Gm-Message-State: AOJu0Yx0zFvkvc8QKEFTxdUm1M4xjIn2QK1byIiu6VUSs2m7s81K9ayf
 gRN32EYtaiADVBMcpplkBVKBT0ZcVcg=
X-Google-Smtp-Source: AGHT+IFgMhw+8Rd1sJ/HEm/4OtLn4mbajUnYqBA9csymsOQYZmbGYHinHiV4gnwrPZyNd8YadmtLcw==
X-Received: by 2002:a05:600c:217:b0:3fe:10d8:e7ef with SMTP id
 23-20020a05600c021700b003fe10d8e7efmr7364324wmi.19.1691955793338; 
 Sun, 13 Aug 2023 12:43:13 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 11/32] Rename target_freebsd_time_t to target_time_t
Date: Sun, 13 Aug 2023 10:41:32 +0200
Message-Id: <20230813084153.6510-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index bdcdc4c0fe..ae679650e3 100644
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


