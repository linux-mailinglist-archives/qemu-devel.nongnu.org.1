Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED228836B02
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxI0-0004Cz-1U; Mon, 22 Jan 2024 11:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHW-00048f-Ga
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHR-0001hU-2U
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:15 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-339261a6ec2so1955521f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705941370; x=1706546170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Dl719vf+4e7ak89dH3QgvfFZRLc4oDS4GdFH0txpAw=;
 b=o1Bi6Yza62OnhVNOELHw0dAVYgrZLboieoBk17ZSOK/mU6eCCJe2LN07plf07C8L3x
 VNfId6IEz08aL65fdt/oDdBvyERAib2LijjXcHANjWTqEA6oSEqcDIjXO3VOfkNX1qwB
 zB83WaaXKxm4hRRV2qjxjxSWZroEtmsy/A6RkKHjFPbo8hsTkZRYpQjzGdJ+igUlhTRT
 NfpVJiVHFUkVV/+9D/Ep9F+yGGA+Sd75diaHSIM93i5FJ1hbFdCAdM91fmvd5+bsGEgT
 tXVKhCQmP98uyey555x+97hAu7OU59XpDl83X5hyPjZYr2vRjq0n+uJpPFfEe2k7fuxO
 /UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705941370; x=1706546170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Dl719vf+4e7ak89dH3QgvfFZRLc4oDS4GdFH0txpAw=;
 b=XT6gQ87rcQGW6zBvSGfCrTm8N2jwujj5bohkVqorK7Ni9OPlMMrQAr3WrYr+YPYHIp
 DrrbYYI90stX0KuOxTQZ6h60BeU56ilzr8/Sh/LE2/CTBGnCUA31a80KfWxTvttiIMvv
 q/gBEcBK9u2v4Jx+9xxOAbQijnOEpRZrGKAbRps90gFD+MjumCrTkVReFv5l1iUkq2tZ
 sZ1ixbnSihpnCi8sf/JXfe40ZjBNGtq96bpJB91MuI5hqH/UoJgPC5hhqErwlHMjAaU7
 ntIJD/taL92zcbirYherhRpzzMxpG13QRbsNGicS3oRFFdkIWgCDTrjSewLZaqshagSe
 mZbA==
X-Gm-Message-State: AOJu0Yy2y4sWvEqpWYzdLw6+fKQ5miQzddeClcxG8XfmsrOVRb5WKKZH
 wwT8B7gJxstDtl58JJQ5rIU3hVEu6gLH+4VcSVgiM7/yBn18ZgeIjogooqpjeP9M+nAXSntkL66
 H
X-Google-Smtp-Source: AGHT+IHmDJnOxFc9GVz+rsAfolD/ZvBB9VEF5TMHiNk18EjNfUm9xZdXBVbtTPmipnshWZoO4Zw7Rw==
X-Received: by 2002:a05:6000:dcf:b0:337:c5fb:c851 with SMTP id
 dw15-20020a0560000dcf00b00337c5fbc851mr2892718wrb.8.1705941370485; 
 Mon, 22 Jan 2024 08:36:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a5d530f000000b003391720fa51sm9188728wrv.60.2024.01.22.08.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:36:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] qemu-options.hx: Improve -serial option documentation
Date: Mon, 22 Jan 2024 16:36:07 +0000
Message-Id: <20240122163607.459769-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122163607.459769-1-peter.maydell@linaro.org>
References: <20240122163607.459769-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The -serial option documentation is a bit brief about '-serial none'
and '-serial null'. In particular it's not very clear about the
difference between them, and it doesn't mention that it's up to
the machine model whether '-serial none' means "don't create the
serial port" or "don't wire the serial port up to anything".

Expand on these points.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ced82848637..d8c3fe91de1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4129,7 +4129,8 @@ SRST
     This option can be used several times to simulate up to 4 serial
     ports.
 
-    Use ``-serial none`` to disable all serial ports.
+    You can use ``-serial none`` to suppress the creation of default
+    serial devices.
 
     Available character devices are:
 
@@ -4151,10 +4152,17 @@ SRST
         [Linux only] Pseudo TTY (a new PTY is automatically allocated)
 
     ``none``
-        No device is allocated.
+        No device is allocated. Note that for machine types which
+        emulate systems where a serial device is always present in
+        real hardware, this may be equivalent to the ``null`` option,
+        in that the serial device is still present but all output
+        is discarded. For boards where the number of serial ports is
+        truly variable, this suppresses the creation of the device.
 
     ``null``
-        void device
+        A guest will see the UART or serial device as present in the
+        machine, but all output is discarded, and there is no input.
+        Conceptually equivalent to redirecting the output to ``/dev/null``.
 
     ``chardev:id``
         Use a named character device defined with the ``-chardev``
-- 
2.34.1


