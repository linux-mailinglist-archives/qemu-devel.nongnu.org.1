Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A27A3DE6
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUS-0004W0-G0; Sun, 17 Sep 2023 17:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUR-0004VY-5V
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUP-0004Fb-MP
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-402d499580dso42001465e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986776; x=1695591576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw1dyfbeN3ouZtpJ+EsLMpnbrhAyvsGjO2B8aC+yH6E=;
 b=VXVOWguCbuNLkdlaED0NqMwhNQ4gRCySgcOkC+Xv44hOYezLelmARX6UZbex3rx4RO
 wA87j/u396SX7qVOBhutS0KGpkqLVR1l+tqRwQDDfypju2u+AkkdoSGrqJkK7tYThtM+
 pW+DbwLrM5QSIaKNQabh5s5H2II73dv9ugGM0dlwQVKwAKIFh1R/SLeyfX6a28rcCRkw
 9c0RsCbVJt/qDF8Y6c1lKlMa4E/5yH3MjMXtxdsHRcagq0OZzsDqz11uuLDUImaq3dOL
 4Jh/bpR/1DRYMgPzeMfge5vins0OVrzGgP9GbRW3zGY3XxIlHk//QJWpUOywOj3MzTWC
 1hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986776; x=1695591576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw1dyfbeN3ouZtpJ+EsLMpnbrhAyvsGjO2B8aC+yH6E=;
 b=AREE7MsUrO5jzfv0PiKRqBbLHyoMniZr32rUlxRN668VffLs6p9gUu3XhcFWwQSSwt
 PqgVWlUnHqMvXRxblNgR0/7hOHjc4VrMpf7R04UAnkxqub2+/d3gIWgBDTij4YQZ3WEY
 zypFwygpTTofyqOIdc3gY1Tlzf0Meu5POPpxtTZHCassbEPz8RpJ1WangSxKMXNsxVrx
 cnJ4R9YGZGOyUeFNOWnBssBDqQyx4pc3j+avdM+h6am3q6hG3fOgeawJY50Q6BE5GiEK
 Cla0zWFwYDsji+70bpvADkTZdJOxCqOUFfLljniVQrm2wwUihf2IntYXauQC+6iBdgXt
 H5PA==
X-Gm-Message-State: AOJu0Yyd1b23pX+8uOGKo61loO+U31j6iadCygd1hL+aPYRtCLjnIK0x
 FJHqRfzXfUhEu6RyY7yX4VZSaM8pBjs=
X-Google-Smtp-Source: AGHT+IG4ATdtN1ghyB3V/fwnYaMS8NyjA13exQYG25oG8rf/YvBQMStTCF1J5dSbeuy+w6Dq+351ZA==
X-Received: by 2002:adf:e748:0:b0:31f:e759:d68e with SMTP id
 c8-20020adfe748000000b0031fe759d68emr5877417wrn.58.1694986775613; 
 Sun, 17 Sep 2023 14:39:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 07/28] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Mon, 18 Sep 2023 00:37:42 +0300
Message-ID: <20230917213803.20683-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 68410a0aa9..19e39a2f76 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)
     return code;
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    return tswap64(target_rlim);
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    return tswap64(rlim);
+}
+
-- 
2.42.0


