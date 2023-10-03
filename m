Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D27B7511
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnov6-0003vS-MF; Tue, 03 Oct 2023 19:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov4-0003vA-7q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:14 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov1-0006gW-71
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:13 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso60161939f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376108; x=1696980908;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWdm+hDV/GXkOmrbOCDP//62BDkJTz7eQAUm8g6H/pk=;
 b=pI+p2q0DCqHgkfw+ntQpEWRSlMCXp3LiSgpL72dGfABdwbZoUGDwH9gbFysEpYZU4u
 hCBrbO/IRW3Kl3XZwSstIKduUV/bQJy0uN+YRvxZ0qsi+AldKCP8AYrxcZALj1pi3BF0
 8+Jc47fRnXijRVEwbJ6s1ozCYEpWTfAsoTxrFwZ7mY2fpg6Gj80n+q94hC4cdmYephuP
 nmia7bBPRzlVcRaNJoPqKS24ff6UHJJSbsAWkbI8UQ//VdNceyq4CTpOr9Yn/RhUao5b
 GQ+W/RduAPA58t7ZCsmGEj7hjrAx8FZid9oWw9JZIJ3jyVwq6NWTerGtn0kV+QEG7a+f
 zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376108; x=1696980908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWdm+hDV/GXkOmrbOCDP//62BDkJTz7eQAUm8g6H/pk=;
 b=piGjBLWxo3Y1QoWVbFt5TPq8foJ7JN3Br8nQE3LRbcYYbUaDes8IPbWOfcaXJmacKg
 VCxkrFfW8nDMfbGa+jJNY3jHhGSzj9Q96hTe4AuD11Q15yDbnYbU7bUVAOFe+/ReQ1J8
 v2f0IRYyGHNi3WZoLNnm5V2zydYqe7pW8mSOrUq0uxE+ld+6BrHkjYq72jlXpZLjp1Dl
 jNBX2TenjlUIbnqpfvc2n5koYtep1pJwpMWqvWjNaK6vN7pcuSh94UYVsDNWkc3Qw+kV
 5DlWbwOXTIFPh/NDedi/rIMpm38ycGLU+P0+pYfuPN17hw/FtMmXNVKK3wB46wZ1jvyd
 UV1A==
X-Gm-Message-State: AOJu0YwyRFD6eVFy5fGhUEKZTZ1e3HqQa5nqVZmaMibFpA4JVTnNBI15
 wVHU3k5XBijF8RQu4cPw1h245hUhFiZ3Kubu6/r4gA==
X-Google-Smtp-Source: AGHT+IE9dMWSyqEayfRJFF7JquFMLPPymh1C06GHHWp03sqM2FU/sMIM7lTCeGQw8g98Zud7MHZEhw==
X-Received: by 2002:a6b:5b03:0:b0:787:1555:efca with SMTP id
 v3-20020a6b5b03000000b007871555efcamr977020ioh.5.1696376107841; 
 Tue, 03 Oct 2023 16:35:07 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/51] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics, and fix RLIM_INFINITY
Date: Tue,  3 Oct 2023 17:31:25 -0600
Message-ID: <20231003233215.95557-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
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

From: Karim Taha <kariem.taha2.7@gmail.com>

RLIM_INFINITY on FreeBSD, OpenBSD and NetBSD has value of ~(1<<63), caculated
one way or another.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-2-kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9c90616baae..ddd38c13e08 100644
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
2.41.0


