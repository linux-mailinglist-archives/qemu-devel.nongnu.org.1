Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496277AAEC
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzx-0007wl-Jr; Sun, 13 Aug 2023 15:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzv-0007w0-MY
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzu-0002TV-2E
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4b95c371so20962665e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955812; x=1692560612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HD36HNy1sYanocpvKbE1/qChGIAf2ss1+1ZwBL1pR0=;
 b=Mfa8haEPjADAU6M+ziKDM4FwGEKpxD7prdszWdGvdXkhF5VCjXv/M+G8nn4/1xvdnB
 ltgseHSCkgok1Fn3Xubv//HRfNCVqCT1KiRqYDCclhehd/Oo1x8LuabWtR/DsBd0Xl5O
 xHbwPDVZnq87zoVPajp70lWgiD8TwM4jOo1q5VEZdA0ZVd/vakCokvSsZvglApde7pYS
 zez79kJ44Vc8/NdaAVVchGbG3w2dkf8wffp8VlQdNT7pqcq/8+0xCapA7PUH3zCNkqv2
 UmPdr+h1DA7RwkPJ9ETa4vfilAvFoKBhiiCtNxSYoydkRqU7DmY7SURuMExALuIT6k0l
 iQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955812; x=1692560612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HD36HNy1sYanocpvKbE1/qChGIAf2ss1+1ZwBL1pR0=;
 b=LlIm+P55paweVJjeMKU+i1f//YIno9xMB0dMgnrbt+W0WRRyfTnxR5L08jBdlDkZ2e
 5MRMv804qJJwubFMTOxi80LlqfkfE1DqNly8E2eoQyKVjDfu6p79zpscYKbJvIkuITwW
 CjhGHLDhIE7j0hyXtlP/y3/hyT2ep7jaCxWWz83CTviLIAMU/wh/HBFAJOHKJbtOQuBj
 p2LMkZKZH9A5WMAc62StMb+3rnraXoMqhBPKFoDG2GHDfFA8OwfLkgUiX6JZKFWeWnUX
 YrFDkPwBId74c/UtmH7RV/Xwn/F8wKaUpZmOQ4WAusRrgTPk4apT1ggNwJ7uFNDetNQ3
 JnTw==
X-Gm-Message-State: AOJu0Yw2J9nCjxXnMV+5yy4I9oS72p9M69nUEL8d/5OgPnUTs9TzMBfs
 /BUIot04IMjXlDDFLfzWiclhoFN7s8o=
X-Google-Smtp-Source: AGHT+IGSyq5ocKP3HWtO8VIC0xEM40ArIfGaomto5Vr8OJ632BBFqs7aNyq2wiUBFf2/4ER9kzOU9A==
X-Received: by 2002:a05:600c:1e14:b0:3fe:373a:e523 with SMTP id
 ay20-20020a05600c1e1400b003fe373ae523mr8713283wmb.15.1691955812313; 
 Sun, 13 Aug 2023 12:43:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 27/32] Implement do_freebsd_realpathat syscall
Date: Sun, 13 Aug 2023 10:41:48 +0200
Message-Id: <20230813084153.6510-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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

From: Mikaël Urankar <mikael.urankar@gmail.com>

Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index e31b2aab9e..b20e270774 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -634,4 +634,30 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
+extern int __realpathat(int fd, const char *path, char *buf, size_t size,
+        int flags);
+/* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
+/* no man page */
+static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_long ret;
+    void *p, *b;
+
+    LOCK_PATH(p, arg2);
+    b = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+    if (b == NULL) {
+        UNLOCK_PATH(p, arg2);
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    UNLOCK_PATH(p, arg2);
+    unlock_user(b, arg3, ret);
+
+    return ret;
+}
+#endif
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


