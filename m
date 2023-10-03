Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79D7B7525
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnow2-0004sg-71; Tue, 03 Oct 2023 19:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnow0-0004qS-7m
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:12 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovf-0007TW-SA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:10 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so59914839f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376150; x=1696980950;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o5uCmY06ZAYAK3HvpohN7Kj3r79hSbBC/UkGrV9km8=;
 b=jNsHU9AI9DCpKr8bHG/cbqKN4o7grMASAUbf6FtZv1Lb4QLVytvcXgA9X0UtJ+rUsM
 v64AQwTmiH1Zm7aWa+rN7xHj/N3p/KKldQQaUu70AoOydMbAy1qLWCRXHX1MiMcJgoYK
 xPOjFZ/obFsiFE2xZ1alTPyWfxHI68sCSDAmH45ZItxH1+MmSOPp+maMso2/QrZ8UT1v
 KrvoQGHNzsr/CTqDi6bycs0iknoMr7Mllgy2tOgT5ZGCvh29ojDdpV6S3zMuhIUjZ/MQ
 H8MEXryEVI98DTvRTWXd6KOfgrrbyKwCOEMU3pljujOoema/cI1rs0bdCXMfihH6Rij5
 qgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376150; x=1696980950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5o5uCmY06ZAYAK3HvpohN7Kj3r79hSbBC/UkGrV9km8=;
 b=OVlZoJGaUFUT/toOQYMo3f65ENmr92GQtwdXn6rY39Tfv6tiS90RGADqKw8Wap1NmF
 SPw0FRX4sXIHe5m9wDQ6jYJ27mccnB9Hkn+tGMYXjlGOfzZFso/jUE5+yY3qZ0FPZQJD
 kVC61zD4U0ZvvJtLjlqx/s5LQcK2TmbV+YRM5aoOZPLeCex1KlxfmyP5DEnkB6bqn/qj
 VtifmWJrtjjxO7n5QamJxLRfcdOwcg94TG+drTFd0GN3yDSm6TXeuIuTnAcsjVGYgWhZ
 zkXTA7yYaMeQlVrpW6z2DHM4KO/5/ZDxJtRJk4OCrBRysOfRp8QyBeNmIek1XmYCbqvG
 p4ag==
X-Gm-Message-State: AOJu0Yzr4CLuwoz+Yj8cD6fgIp8WH1zFN/MWXhwIhg+MxOpnwyrInxVY
 4BNd/jM+YTBFBzMQttlQhIbLsT2m5ef+sJmlA6L2LQ==
X-Google-Smtp-Source: AGHT+IGlpaFEVbjQZyw51q+z5W4ZE3DAOlQQ4z1pvtOSFHeJ+sOaFH+nw30bfq5o2dJqOijwKaMRxQ==
X-Received: by 2002:a5d:9943:0:b0:79f:9eb4:3ea1 with SMTP id
 v3-20020a5d9943000000b0079f9eb43ea1mr1020336ios.3.1696376149917; 
 Tue, 03 Oct 2023 16:35:49 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 47/51] bsd-user: Implement shm_open(2)
Date: Tue,  3 Oct 2023 17:32:11 -0600
Message-ID: <20231003233215.95557-48-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Co-authored-by: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-20-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 25 +++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index b296c5c6f0a..f8dc943c234 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -257,4 +257,29 @@ static inline abi_long do_obreak(abi_ulong brk_val)
     return target_brk;
 }
 
+/* shm_open(2) */
+static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
+        abi_long arg3)
+{
+    int ret;
+    void *p;
+
+    if (arg1 == (uintptr_t)SHM_ANON) {
+        p = SHM_ANON;
+    } else {
+        p = lock_user_string(arg1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(shm_open(p, target_to_host_bitmask(arg2, fcntl_flags_tbl),
+                             arg3));
+
+    if (p != SHM_ANON) {
+        unlock_user(p, arg1, 0);
+    }
+
+    return ret;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 92793ab1fb3..0d4c3118f0d 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -843,6 +843,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_mincore(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd12_shm_open: /* shm_open(2) */
+        ret = do_bsd_shm_open(arg1, arg2, arg3);
+        break;
+
 #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
-- 
2.41.0


