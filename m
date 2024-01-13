Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21B82CE46
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 20:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOjVH-00069m-Md; Sat, 13 Jan 2024 14:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV6-00068c-EX; Sat, 13 Jan 2024 14:17:02 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV4-000866-5h; Sat, 13 Jan 2024 14:17:00 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28b82dc11e6so4612487a91.1; 
 Sat, 13 Jan 2024 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705173415; x=1705778215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Ryj8hm3I3R2bbBqJYa8XZwa9eu9X+i4k5Iz/3RYnXRU=;
 b=O87wtp5tpxZrg/b1OOhJEx6CciTQrrsEAZvo4DHXPYk4bAGmFAlGb+bd/gU0wRHqyb
 dCnJTI+iDvYCdyf998pVQj33fYQaFnPvbTwyPH8eaiVxALD54qAW/NIF3yi0TmVR2Ovp
 TJeBKJGVmZNpWjyDaZGMVtauQZXCgehhcMmAOk1Hs4yadqlCpPep4LbnZ3wBONIV+vYE
 /bqulUQ+tT23mJhRxnsMv+9xSRv/S1Qgh2ETh22sEgB2+yNvquJYmCQnRf0+OUS0TxPs
 13AqEbg3tBJyUQsTL8mkDSoMK64+IMCvSJ0JN0ZfiN0SYGmIHRCxm4QBi1Dk5huz/S7N
 JVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705173415; x=1705778215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ryj8hm3I3R2bbBqJYa8XZwa9eu9X+i4k5Iz/3RYnXRU=;
 b=pvIsBpy2axfoFzyU1P5Lnu4/FW3Lb9iBfM9G5WaL9G70RzEmScDkyZJP+aSO48QWIB
 Xhea6AKPkLYF7dHDGM7VWiaNvGF2KqYFioo716OmQIR81UP9SuXM+aqZIi4w7jeRS6zl
 wKSzWZusP55tA6RLl1nvy71kS9xnsV7PnsTYiPphqUN7I8aISWkdHFxod9bxrnB0VhdU
 u13DBhbrDNG8MmWeazLsWnijBUNptxbzEyhYwlZEG7UQCMVyPmOPfR2aDCR/chTouLlv
 wswD10T8/Xxvd9ZZd9MjfWBDsMjZS1ENTJoLHA5KDzYUWHKZhenuQJPyiHSocmf91J+V
 0YnA==
X-Gm-Message-State: AOJu0YyV2Qom841nIUf3zGNf0aJBtA3PpKSNkAOLTOv/xbitCgBhaxsd
 ToPz59FrSIYFxFM2SNzlqJY=
X-Google-Smtp-Source: AGHT+IGhdCLBt9//+9vM4LM21B3DnpT4D8YM+wmCoaty5lYJO1DUOUXBUHl6w4HqEdx2TeCsfwsX1Q==
X-Received: by 2002:a05:6a21:183:b0:199:c29a:190b with SMTP id
 le3-20020a056a21018300b00199c29a190bmr1941834pzb.108.1705173414736; 
 Sat, 13 Jan 2024 11:16:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170902edc300b001c71ec1866fsm5125097plk.258.2024.01.13.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 11:16:54 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] hw/arm: Add support for USB, SATA,
 and watchdog to Allwinner R40
Date: Sat, 13 Jan 2024 11:16:48 -0800
Message-Id: <20240113191651.1313226-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add support for

- USB 2.0 EHCI/OHCI
- SATA/AHCI
- Watchdog

to Allwinner R40. The hardware is quite similar to Allwinner A10 and H3,
so the code is derived from the implementations for those SOCs.

Tested with bpim2u emulation by instantiating EHCI and OHCI keyboards,
by booting from USB, by booting from ATA/SATA drive, and by manually
testing watchdog operation.

----------------------------------------------------------------
Guenter Roeck (3):
      hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and Bananapi board
      hw/arm: Add AHCI/SATA controller to Allwinner R40 and Bananapi board
      hw/arm: Add watchdog timer to Allwinner H40 and Bananapi board

 docs/system/arm/bananapi_m2u.rst |  5 ++-
 hw/arm/Kconfig                   |  4 ++
 hw/arm/allwinner-r40.c           | 90 ++++++++++++++++++++++++++++++++++++++--
 include/hw/arm/allwinner-r40.h   | 15 +++++++
 4 files changed, 109 insertions(+), 5 deletions(-)

