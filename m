Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDE78B920
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZJ-0000Xn-4n; Mon, 28 Aug 2023 16:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ8-00005q-Ka
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:28 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ5-0007dR-8P
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:25 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-991c786369cso469091166b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253421; x=1693858221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVIqVPnkGSyrltmga8v21mUu5LLn049UQ+w7KAp37Ns=;
 b=edfB5AYHyGXvYK1m8vFLKptoaI+NEPZQ9qPDry6mkkd1xYBECg+K3MNMA67Og0ntnJ
 gx4LLEbfWiDxQFW1jbWVE9cT+TzZg/mDslgUxjFhJyJ4ME/i7J1fbsfrV/X0khK/Wjs3
 A7e5eeLJWNB9da/tajUNOk5bkYusDgmqPZkqD8oIC/QLAk45mZK1TU14ewUIme6Z50cK
 vjTTCOmqIXA70aocfJPEar9GIUGvZTFKSv1zGtS9L5dlYkWBpoU0r08XRel9yXDLBa5Q
 tO4PmIrhQIBV+yRC4vrqxr3Bzp6+YZcN0dNxPDQ7LMpRKGfWAzkSRMtf0bU0KtiJnTji
 VRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253421; x=1693858221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVIqVPnkGSyrltmga8v21mUu5LLn049UQ+w7KAp37Ns=;
 b=copasMdrFOw99bYRgKmvyVmzK6aN2Er+KA48qIERgW5KO5m7XGChvw+Rsz0HMWjqe8
 T/jPVJylBkBsoSLjA09puf3kmUe8+apNqj8xEMSPI6MBhPuFBuMhY8ud6xExGa73/FyZ
 mmEZ6TDiUxhctPA5dujL2RFS1FfPjH1saQGxEejDAc0XQpvtUzRp/G4LwnO1TqV/WCvx
 uahaiCTilrXEXAvhkyESHsme8qMD3GvmU/EyDNxRNLlxG59rLTXH/pEqqp1G15jT5AGh
 gtymM1FXCOq8/Vm4zORCqKoZb0oatDDrdJaV1pwZxVDCqgeb27uFbZjUmOX+Gj/TMpiD
 lfJg==
X-Gm-Message-State: AOJu0Yzf6fbihPEiNjSX9OphJEsRM51GHqOcQOsmQCrXMq6pWCdVmu1z
 D+7EXbupAxlzfrZIMPYOJ2WkKvsn/4vlZQ==
X-Google-Smtp-Source: AGHT+IEjeFF1xIrnHQ06JZXYpSLb6kQkxJh90GpsOcVsottbXmW0rGmtMqDGZ01++Dt+dSezJoue6g==
X-Received: by 2002:a17:906:32d6:b0:9a1:8ee9:cc0b with SMTP id
 k22-20020a17090632d600b009a18ee9cc0bmr17532430ejk.21.1693253420795; 
 Mon, 28 Aug 2023 13:10:20 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 14/32] bsd-user: Implement getrusage(2).
Date: Sun, 27 Aug 2023 17:57:28 +0200
Message-Id: <20230827155746.84781-15-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62b.google.com
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
 bsd-user/bsd-proc.h           | 13 +++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 5228b4be78..ddb5a4d452 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -124,4 +124,17 @@ static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getrusage(2) */
+static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct rusage rusage;
+
+    ret = get_errno(getrusage(who, &rusage));
+    if (!is_error(ret)) {
+        host_to_target_rusage(target_addr, &rusage);
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 194248924d..f7c4a64f9a 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -240,6 +240,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getlogin(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrusage: /* getrusage(2) */
+        ret = do_bsd_getrusage(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.40.0


