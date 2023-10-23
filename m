Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FAF7D3EAC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMV-0005Oh-MB; Mon, 23 Oct 2023 14:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wLY2ZQYKCjkodopnmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--titusr.bounces.google.com>)
 id 1quzMS-0005Nd-QF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:08 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wLY2ZQYKCjkodopnmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--titusr.bounces.google.com>)
 id 1quzMR-0006wy-6t
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:08 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a839b31a0dso70400437b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084544; x=1698689344; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KbV14A8alfaUICvgPRLDukMHo/7m/lBZ+95cv/4vjS0=;
 b=rK+ya0Hsvjna+X0keynGni/1hOBAKfos88oacPZtgX5CLiRdcXEqXT0pkeNsXa/8n1
 XvASqW25ISpd5fIixXD4HYH/dKiKCyzHZQGI7H5PMcFLA+qo95mqn3kwvbTcET1A6+/M
 Z5JQfikEpwlM11d1ICjByTUCPwl3wpPs6Sr29q2GSd2rMvyvCznePmOHrr8KfzHoz5EG
 bcUzuseqcf4WA9Ujp3GtPXj/GjdSOW/9JTzR00QJRBWUdA1pPp3ofT2VhDWZRwrF7xYO
 J5LYLsHfoJyHOGWu/v9tX6eSjY4+FUGaSXgBOv6YWamB3SQpTpDS5QOmyJHPFey5XwM8
 63xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084544; x=1698689344;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KbV14A8alfaUICvgPRLDukMHo/7m/lBZ+95cv/4vjS0=;
 b=k0he9NcqhnXPKihR68VsqnQV8Ry9B5fTShnwViUHoLhylMwkNYsCdIfb89eEBWdVna
 xKKd8ucefSFtVxeyF8P+BUUtBeN7NSRLGHhVSjxZJedm+RJocbCPEYXWeZHmP3xX+Jxo
 8aTxteJe2PhK/aTm0qkNmXvbUnjEcIGhPsNMR6DRFQCWXXozUsauBgisl+xtORBUuP/U
 NUgxGnwU1Y3cqUb5U/rFobIqX99fFflg3UTjpZfwaTdq4ZBxMCrUYKgWCUhnd3t/Jb1j
 9BhIm016Kk+crzj8mPJXeO9auXRvB5BGmH5TOD5foms2cZ3MsZ1IWFecjQxfj2BVx2HN
 T25A==
X-Gm-Message-State: AOJu0YzTlzpl026Blq5nZigUyUfTJBaOXvtAURgEbMJMkFOVOzZEZP0a
 PAZdfIf+o1/D5EIXm3t9mzBO70RRsUg=
X-Google-Smtp-Source: AGHT+IGajiyMpp23xxkw2f1DngnEIVRNGpEmSZaYlZ5LfTSq0bFGJtJZGIU97RsWUFbkJwjsFguibntxF+w=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a81:6cc3:0:b0:5a7:a98a:4af0 with SMTP id
 h186-20020a816cc3000000b005a7a98a4af0mr220029ywc.3.1698084544085; Mon, 23 Oct
 2023 11:09:04 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:31 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-3-titusr@google.com>
Subject: [PATCH v3 2/8] hw/i2c: pmbus: add vout mode bitfields
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3wLY2ZQYKCjkodopnmbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--titusr.bounces.google.com;
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


