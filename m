Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390197D437A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4dW-0002qV-Fd; Mon, 23 Oct 2023 19:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38gU3ZQYKCgs4t4532rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--titusr.bounces.google.com>)
 id 1qv4dS-0002n1-EG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:02 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38gU3ZQYKCgs4t4532rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--titusr.bounces.google.com>)
 id 1qv4dQ-0002lb-Uj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:02 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a7cf717bacso55355097b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104819; x=1698709619; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9PqfwJZCklklflJWx1kiMMaSEZM0FI95tSIjALLmPY=;
 b=wpRdadLeTqWWGw5HUQVXgFYrg6GHr94YO5OeoZHADjWvZkAf6V/Wsfl2do20RFSeEz
 OI2IRqwBq7uZH3xegbYbTmEIBrjKOfZn+7zaSmHZmjHkSQZiGmENhKGxtT3EzGYXVtIA
 N7iFPbY4jXDvgK3qr84tTero0To0iG8LfeYZC3GgnbbgTTi/OkAzVb/JEj8tf5wBgqKq
 ZgN5oDaLf0k4+H0yOL91yYo2ioKP6F5QzPSSov/L++dGGa1nxQ9o9N66CAPlK9r3tDch
 jw+QU9IxjNoIBPUAMy8TOCJebnUeEfsLaCjWTyLq10FcY8mlNTgrXWvWLMiK1zr2d3DL
 vRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104819; x=1698709619;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9PqfwJZCklklflJWx1kiMMaSEZM0FI95tSIjALLmPY=;
 b=ZfJlhq1S+cJeOc25SgN/tESK2sV34Fw7HUQo8i6NmbK3LF0KUe6kRscDqLK5Pkb2Ks
 tWzK/Wvv7PbvrjWNH7UO6jtBvQ86uZNlVxih3VTR4vwZcWCC8fd9bCTClD/7wAHUgYDr
 VWvSBcKVbP55CJNFkFTnvJsvfceLDJJFYifr5ZzkUyf62USBrgWyETdOFF0lURpwxfCM
 ELd9zhmjpN2HZc/LYE2G56ZJkMEoJdh2Wa8znbfx6hV4Be949Xx3bQezv8IO6gujmY2/
 C4DauvM7YgVlU8N+EaDdVsPUGj3CEJIoOhOZCFW4u/U0F9P/HqviH5vUeAUGDcYt4Myg
 qNcQ==
X-Gm-Message-State: AOJu0Yy/RpFjdCPb4rRB/w0iQNwZIk6govp6ADsXXNsI+ML2yB5FFptT
 oqLedupabz8lK8h9y6vIVUQiHwa4iC8=
X-Google-Smtp-Source: AGHT+IEk+2N/M0vGvh7Ek8YIq50a7tIxVP8Znvo0/Rdr8CIjU803cDiFJzGHJnvl4bJesHKAVVF4UCg+Z+M=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a81:4e8e:0:b0:5a7:ba09:44b4 with SMTP id
 c136-20020a814e8e000000b005a7ba0944b4mr248644ywb.1.1698104818916; Mon, 23 Oct
 2023 16:46:58 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:41 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=titusr@google.com;
 h=from:subject:message-id; bh=3ydAUfrEAeZPVQPNXJngklsGr0uuFIogbpEk1CsC6nQ=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXtjtsjf9QmxszIiPGvbc4msOc33M/DF1bOh
 SS9YkEgHeSJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7QAKCRDEEgAXXNIe
 MDMiC/49DLaShVclciQa158hVXIRKcL1oe7nw6RcZELMEHLXJR7QVC5hJe1eBwHmhJ1hQdbVdrg
 QEu43M+JHovPUAbQMTpohTiazv2X6iJZ8JTf6JLTofSjIvK3EyGN/jQL4rDVlA8V2aCynIJWuJP
 mxXNxPcTBTLSINETr+P2GSgqvHqGTzfYJoVidH8iwvdB01TVb9y9+NiKb6f5y2/gFkWG13144Lq
 U/KQEsKGB9b1C98OtkVuEVR4cSufPK5/QTDFLCme25wwEhQfwM9mPTnJcnZeFNvesd4+3cew+bU
 Y7GiyPb9e4jZVWRhQNps3t0466Gsw6F6JIcIJZvrvB1iUVqiqaDOKoCYpmpneVyFUF8SxkTKTzc
 IAptiOBkfU7hs73+6b5BWeBwTXzyjNvjJQQoEhdRUMmT/t15/OmkLMn3o1zgvPtrsNlYXxdp3dy
 ebAuXjkgcGf8eK8EBkexGE8FjcKEqPR2D6BJRZQHR0kg9I3qXMB+uSRk4v3nIw4OUsK1c=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-2-07a8cb7cd20a@google.com>
Subject: [PATCH v4 2/8] hw/i2c: pmbus: add vout mode bitfields
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=38gU3ZQYKCgs4t4532rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The VOUT_MODE command is described in the PMBus Specification,
Part II, Ver 1.3 Section 8.3

VOUT_MODE has a three bit mode and 4 bit parameter, the three bit
mode determines whether voltages are formatted as uint16, uint16,
VID, and Direct modes. VID and Direct modes use the remaining 5 bits
to scale the voltage readings.

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 include/hw/i2c/pmbus_device.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index 7dc00cc4d9..2e95164aa1 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -444,6 +444,14 @@ typedef struct PMBusCoefficients {
     int32_t R;     /* exponent */
 } PMBusCoefficients;
 
+/**
+ * VOUT_Mode bit fields
+ */
+typedef struct PMBusVoutMode {
+    uint8_t  mode:3;
+    int8_t   exp:5;
+} PMBusVoutMode;
+
 /**
  * Convert sensor values to direct mode format
  *

-- 
2.42.0.758.gaed0368e0e-goog


