Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C307A0EB7
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZX-0002tR-Ig; Thu, 14 Sep 2023 16:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZV-0002sl-IH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZT-0001UJ-Qw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so14555025e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721854; x=1695326654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RLJ4zSpc/hhC1DTqvPXVuxIGqkkJ6Cdn6Mza5ndY54=;
 b=SzpYOTnfrkSMpe2hZlsb5rkQZnsIKLyk7JzXr6fNia4YpLL/NnYBYe22HRa7rjVwZF
 1UUJcsQH+QLh9XlcHRRnZIpv/MGFqJGe2dgQ6u+p2gI0kwuR0C5JBYqcC1QlI3w6wcwN
 76XTqbrp1LcBs2P1isyorv5hTWxVBqNwdmBuiSmLlZTWVuBvkzvjm/v00ig2s0y0Sv6B
 ftmWp1Jl+eXTimj24w5QlDvnZRIySvayK0SUUvcTMttQa7PVnmWXX2DYXS8CpWLODDUD
 iJv++6odIX7SvZy3iQIizKru2pXGIGmnLX0kI5XSzF/Zth1UVKowhS5Um6t+2V5EdUji
 d7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721854; x=1695326654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RLJ4zSpc/hhC1DTqvPXVuxIGqkkJ6Cdn6Mza5ndY54=;
 b=uMWWHspeGGS0uOm1cFXabfvalJhje8+TO/wXPg31nvCzugTn3/IKf4f4WDZPUemCrU
 tiplVA/SI+2GV3DlTjhvgwSS7rq49v4u8lpUypBiaChzbBmuBTf7q6jKpl7VJsLHZ/Rb
 DLFCesyp4e6zEf+yrav+Lbc6l2cb7vBHTvdmqs9rnJjLk7c+DxFvzbuMgNJv+6B+hx5e
 htIIcbquXXyRXnbjppMDcU36MI4Q7GrnUr51R1qOFWm79o5q0Z/ykdiyV0SuMZwc4LQ6
 iKwKlSM+bowtTEqclwjKetNv1mVWA7vjOb7p+OiCvhP0pqcJz4+LTKg+YKDmy64nyYY+
 SJ9g==
X-Gm-Message-State: AOJu0Yw+rkrM0jfdAkteFP74XiNBetT/1Hgdm90g566NrLY7/IkHLlQ+
 riWTAcTSNTr2NnwPQ274E8LRSs5nNGI=
X-Google-Smtp-Source: AGHT+IF0ox3gplKzCYY1Kp+pY2oK1i3ipJ6T4Usmnuim++i77+fySNHrTfZAfmo9nbtWGMcwGR7TKA==
X-Received: by 2002:a7b:c455:0:b0:3f7:cb42:fa28 with SMTP id
 l21-20020a7bc455000000b003f7cb42fa28mr5422755wmi.28.1694721853552; 
 Thu, 14 Sep 2023 13:04:13 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:13 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 06/23] bsd-user: Implement shm_rename(2) system call
Date: Thu, 14 Sep 2023 23:02:25 +0300
Message-ID: <20230914200242.20148-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
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


