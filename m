Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 672B5774108
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDv-0004UO-G1; Tue, 08 Aug 2023 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDs-00047e-7S
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:20 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDq-0003oQ-8q
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317e14b0935so42459f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514616; x=1692119416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdOxVXghhdO4DgKur4m3AtRQMe0xFu/87Bd79EJQ6xk=;
 b=T0pBoiGQZV6yUYFcjcfxBCj0v9h5Q+KeImVmbogLdr03RkUWi/4YtdWvrMXMSyb+rC
 ojCn8h5uPq4UkA4hbFtiOzt87nnW8KT6myOiOWKDncryrF3jLdIMLcZUVIDmZtKqg0kD
 mHrUufTgEjcsD8SHDlaY+bHKN20h96XEvH+tKO0DYOAWf7uHaX4SSALcSXsloF2/nnrc
 7M7iLnGVz9RYJDr/NJz43SQvvRbKnLAbMTt2FFYCVu66XxQ5r7vMpljV6lKeAsV14hfR
 EuOen8BjFRdtf/OKfy3zZ9z/RQPcILHr2E57O1Q+/KSvzJK29qe/Khc7BaIzBOr61T4O
 vgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514616; x=1692119416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdOxVXghhdO4DgKur4m3AtRQMe0xFu/87Bd79EJQ6xk=;
 b=PKUtfS1Us4MJrrxGX9EM7egrNf/FNxWswCiM4PmGZQUAK5hPMOu9Pt47DzhbSK719+
 NzYT9KXC8sk3SJGb+u64v+ztaN+vGXGq6d4mL0aUi43mNvDNoN9hupjk7u8C7wphFjPR
 vVtBgFRAHK1/1uw2noW2Abda8B5t1jUQO5Sw+Z4IFgIxQkoqxx+frNiulUIW29zwhX5n
 jZ10q1SkErVhJafKa7EECrCWm2PmmJ2QYL9fliOQ+BctQOrFgk/Qt3Ft7FrQtWl25CTc
 wqF9s6LDQSlXOt7iKXXiAHhSFd0318k9uKkTH8I7VB7M3gDXLyp6hZM3/0FGVjABP89v
 DkCw==
X-Gm-Message-State: AOJu0Yz1JZSzmvDcXf21Z08JymbRqypwxvTvUqxEgLr60ArHQjXRNuxf
 Sdx0n2T/bswD4C3EatS5xrOuouXCYoloAw==
X-Google-Smtp-Source: AGHT+IG1Jl+df69Y/ma761rJig+vDNxS1qO0dxFUIV8gFyGCqhxQPR7L3LrXURPmbg6+kX16dRTxog==
X-Received: by 2002:a5d:4249:0:b0:314:3f1:cebf with SMTP id
 s9-20020a5d4249000000b0031403f1cebfmr8638062wrr.28.1691514615843; 
 Tue, 08 Aug 2023 10:10:15 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:15 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 28/33] Implement do_freebsd_realpathat syscall
Date: Tue,  8 Aug 2023 08:08:10 +0200
Message-Id: <20230808060815.9001-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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
---
 bsd-user/freebsd/os-stat.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index e31b2aab9e..cf56c778ae 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -634,4 +634,30 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
+extern int __realpathat(int fd, const char *path, char *buf, size_t size,
+        int flags);
+// https://svnweb.freebsd.org/base?view=revision&revision=358172
+// no man page
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


