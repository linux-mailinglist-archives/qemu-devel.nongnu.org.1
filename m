Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075F7D61E4
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXlw-0008FF-Pf; Wed, 25 Oct 2023 02:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXlc-0008DT-1e
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:24 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXla-0006qk-Ek
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:23 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5720a321aso48903541fa.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216800; x=1698821600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6Qda9vsigsp4Gwj6hYyFf7vLPkt//7koKT5q0vZ3TIc=;
 b=i9dt7AJ66JYyhgtt4yJ79m4dMK163+XcIyWX8Lt9o4YMifVbjydH2vY6TWn0GsHuWt
 G5c1at9hnmgRyNFgCZpA8GUeusnGc9ROTtlUradrb1GnM4pTNvrZy3ZNcHei6tR82rSg
 e+YSeZy3gqH+2wRDiDINurQJ8DayLI9ovCj+G99FYkZd25aO57Crcx2ZbNDCWHOiIIAv
 738kZwRFe5Fynjh38bL2tvi0gJzFQwCIw+/zboFXLtnvIAxqUM93pxgwIkniEceiS+fk
 U/rJCB907uq+cMLQ2J85HdJGb9p43P48z0Hv5zPlHYfdjvShhCBs0KSF8UK1FESM5jf6
 JWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216800; x=1698821600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Qda9vsigsp4Gwj6hYyFf7vLPkt//7koKT5q0vZ3TIc=;
 b=lBaXJCZB6yx0OI63egr3Cec/e4MV6PyCmubqo+ybfnfImdcvky1PCxOuxRXI/dRyUW
 rfFRd2XEp/v/UX1bP2D9QoACL8tnVPMKKEI0czQZsAVEWKCZl914ovVq9RomN3L1HSAK
 fzMslc7efp/CshheHn2TyOZ5ugPIoFNltGKhfmU5jIbxZswifeSLfzheNLCiueBXAzSY
 LHG7JyIGTbi6zzxjiAubpg77PUvzSRVJmfPe3zuLfETO1EhQK6G71wLsDHQ+74UwHAkm
 7xCsZkV0gEBqe1d2CT8x51BY9hLS1Jkm3MemN80m3XJnKcm02cVkXnW6yJwPz/3J+AUY
 BM5w==
X-Gm-Message-State: AOJu0Yx0tTm9bujkvIYGzbkrMYRBI8RH6SNniq11n1XqcLV9OlfMdTnB
 GPsNY2TkVRSVKGNf1KmZz8Mhtvqy3VcSEwDrLUk=
X-Google-Smtp-Source: AGHT+IHww6a84AycyO4oYX3Hn04+7bG5UiEuKvc/7ov4x8IU10viTu/x1LAcYrV9h8DVyUZ0DPlWXw==
X-Received: by 2002:a05:651c:2123:b0:2c4:ff2e:d6cd with SMTP id
 a35-20020a05651c212300b002c4ff2ed6cdmr12267173ljq.2.1698216800095; 
 Tue, 24 Oct 2023 23:53:20 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c190600b0040641a9d49bsm13795790wmq.17.2023.10.24.23.53.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:53:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] hw/arm: Move 'hw/arm/boot.h' from header to source
Date: Wed, 25 Oct 2023 08:53:06 +0200
Message-ID: <20231025065316.56817-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

Almost no ARM board header requires "hw/arm/boot.h".
Move this header inclusion to the source.

Philippe Mathieu-Daudé (10):
  hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
  hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
  hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
  hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
  hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
  hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
  hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
  hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
  hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
  hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header

 include/hw/arm/allwinner-a10.h | 1 -
 include/hw/arm/allwinner-h3.h  | 1 -
 include/hw/arm/allwinner-r40.h | 1 -
 include/hw/arm/fsl-imx25.h     | 1 -
 include/hw/arm/fsl-imx31.h     | 1 -
 include/hw/arm/fsl-imx6.h      | 1 -
 include/hw/arm/fsl-imx6ul.h    | 1 -
 include/hw/arm/fsl-imx7.h      | 1 -
 include/hw/arm/xlnx-versal.h   | 1 -
 include/hw/arm/xlnx-zynqmp.h   | 1 -
 hw/arm/bananapi_m2u.c          | 1 +
 hw/arm/cubieboard.c            | 1 +
 hw/arm/imx25_pdk.c             | 1 +
 hw/arm/kzm.c                   | 1 +
 hw/arm/mcimx6ul-evk.c          | 1 +
 hw/arm/mcimx7d-sabre.c         | 1 +
 hw/arm/orangepi.c              | 1 +
 hw/arm/sabrelite.c             | 1 +
 hw/arm/xlnx-versal-virt.c      | 1 +
 hw/arm/xlnx-zcu102.c           | 1 +
 20 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.41.0


