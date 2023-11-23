Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C271A7F61A9
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:39:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Aqn-0001mh-WC; Thu, 23 Nov 2023 09:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6AqV-0001m5-GH
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6AqS-0002PD-El
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:38:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-331733acbacso612326f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700750298; x=1701355098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFa7i+NW2UQ3kmh2XmqKEmfildbqevSt27vx2CpyNsM=;
 b=QW8pah3SPrCXsAQhsAABMCy4SG8qmQT7eqMs+AffEYPSQ7APQRLtOU0CnIoi995Mgm
 hRJUeSEpKLUtOdGkk49XMomo8zVHbRSYz6jDgdky8qeegBF49GUgMCPzZs8dZbnXW9lR
 rNQRNrTkFAe39Z4SjsCHTsCfqk6oZSNdwDItBB0NK4V6ZywSTpSC5skni+IzXq8Nkcih
 NhcqCkdxp2xe/JFtbeClZmNqtVnwfGZNNA1jP0d/auA4DHMz+A8qAq9GUfmp0trmgjjd
 RzgWYBDPK4KYDttFRQ0DaPaOA+LVo80CRwYHw8Ob7c3Mkjnj2sNCnW4ZIFjXMGkVMz1Z
 ov8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700750298; x=1701355098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFa7i+NW2UQ3kmh2XmqKEmfildbqevSt27vx2CpyNsM=;
 b=Byzkalm3QkY8+ihCclTVUifPkJqfkwy6YoEC3vztL2xnj7+BsYSPyD9TiB71QqKpqU
 eeftR1i6uU4pR1FRzLE+V9KMF+Mp3jjmGOs/H68KGhIpaFVxNNzLrcas5E1XAOYLH8SU
 tQCq4z3xVVTG5zMqg46wM4E5or16eahuR/SSbmtXQMvwrTEzOLtI7mWizDdhZLVi8RCS
 EGGWcDyIgx6/A3JaViLfzNOcDKlToRjB8j7Y8RZczeawCFMlq2odxG4pT4kYp66NUmfW
 SshTsC1U7Fe6o2Cfwq2taPz+LOrgMGb7jb8fiyK/PHt4maeagw74Kfz0gRmE+3TUNRW6
 EMxQ==
X-Gm-Message-State: AOJu0YwvmgUkE7sRFAbViYOAFdJHeKu/RSGwdAry5KAFYXiN9fGqu2Gz
 S+pv5Hh0Zl6fs20OfhM2rj4EqA==
X-Google-Smtp-Source: AGHT+IGUNt95c4UGJMFc9fse+XceLKFVdpq4JDMw/PpzxT4D1i7OTLDMcAsKwJMPLA3NG2iA3PW/UA==
X-Received: by 2002:adf:f34f:0:b0:32f:c3d0:89db with SMTP id
 e15-20020adff34f000000b0032fc3d089dbmr3425517wrp.27.1700750298351; 
 Thu, 23 Nov 2023 06:38:18 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a5d4602000000b0032da4c98ab2sm1884975wrq.35.2023.11.23.06.38.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 06:38:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH-for-9.0 v2 0/8] hw: Simplify accesses to
 CPUState::'start-powered-off' property
Date: Thu, 23 Nov 2023 15:38:04 +0100
Message-ID: <20231123143813.42632-1-philmd@linaro.org>
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

Extracted from a bigger series, after Markus' review.

Supersedes: <20231122183633.17676-1-philmd@linaro.org>
Supersedes: <20231122183048.17150-8-philmd@linaro.org>

Philippe Mathieu-Daudé (8):
  hw/ppc/spapr_cpu_core: Access QDev properties with proper API
  hw/arm/bcm2836: Simplify use of 'reset-cbar' property
  hw/arm/bcm2836: Use ARM_CPU 'mp-affinity' property
  hw: Simplify accesses to the CPUState::'start-powered-off' property
  hw: Prefer qdev_prop_set_bit over object_property_set_bool for QDev
  hw: Simplify uses of qdev_prop_set_bit(dev, 'start-powered-off')
  hw/arm/bcm2836: Move code after error checks
  hw/arm/bcm2836: Add local variable to remove various DEVICE() casts

 hw/acpi/cpu_hotplug.c               |  7 ++--
 hw/acpi/ich9.c                      |  4 +--
 hw/acpi/piix4.c                     |  4 +--
 hw/arm/allwinner-h3.c               |  3 +-
 hw/arm/allwinner-r40.c              |  3 +-
 hw/arm/armsse.c                     |  5 +--
 hw/arm/armv7m.c                     |  7 +---
 hw/arm/aspeed_ast2400.c             |  3 +-
 hw/arm/aspeed_ast2600.c             |  9 ++---
 hw/arm/bcm2835_peripherals.c        |  3 +-
 hw/arm/bcm2836.c                    | 51 +++++++++++++----------------
 hw/arm/boot.c                       |  4 +--
 hw/arm/fsl-imx25.c                  |  3 +-
 hw/arm/fsl-imx31.c                  |  3 +-
 hw/arm/fsl-imx6.c                   | 14 +++-----
 hw/arm/fsl-imx6ul.c                 |  8 ++---
 hw/arm/fsl-imx7.c                   | 20 +++++------
 hw/arm/npcm7xx.c                    |  9 ++---
 hw/arm/xlnx-versal.c                |  9 ++---
 hw/arm/xlnx-zynqmp.c                |  9 ++---
 hw/core/bus.c                       |  2 +-
 hw/core/qdev.c                      |  2 +-
 hw/i386/pc_piix.c                   | 19 ++++-------
 hw/microblaze/petalogix_ml605_mmu.c |  5 ++-
 hw/microblaze/xlnx-zynqmp-pmu.c     | 18 ++++------
 hw/mips/cps.c                       |  6 ++--
 hw/ppc/e500.c                       |  3 +-
 hw/ppc/spapr_cpu_core.c             |  2 +-
 hw/ppc/spapr_pci.c                  |  3 +-
 hw/rx/rx-gdbsim.c                   |  4 +--
 hw/sparc/sun4m.c                    |  3 +-
 31 files changed, 93 insertions(+), 152 deletions(-)

-- 
2.41.0


