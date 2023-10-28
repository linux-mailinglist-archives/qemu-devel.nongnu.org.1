Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379177DA6F3
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiMh-0006Jb-V8; Sat, 28 Oct 2023 08:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMg-0006Ix-Gb; Sat, 28 Oct 2023 08:24:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMe-0006lH-P0; Sat, 28 Oct 2023 08:24:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso462779566b.1; 
 Sat, 28 Oct 2023 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698495866; x=1699100666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YiyCcN/ucib3SSeMOWbQOQVhpMOluzA0hVagTF6ISfc=;
 b=dWLVTucQ+nO36PGKtvl+sqRBZWeeP4k3SPnP9Yr4LIN8d1frurGOS3+JSXlwBi2lsV
 nGzxsjnWSsD3iK6W7X80U9JLqZKQRpuES/Uc5CPCxuBna1ia1+0FZ8qcwDHF1HjDrHPh
 6GTde86q+Vxgf5PrHwnj5Bka7XAPy0hINxip8SpvdAXFlopnHrZdykQNcGhA2MvxtWIT
 N2bx614FJvqjtX+bw1fbJ9+tWuQj/7kD+hKFPXeaFx8QbZy+GPMZaxN/0ptd3skps7N6
 S//QrBYxYYWvvJ84IJD79U2JOIdZmdAGT8AfN8JU5eAXYEeggfgX5n3UAHb7QlmVMQ3A
 cQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698495866; x=1699100666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiyCcN/ucib3SSeMOWbQOQVhpMOluzA0hVagTF6ISfc=;
 b=wAR6mqOOoJ9ua0mkXxMC/s+pyvRnmh6NRqXKvgnMxjI+5IX4inhrvRtKIC8XajCWYL
 R2FlXGA//mYshnKKbiQpseEwq0xu3RF3s3cEIfOEdBO/NThaxfH7FAOC5ploUI7HsMIn
 K4G5BeckavXkED2ywr7t41+vyeYhynUtgv/MhhiamIWqs/mXn/oImt/m/Y0kWvmPBeoW
 9XxCn/bD7zHx49z6F2GYRS//eee8ZfJjkRJi+Jn3N5lE7Xy5kGQRUFJ4i6GeTEUp3dRZ
 WHun1mp3o5D5zwpxzMtR1ZCR9iR+ReMHUIUItXcOgQpJUkkqsKJU4Oc8l/67wqjvhRdC
 2oZg==
X-Gm-Message-State: AOJu0YzWknJn2ysFhtu6hn8mpMEYctQ4DvjwWH3XlWayaoepYz/uXWVw
 8KeYh4Egyi0cVqqKddL/Uyi+RCHS0yQ=
X-Google-Smtp-Source: AGHT+IFDwcgbz7VIzpg2MbcoN2kxlzeSulJeE65nndvylyb8XnDwMA9ecrJJitkjHbt5LTUPOQkmOA==
X-Received: by 2002:a17:907:a4b:b0:9c7:4d51:af08 with SMTP id
 be11-20020a1709070a4b00b009c74d51af08mr4464727ejc.43.1698495865996; 
 Sat, 28 Oct 2023 05:24:25 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906190d00b009ae3d711fd9sm2706687eje.69.2023.10.28.05.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 05:24:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/6] Various tracing patches
Date: Sat, 28 Oct 2023 14:24:09 +0200
Message-ID: <20231028122415.14869-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series enhances the tracing experience of some i.MX devices by adding =
new=0D
trace events and by converting from DPRINTF. SMBus gets also converted from=
=0D
DPRINTF to trace events. Finally, when tracing memory region operations, ho=
st=0D
pointers aren't traced any longer and are substituted by their memory regio=
n=0D
names.=0D
=0D
Bernhard Beschow (6):=0D
  hw/watchdog/wdt_imx2: Trace MMIO access=0D
  hw/watchdog/wdt_imx2: Trace timer activity=0D
  hw/misc/imx7_snvs: Trace MMIO access=0D
  hw/misc/imx6_ccm: Convert DPRINTF to trace events=0D
  hw/i2c/pm_smbus: Convert DPRINTF to trace events=0D
  system/memory: Trace names of MemoryRegions rather than host pointers=0D
=0D
 docs/devel/tracing.rst   |  4 ++--=0D
 hw/i2c/pm_smbus.c        | 18 ++++--------------=0D
 hw/misc/imx6_ccm.c       | 41 ++++++++++++++--------------------------=0D
 hw/misc/imx7_snvs.c      |  5 +++++=0D
 hw/watchdog/wdt_imx2.c   | 28 +++++++++++++++++++++------=0D
 system/memory.c          | 26 +++++++++++++++----------=0D
 hw/i2c/trace-events      |  6 ++++++=0D
 hw/misc/trace-events     | 19 +++++++++++++++++++=0D
 hw/watchdog/trace-events |  6 ++++++=0D
 system/trace-events      | 12 ++++++------=0D
 10 files changed, 100 insertions(+), 65 deletions(-)=0D
=0D
-- =0D
2.42.0=0D
=0D

