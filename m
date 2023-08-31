Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846EF78EB05
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfBM-0003rO-5b; Thu, 31 Aug 2023 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfBB-0003dh-Cl
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbfB5-00045D-Cy
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:45:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31dcd553fecso480210f8f.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693478730; x=1694083530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+VSlQGCsD1Pcew2GJP5QWEZRyhS81cLxeQnfhrofKf0=;
 b=ex4ekol4H36W4ge9il9DwlbDng9niFS7UMF5V7Zh5NpLS8DI64gOBXrRT5TtJVdydn
 rszjjThaTA5gg0Kpm5+n2CnkoOoS8A3xX0oAssNOMh0yd++NHEVWIVAtoa9LgmUZcEsB
 q/GJSHZgCYCZOz7f9rQBWmELMSUL5ElKbBxCGYMjbEgjUL5apQMoMXiBq3PVEf8vRX0B
 Cev9y7ri91X7vahKvcK9cWLgLNAQnt5lQgzvAOg5M9cHCYnGK9nQTQ2W4hdAcSymK9si
 4i0acVL06DpJl5FAnU+kR7l98k/3BR1ufT07CwiVfkowLFRyJHjaTskA0rfOZ/+GmjFq
 akhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693478730; x=1694083530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VSlQGCsD1Pcew2GJP5QWEZRyhS81cLxeQnfhrofKf0=;
 b=jJQKDF+FWBPUm8OZBLAMHXQubpyXZZszgDD9ERslGoGQ0IqGe4tWXUt99eHg1I6t0q
 f1Ur6rDrTC4t0Rig5WvxwQQyHqZXNE9I1uaj0AvQeWayJuTiMq2GNkSItCC0qQ3GwP8L
 /P4TX7Ejq6sawHqJ7n4zhw5q7RM78r1hLzSQZ3icffWf4MJZ/7zZ+6cGp17EzjUceIRb
 jT3hNxhHeg6ERYu5WQ4sxcXAMoHxbLM0E+vTXSfZJxM/xVe1dAF85A3FvNDXbRLu1pPI
 QqYg1RTMLIocS3SnO5jcXmtzRwRzUpjN+rP/EHTrJLV8xRJYWzi3hhLoRZ0xr5K5+45a
 3kPA==
X-Gm-Message-State: AOJu0YxUE9m1tbIvrv0G4H4b+fm792I1dnpNINuXSOY8EqQpkfXQc9MR
 nNGqGg2mRt/uFkth+ZRxluxY8vKARDgwHfILUF8=
X-Google-Smtp-Source: AGHT+IFmOnSKxs0IHqEKGaA0FE9D8X9tHPr6kMiSu4U4D00p8keMroFUKVHzg8LCNnVT66fsC8zQ1w==
X-Received: by 2002:a5d:5487:0:b0:319:8a5a:ab5e with SMTP id
 h7-20020a5d5487000000b003198a5aab5emr3656194wrv.38.1693478729799; 
 Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe585000000b0031c71693449sm1785524wrm.1.2023.08.31.03.45.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:45:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/24] rtc: Use time_t for passing and returning time offsets
Date: Thu, 31 Aug 2023 11:45:16 +0100
Message-Id: <20230831104519.3520658-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


