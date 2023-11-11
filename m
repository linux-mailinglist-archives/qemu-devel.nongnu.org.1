Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EE7E8790
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:33:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crJ-00024I-UI; Fri, 10 Nov 2023 20:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crH-00023T-R1
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:23 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crF-0001aQ-0o
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:23 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2df2fb611so1672967b6e.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666338; x=1700271138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJJdkh5pXAC1KYfiOhcm7P9Nmsr2BleAub3AZo0lMkE=;
 b=Qj3cvxQCD8EHVQdNgt0nEUW/jJnwb82qp6ebMwJdHhUK0nc01ciuZYQeK72FinDcbO
 6rVdVlDYo1olpuod+fUwmjNI3Zab6mUvBRWI20SZ6IlLm42Hip/R4E+Ozj4eRrCQeDjH
 2bNIwt4YqU11/EV7K/OUt4064rH0IMIDPDcny1bPsS3z39teGEZp/r6px3TK0G89YmtG
 +etljJDNHqyWaWizbPd4ZQXc6toV7FwQMetpX9w/utppQBliOdZWXvSjfqE5AONDQV2p
 KDh52zLxXVOzdAMtUGPWnOyUJpQrw5fqg5lz7TZsm89JLjklqHt42Spa8oFz4nILQdcU
 6Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666338; x=1700271138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJJdkh5pXAC1KYfiOhcm7P9Nmsr2BleAub3AZo0lMkE=;
 b=vBOPZe3QwARcVQLXuG05gMqqGdYi66nUt+3QzAU6zu+hdNoYDZIsmOs4C1cy9oqTQT
 AHsI9ZiuHs9qSPhLOdv9KQ9mECo+SECrXdH9HSuzX2fuAXJr9ic7aI0RHtGuXJFM9n7A
 Sj7eGYqvXtLxY9uMXuqtvv6ezbublPeTwZf6MQU7NdSun9S3/RL5qrY0r/pd//wpGtZz
 WCswP1Hmjpp/D3fQ3H0oXizH3wdB3qzG3C3w+DXK5cHUZ7ZRwVbAjlIGuSJ7C+kiTEhH
 BSj7Ux9NCZZfE6E49PDWc3ww2coTO4z4ioEhGtBPaPIe+b/MHWWuqjoaBZLPPptZILkU
 cbGQ==
X-Gm-Message-State: AOJu0Yx78sP2MevvFXH7WZI+D5l8LqaEwEoJgFLwDoRcOTKzdx1cYqYB
 805MH0tUMqktA9qEwlFWnpMhhH+uDtnDcJvXfPU=
X-Google-Smtp-Source: AGHT+IHWExxyOgYN5PK85CRZ9DidfhCKm1GtTXLgJr85miCmnEp1YxmTHCCxsypZqxxwO2pE9FRMig==
X-Received: by 2002:a05:6808:2391:b0:3b5:75d3:14aa with SMTP id
 bp17-20020a056808239100b003b575d314aamr1371879oib.25.1699666338719; 
 Fri, 10 Nov 2023 17:32:18 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 02/11] hw/hppa: Require at least SeaBIOS-hppa version 11
Date: Fri, 10 Nov 2023 17:32:03 -0800
Message-Id: <20231111013212.229673-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

From: Helge Deller <deller@gmx.de>

The new SeaBIOS-hppa version 11 includes the necessary fixes to
support emulated PA2.0 CPUs and which allows starting 64-bit Linux
kernels in the guest.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a3222d3a96..dbcf0c07be 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -34,7 +34,7 @@
 #include "net/net.h"
 #include "qemu/log.h"
 
-#define MIN_SEABIOS_HPPA_VERSION 10 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 11 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON (FIRMWARE_END - 0x10)
 
-- 
2.34.1


