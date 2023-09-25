Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D17ADE9C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHO-0001Ae-72; Mon, 25 Sep 2023 14:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHL-0001A6-W0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHK-0007Gn-F5
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso74587445e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666352; x=1696271152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0hUnJo62FgJTQIoivO6Goxg3C9ame5/C7KEuYom5hs=;
 b=PBHuGV66nfz0fj9FWWLCu6BrIfiak8Eqz9TfPmJkD6zCVkx9rOQt7463KjRv++B6gT
 B/UtirkVg85/ClpA46kS8UXgzV4ZfySNuTiVoQweaB1jK3LLI23XNb0bkd7ADFTJ2ejO
 5lzvpp1kFB2jbUT36B92W6gA6g8RwQDev5uiuiQ9eXmwWHNWObwN79sqVYmLTFn83PLJ
 q1trLHUEZnStxAR6iGrkQ7JGxpb1x/zSGXr98BlMRHi6iIDyKWecL2lIOcYU6jGRAUaV
 4bqYcVk/3LHXodzJyyNhw1LjzhJh4OfKWYlTTg/dVYZgmgRfymcE3UnQkw944oNLX2Uv
 BNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666352; x=1696271152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0hUnJo62FgJTQIoivO6Goxg3C9ame5/C7KEuYom5hs=;
 b=c6ylXrblu7DlTyggJ5GeqT8HfzCHONCsaEmZ9nBJZt9xSpQO4MYCp0MoTEkxu8Gm1l
 a4QIdqD+d5BNeNsFhXFQWYU4UK0Sfp2zUsquNY/5nPIfdGjOOVdMoLuvHe62rS9k6hlA
 OZvzFO+GHmHPEbKuzzL1Ukql6SrBNIHhpL79nxJArJdDiNzzE2IKeADidBBFDzziP9mz
 Vy4xEJEds3IOJ0XlxooyrPmEHJjj85/AOAVpvgVn4SxyksME9/EPuvFfnD2u91RIzr7f
 P4KoEXx1tuHOvSgm7LQkBCtsD/Nq005sAB+MNZOMZDax+rCE9pBAKLLkJ9wJRYzmyws3
 hJuw==
X-Gm-Message-State: AOJu0Yz5+Iy/AIVUnZ6ByyGGfwrUwKCoKpZlYS/vB+GaOuDvn2JvZQUq
 xP+MbWYjhAd7Zpz3jPUUg8SWocn5m34=
X-Google-Smtp-Source: AGHT+IEHFGl3EuVwc6545wJGi3uDerdAeUvStxKp6aWavQ4UXzh0Aes+utTNZGNY45A6SHI+VBXn/A==
X-Received: by 2002:a05:600c:1913:b0:405:95ae:4a94 with SMTP id
 j19-20020a05600c191300b0040595ae4a94mr1898001wmq.5.1695666352422; 
 Mon, 25 Sep 2023 11:25:52 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:52 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v5 01/28] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
Date: Mon, 25 Sep 2023 21:23:58 +0300
Message-ID: <20230925182425.3163-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
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


