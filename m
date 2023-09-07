Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22B79964F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfN-000119-OV; Sat, 09 Sep 2023 00:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfF-0000zQ-7w
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfD-0002vu-2O
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso1852566f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234021; x=1694838821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQPQkmqbnFACQIlUwkAtPXqSarrHZNN1zhubxQ6WoBA=;
 b=KB5Mg1cnwpYR89z22XtLLOkUHK6vPUohHOX1gujODfYyXKOmAFCWxVzSflBvSFzI99
 /gBExeNc5/OMYNr9kfuLinQ78HflYlRiFbRtjnkbQIeP19OyEmTNDO06kvpJDR9ncQJq
 p8apBkPajGCMWfx6eKlg306uG4ibQB2Ud9PKfTK6xkoAMKZlsD0DIwt/RJfy3nYvt8WR
 uz8pxezLZn1jkd3q839TmZVH8QWZJxQZBBQrIBjHHD1JKvwzeEcX5Yn4YsJ/OAgOU/jS
 sH7QKdlHcL++OV48GAVAZRkTO/CsXsHvAwsMTy0AEQb6Q8AgyMv7KXSrdASMBs45334I
 DwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234021; x=1694838821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQPQkmqbnFACQIlUwkAtPXqSarrHZNN1zhubxQ6WoBA=;
 b=VBiOfVPc7Y+pO9+Im1RJgkQUf5Z+6s8d1AIWMgoU286ikKcjAe7w2XMS/SaA1jJxBO
 6z472VUDCNDvjj2kjHcIWcoggexi1twiebG3wGFiK6XnGwpUXoUzTQipFoHhnQfMwIOE
 VVMHDdNuF73ll3lKLy/lJcQWypy9GYgtb9K35gWzBSU0h4C82qcRbk9FzDl7DlAVFTCW
 wRDKTbycgGzy1c3BTK/VIGwivk2HZga49QyRez0Y6s7fetcRhoL1htnNG8D6rVARwn9C
 sNyslYJ4K8o9kDe97Gg8JzG5tJs82+38y6LtLknosHrYMYI6H5i1PaGIA5ouw0OdiCaZ
 ZSyA==
X-Gm-Message-State: AOJu0Yy4WJllZv/zmp+ljONirnLZM2xXQYs2st/7qdir+eRTGemJGKFP
 /6SZ3f4cP/2qsFPfe1jatuIxXPzriCc=
X-Google-Smtp-Source: AGHT+IG6Hw0IwcyY7A+xgHSGYHWjw2DyFUi9jD8bw10JhsQ/2Q2PgpU4HX6GWiM38aQx8TJu37CF5A==
X-Received: by 2002:a05:6000:c8:b0:315:9676:c360 with SMTP id
 q8-20020a05600000c800b003159676c360mr3735985wrx.25.1694234021098; 
 Fri, 08 Sep 2023 21:33:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/23] bsd-user: Implement shm_rename(2) system call
Date: Thu,  7 Sep 2023 09:42:45 +0200
Message-ID: <20230907074302.79234-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 6b424b7078..67e450fe7c 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -66,5 +66,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 }
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index b4311db578..2920370ad2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -495,6 +495,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.42.0


