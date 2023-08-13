Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E977A6D5
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:18:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpp-0008BC-Vg; Sun, 13 Aug 2023 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpT-00088M-IN
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpS-0000qm-22
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31963263938so1538054f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935944; x=1692540744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifoCtKg1yGM9PYJTvZyGZBbRR1jmyTpgo6v/+2GRTtI=;
 b=U0naJt4S8fbKvFWJ7boUvFQ6ybSUTzVPr/oQqDBz7nGlAwd1TFV1kgOhXnrqxp5B5X
 LtTz3lTYcc+yIRh8xqueD0CFecP/Z1r1WmAe3wEoORse4WJiT4d23xyouSWy94G3LecW
 +VVOidOWxQXIoFG+VAJeoguV2+bloJQrPBDR5tOWvrVhRdnpfp604eJwqe1tIt6YDmcJ
 ey3wErRsu5eoC73rlzn9snSQDzvnK4rFCJJAaCfc80SzLEehoE/mJXdNrhIawymTfRTP
 6rf/AiGWEij4Sagl3VoyJcLbYtBbixvIQuHOrQHJ/wtZFWrAxxNh2+c2qXHIsIgKaKYh
 wUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935944; x=1692540744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifoCtKg1yGM9PYJTvZyGZBbRR1jmyTpgo6v/+2GRTtI=;
 b=WAUVgqMxD61dpXrzCy1Nglx9wMSa4I05g2xCZiPc4Z2HgHsGI4Xfn4Vs3R9auFGzor
 Df5gfVS+ygJ3zXj8nqw7LLVm4yiqeJpqIlnGRJlmN4eCU3RRCJ6gDVuWhbB6WaDU3jrO
 cT5rJ+naPWoaGmw4w9jFDLraJ7db5O/poh4jsAr/2vslVv1FYWCyUD/V6IaTpmlnrLQ8
 /8vi+jT894fWDQlXNBAtleokPaIhE4uwpu59n7uMYT6QM+XSp/axAqkAacKt/AFkiJaf
 QI8/V94uXrWnfnFrfxTBM1tN8qyI0JZouK4AvTzUsYXdnCCliZjyYiLZdGLHUam/KFOQ
 gCmg==
X-Gm-Message-State: AOJu0YwK9AdPYSmR+ktR/C6KUgX+tCm4s2qAx+Gp0BItLd5a7UDOKWOR
 2vYbF3lgbZxMZnN1tJn5OkolF+Vz1Rg=
X-Google-Smtp-Source: AGHT+IHtCVnXJWDNQ2oUoqEKfkFrjJ83xX+2W5Q1mJBtFN1MTamggyP03XT6/ZsELHqBFr8KJ21oXw==
X-Received: by 2002:adf:e348:0:b0:316:ff0e:8213 with SMTP id
 n8-20020adfe348000000b00316ff0e8213mr5161813wrj.15.1691935944268; 
 Sun, 13 Aug 2023 07:12:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 13/32] Implement h2t_freebsd_fhandle t2h_freebsd_fhandle
 functions
Date: Sun, 13 Aug 2023 05:09:54 +0200
Message-Id: <20230813031013.1743-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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

Implement the stat conversion functions:
h2t_freebsd_fhandle
t2h_freebsd_fhandle

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 8c73f7402c..6716cee3e2 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -92,3 +92,40 @@ abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * file handle conversion
+ */
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_READ, target_fh, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(host_fh->fh_fid.fid_data, target_fh->fh_fid.fid_data,
+        TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_fh, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(target_fh->fh_fid.fid_data, host_fh->fh_fid.fid_data,
+            TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 1);
+    return 0;
+}
+
-- 
2.40.0


