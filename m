Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 268747C63E7
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn46-0002xr-2y; Thu, 12 Oct 2023 00:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqn40-0002d1-Ao
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqn3y-0002Wl-Ba
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so3520009a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697083960; x=1697688760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wqMnVC1PNKuiV5TnLAY6KW9Wm93FzcifyJIT73HOIHo=;
 b=QyPoAXWJZNs+ub+68n6H+EN3dHs61MfHRfxfrsJtVL/nLI8YY0B8sUS3T7A/dFFv5H
 Eu00WehaL0iTGpXb5uN5E7Etb8oKT46z+4Zl7XEiDYHSWrsqS70eb89zvodaQ+SuE7nT
 EzeUdsYesgg2aAhpS43y3dwtx6ong3TOwwwZtNqxW6EYeKibe8yYRpdlOGsLpprqTqIG
 AJ06EhvZffnfoMU67wHt36rj/DuQqSyPNo2OB8K6d/l8WNPS8orWHGUOrB08U3xxDj+6
 gmDuF/J5hlmlr3/cNDEy8HvTYdKl7zyW09s2VZNLqvul7+Q5ACCto2LeHMS+6eR+mYIK
 DtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083960; x=1697688760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wqMnVC1PNKuiV5TnLAY6KW9Wm93FzcifyJIT73HOIHo=;
 b=KYlB7URfeqZhxMmYNp8TyF34HUbZNWoW0pX543Eyw1VDxpK+Zj4syANJSjYArDWu+9
 SxFO6+lKQMO10lWlgjdvq6hoFQkgpXTqtIsXJtecQ40jtAJgmNmDddz86+x78aG7LyDo
 wE9qaq3rG0JT7z/9iwt+Cj8OoiqA1l+d1X5CJtnVN7zD2fZK+Sa+1Nw/ZGAo51UY/Lou
 BUqgHVAj44YTrvS9i/82PdRjoUHjwRKU5QUFf8elOV8DxpVaB2pCpa7IvV1W6Y5hpveA
 wgStByHbWGRkPxD+f50phakxHYon2A4ajrSL7VpKxA4gOldnvOI+pQsYgJWEhKdfxdKU
 UyRg==
X-Gm-Message-State: AOJu0Yyp0bn+TiRG2a9VtyM+twOZww+AGPKm0sAt3eyF+C2cIhsd3Dav
 yy30Af6sU7xmWN+kcWtaAStoBuUciMTPOGGWcQs=
X-Google-Smtp-Source: AGHT+IH43do4K+sJQSa+lfIAD3X/J9faqSAF4SQjrnftfstyMY311YsVWbF+M+fLpyqH2ZMQeK2BZA==
X-Received: by 2002:a05:6402:40c1:b0:527:1855:be59 with SMTP id
 z1-20020a05640240c100b005271855be59mr16549831edb.3.1697083959580; 
 Wed, 11 Oct 2023 21:12:39 -0700 (PDT)
Received: from m1x-phil.lan (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 bf14-20020a0564021a4e00b005362bcc089csm9417447edb.67.2023.10.11.21.12.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 21:12:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/pci-host/sh_pcic: Style cleanup
Date: Thu, 12 Oct 2023 06:12:34 +0200
Message-ID: <20231012041237.22281-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

- Use QOM DEFINE_TYPES
- Rename few functions
- Replace magic value by definition

Philippe Mathieu-Daudé (3):
  hw/pci-host/sh_pcic: Declare CPU QOM types using DEFINE_TYPES() macro
  hw/pci-host/sh_pcic: Correct PCI host / devfn#0 function names
  hw/pci-host/sh_pcic: Replace magic value by proper definition

 hw/pci-host/sh_pci.c | 57 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

-- 
2.41.0


