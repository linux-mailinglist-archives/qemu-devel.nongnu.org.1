Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226027FF3A3
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:35:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8j3R-0007g8-6J; Thu, 30 Nov 2023 10:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2w-0007XM-Kt
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8j2n-0004zk-Rp
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 10:33:46 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so9003455e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701358414; x=1701963214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJMauOfyWGFYkIZAfq/bsS5e9jl1HNaFLiAxTQwxJLQ=;
 b=hrwRl8j+DADBqe0XuG2jTjWLpAl6dAjPZ9pSaSPQXzlv1U7pcrMz9OOm/qRd7TsnYb
 Cm2OG5Uk0FDLyhzd7kueQvgJX31IzzejpDUX7BtscetRflMeEjxXl/MxUZZPNJvO4Yyi
 qm8RhOdcWk2dRX7SV+63NUKrquF/GFyFWgjlfS55d5Rs4cAN8MskB42Jr2FGPK16sDYD
 g9uWn274tEp5chQHZUHmna5KwICFnGYtS1967moSPuXkwW7k0hXn7oEy1CB4+z5G6KDi
 mR9bG3Bs1m4gU/xSXdXB4AJxM5ur3u5izT5DJG5s7A1nVCEEgTI5Q6opJAG+2IJ/X1uF
 mW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701358414; x=1701963214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJMauOfyWGFYkIZAfq/bsS5e9jl1HNaFLiAxTQwxJLQ=;
 b=kwC1Yz3P7QDsP4YNpnvWg5UuWaCBz1B5WlXa57GzlHbjs5DgOUtM3JKF73QbYkRocq
 8dPwLdIqut2g11oc0iNuRX8aYT8wbdPi6p4OVVAeL1uzyHrB+YmE2uKWPBQpEv6iWzjH
 icbmI/uSf9Im+pTJfn3go4o+iyr8iIthPm5HPbzNostKypzVzzE2C+0pfnbgy/OUpL3H
 ooRbJJfnVLVPpm522kqyzijtpDEMg7NbM9ejuhWosY3SpnO2GmWRkSTnHEB+y7EiVqsn
 G6YKiB5sy6kzced6ext5VnMOwa5kXlbLo3liWJZ5c6lqd+Me5GHHvp4cafoDXqau0RIX
 FuOQ==
X-Gm-Message-State: AOJu0YwIFAqUOXWmRRbRM9uANqrDxgh7W+3EDSB9UDigGaYWJoImFuEy
 HQPczmR/WbRCa+UKs1Bmo2YHmQ==
X-Google-Smtp-Source: AGHT+IEQThGB6JMkf0tBER1nXqhHQ5nUy4FO3pfsfWfxYgoaJru8G6HWzGAjzVL8zhc/fFNaT/cELQ==
X-Received: by 2002:a05:600c:314f:b0:40b:2a18:f1be with SMTP id
 h15-20020a05600c314f00b0040b2a18f1bemr15981841wmo.1.1701358414168; 
 Thu, 30 Nov 2023 07:33:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q15-20020adff50f000000b00332eaede976sm1822881wro.86.2023.11.30.07.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 07:33:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 869325FB4F;
 Thu, 30 Nov 2023 15:33:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-s390x@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Luis Machado <luis.machado@arm.com>
Subject: [PATCH 1/3] gdbstub: use a better signal when we halt for IO reasons
Date: Thu, 30 Nov 2023 15:33:31 +0000
Message-Id: <20231130153333.2424775-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130153333.2424775-1-alex.bennee@linaro.org>
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The gdb description GDB_SIGNAL_IO is "I/O possible" and by default gdb
will try and restart the guest, getting us nowhere. Report
GDB_SIGNAL_STOP instead which should at least halt the session at the
failure point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Luis Machado <luis.machado@arm.com>
Message-Id: <20231123131905.2640498-1-alex.bennee@linaro.org>
---
 gdbstub/internals.h | 1 +
 gdbstub/system.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 465c24b36e..5c0c725e54 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -24,6 +24,7 @@ enum {
     GDB_SIGNAL_TRAP = 5,
     GDB_SIGNAL_ABRT = 6,
     GDB_SIGNAL_ALRM = 14,
+    GDB_SIGNAL_STOP = 17,
     GDB_SIGNAL_IO = 23,
     GDB_SIGNAL_XCPU = 24,
     GDB_SIGNAL_UNKNOWN = 143
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac140b9..83fd452800 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -183,7 +183,7 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         break;
     case RUN_STATE_IO_ERROR:
         trace_gdbstub_hit_io_error();
-        ret = GDB_SIGNAL_IO;
+        ret = GDB_SIGNAL_STOP;
         break;
     case RUN_STATE_WATCHDOG:
         trace_gdbstub_hit_watchdog();
-- 
2.39.2


