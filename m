Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8078F5E2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqaL-0003r0-8Z; Thu, 31 Aug 2023 18:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaI-0003pI-MH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaF-0002o3-CB
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-500913779f5so2593861e87.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522572; x=1694127372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jKdocwvusJcWDjf+v4RM9Qjoh/9+oixhFLCVcNMDDYE=;
 b=PRTD9j4nwt2MYriHQeCE8WQvgKoxZOoxkrBY4GZW7EMZJ73guW4ll3yM/63Scj/ABN
 M2UHAdDcJnGALhIFuv9DnCQHnkE6xQfh3UBd3vRDskQrvIokdLMYehrxZDu/Fdu+OlAW
 rQZtNn7pPzXGOkmke9+BRhPRQE5z3bWpLoeT+lRsFxyS66YIwmbOntlJJIyMd7abEk7F
 LW+XFYnYNQGw44cvQTsoM/0HizUdvFMcw9mZIjnzLsEBthPL3j+P0tQmL64PJp5xN124
 4hMj81Ou79AnGUyR3b6XtJA0deUH31TVZsJAZykN3VR/gM2CbWJBZ1bpd0F252oxTd6q
 t7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522572; x=1694127372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKdocwvusJcWDjf+v4RM9Qjoh/9+oixhFLCVcNMDDYE=;
 b=i8UEHYactWISLw7gVSVIcfayfgR7gS22pMSBdVbFOy5sM/8XyvdjNn/Vk7ILyO3kng
 Ry10NgTDJrWX3kpz1zJiQF96XUCzyL7y5JjK29VCpV2XQryUWfYBhS3/c6ugQPw+gklb
 FuHoZGTYi7ngaaMisD812yxy4vR0HpPioqGr3Oz2RJO2oxtYLaH/IkEu1+FoZi3G912z
 anZivOLXMW2hOFBptjRC0ODE8skU/yoWAB+mGRR8hpphSvM1CFbIvhbyu+NPPFQGtGAQ
 SLBOER3+xpjNXn4zwiCCwvUVm8kaQqWI26rBitTGxnVATJA3EizrdpnzT0Yyg1Ian7um
 WKUg==
X-Gm-Message-State: AOJu0Yza/5k4BegsOVwZmTekJWLSmZOCmQIZ5RQ90GQrq7srcdzBGoF/
 XiuV3PppiVq8E+kKOnOvj4hykrSHQ6nOugLxioE=
X-Google-Smtp-Source: AGHT+IHOUaf63X4lkDbpGdBXKHYc9HsG16TmPJ5xLewf1Y0wKjn0AUoYKEOWT6ArG9KFosIQt/D1Rw==
X-Received: by 2002:a05:6512:3b26:b0:500:b2f6:592 with SMTP id
 f38-20020a0565123b2600b00500b2f60592mr471916lfv.50.1693522571540; 
 Thu, 31 Aug 2023 15:56:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a05640214d800b00525503fac84sm1324851edx.25.2023.08.31.15.56.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/11] (few more) Steps towards enabling -Wshadow
Date: Fri,  1 Sep 2023 00:55:55 +0200
Message-ID: <20230831225607.30829-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

For rational see Markus cover on
https://lore.kernel.org/qemu-devel/20230831132546.3525721-1-armbru@redhat.com/

This series contains few more, my take.

Based-on: <20230831132546.3525721-1-armbru@redhat.com>

Philippe Mathieu-Daudé (11):
  tcg: Clean up local variable shadowing
  target/arm: Clean up local variable shadowing
  target/mips: Clean up local variable shadowing
  target/m68k: Clean up local variable shadowing
  hw/arm/virt: Clean up local variable shadowing
  hw/arm/allwinner: Clean up local variable shadowing
  hw/arm/aspeed: Clean up local variable shadowing
  hw/m68k: Clean up local variable shadowing
  hw/ide/ahci: Clean up local variable shadowing
  net/eth: Clean up local variable shadowing
  sysemu/device_tree: Clean up local variable shadowing

 hw/m68k/bootinfo.h                       | 10 ++++------
 include/sysemu/device_tree.h             |  6 ++----
 accel/tcg/tb-maint.c                     |  3 +--
 hw/arm/allwinner-r40.c                   |  7 +++----
 hw/arm/aspeed_ast2600.c                  |  2 +-
 hw/arm/virt.c                            |  3 +--
 hw/ide/ahci.c                            |  6 ++----
 net/eth.c                                |  2 +-
 target/arm/hvf/hvf.c                     |  1 -
 target/arm/tcg/mve_helper.c              |  8 ++++----
 target/arm/tcg/translate-m-nocp.c        |  2 +-
 target/m68k/translate.c                  |  2 +-
 target/mips/tcg/msa_helper.c             |  8 ++++----
 target/mips/tcg/translate.c              |  8 +++-----
 tcg/tcg.c                                | 16 ++++++++--------
 target/mips/tcg/nanomips_translate.c.inc |  6 +++---
 16 files changed, 39 insertions(+), 51 deletions(-)

-- 
2.41.0


