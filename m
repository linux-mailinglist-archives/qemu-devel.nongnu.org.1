Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A2836B01
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxI0-0004Dx-C0; Mon, 22 Jan 2024 11:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHW-00048h-Ha
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:20 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxHQ-0001hN-Mm
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:36:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337cc8e72f5so3111806f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705941370; x=1706546170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbnfC/D4PDNYwfVyZ7HdEI62GO35WnzElpqTdsyXzQU=;
 b=aX96wJ11TghmOeWa23BuzcsZG5wB6tO9hujD/cd/30F+dPCK0Ns2DwQGE/lGaEG4+l
 kF5hQuae9BYmmBNEBjS3nav7aRU+TK9LFR3qhf0NWXRsj9H0DepRgZ1izZMSPokPV0FK
 C84iaPDCDxbCrSs9vJ5b6XxhtN50xR0u13Ht3tlNbPVo/K+kO8z/NIzQT47FT61SQhxy
 SGeEoOnHEIqdJnVzJCJnnLiAajb31UqizqqUB1ovXQz/NmGUxg+xrYbHrDRY48tWnyTD
 5hkjt/KGGppLgGOpNAGbZrwncisWVEzV5c4JQrw86+NsNOb5gsbSO9z46vGVlNvnPK6H
 ZsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705941370; x=1706546170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbnfC/D4PDNYwfVyZ7HdEI62GO35WnzElpqTdsyXzQU=;
 b=oQUDw44MQuW1PvRIiZqbbAd8RhkYL6Fb9/QT4HdXtF7GDF0IUVvfBbTAqKr4tr28FG
 knHYs47Epq5c+ZYRGThInYKJZE9WUwUEl/6cVuAvFWLED+mAGtudFkP7Z6x2NnrB6C0x
 IOZcjUDDlhpl5jMY5jRO1QV1KBAiUUj/HuAWNXlhdmKem7ZR0jBGGzIG39ojsdgozGPP
 ffLXxHHMkWleZA7BSioSio4ZyX5X3K39OGbbTZaSpcglTzE/ctyH7uczmcpF2vtbMgis
 T+2a4YcpeV1R6LOT/Tt+qfse+h1p0xHMQ27sjKhdwuB9WeHzy90bCxdA6ghsxD1s+yEZ
 +aAQ==
X-Gm-Message-State: AOJu0YwwEru7Cb6x5aTg53gazp8czrH95yWt8f7n7JBAFk0RgczFjjzo
 T+3vZDohmgjTaIluA9P9e9UfZRVC287hIt/oFf8wXDLnmnVibXQDa5kPNDrUW2mbNF4L54+GsxY
 k
X-Google-Smtp-Source: AGHT+IEknpqVv/fPdvkFaA8i5zohf5niL3IusPQMpiF0Tz2BpJmzZzL1s35IpZUEmiuJ7zIx9Xw/Hg==
X-Received: by 2002:a05:6000:d88:b0:337:b9ac:97f6 with SMTP id
 dv8-20020a0560000d8800b00337b9ac97f6mr2393941wrb.55.1705941369834; 
 Mon, 22 Jan 2024 08:36:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a5d530f000000b003391720fa51sm9188728wrv.60.2024.01.22.08.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:36:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] system/vl.c: Fix handling of '-serial none -serial
 something'
Date: Mon, 22 Jan 2024 16:36:06 +0000
Message-Id: <20240122163607.459769-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122163607.459769-1-peter.maydell@linaro.org>
References: <20240122163607.459769-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Currently if the user passes multiple -serial options on the command
line, we mostly treat those as applying to the different serial
devices in order, so that for example
 -serial stdio -serial file:filename
will connect the first serial port to stdio and the second to the
named file.

The exception to this is the '-serial none' serial device type.  This
means "don't allocate this serial device", but a bug means that
following -serial options are not correctly handled, so that
 -serial none -serial stdio
has the unexpected effect that stdio is connected to the first serial
port, not the second.

This is a very long-standing bug that dates back at least as far as
commit 998bbd74b9d81 from 2009.

Make the 'none' serial type move forward in the indexing of serial
devices like all the other serial types, so that any subsequent
-serial options are correctly handled.

Note that if your commandline mistakenly had a '-serial none' that
was being overridden by a following '-serial something' option, you
should delete the unnecessary '-serial none'.  This will give you the
same behaviour as before, on QEMU versions both with and without this
bug fix.

Cc: qemu-stable@nongnu.org
Reported-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
Fixes: 998bbd74b9d81 ("default devices: core code & serial lines")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
See the discussion of Bohdan's patch on the mailing list for
further context:
https://lore.kernel.org/qemu-devel/CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com/
---
 system/vl.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 788d88ea03a..aa7953bdd7d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1439,18 +1439,22 @@ static void qemu_create_default_devices(void)
 static int serial_parse(const char *devname)
 {
     int index = num_serial_hds;
-    char label[32];
 
-    if (strcmp(devname, "none") == 0)
-        return 0;
-    snprintf(label, sizeof(label), "serial%d", index);
     serial_hds = g_renew(Chardev *, serial_hds, index + 1);
 
-    serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
-    if (!serial_hds[index]) {
-        error_report("could not connect serial device"
-                     " to character backend '%s'", devname);
-        return -1;
+    if (strcmp(devname, "none") == 0) {
+        /* Don't allocate a serial device for this index */
+        serial_hds[index] = NULL;
+    } else {
+        char label[32];
+        snprintf(label, sizeof(label), "serial%d", index);
+
+        serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
+        if (!serial_hds[index]) {
+            error_report("could not connect serial device"
+                         " to character backend '%s'", devname);
+            return -1;
+        }
     }
     num_serial_hds++;
     return 0;
-- 
2.34.1


