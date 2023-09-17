Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E327E7A3DF3
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUM-0004Rw-N7; Sun, 17 Sep 2023 17:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUK-0004RC-ID
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUI-0004EV-In
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3214de9cd8bso418626f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986769; x=1695591569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xyYvDm6vr5FBlsfvLve2y0GH2jJ4Bm4yKdVTAQCQ7A=;
 b=GOBiTGEX34Ox9qWdEPsVT+f+9UfvMsFG+ox7b40DE+t2HIIV7p+m+fiR/YJbXgm00u
 52ROo7Fskg/cqY2Uw9DqZBgdMmPQGYrb3etyldQVn+zQeafl/+d1zA3fQhqivNmsRTC3
 iST6QK+q1JVpR9Yx6BERrg9Gz4KT9NNU+Ng32mg5ESm4n3+Pv9GGf7N64zT+/4MhMZaw
 XnCghVz88PBhiU6eomUfSyED5Q6wZvu6K/6bGnIgcUc/o9vWMnAFOQPVTGuzQdICMmZ2
 I77Or9HUSwgZ1rNMjCkC0FwZ79kPx2XthhlA+92CzcP4/xj/4B8NVez/PC8bIpkhoOmM
 ctUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986769; x=1695591569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xyYvDm6vr5FBlsfvLve2y0GH2jJ4Bm4yKdVTAQCQ7A=;
 b=vrmbgNTmvIDynVYLtjyV5Eapy37tBder4dbErkXUqP1OB3058dyzObooTO7d+KNOhF
 UOSkw26DYaxJ+2CGsIyIHmqRtooghMO38Ms3dsWnnAkk/7s7TQsQymvooZtay49LjWFK
 kbDjdXhn9cIF4qDmtPGhRjFA0W/AKIudDKpqdxlP8/a3OmGywMIT4ADRbg+ZqsJ9lcI6
 kC9XDzFzzwnbubgGEtDALoMLYId3CAqqp4spFEYzlDAS/SsaQsYZBWhzF6dd9jUzp4CA
 nyjdwRxib1ffkAkzXV7SXxtqUVMTkFF1DslTt0kIV+3uoxYdvMaXsF1XJ3FGWcWK7eCt
 U93g==
X-Gm-Message-State: AOJu0YxTczm944SwT4etbPk5yiR06oQUExNPiv+dHIiG8pC6kTh0sU0/
 tr6ku9dvwUimvrvWmRk6GOT0LjAEViU=
X-Google-Smtp-Source: AGHT+IHSv+V7gJr27VpQNDxBkUjCI+0Hbxa2NkUGlZrsOMn2516xiYxQkyjrLI27b6HtBPXLbSB2SA==
X-Received: by 2002:adf:de90:0:b0:31f:a4fa:130a with SMTP id
 w16-20020adfde90000000b0031fa4fa130amr7690469wrl.14.1694986768525; 
 Sun, 17 Sep 2023 14:39:28 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v2 01/28] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
Date: Mon, 18 Sep 2023 00:37:36 +0300
Message-ID: <20230917213803.20683-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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


