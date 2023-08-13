Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F877A6CE
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBps-0008EI-Ew; Sun, 13 Aug 2023 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpa-00089n-A4
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpY-0000rt-1c
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so35096835e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935950; x=1692540750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4VC00NMaV/EVxyvh1YhfOSLjPJ+EyYcglqkFbj3qYA=;
 b=dxWRV9A+v8RNnr9hcVksZI0xxcuEkb/8eCbJPNHdQuLo+Ixk2jIFVw0S/7M1eHh5DM
 tbStZ1Z+CGLiyqqHHwiIRDPzFoJC/x5vHQdtkMULitWaCt8gUrZemgW2HjYBC9N9KyEj
 mITFZMD5NlJitpyPzP5nvazqMX2YCze5bmjlQgKZtQt2AsOmvki2tm2zQcudM5RxLufV
 h+4wFUnydEKygsSbfGreUlCryJKq9Al+PASvsEoVCZb7eHGeGXbZpSOzlHv6ebzx8FQG
 7/RRbiKdSHqWzWjDgHDU6ob/2ng9Vzmx5XZB6Elkrs+RXgyX6+5HIxscV8jD7LDyBFfu
 vwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935950; x=1692540750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4VC00NMaV/EVxyvh1YhfOSLjPJ+EyYcglqkFbj3qYA=;
 b=QnrHKj1TgX5EdJKNymwPDrgQoQolaB4M0CZQA8x9LeOVmt2C3/bA5oGZqjErFLwGiH
 lgJgYapRt9mJAAK8clLYdxiSTQ2l8TlDW7lMAt+RsG5k9E2lmMmmk3Xdj5GatLHkmOH0
 8aNgpuwkM/4y3JHcS0HAfPivdvTTgBM+YDBMAjNPtv79L3MfY4jArlhipRryAXUPQQ4h
 Ai/fCYMDafBTaGfjrSssMuBhSw73nV0yYinlKuD31vhJLyQkOAciFHbLiYtPriyjstSa
 KDAfw9cGLSu3J7GV6CEvgGsxRSk6KiyN0BTXFLFt0FX4udXB5gfb4rvtnGQMxZNkE/gD
 vH3w==
X-Gm-Message-State: AOJu0Yw9W/FNkQCgTKvso+Zi8Aj5tOKUwX5J5rqfWhoHWPVqE/UiS8YP
 qXf0Zdytl9YrLri/OfCM60Ugz7W/qPA=
X-Google-Smtp-Source: AGHT+IFCRX0+iFGuIpxRv4AXdC7/+t1qds14WmAKBSuUE3DyRW4AvAFznkAgb1nMDK6Xz7HQGCDzBA==
X-Received: by 2002:a05:600c:5121:b0:3fe:1b4e:c484 with SMTP id
 o33-20020a05600c512100b003fe1b4ec484mr6321884wms.5.1691935950403; 
 Sun, 13 Aug 2023 07:12:30 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:29 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 18/32] Implement stat related syscalls
Date: Sun, 13 Aug 2023 05:09:59 +0200
Message-Id: <20230813031013.1743-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the following syscalls:
getfh(2)
lgetfh(2)
fhopen(2)
fhstat(2)
fhstatfs(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index f8f99b4a72..935663c071 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -127,4 +127,87 @@ static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getfh(2) */
+static abi_long do_freebsd_getfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(getfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* lgetfh(2) */
+static inline abi_long do_freebsd_lgetfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(lgetfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* fhopen(2) */
+static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(fhopen(&host_fh, arg2));
+}
+
+/* fhstat(2) */
+static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_stat(arg2, &host_sb);
+}
+
+/* fhstatfs(2) */
+static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


