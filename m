Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F778B941
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZO-0000zI-Rj; Mon, 28 Aug 2023 16:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZL-0000v0-Lv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:39 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZJ-0007jJ-Br
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:39 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so450006466b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253436; x=1693858236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsF5lR/xA+aNMrZWO0/VuSFRuaGJ+PJkz50iHadMyng=;
 b=WY1aOkasH4eO94tZkL2By8Ou73oyIV0hV3FzeBd/wU30cbzpo7Bm3NA5BwD/EHbCv6
 RglJA1LMmq2i9xDTs5FNKzw9Qrk+PbWxlPczTzD2stIvz5ki7APV2hEXjGHisQD5h035
 zNCigN6Uov4f+bNOj2TcwDJLH/XDTH3kjcL/GyrYmWX8ce+f4rBh0qvzyYsSkojsoz+c
 eU71ZxoYaSvJFLoTm2Aa+KST+n51cZIb2apGB3mBVn/QernPIfRqs9aDxb+81INTvV4B
 OIMGsmvJ3Agr5CxuWrhfAC36CXFPkaatf7uXcvFM97tVLayEnyaTMXGxNgIVN4Tj9+do
 o/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253436; x=1693858236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsF5lR/xA+aNMrZWO0/VuSFRuaGJ+PJkz50iHadMyng=;
 b=OAs4Oa0Dmfr7/3tNQGFEHS1w7Des/bWwtqv6+lLk7IF0SUyU77+qfJuL3W9YP3X8d6
 94TX3bFsp/RgrBEuwUvciJ1c2JNvlHyZfqntyjalaUmB2RAOhpkLVnNf0V+KCmN2s+BI
 oiL77JOQ0pcLc6XE6GfCgKuewwyHy82meyWe1YfKnxh2t8tWpvXy+vJco/ZIHZQ7Ewr9
 Zk2YnZM5ATGOSkAxmJSP74CiVf42KBJlE6YyYtzKooaHxVkIG45LV/AVaWAhwmJ/MTaw
 WcKW5r5QnfMAGoWMiZc7ahncjItzpk3BZucV05hn13oJ6cj/wvgX7KGXxuA0Fc0MRXm8
 wkaw==
X-Gm-Message-State: AOJu0Ywz7VnC9Z/tqZGknxr0GXYZ3PQptkJ0nPGUGaDtnmuNTFySamsG
 4ay+e+GvBZ0UkJMsWxNRH3SnEczrRhXf+A==
X-Google-Smtp-Source: AGHT+IH9FKgqiFkyBU076iZq6Q3ZjPE2ua533pBkpkjHu93m22XMYrs6NDlHJiB3MOBgG8rhT0mPcw==
X-Received: by 2002:a17:906:5a55:b0:9a1:c00e:60c5 with SMTP id
 my21-20020a1709065a5500b009a1c00e60c5mr13727313ejc.48.1693253435703; 
 Mon, 28 Aug 2023 13:10:35 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 19/32] bsd-user: Implement getpriority(2) and setpriority(2).
Date: Sun, 27 Aug 2023 17:57:33 +0200
Message-Id: <20230827155746.84781-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x636.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h           | 27 +++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index c9b5a4cbb6..c7769e3560 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -390,4 +390,31 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
     return -TARGET_ENOSYS;
 }
 
+/* getpriority(2) */
+static inline abi_long do_bsd_getpriority(abi_long which, abi_long who)
+{
+    abi_long ret;
+    /*
+     * Note that negative values are valid for getpriority, so we must
+     * differentiate based on errno settings.
+     */
+    errno = 0;
+    ret = getpriority(which, who);
+    if (ret == -1 && errno != 0) {
+        ret = -host_to_target_errno(errno);
+        return ret;
+    }
+    /* Return value is a biased priority to avoid negative numbers. */
+    ret = 20 - ret;
+
+    return ret;
+}
+
+/* setpriority(2) */
+static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
+                                          abi_long prio)
+{
+    return get_errno(setpriority(which, who, prio));
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7c5c17e70b..0f25187d63 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -356,6 +356,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ptrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_getpriority: /* getpriority(2) */
+        ret = do_bsd_getpriority(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setpriority: /* setpriority(2) */
+        ret = do_bsd_setpriority(arg1, arg2, arg3);
+        break;
+
 
         /*
          * File system calls.
-- 
2.40.0


