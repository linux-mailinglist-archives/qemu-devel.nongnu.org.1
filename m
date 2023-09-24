Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431627ACE41
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT7-0003f5-Qg; Sun, 24 Sep 2023 22:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT5-0003dj-SR
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbT4-00009c-FX
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:37:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so646047f8f.2
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609420; x=1696214220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veKd30oIcTHeerV4sm6Po5eWbUfHu/04HcESP3anl/c=;
 b=VN/ChUcnLKp9Du/hkar3EYEdXwS4qGkDFQu/79/J140shYTa4dmWOgtoWx9Os2TnF4
 gsFKuLrJS4S55aeFhDXjm00KK9db8rVYWJPEDgHCt+SYRiD9jbnCbu+JkC75De6kB1Pd
 yslku3pnByjq5zspRfB1gCgJnJbn3NUkk53o2RkoLNVpb3VLZ6uTZsEKuziC2Rsv9JcC
 O2ve620jfmVjLGTYlVzKCSxs3270asa6mOg43ZCyzNMCcD75u6c/P6qLJrvnqPipDzVk
 lCsv24UwwlfFbnah9vDuf70PnZWW0zncCRWEWJBGrVyc9vOHPCmTnzHarVzu3wRb101R
 KP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609420; x=1696214220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veKd30oIcTHeerV4sm6Po5eWbUfHu/04HcESP3anl/c=;
 b=FJ789lSj9ZSuIwODsS0t1SVuMg5UolbSrAxFaXJ0bkHWVph6Wc9RXKTuRkFdTGmbZH
 1d88LyJKnqZ7OcOG/AYpB6Rv/7FaS39ICiQm1phEFu+m0noVP622BDcREebukdVVmFDe
 q6oyHC+fdYIdTqUNYG0Nbi5ZztjArbyubbiL1kJeRYAtOIk+FDl+sKGb2nviZmLYPtyL
 P345PRglcnb9JMVcDxC2/qOf+FjPqjal8tEv9ACycaW5UsODI6UTYVnmfS+0Db9Xutyj
 tRoOS43tdsuu6OFot7kY7kbEiwENezyc+TqWArM7b1EwLjpIP5yhzivpTQg7H5wRjJye
 BWqQ==
X-Gm-Message-State: AOJu0YyWGkJHB/ZbZqOvIl9big7Cv52KdtW7w/KBikPwcllPjo6MkfeY
 spABUnxzYoGl5RNSmT7XoT3Bl2uB6LM=
X-Google-Smtp-Source: AGHT+IHVlSUz5TSgKFc37ZzvpmijfXLDXo3gX0H3IvIQpb1TUSPmlbzNOCpsK/4TNIrz2x/ldGoP2Q==
X-Received: by 2002:a5d:6084:0:b0:319:785a:fce0 with SMTP id
 w4-20020a5d6084000000b00319785afce0mr5114915wrt.26.1695609420446; 
 Sun, 24 Sep 2023 19:37:00 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:37:00 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 24/28] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Mon, 25 Sep 2023 00:01:32 +0300
Message-ID: <20230924210136.11966-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 04bce755e5..2eaba141dc 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -130,4 +130,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     return ret;
 }
 
+/* setloginclass(2) */
+static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setloginclass(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getloginclass(2) */
+static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getloginclass(p, arg2));
+    unlock_user(p, arg1, arg2);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 55e68e4815..d614409e69 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */
+        ret = do_freebsd_setloginclass(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */
+        ret = do_freebsd_getloginclass(arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.42.0


