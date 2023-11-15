Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000F7ED47B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:58:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MvZ-0004re-Hv; Wed, 15 Nov 2023 15:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvT-0004mG-Km
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvQ-00089f-C5
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40839807e82so576635e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081747; x=1700686547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjAJqKCk3iUb0SkYI6f8P9mLxZWi+VPPBoOgrXC8tUg=;
 b=AhXAmK4IhbMyZxxcNNS7BBpxE6enb/4MxsmhWjsJ1Ihg3CfOc3EpQ4YI8GXzLO4JjY
 awHXvjDmOK/6emtLtmMcBAs1C3wQs6hkrBElCKdWSu4sspwrt+2U/+ZikkL4Q66cgec9
 FmvK7Xpatxr02lo2yVVV16hdo3+0miJXwMsIXDgqm51eNAi9QYHmLqhxnd1ukXSbt8KG
 +rCoYXJ9dDTc0nqC4KRM30I9Tw+V5xwFVt4Tf45hgUccxL8ALICjV7/417ZwjQEZRa8x
 PidYbd4GoAjjGpwwO1JdqGrTJ2HXLCHBxJA3mzrRBoz9WeAEGVBqRnEoVszFS+Qr/zLM
 O/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081747; x=1700686547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjAJqKCk3iUb0SkYI6f8P9mLxZWi+VPPBoOgrXC8tUg=;
 b=OoluJ8LASh8YwAT1N8wutVvDNtfM1Vt9uMrhsaZJODVTYbYuKD4J/PpSiTZVyx3exz
 c3v9T38GFyag9uIHRPo9NVkeJEgZWeb7zCBFdVqS2K46IUZesyAhyR3zzFLl4aKBhtqD
 LMsMhVGouZyp5to6/1NTuL3e73YRQzadZmpjFIua9WdhutN1Oa1+v76X4sqAg7ljSzHa
 4A3QGvVhgwe7r0nqoQAZltgvmUQ5RnpV1VZ6wlElFrjqjEDaP6qjddPXjPHbbYCihsTO
 COo7qPN++FMMg+vTlAyyCK37xTH4e7oZXQu+9ddKZYHxhhI2eftUztD95s6jOWAh8X1n
 RxaQ==
X-Gm-Message-State: AOJu0YwSPN4hHcUrbGvuD3FUbO02AoY7skmD7AbzsBOQ5xAv6UJL8KC0
 sW37VkBCDjLunQrXA8SD8r35Yw==
X-Google-Smtp-Source: AGHT+IF7n3QuDjtelx2jbGMoDnlKdqUewGSVxtWF5uOHWJrWAdSPoElEadcpVGcUtHjfjPS/40vlXA==
X-Received: by 2002:a05:600c:1c89:b0:405:358c:ba74 with SMTP id
 k9-20020a05600c1c8900b00405358cba74mr6784269wms.0.1700081747034; 
 Wed, 15 Nov 2023 12:55:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c028600b003feea62440bsm826359wmk.43.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37AE35F7B5;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 05/10] tests/tcg: fixup Aarch64 semiconsole test
Date: Wed, 15 Nov 2023 20:55:37 +0000
Message-Id: <20231115205542.3092038-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We need to ensure we squash the serial port if we want to hand craft
our muxed input. As a bonus emit the example with a V=1 build to make
it easier for people to figure out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b74a2534e3..77c5018e02 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -48,10 +48,11 @@ QEMU_BASE_MACHINE=-M virt -cpu max -display none
 QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
 
 # console test is manual only
-QEMU_SEMIHOST=-chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
+QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
+run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
 run-semiconsole: semiconsole
 	$(call skip-test, $<, "MANUAL ONLY")
+	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
 run-plugin-semiconsole-with-%: semiconsole
 	$(call skip-test, $<, "MANUAL ONLY")
 
-- 
2.39.2


