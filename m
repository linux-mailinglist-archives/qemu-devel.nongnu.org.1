Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2475B3B4
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMW3u-0000ZJ-9D; Thu, 20 Jul 2023 11:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3i-0000Xh-C4
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:25 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMW3X-00054Z-Db
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:59:08 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so1560254e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689868746; x=1690473546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqoBrwb3O6xPxonYvG2KesZmPgQJqZE5ArjMIGo47jo=;
 b=bRFrMk2s1BnbFjrIcdW9Hd8QMDfK3AsqTdGpbkKZIUI8Wt5bboegGBH+XCE6hjQJkL
 MzhlYp48EjCxrA761wwJNMzeXOEHuZpKLJpYXlK/tyZdtnOIBjNIi7Rk1aUsrl8opS6v
 wNkJPHJWE13RRlIe8PPbY6XZl44unntey3lViRKNj6hhWGDIugeOG1WBDNBSgkElnt3f
 Qkj+7t3vuUp/QtmT0P8tXEqMHTA4CSw78UfmpvcxOuXlapZHmTrV1tayjeIvl3bPSYOB
 7YS9SzYpW6yFes9QRGnZcTeI7aNur6btW9e74/LhJItBodALLwBvXQmF237s/mfrVDOw
 uGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689868746; x=1690473546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqoBrwb3O6xPxonYvG2KesZmPgQJqZE5ArjMIGo47jo=;
 b=UCyXRFnFntGweezxyFt/2sPTEnX65xQ8sKYptJNIWDAZSoE8A8b+u5Ctd41SeKGfgL
 tDilPaE3LdckSdKFdc6abJcSQj4SWt+2pq0otKyPyW4VBNzaQqKjeuRnt/Hxv0e9npr9
 hS+DgeYpKxTJYlrRg6sSUQM/fhuXtnxHnHpYBH61qu2y9tb7DGLiOEaj0x9ywAc4k+Wn
 6TNwdQRxQLzwpX1iBg5oMADkVDb/M5vSJw3gdjjaVc/HFEUH5/NLJRnnc0vNJFWArsyK
 kXGzSBT9AiyK6HJAgsxtNIOs2nOBu8fSuQQLDP3zzHgPOZrVGl/WYrm6u1Y9o7NkPMp3
 07LA==
X-Gm-Message-State: ABy/qLYhGBT1rXxuQmpyLAHZu8sJ79LHpz1YLC0U3e1mnMpVk+e9HozE
 YcbT9NyuWOUg+1sAaC+5it/5I3JdRlOIXR41/i0=
X-Google-Smtp-Source: APBJJlFscCloGNVNfegSbozo+JIroDgE6QXbPToUe9wCrXvlFyJtboFgyUgtQT952nSESitn5ChEgQ==
X-Received: by 2002:a05:6512:1115:b0:4fa:f79f:85a with SMTP id
 l21-20020a056512111500b004faf79f085amr2124742lfg.69.1689868745881; 
 Thu, 20 Jul 2023 08:59:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c220500b003fc02a410d0sm4187572wml.48.2023.07.20.08.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:59:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH for-8.2 4/4] rtc: Use time_t for passing and returning time
 offsets
Date: Thu, 20 Jul 2023 16:59:02 +0100
Message-Id: <20230720155902.1590362-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720155902.1590362-1-peter.maydell@linaro.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

The functions qemu_get_timedate() and qemu_timedate_diff() take
and return a time offset as an integer. Coverity points out that
means that when an RTC device implementation holds an offset
as a time_t, as the m48t59 does, the time_t will get truncated.
(CID 1507157, 1517772).

The functions work with time_t internally, so make them use that type
in their APIs.

Note that this won't help any Y2038 issues where either the device
model itself is keeping the offset in a 32-bit integer, or where the
hardware under emulation has Y2038 or other rollover problems.  If we
missed any cases of the former then hopefully Coverity will warn us
about them since after this patch we'd be truncating a time_t in
assignments from qemu_timedate_diff().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/rtc.h | 4 ++--
 softmmu/rtc.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/rtc.h b/include/sysemu/rtc.h
index 159702b45b5..0fc8ad6fdf1 100644
--- a/include/sysemu/rtc.h
+++ b/include/sysemu/rtc.h
@@ -42,7 +42,7 @@
  * The behaviour of the clock whose value this function returns will
  * depend on the -rtc command line option passed by the user.
  */
-void qemu_get_timedate(struct tm *tm, int offset);
+void qemu_get_timedate(struct tm *tm, time_t offset);
 
 /**
  * qemu_timedate_diff: Return difference between a struct tm and the RTC
@@ -53,6 +53,6 @@ void qemu_get_timedate(struct tm *tm, int offset);
  * a timestamp one hour further ahead than the current RTC time
  * then this function will return 3600.
  */
-int qemu_timedate_diff(struct tm *tm);
+time_t qemu_timedate_diff(struct tm *tm);
 
 #endif
diff --git a/softmmu/rtc.c b/softmmu/rtc.c
index 4b2bf75dd67..4904581abeb 100644
--- a/softmmu/rtc.c
+++ b/softmmu/rtc.c
@@ -68,7 +68,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
     return value;
 }
 
-void qemu_get_timedate(struct tm *tm, int offset)
+void qemu_get_timedate(struct tm *tm, time_t offset)
 {
     time_t ti = qemu_ref_timedate(rtc_clock);
 
@@ -85,7 +85,7 @@ void qemu_get_timedate(struct tm *tm, int offset)
     }
 }
 
-int qemu_timedate_diff(struct tm *tm)
+time_t qemu_timedate_diff(struct tm *tm)
 {
     time_t seconds;
 
-- 
2.34.1


