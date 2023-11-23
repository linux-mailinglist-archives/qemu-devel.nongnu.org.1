Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D77F6379
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C48-0005yq-Fk; Thu, 23 Nov 2023 10:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C45-0005x9-3h
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:29 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C43-0002Kb-Ei
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:28 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso1444990e87.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754985; x=1701359785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYtTw4ASUySFW6kKmyEfvxpirNrDtpnKMB7Ug/FIcYA=;
 b=nbXoOhpSXGi7Mcxgmwp2qqXwoMAm2JG66OmT61bX3Sj5z5BN9gsJJ2//aE19GMstCA
 71uMlTxFta/uzp0JZcsIXvhPt0inEFvQG1NaPOUNhrbZyhFDJK0DH4n1qo5CWfsIcZHV
 iNHrvgTuzGplQwM917SQI4dFvDmddAbGvn2fcqNmmu3Awr1iPLl26+we9mYmtYvqsfjk
 migWXoxX6ElKJB3qRSVqoYUmmuxWhKm7qUM74hU+WRd2GYeVKhU7rMH3cdee1FzwIk59
 6To+hn9P0i0q7fO9352gZWO+YO8wqe+IcSDhkverR5VTWsPaaTuhg/vlb/kOHSPmfx4Z
 nz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754985; x=1701359785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYtTw4ASUySFW6kKmyEfvxpirNrDtpnKMB7Ug/FIcYA=;
 b=QjqWmJRGBHVThwLY33JYVFw1Ttkadom/frtfvM14cb9BUW+cQfB2kOJRfaDRHyqd0f
 39KJL2/EB44iEQXuS8O8fgiv5VvzpRVmFo1ntM3ibqBIX6kHq9n4CPq62v4jzDXi3CNP
 Z5TtG7LxuZKSoBX9iJyUo2KJVhw6MRNa3IxT7X8zcETgAr5wB3KNxoqyrpn3CUoIxvmp
 uP7IQDRbvgm4DJZybikxlzLCkwtQhTEKtMKHX6dFBL7L4RGFGOA7y5kf0ABSPdlt+Bkl
 NsNDHfQp0b6SlcHSd/eJl+MPXW2rGYJwVmM07CWxuHqZjfdqqM8i9OGc7OmOEI3RbpHc
 Ta0Q==
X-Gm-Message-State: AOJu0YxGC+ChCecCIkSv/Dw1pffkdAs4JGABlBVeEexqZtHe47Pxcgf1
 psfoQoWtVIMU2Bek3O1fsA7CmQ==
X-Google-Smtp-Source: AGHT+IE33H8vXHdJEF+l+mivhuFz5EXUN+984b1JR03tMo1tCmdQcX8tF1qjs/ARMiJi9hm877EnOw==
X-Received: by 2002:a2e:880c:0:b0:2c8:330b:7181 with SMTP id
 x12-20020a2e880c000000b002c8330b7181mr2942704ljh.38.1700754985119; 
 Thu, 23 Nov 2023 07:56:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040b38082b99sm1009113wmq.1.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49A55645FB;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 06/14] tests/tcg: fixup Aarch64 semiconsole test
Date: Thu, 23 Nov 2023 15:56:12 +0000
Message-Id: <20231123155620.3042891-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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
Message-Id: <20231120150833.2552739-7-alex.bennee@linaro.org>

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


