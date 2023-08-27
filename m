Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D878B923
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZH-0000Hx-BL; Mon, 28 Aug 2023 16:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYx-0008B6-7p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:15 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYu-0007aC-2d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bcf2de59cso479201366b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253409; x=1693858209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndeNKsdGcTFoKqxXfBgmIgWoV6MfU8iaJxUoXl7FUgE=;
 b=Dz00dyfloFHYsiU6muXzypwa2AYnRwtNReGwl0DzjW1Alu33p5jXaWvLLhtGaSeIlK
 ki77EyW+CA1hhcB3rqqhtmA0TEO+TYnnuHJgTYathnXVpjRVbTQ11T8hFwfeS6AIWkp1
 UYdjkAa0xeWCNRA2F78dzAzT1BlfRvBVJc82W5Hk6eX+NM2YqVhWgQNAufAe2yKCeqMH
 xa1cvbbgQmnNEB2X5QyEqZdlWKgAHK5HcnH2WTPZavPPjhB+VlfE7B0i8OdmKt45k2gf
 EMjDIpxUUNKxb1XEKRMeQlReE9Iq4LSi28O5DIE6koZMA7Iequf3EZAMrjQn4WeuKYQP
 6xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253409; x=1693858209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndeNKsdGcTFoKqxXfBgmIgWoV6MfU8iaJxUoXl7FUgE=;
 b=BbVogYp96p3ZWYS7ehCHC3FK7e32xgSUKBIr8zy2XfD4ScJt/yDqrERYsAsFomVtAZ
 6DKo5y2nsTWCZh1pWje41h5c0TrN95R+xyxF4CoI8jorK+bd0x6RzK4bwjpw+ygbRC4y
 SsKM1r+Dho/OWMvGSVTku5mFqz+z6T74SxZ2RwW7VWBzZowFYX233kCTEoDN6gEaa+GJ
 18fGNtGoFfoGgSs2wC/r6NIiqQj2A5HIevunyLlXMl2sG7gO7ecCucVPyy/fVJYd+Cg3
 YqYN4KqWfzk6DU6v0RZg4Fuu8pIqOaZi8puvv/l1XDLLd2F0H1imD0ksKgb5gqs5h2pO
 EADQ==
X-Gm-Message-State: AOJu0YwSuIgETUCoXlOqTRF0P2RUH5KlJoD537ohk4N9lToiKoH3e3Kv
 uydX3k30fjcSfAU50PwDYan7HUFKWHA/2g==
X-Google-Smtp-Source: AGHT+IHQ6eWd9yoGCwpIgf7FlpHny0+1t06KrQbZklfYRKZX+46zWPXeERrjEGRxHgaR6PtxwnxHCg==
X-Received: by 2002:a17:906:2932:b0:99b:4ed4:5527 with SMTP id
 v18-20020a170906293200b0099b4ed45527mr19048258ejd.25.1693253409227; 
 Mon, 28 Aug 2023 13:10:09 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:08 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 09/32] bsd-user: Implement host_to_target_rusage and
 host_to_target_wrusage.
Date: Sun, 27 Aug 2023 17:57:23 +0200
Message-Id: <20230827155746.84781-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62d.google.com
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
 bsd-user/bsd-proc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 12e43cfeca..8e6dd5e427 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -114,3 +114,57 @@ abi_llong host_to_target_rlim(rlim_t rlim)
     return result;
 }
 
+void h2g_rusage(const struct rusage *rusage,
+                struct target_freebsd_rusage *target_rusage)
+{
+    __put_user(rusage->ru_utime.tv_sec, &target_rusage->ru_utime.tv_sec);
+    __put_user(rusage->ru_utime.tv_usec, &target_rusage->ru_utime.tv_usec);
+
+    __put_user(rusage->ru_stime.tv_sec, &target_rusage->ru_stime.tv_sec);
+    __put_user(rusage->ru_stime.tv_usec, &target_rusage->ru_stime.tv_usec);
+
+    __put_user(rusage->ru_maxrss, &target_rusage->ru_maxrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_idrss, &target_rusage->ru_idrss);
+    __put_user(rusage->ru_isrss, &target_rusage->ru_isrss);
+    __put_user(rusage->ru_minflt, &target_rusage->ru_minflt);
+    __put_user(rusage->ru_majflt, &target_rusage->ru_majflt);
+    __put_user(rusage->ru_nswap, &target_rusage->ru_nswap);
+    __put_user(rusage->ru_inblock, &target_rusage->ru_inblock);
+    __put_user(rusage->ru_oublock, &target_rusage->ru_oublock);
+    __put_user(rusage->ru_msgsnd, &target_rusage->ru_msgsnd);
+    __put_user(rusage->ru_msgrcv, &target_rusage->ru_msgrcv);
+    __put_user(rusage->ru_nsignals, &target_rusage->ru_nsignals);
+    __put_user(rusage->ru_nvcsw, &target_rusage->ru_nvcsw);
+    __put_user(rusage->ru_nivcsw, &target_rusage->ru_nivcsw);
+}
+
+abi_long host_to_target_rusage(abi_ulong target_addr,
+        const struct rusage *rusage)
+{
+    struct target_freebsd_rusage *target_rusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(rusage, target_rusage);
+    unlock_user_struct(target_rusage, target_addr, 1);
+
+    return 0;
+}
+
+abi_long host_to_target_wrusage(abi_ulong target_addr,
+                                const struct __wrusage *wrusage)
+{
+    struct target_freebsd__wrusage *target_wrusage;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_wrusage, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    h2g_rusage(&wrusage->wru_self, &target_wrusage->wru_self);
+    h2g_rusage(&wrusage->wru_children, &target_wrusage->wru_children);
+    unlock_user_struct(target_wrusage, target_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


