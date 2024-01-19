Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50D83307A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:52:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwlp-0003tH-7b; Fri, 19 Jan 2024 16:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwld-0003sR-2p
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:13 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwla-0005P8-Uj
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:51:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-337b38d6568so1109726f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705701069; x=1706305869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O1PQjWgpBW2NJ+Bq1GU0NZb12Y8zCOGxZ2+frvV8uYQ=;
 b=L+avwftcYxBOcwsV4pzlK4Ln5EFY9PWoEXGK9UpgacInvlAtiUKKP5+7pELtSxBTzy
 Kbc9oi8qPpCNXMclri4af8MxMT7LZs1HCnCkXU+CNQjTMHqO53Id0+Gz/Fs5jy1noMNt
 zJbEKR/tULQshC3FFWt8HnHlwsicvZhvRjKPaKS2Y1pGDbVHPbQ0tMWXr0WgtOqahmgp
 MqeseyigGiisdWGZ+4b45sg071cA0iMpUmF/eI+dWaou0lW0ANqdlb4AAJc9hm8Wvlv/
 F4sqoqQDgxgahEUixKMjmicgUtbEQuXLSM+i33Bof3OKS7VdG5WzRfj2ncrHAC+3skoK
 Zfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705701069; x=1706305869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O1PQjWgpBW2NJ+Bq1GU0NZb12Y8zCOGxZ2+frvV8uYQ=;
 b=PNSPRqNeyyqPqIFmh3j4MzkQzfKldSKtqxfUFSXuN9tWsEcV4MRGCGcau4i7ewfpLv
 qGQEMdg5VFZ2Dw4nKywbVt1FQZ2efmpX73Ia+cN7ec9gjcIbWYF0eFPCHqZDaLNiFGWO
 xNCs8V2Zg3fAAdl0KK4eanXXi0MgDkpxOr/7cs/QfP2KywJpfurrMAPYgUjD3buZdJOq
 c3sWbHph8AMkEiWrJphIG8j71YTlYOUi+xNgZhG10PBnJcnJvfz64GgZH3i3KyQZ2LHQ
 hcUkmnigbMFl2o0VVJ8FsyMS+5OmIZx3X/6XYuStyCtbS5Qi92CoTmhy/06p1n0qsubQ
 4gUA==
X-Gm-Message-State: AOJu0YybG10Q3/VxVdSnZT8saGTUvoGjA50zNxvbzxtiZllHPjUhCM0k
 vtpkd/1YmfNVih3e8ca2NY0Hu0+oYy0J28Z8vurYUh0+Zva7t9nZLrPBHvl5hqNVQHkALSvjFBh
 B
X-Google-Smtp-Source: AGHT+IH50/FqvaWYWaBwlrQyt1aj9z/s6qNC8br9Sj+lVvlglg6ujA71ZEUfspEyndTXori3dpfkYQ==
X-Received: by 2002:a5d:4208:0:b0:337:4219:3e8d with SMTP id
 n8-20020a5d4208000000b0033742193e8dmr235290wrq.15.1705701068819; 
 Fri, 19 Jan 2024 13:51:08 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 a16-20020a056000101000b00337cd6b1890sm4886383wrx.80.2024.01.19.13.51.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 13:51:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/arm: Unconditionally map MMIO-based USB host
 controllers
Date: Fri, 19 Jan 2024 22:51:04 +0100
Message-ID: <20240119215106.45776-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

When a chipset contain a USB controller, we can not simply
remove it. We could disable it, but that requires more changes
this series isn't aiming for. For more context:
https://lore.kernel.org/qemu-devel/56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net/

Since v1:
- Mention migration compat break (Peter)

Philippe Mathieu-Daudé (2):
  hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
  hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller

 hw/arm/allwinner-a10.c | 49 +++++++++++++++++-------------------------
 hw/arm/nseries.c       |  4 +---
 2 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.41.0


