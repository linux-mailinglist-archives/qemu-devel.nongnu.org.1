Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493582BA56
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 05:23:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO93E-0006Fn-Tn; Thu, 11 Jan 2024 23:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93D-0006FT-7H
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:21:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO939-0004bj-9q
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:21:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3e84fded7so34970485ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 20:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705033301; x=1705638101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI8h9PeADJ9Z6ilD8u7KPAuI2ZpTLWM9PMTRdVTB5sA=;
 b=ZCM2YDZ7rb1u9+UHdkrvgPyfcJVTNUMuMSRr0UDo8/2kmiZSZhXq308tMgFc8O+55i
 dzoHIxG1VqNnUs8teq7KUExMJyaxYP5UqfOixvPpfjDG9IcLQqD9fBtWCtcMO8ZhCAC/
 SOv28kq1vO45CgIPuKccynUki8s5z3XVTtlDr3gzZfZDUaKz6oqdXgBm+Occzz/S+tzz
 cBb91d36SI7/cqJBf5Fcank2N1p44YUiun2v1xkGH/+q0ytILHuVxpWnINvNg9h2DAF5
 prC+lijewOZ/xlKdGWjkCLSfHMVjEW7DXtUvwbIv1iGBPOvyxvJA+n65WMNjdmuOC+Yx
 O1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705033301; x=1705638101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UI8h9PeADJ9Z6ilD8u7KPAuI2ZpTLWM9PMTRdVTB5sA=;
 b=um4ctyUAmPhychZxRkUVZglQ99Ms3XaKj/1mytIZ/ABnUvBxHF2WkIf6d5CPvag9A2
 Dk/p+ekx5/9uNRDBIzlxU+n87FmnfUisBOVIMI2DLfsHDV4XoSyckuCnEL9J2MSvLwj3
 90kn/ScvqNlGuMSmgGI7GHyktN4qec5g6pF+9JM8PkamFag4YiJ6Zr2D9e6rbk/WkYeo
 +w7inIw6Loj74LOKiyRMRl9ab5y9CcWIQ7klAoG0lCSLKykNCeDuZt5Qo19/wvkXA18M
 7YShHS0UPdNJoyKg3exEOj18KrJKvrm86a2tY4HH1Vgt6WKsjSvrlYhYCgB13VhcMUzz
 tYmw==
X-Gm-Message-State: AOJu0YzvM79PEWJVE4X2TUnxT+X6mQsk1N0UwWJ7ffo4Wj1hdxetBMEX
 k0ZQCjauKuIEhiVIwefbbSVTVmPM5Mc=
X-Google-Smtp-Source: AGHT+IEeQ4w/u3b/ctMQgVy5LJJafwsBzk8QiLoGUvHpQzwcVxkgJtBKo8JU1GRHVaJNPP59oW3S5A==
X-Received: by 2002:a17:903:1ca:b0:1d4:752d:2f0e with SMTP id
 e10-20020a17090301ca00b001d4752d2f0emr341060plh.79.1705033301503; 
 Thu, 11 Jan 2024 20:21:41 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a170902d4d100b001d4c98c7439sm2018576plg.276.2024.01.11.20.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 20:21:40 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/4] target/xtensa: add translation for wsr.mpucfg
Date: Thu, 11 Jan 2024 20:21:25 -0800
Message-Id: <20240112042128.3569220-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
References: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Although MPUCFG is not writable, the opcode wsr.mpucfg is defined and it
just does nothing. Define wsr.mpucfg as nop.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index de899405994e..6a2f5d308e6a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -5332,6 +5332,15 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OPTION_TRACE_PORT,
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "wsr.mpucfg",
+        .translate = translate_nop,
+        .test_exceptions = test_exceptions_sr,
+        .par = (const uint32_t[]){
+            MPUCFG,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.mpuenb",
         .translate = translate_wsr_mpuenb,
-- 
2.39.2


