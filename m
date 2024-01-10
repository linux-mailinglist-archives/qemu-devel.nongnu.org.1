Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA482A428
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLL-0007Eg-1U; Wed, 10 Jan 2024 17:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKi-0005mH-W8
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:01 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKh-0003AQ-CO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:00 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4298bdafa54so25704131cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926758; x=1705531558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zCJMFAqdf2iFGNb4zrA/FuyIMECuUh8qss+ekAKVh8=;
 b=eLaddh3/aB5stt/DScS0KSsLoZ8h3acGVqTRqmRgc4KwK5+gwE6EJWOUNAUDkMLbdo
 nWHkYrWcdLe5+EDxzsm6upurAO8dL44+Fl2JvInph0sXzTyVQowBQr83x6wJEWTsg2kq
 Bjk/gVkFYhijaxAjxw3FJKxT9DUt7yNkorQb21KGhWIB3Y2NPI2EUtppBSCz2Aha7lKW
 jPniBPGSqUFWoVA7k614EsN0NZb/yuS0vj9/6wUcVFIj0260CxzkoNCO2iYeOQaf/w/W
 P5ASo5c4xaQkqLzZuILObFsi5E4RDB6iKhzAC99J6sDgQPwAxs3UMv7A/OOgu6Pjnumw
 tzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926758; x=1705531558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zCJMFAqdf2iFGNb4zrA/FuyIMECuUh8qss+ekAKVh8=;
 b=syegySttrPZ3WgnxrQCmXetxfzsn3Ja6b3YtsXFGi9CCIjgkdo6lOGNpDudH0ycbI3
 x7c9LYJr+rJe2CffP6QSlfmLlET1YToCoxFGAlzM0KL896JB4uP3pW8P3/9wuyxlTjf9
 CMDFWAPh62cvBomS/VEuteW730vyv1pWzDM3bujMWaltuepo9mqgM2upQzDdmaJIaBhX
 aaoBhOW1sYed/IP9fJUfEvs7w3uuod+tbNeu3ja3XbQ0cYW3GDnD7qSESmY06oqLsKi4
 qRu8Xe0/57sGmOCaWDdZrGd5wrowRfe8YtYt3wBTUBDEpVTKG2E75YvsmclCUWV/xGee
 jvug==
X-Gm-Message-State: AOJu0YwI5l5TYVvtJtvE9eiz984lCMYaCGsoptTrvuN1mqVzta9iHFAh
 pG1CAAMSBIY5NHPIieqcUdyUSxlFfw1TKmo/RyjiywuinGRaQ9+a
X-Google-Smtp-Source: AGHT+IEawBiEdaZMeqifTfwxd9JRAqgEDGRhJ8DdtGW3ehTqW3C0gCdPEMvAkrVtU+axa4DRCcXq3A==
X-Received: by 2002:a05:622a:19a2:b0:429:7fac:a670 with SMTP id
 u34-20020a05622a19a200b004297faca670mr291082qtc.57.1704926758097; 
 Wed, 10 Jan 2024 14:45:58 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 19/38] tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
Date: Thu, 11 Jan 2024 09:43:49 +1100
Message-Id: <20240110224408.10444-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

... and the inverse, CBZ for TSTEQ.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 55225313ad..0c98c48f68 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1453,6 +1453,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         break;
     case TCG_COND_LT:
     case TCG_COND_GE:
+        /* cmp xN,0; b.mi L -> tbnz xN,63,L */
         if (b_const && b == 0) {
             c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
             tbit = ext ? 63 : 31;
@@ -1461,6 +1462,13 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         break;
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
+        /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
+        if (b_const && b == UINT32_MAX) {
+            ext = TCG_TYPE_I32;
+            need_cmp = false;
+            break;
+        }
+        /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */
         if (b_const && is_power_of_2(b)) {
             tbit = ctz64(b);
             need_cmp = false;
-- 
2.34.1


