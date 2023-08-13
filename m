Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170177A6B7
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:13:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpT-00087T-57; Sun, 13 Aug 2023 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpQ-00086l-Sm
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpP-0000qC-Cw
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317dcdae365so3036331f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935942; x=1692540742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDTOrlECkXwtbP3Q8uyO+H9meUZpmn7vqWB6qzJf774=;
 b=XSadXyT1qeIKGChvZWDaz+dUo0xgV5ZFRcVMyJomIkdNI0cnlcXLISBOBAidI6Pxme
 0i7OlPhzA7n6TjvOBMf1Unuv2MCLoF+Qm8seosj0KiSJE8K5RCZza2BUDaqW/HUVpGlS
 zUOruufbCgqYYnaQfMBT5UPSKwz9uRSPZypYLAfxSTS1jInsimK4J8twIkgOVEQLN3jk
 tDcfPtDdCKNXJYJHICPyYxbn+3RJKSeyn42QIp/Q7o0AwleOyf8rwIuwTKnthPW1rqoS
 6+UCqBXT0Z/BgKqV8BEGMSoVdohULRM9zLBjI6z78m+ptRI+++/nYzMyOp61HtwZ9B3x
 Xj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935942; x=1692540742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDTOrlECkXwtbP3Q8uyO+H9meUZpmn7vqWB6qzJf774=;
 b=Wl2ejInw5V1fHqO3fbucqCTpzo8cwYMrx1z6RjLGXdv1wbuGhZpX5pa77/RWyvQyPf
 6FKHRXB4fdMuIYG0jrx/5pRyQ+AYH8Gjy/yU9C6+vq0EN/8ZdEdL0P0VLb0GpPLdxeC5
 PgphfiD0Y2QFPL1c6TVI+Wrjj9p5Su3/C75KgKIQuynb0N2cjLqgBIdZz8J7O6jd6Q1i
 Gv8y781VUqCVphVv59LeWReoH33olI2M8I1/ShPNCT/VUeN3zcRBsHr1NOjCJTRLC+T8
 Bx0VnipVVtBeUsk3kyGbu8+tzWp2ZgsOf7lUEnd4xn4qlTPXSNS9ZVSxBjUNoqmEPqPg
 qOVw==
X-Gm-Message-State: AOJu0YxurO3IE1tPkkNqgIo8fe7hJUuoX/Qw5HWgaoIwWql6PbjcJQ/9
 S27VlnoU5JjeHFhtpRQ2gerQPCU0KYk=
X-Google-Smtp-Source: AGHT+IG7w2X966HmhhvGGB80KHaR6r/44//mtnNwW3Cd5+vkxo/TPAlD+bCg9W3c+goIiYRaXqiJBg==
X-Received: by 2002:adf:e685:0:b0:318:7d5:67bf with SMTP id
 r5-20020adfe685000000b0031807d567bfmr5788612wrm.49.1691935941805; 
 Sun, 13 Aug 2023 07:12:21 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:21 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/32] Rename target_freebsd_time_t to target_time_t
Date: Sun, 13 Aug 2023 05:09:52 +0200
Message-Id: <20230813031013.1743-12-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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


