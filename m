Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D87ACE42
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbT0-0003Z5-RP; Sun, 24 Sep 2023 22:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSx-0003WN-Rj
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSw-00007o-8N
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so5245155f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609412; x=1696214212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJNgA7i1skSBgo3G8Dhw1FER8/CjFW3btNuWKszZ4Dk=;
 b=P7gOFedIEqO5lwno00loIF3wfUPtm2MA2slXBdGRx/P1iOZbRmc4lMkiXkGu6hPbAs
 CsKKWc/5CN9ujDBQci9r3NGZ34TLrfeLdMbAV64VHi9C7QsTJJwBHzIroPgOx95LjAxI
 qA5vT5DgB6EisD5y87rPveXmD9NjXunf5F9E201WPGw5gtL7WF/e/SDm/QgZYj1o2Ggm
 Ki44TbJRKLK5JsWtPY3z7bpOYw7Fz5uylZW/y58brq/uFbz7R4B7EogY0goos6vGoR7G
 cMNNakhYbO/Waa6TVrKJjK7Mv33EctQEnUP1PCT9P6zpxdjVqnVvmizjuwucX8DAMAmn
 Znag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609412; x=1696214212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJNgA7i1skSBgo3G8Dhw1FER8/CjFW3btNuWKszZ4Dk=;
 b=I3ACTuPJG3Ip6v2ZFScXUfFVUzSQtF0o5MnY8gbsz9J5woE9RvFqITBbni54/QOuos
 Xvqcw+X9w5NVPySIGhh+zdiPh8BKKBrEXBz1wEOgxMxKPrC3Wwr5C67ebpE2sbwp2a+z
 ktg9/lEVR390PJVzlNPAPQCj99WPx5ytvljIjjFChqiNkbHoKzTGLsvm/tc/hmiWwqoT
 ZiEoSeuEaF1ZR/bVSeCtRak7qdk6k9UTckav1AZTGimwlws70z7ynk5+yC38ecpwB7Dd
 OzXjjxLt8EHsuvxo4p2tyjdVD04kwjunrBiZ4hbv/xSEHNl2KSyDEMCJhccz6iQO3S+Z
 HOlw==
X-Gm-Message-State: AOJu0Yw+vBSmArriPHZc87th8WLoTRo84IFaRt5UGyX/iPnejIIAQkOm
 HdIn4CZxssLrOc1kpe1cnFJamAm3bm0=
X-Google-Smtp-Source: AGHT+IG/lu12jtLuQtzmCYGOrHexLypslvCGGe8vvy3qGGiPAkAxQadjpqAdVFlRbsYZZ9UA0U7hvw==
X-Received: by 2002:a05:6000:1c7:b0:320:261:b87f with SMTP id
 t7-20020a05600001c700b003200261b87fmr5342430wrx.62.1695609412069; 
 Sun, 24 Sep 2023 19:36:52 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:51 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 18/28] bsd-user: Implement getpriority(2) and
 setpriority(2).
Date: Mon, 25 Sep 2023 00:01:26 +0300
Message-ID: <20230924210136.11966-19-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 2c1a9ae22f..9a8912361f 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -390,4 +390,28 @@ static inline abi_long do_bsd_ptrace(abi_long arg1, abi_long arg2,
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
+        return -host_to_target_errno(errno);
+    }
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
index 1a760b1380..71a2657dd0 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -359,6 +359,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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
2.42.0


