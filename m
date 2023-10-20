Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198067D147A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:01:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsrF-0002TJ-Ai; Fri, 20 Oct 2023 13:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsrC-0002T1-F1
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsr8-0008Pc-UB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:00:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40651a726acso8561065e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697821212; x=1698426012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yUak8H4M4zPRU/zOOYuvzt7PvQtfGRk2Ok6XYvAqPoc=;
 b=WUkMPWJ9zca460VU2mEwkEfQBpoOrcET9M2Mhix4SgrNAaZYGise2g8y+cG6JEbuoj
 oWeIXoZ1/BgRpnO6Sx9ooUCAuAbxb2GdU9RnDMmkHKMYP402K2in8fazSpWsDFTESk9c
 1aItLfMXAjdc34BYTf+U7df3RjvLbyR8r3c6OpdgocX7NHa3TbMQ3sIYVRJ2B46a8qUO
 VrCiu5s/QF7WrDvm/7eTp9V34fw0vQxnYqYvW+7InJ4BJteWLTVyIALCPbE6p0TApeIc
 tGLENKTyPKpKoVfoqmwURVY+wCW7tnL3/bpCxGAKzarvQcyVV1066jxQXBHKHaEhobBX
 dVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697821212; x=1698426012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUak8H4M4zPRU/zOOYuvzt7PvQtfGRk2Ok6XYvAqPoc=;
 b=wvN8Q75jt6Hcay4rgUS/KsGAAXq56BQibexV/qcHuVoqjPbQzg+QSV/aJlJR7rozrm
 JWZ1CV6MyHgKDhgeiu74iAq/0iKQiGhv4pZdkDHhA0xyhys2MmZoRYhND2YepzZ1GMiD
 wDu3Jwweq19Tpg00YrZZ9JLOfaFwBsfuggUKZaDtoIsoQcwEBU/Wqh0Q4JG+zulErGBa
 ciNqYwvsZGNl/p9kqNRDVLTbmNmWuK4wA57eQjaj4sz3TdFOZg2To5KDCHE4ZRn+En1F
 A/2b6Et7P4dHcXsW38M52UvjhVX5srYzODiUju1mJGn+P1dmI6I0tNvIHPf30aktcVT7
 2EQg==
X-Gm-Message-State: AOJu0YyyNSSE5J9xrGTJ2fydby9MjGXYIGudYCXdd3+9sXRNtyEB/elO
 qf1luA8gaJXd0Kb9os6VQnru0A==
X-Google-Smtp-Source: AGHT+IEdrwpQAvct1thlMHhwhbEvVxohynSgdwKG2hG8AWfLEG/hGkfm9BwPKPvwqzekesARzI3KuA==
X-Received: by 2002:a05:600c:3b8c:b0:3fe:d71a:d84e with SMTP id
 n12-20020a05600c3b8c00b003fed71ad84emr2015265wms.1.1697821211974; 
 Fri, 20 Oct 2023 10:00:11 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b00403b63e87f2sm2618679wmq.32.2023.10.20.10.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:00:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] stm32f2xx_usart: implement TX interrupts
Date: Fri, 20 Oct 2023 19:00:04 +0200
Message-ID: <20231020170009.86870-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Hans-Erik,

Here is the respin of your patch [*] split in 4
parts for easy reviewing.

[*] https://lore.kernel.org/qemu-devel/20231020111428.3260965-1-hans-erik.floryd@rt-labs.com/

Hans-Erik Floryd (4):
  hw/char/stm32f2xx_usart: Extract common IRQ update code to
    update_irq()
  hw/char/stm32f2xx_usart: Update IRQ when SR is read
  hw/char/stm32f2xx_usart: Update IRQ when DR is written
  hw/char/stm32f2xx_usart: Add more definitions for CR1 register

 include/hw/char/stm32f2xx_usart.h | 10 ++++++----
 hw/char/stm32f2xx_usart.c         | 30 ++++++++++++++++++------------
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.41.0


