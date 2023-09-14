Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549577A0F2E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAg-00038X-3z; Thu, 14 Sep 2023 16:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAX-00037G-72
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAU-0006GD-RH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-404314388ceso13012355e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724149; x=1695328949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7uKJtjQDxrpcslNDuL3FuFOFPTPw3U7VbY8diH7n9M=;
 b=LnhmnhJ5pycdWo8MSzy2ToPCF9RyFryisLk9A39YT2iFcMEh8/joSXApYFOtNPZUeA
 BR6LDBEG0Mwqsx8NggmzFIXhwe9QfPKTjQLMbEIne8j7IpO5Vv18DKxX7Y1T66oDYKuL
 90ivaPr2EY1zr0Ut8U+nRNpzCsnTrxx6JT2BeOr0s4g9UVmzdBjiAI/fIxmIwh8W4T+/
 mswDKUKJN3DGjGahtpmUOGl37JpP3QA0/36vPwriH9KE5qkbewj7HvbZsJpmSzUjz2Sf
 4Il/RoM4G+2AD+gwka8+X161WDwy6f/88083+wJm1Fzgg3ZvqeloyYWlXnwsZV0ciSlb
 j2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724149; x=1695328949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7uKJtjQDxrpcslNDuL3FuFOFPTPw3U7VbY8diH7n9M=;
 b=FubMIYbdSghRufJOeTTZH1Ltgv3Ip2PJu2Lc146nxDjTfovDBGtAVbdVlvFHV/f5/I
 tOV80O9ODwA5/TIBGDEaJh/rH21Mg7U4Vjd+q8LZ4gqHRuQqWZRg8VYPDBYbSFWiyq0a
 fg0Z6rYKX515168lRxxtz2fExAqfZaf8/bKTpxllQxvJoOiHg1uPz44Uwve6Smp5/9EG
 YVeJIlnRGhqxNRqd+nUzBy99C/LuKoDs4Ava0HHS/b4Gygo0oi6nq0uIUc+YHBDut68q
 CMTP+z83ObDuwj0gK+GmWnnZfueTJTAyOwevKkKar+APipiggQtFIbWoj+xD/BgpZiMM
 iLNA==
X-Gm-Message-State: AOJu0YxPEZMc0jbhRPq1regTrQNl0M0WoFtE0Ke7gjl7f1b+NX/hcIC5
 i6yiijfahPpKDqa/Fh2jA/wRQjs5K8o=
X-Google-Smtp-Source: AGHT+IE+5iUwBb3ADsDLgtqV4y98973Ta+plaxrSmUifQhtcm29UpY4AdwX705DmA1nazQ4YU6dnWg==
X-Received: by 2002:adf:e283:0:b0:317:6a07:83a7 with SMTP id
 v3-20020adfe283000000b003176a0783a7mr5060874wri.38.1694724148750; 
 Thu, 14 Sep 2023 13:42:28 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:28 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 01/23] bsd-user: Implement struct target_ipc_perm
Date: Thu, 14 Sep 2023 23:40:45 +0300
Message-ID: <20230914204107.23778-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9c90616baa..4deb4fed35 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -55,6 +55,23 @@ struct target_iovec {
     abi_long iov_len;   /* Number of bytes */
 };
 
+/*
+ * sys/ipc.h
+ */
+struct target_ipc_perm {
+    uint32_t    cuid;       /* creator user id */
+    uint32_t    cgid;       /* creator group id */
+    uint32_t    uid;        /* user id */
+    uint32_t    gid;        /* group id */
+    uint16_t    mode;       /* r/w permission */
+    uint16_t    seq;        /* sequence # */
+    abi_long    key;        /* user specified msg/sem/shm key */
+};
+
+#define TARGET_IPC_RMID 0   /* remove identifier */
+#define TARGET_IPC_SET  1   /* set options */
+#define TARGET_IPC_STAT 2   /* get options */
+
 /*
  *  sys/mman.h
  */
-- 
2.42.0


