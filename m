Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4E7F16DA
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tf-0006J9-5e; Mon, 20 Nov 2023 10:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tL-0005qO-9L
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tC-0001EQ-12
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32df66c691dso2866403f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492920; x=1701097720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjAJqKCk3iUb0SkYI6f8P9mLxZWi+VPPBoOgrXC8tUg=;
 b=BQKTFM0lIX4FCT5KeM9hgHLytNqqSQcT6HboPktwPoEMlj/8Sd81OJ2If6iWTQZdZJ
 xrIs/n2EHtFm9PLPbatH1Lhum9p39YpStsl2nONmTEElEU/9CS6U2RmGbBZUIRnTKvtH
 MdUXlucrKCcE09Bc8Fy4m6gE0mChtxckaDKLUFE6Prci0bMZ5C8k/uLVfbJhssCkp2T+
 FNBvP0ZrAbsuoeaxYTYZdE38a/bU1QdCnDWcSI4FyKO9GdzXqvFAj5EQDDSVvBLPGQaI
 ogBvUvu1ru6/xlQ4VC0q5HEVMk0vqqR0FsSMxtfunPEPzl76VX8ICUy/EgsXhECI9ctO
 Hn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492920; x=1701097720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjAJqKCk3iUb0SkYI6f8P9mLxZWi+VPPBoOgrXC8tUg=;
 b=ocgAkokFFETsA7P+UdyJMDoKlwbPHviHPH1ke8faotsYcKKsjGHoKiAONmCH1XpznT
 ZLG5UTJkjG6DPTI2VoxFrW6FdoJyPGwsBxpJqOYJmajD4BxVL/JT+FNOWYmb1iKX8im4
 dB1Kqfq5mRotqxONlATGAxq+Ye3DDdox9E8Mex1lHOqzVVf9vum75JL1xSKsbHdHv+fV
 xMQVvncB1bPjObTK/jSWcg1fLr4pRT1tu4gJhiniS/OVRtPefyudCzNFn0aV2+e+Lc4h
 S6pAy8qPH7PictPOYqJXEVT1r8PWsZUFKtdCmUdP/dIY73yChhrMXkEqwwsQu1GxY89X
 ruPQ==
X-Gm-Message-State: AOJu0YxM+0vVV4vjyseICgek3kc1ev9GVX+7Ap6fJRxJf9/t4DjtFtBW
 FJAVg96Budi7/KglaK87slwZoA==
X-Google-Smtp-Source: AGHT+IGnzZYarrmBs2T1ybalMqbmG/wDdDbl5pPaKrGhn3vwefQc7sq4CUCEcB7JFX+K5XLzlZ4XdQ==
X-Received: by 2002:a05:6000:1883:b0:32d:701b:a585 with SMTP id
 a3-20020a056000188300b0032d701ba585mr7086064wri.69.1700492920360; 
 Mon, 20 Nov 2023 07:08:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l5-20020a5d4bc5000000b00332c4055faesm4984373wrt.87.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D8DD65774;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 06/14] tests/tcg: fixup Aarch64 semiconsole test
Date: Mon, 20 Nov 2023 15:08:25 +0000
Message-Id: <20231120150833.2552739-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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


