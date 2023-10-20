Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 002237D0E33
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnPw-0006c8-LX; Fri, 20 Oct 2023 07:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnPr-0006YH-Q9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnPq-0002GN-8l
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso5796735e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697800300; x=1698405100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TyNYvoLX9L3eXtwjSCXSMnmZnWiq3lgg9TbHE+Y44Dk=;
 b=A8Zpe21GYFzmAk4HCEiNsO6PYbjNhiXPM3IdItkjfbXK4rIna6skLWAlEEJ9QeDXYS
 TwcFxerQz1bggdjyyBu6rCB2tD+KnRzHQZEF1pdv0jDVpnctpyyRf3qIp5f+hyNHAHrQ
 LauIy3/S6YeMsdptzuoBwIXOh6P7NrbzxjBlIIpnmNitFTL+7OJm/VtjUK9PfHf0eTBi
 pMLq202dV2DUsgC97RyOh0lR5Vry2AXIMHbzmYLlZwC2kD+yxatJQjV/qlVOIlI3vG2S
 txZJ8AFTxyqe3sQxGBzuAsCejq4PKMbxW3V+073jBMwQd7XAqZugQ1T5S4tgqj7FDHi7
 7Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800300; x=1698405100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyNYvoLX9L3eXtwjSCXSMnmZnWiq3lgg9TbHE+Y44Dk=;
 b=BWClcSgbvusZ2HJuB+qVM1yX1yFw7A6okRLtsIydL1ntkxkEbwEbSJBTYT3NieN5ua
 QE9d9wy+Bi3mDveD5vmOHR+HBCdpjUWS9/3gxKW4P6dzp+gQ4qRGUnPzbkAIu7/lTHU/
 z6ZxwwcGFM7lzgu+vyBv4B3sBIY2MHGxKcQKhPQBkOc26JlotQYQlhnlceUTzzHdJgVo
 7q/W+zh3UET+6Hs82BB27f0cn95vPCpP3LBZLT0pXYwQHlJwcfQOT8A/g/FSlWqh8U0D
 hyXihpRKblM0qUj0Q+dSXlLvaYUpyY/phvOboiui8u1qtYARfuN2Qx+L8qTgl22DzfXE
 L91g==
X-Gm-Message-State: AOJu0Yzx/dGbvxhWq0f5LmCQvXyDarfKJbuWNZdVzO5Bfmp7gpccBjZn
 5L6Y/kzH8avgG4mjZF778VZthV+3HgJznODQoqw=
X-Google-Smtp-Source: AGHT+IH1fZj/GBzGoLoNir53wuP24pomnTQvrR4zn+M8dLjdkEkg9RID7HSI8Py1af5wiecf+5nVyQ==
X-Received: by 2002:a05:600c:474f:b0:401:d947:c8a3 with SMTP id
 w15-20020a05600c474f00b00401d947c8a3mr1162572wmo.32.1697800299891; 
 Fri, 20 Oct 2023 04:11:39 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c190600b0040641a9d49bsm1919571wmq.17.2023.10.20.04.11.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 04:11:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/i386/hvf: Style cleanup
Date: Fri, 20 Oct 2023 13:11:33 +0200
Message-ID: <20231020111136.44401-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Keep HVF style closer to rest of target/i386/.
No functional changes.

Philippe Mathieu-Daudé (3):
  target/i386/hvf: Use CPUState typedef
  target/i386/hvf: Rename 'CPUState *cpu' variable as 'cs'
  target/i386/hvf: Rename 'X86CPU *x86_cpu' variable as 'cpu'

 target/i386/hvf/x86_emu.c | 106 +++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

-- 
2.41.0


