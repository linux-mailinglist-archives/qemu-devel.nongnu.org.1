Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8202382B531
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0gV-00060H-Rn; Thu, 11 Jan 2024 14:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rkCgZQQKCuMKQbZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--flwu.bounces.google.com>)
 id 1rO0gR-0005wo-4q
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:25:43 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rkCgZQQKCuMKQbZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--flwu.bounces.google.com>)
 id 1rO0gL-0004Gi-O7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:25:40 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-6db0c931f7cso2966000b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705001135; x=1705605935; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yU8Bwsv4Ub+jQ+i0pE2G4S+631LJCrBTTrKsYCnLbHQ=;
 b=3aR8szKVJJ2pgQisNi8SZR9HosaTBj+MUM4HYDjug7JJFhI3XLVPKWb7VZEq0OKW3/
 VhzTdmSrRVva+mZHtnaVxoaxHftglFt02lsC3BkY4xMwekY3Pttk/NynQVwLtK1igfHm
 KqKOaBBewKH2U0aUAo4gOWGzzNTlBqJNJ/iKN8UfRHXCuOC+EZjuOdGN1X8oetg7mLME
 F0K/aTwM6kuy9LDS1NV5VjPj/P614jpJCB9uPb5rHUtbhwRWk/JfRq4WhuQWBeIeM12E
 v/wDADmfffuCySJSbmWvWw2dDd4eJkFTqbnj7ZV2potGZxhfYYp7G8Z+TjktFzSOH54t
 EbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705001135; x=1705605935;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yU8Bwsv4Ub+jQ+i0pE2G4S+631LJCrBTTrKsYCnLbHQ=;
 b=n1peTtiJLejv+mFGG+SsEWbL6VO3jG1DbBe64rRbg5lQzFLjbFCTJGHswe4TAArnE+
 hbBATfKuSfijxOuh/ZoELUJJmEdNPMP31e9fTrCxzA8qGtlUgsjVkYYrY5s+EoO4Bcx2
 fuA9UhS1/kjVMuJfn5LopBJ4OnJCtsrv3j3Z9mk693JS75OTjxrcukJ5qtxZFlm3fknT
 GLuUUnafFpuiXIMxA9xvtXAol9WXNacevk2FXdMZEidfhdVYRDRm0RtcqtHgzFymPtgP
 JvuIBJIUh6UYnOcQWouzedFGIVWTjA+oNSbEyznsg6+nQYEEmsmCM6Ar0uRcpmZJoLwD
 L+mw==
X-Gm-Message-State: AOJu0YzLBnWQMWwXchsmWSeC93LtHaO7iBQlCy1kuyvTCfNREhTGLHKD
 nZmJkcn5bvig7BPkryrsUuTXJPKZ596wCXE=
X-Google-Smtp-Source: AGHT+IGpR1zuQBwXdIkFBRwPYViLKPSPwh7huR4hpQjJ8QbMPazBjMlZmEwTq0yJrMrDlRP63Fo7gbMg
X-Received: from flwu-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ceb])
 (user=flwu job=sendgmr) by 2002:a05:6a00:228b:b0:6d9:430d:ee59 with SMTP id
 f11-20020a056a00228b00b006d9430dee59mr30119pfe.2.1705001134588; Thu, 11 Jan
 2024 11:25:34 -0800 (PST)
Date: Thu, 11 Jan 2024 19:25:22 +0000
In-Reply-To: <20240111192522.2795498-1-flwu@google.com>
Mime-Version: 1.0
References: <20240111192522.2795498-1-flwu@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111192522.2795498-2-flwu@google.com>
Subject: [PATCH 1/1] SMBIOS type 8 should use T8_BASE.
From: Felix Wu <flwu@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3rkCgZQQKCuMKQbZLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--flwu.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

---
 hw/smbios/smbios.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 2a90601ac5..7dda84b284 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -591,6 +591,7 @@ bool smbios_skip_table(uint8_t type, bool required_table)
 #define T2_BASE 0x200
 #define T3_BASE 0x300
 #define T4_BASE 0x400
+#define T8_BASE 0x800
 #define T11_BASE 0xe00
 
 #define T16_BASE 0x1000
@@ -775,7 +776,7 @@ static void smbios_build_type_8_table(void)
     struct type8_instance *t8;
 
     QTAILQ_FOREACH(t8, &type8, next) {
-        SMBIOS_BUILD_TABLE_PRE(8, T0_BASE + instance, true);
+        SMBIOS_BUILD_TABLE_PRE(8, T8_BASE + instance, true);
 
         SMBIOS_TABLE_SET_STR(8, internal_reference_str, t8->internal_reference);
         SMBIOS_TABLE_SET_STR(8, external_reference_str, t8->external_reference);
-- 
2.43.0.275.g3460e3d667-goog


