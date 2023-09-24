Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 129177ACE38
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSe-0003D3-JM; Sun, 24 Sep 2023 22:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSc-00038o-88
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSZ-0008UP-P6
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40535597f01so54263955e9.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609389; x=1696214189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0hUnJo62FgJTQIoivO6Goxg3C9ame5/C7KEuYom5hs=;
 b=AvBhw1gw7lcHXvjQoM3FxJ5qBe2qTHLaM2jNvJR3L9hASyXRmOKr5YoaAvLRqz8Rt5
 SOXKLhRvHal/MCV84OoY56Y3+h+UJ5NOSEO1VzVigDgaMzu35ujkFMd7DbzynXB5ngpW
 bbXS6sx2QsVkcMFeN2iGpouv//TiCPpY7gMNs6GagJHCpzWCxfz8XY7UTR+1c9Mirxvk
 3DYTVQBpOQ/zRyRsfKakkY4dQ4/2qQtFjWxgOX/Cr5etzeHOU1qfdGFagJn0DNY7C+jo
 ssOIa0QeA5sVpPns6n67keCKWC9g83yHsnc3smYMWwgPdqMCoDz0e63pyg6A/pfLRoGq
 8bkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609389; x=1696214189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0hUnJo62FgJTQIoivO6Goxg3C9ame5/C7KEuYom5hs=;
 b=M3WcS2LidezZ8OScWCc64afscBC8SuoY4uGPEfNYXFEcqPBHIWibMpKdUXMT0Og3a3
 nTO3T88kpzP9872LA8tVlQlQTNjhTCXfQoFH+J3eq4DIWqL7CDXeLda6b7r0AGBQscCy
 R/LcblJk8loDP04AMDQpwgoyPju1MvnErGdWjxRkxCMQmHMx6WiYTfEtO31JKeuqzpwB
 sHdLHQyCHgjYD0DqcZrP+USLKJ7znijuoPe6+gth/F/TPN7Kh+cQVFViY2GO9cElDyW3
 6K/JJEVWGP7kMGi6djAvO5biXSBA/2Bt9SKTgSGECSMZ0J1BS22l5tmIwNzK0ayisYR7
 GcHA==
X-Gm-Message-State: AOJu0YzXDpp1kYuxF8aGr9T1L+jlq9xsKu65tSWAw7ylSeE/pMVk2yX/
 lln+ExKgNvHbGwvaQClIuvYRCz0zMr8=
X-Google-Smtp-Source: AGHT+IFMo5p2QVTQHIgrn/4QE7i9ljQQ+41Z0U+PjUxLCjv4hc2Izx9YmP7zn8r0J9EetYt8WRHHTQ==
X-Received: by 2002:a5d:4dc3:0:b0:31f:fc6c:8b75 with SMTP id
 f3-20020a5d4dc3000000b0031ffc6c8b75mr4342126wru.7.1695609389235; 
 Sun, 24 Sep 2023 19:36:29 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Karim Taha <kariem.taha2.7@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v4 01/28] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
Date: Mon, 25 Sep 2023 00:01:09 +0300
Message-ID: <20230924210136.11966-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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


