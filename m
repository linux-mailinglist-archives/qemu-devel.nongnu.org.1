Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51657C5553
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:24:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCY-0006bb-CM; Wed, 11 Oct 2023 09:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCU-0006Vn-Jc
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCS-0004TU-9o
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so1145775666b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030670; x=1697635470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ULmNsemscS88tpfzJVeAbYmhCI48NkJf3xJUv7cndwE=;
 b=YCA2MG5hyE3mFyXcmP1e+eqj1A9gTXGuvOc1ozubFJHuTjvuedfqcCDBAcnrfuXHkS
 flMdXpNtEY24sW3w7RP4JCcCJY4SuNe/G9HmcCt9Skb0GL88690IDwbYEp2eBLcQ8HOR
 xpfmiq/YRjCIoiS8aFDF8bwXqMahE1PBnYNejW2tPPhUnqGmvkg4VoPszxputHSLiDi3
 H6TODgJCHLAiTwqeM9SZtUlpI/VoKpjYET6CKEiz9UrjQwBUsaXR/v1ZarYaN6Jh/slN
 hDljvY9g8RkW7SMK3Pi+mu8wL5peEdHXJrd1n7PIHRZswk+wNCvwmsPr4KI3fEpAXEUM
 sTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030670; x=1697635470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ULmNsemscS88tpfzJVeAbYmhCI48NkJf3xJUv7cndwE=;
 b=RF0gPODSVkIhxumoK+qUJDODWxX08cHy+T4QeO8TeVpnX+8fVxqh18ZG551icJ+4il
 LUCxgXTawmMuENvlOQlRw9WgiwIT+uA5Rjh32Qch5yF8CUXBg9aTwa+8T0lHZpP9OYUR
 4oTDQWa7Wpz/YAB5CoIybD0iWFvIb7iBqoNHuDSh7KILj35ALfcACuXGPJ7omyds92Lc
 Jy24yNkbi0VPt74kz6celimkZtj7ha555+5WgcUOsZlRclfF5epdjt8T6hRZDzLr4C8o
 k+N57vlvYLqqY9cbY0tTaX3pEt1QhJWaDxfPej23xu2HhdmxfFzxtCjqrrUIcGIh3m7L
 T3vQ==
X-Gm-Message-State: AOJu0YyoSJbhan/qs4EiAchRHjtSEg8aOtWIyaXE2vazsIjNJOoX11na
 ocdolJgx7GOOiihhAC0I2/lxRdObfDLQQ8n3YRU=
X-Google-Smtp-Source: AGHT+IFIodGGEuCCSGidh7mMyV9vvln+XlpQhIj6ex0mlfCfuRzdnajBPs56OGTlb8Jas6Q/5POlDg==
X-Received: by 2002:a17:907:9706:b0:9ae:5370:81d5 with SMTP id
 jg6-20020a170907970600b009ae537081d5mr23684879ejc.41.1697030670301; 
 Wed, 11 Oct 2023 06:24:30 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 ca9-20020a170906a3c900b009ae587ce128sm9769665ejb.216.2023.10.11.06.24.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] hw/pci-host: Build ppc4xx_pci.c/ppc440_pcix.c once
Date: Wed, 11 Oct 2023 15:24:22 +0200
Message-ID: <20231011132427.65001-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

- Move ppc4xx_pci.c/ppc440_pcix.c from hw/ppc/ to hw/pci-host/
- Build them once for all targets

Philippe Mathieu-Daudé (5):
  hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
  hw/ppc/ppc4xx_pci: Extract PCI host definitions to
    hw/pci-host/ppc4xx.h
  hw/ppc/ppc4xx_pci: Declare PPC4XX_PCI in Kconfig
  hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
  hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/

 MAINTAINERS                        |  4 +++-
 include/hw/pci-host/ppc4xx.h       | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h            |  5 -----
 hw/{ppc => pci-host}/ppc440_pcix.c |  3 +--
 hw/{ppc => pci-host}/ppc4xx_pci.c  |  3 +--
 hw/pci-host/ppce500.c              |  2 +-
 hw/ppc/ppc440_bamboo.c             |  1 +
 hw/ppc/ppc440_uc.c                 |  1 +
 hw/ppc/sam460ex.c                  |  1 +
 hw/pci-host/Kconfig                |  8 ++++++++
 hw/pci-host/meson.build            |  2 ++
 hw/pci-host/trace-events           | 12 ++++++++++++
 hw/ppc/Kconfig                     |  3 ++-
 hw/ppc/meson.build                 |  3 +--
 hw/ppc/trace-events                | 12 ------------
 15 files changed, 51 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h
 rename hw/{ppc => pci-host}/ppc440_pcix.c (99%)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (99%)

-- 
2.41.0


