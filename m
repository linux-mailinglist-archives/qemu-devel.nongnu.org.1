Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2737EA2B5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:19:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVa-0007Wa-BS; Mon, 13 Nov 2023 13:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVU-0007W0-EK
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:17:58 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVS-0000Uo-0B
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:17:56 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e61e969b1aso491517666b.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899472; x=1700504272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=capcjVKPKqE+VLy65Ulh8a/I3TCIRtzzamG6SA9QUvo=;
 b=l1JnD9lKQY9XCOCvCr6pYPPrnnhiUrdrlNIIiqCe1QaTg89RpUlFpMVVbw+/l+0YCX
 5dMtbg6+tbUrNBrIMZQuT/T53bKpsMVpxuuxCXBtz/4/QIxFL7PS4evQLREeHllZKZx2
 HAJrAPEvPfSPP57sGTOqAHWmUTePCmNwnWNbbWsE0MipVlvNCOuVKy05fsJUihiZpwrz
 JUZgYgZWyrAwaB+fb805TSas3IQ3KEYSrpIfCEfeC2DmrfIS19Phto7ybu7+4dh7Qchj
 TULt8aPVdwQK9f6z57MFMudETfWLGGLf82VuqHwKJaf5R8rANntZml7TtHaU5ot1CwP9
 vFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899472; x=1700504272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=capcjVKPKqE+VLy65Ulh8a/I3TCIRtzzamG6SA9QUvo=;
 b=NNY4cKr+liX6PK0rUrwKIMBRB3WVMLgalI11WCz0YG1x8mA0IWUwJSwjWDbmNpu10I
 4S/T9dMYT0f8RODRmV7K3bPdbvgSZmT2WhhnV9QyBE3Jrsspl8wdRqH/Ee24ALE5UdnY
 E6JX3GHIpqpmVWzLioD9DMRuyBrHBPgobWvGT5tNVa6z0MujMyNEjf8RGWkV46nTs4f8
 yPK0yVxwIpNemzN9eih24msY3awfhs0Mkv/Xiqu+oQhAIpBVWerENF0bEe9J82gnAdp2
 7Kb8EgQUuaZLSrztQCnGrACpv4cg1AFbI+kPqz1Kc+EF/XUzea0FB8zPZ0v0hDzgX3GI
 Apjw==
X-Gm-Message-State: AOJu0YwRJ4XPKNNND7+V3uQkxgfv+eg9DHnywiiUIKoFG5i5Oy3zREvr
 xhqOLbvtov1PvtO5ZuVtI68YfoNr0NkiZOTCf60=
X-Google-Smtp-Source: AGHT+IEGZPDtI92ETgky8DKBO1ira9DboVEb5kfZrY7ENF/JhamhFp2F86ZRXTQkelgQ/lP5c2KfCg==
X-Received: by 2002:a17:906:a396:b0:9e5:e56b:9b7 with SMTP id
 k22-20020a170906a39600b009e5e56b09b7mr4687095ejz.42.1699899472445; 
 Mon, 13 Nov 2023 10:17:52 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a170906714900b0099d804da2e9sm4388271ejj.225.2023.11.13.10.17.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:17:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 1/5] hw/mips: LOONGSON3V depends on UNIMP device
Date: Mon, 13 Nov 2023 19:17:40 +0100
Message-ID: <20231113181744.49537-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: qemu-stable@nongnu.org
Fixes: c76b409fef ("hw/mips: Add Loongson-3 machine support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231107140615.3034763-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 66ec536e06..505381a0bb 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -46,6 +46,7 @@ config LOONGSON3V
     select PCI_EXPRESS_GENERIC_BRIDGE
     select MSI_NONBROKEN
     select FW_CFG_MIPS
+    select UNIMP
 
 config MIPS_CPS
     bool
-- 
2.41.0


