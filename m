Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B1C72810F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWt-0003b9-UC; Thu, 08 Jun 2023 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D66-0002Gt-Tj
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:30 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D65-0006Sn-87
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:30 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so581892e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220945; x=1688812945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K7WGRL0Ae84U4u6CjC/ye+fomaq6FMO09teV5KonydU=;
 b=pmJN+WNMyWKtkcO66pXdjK1WJwfGImlnRUIHleiALH1iVozxZBGxRQxuFQzXI5Y5H/
 LwOS2hF3YTQ8bRGSzj01S9Sqxm+pCcQ3IxvXCklyRfXHZkPFe6i5JcdhbtGSWJ4BOP6b
 iKNENQXE+qSsVNMreA3xoMcE9qVhE4mUfVu4bcIrkj6EwPiPddZjfh0uwuyaHiqw8mSC
 BsR2nbWL+v3FE2IXIt0ieyd940PMtp4EEJXydrvv5RlhNE0ScRyeaO9llcvxQ+9undNN
 NiWGSwN3USghMgh7mZaVV9sZLTDypYKGSf0mITJyocTpk6V4WKi0u3aEoglQSR6VzdCC
 ZEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220945; x=1688812945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K7WGRL0Ae84U4u6CjC/ye+fomaq6FMO09teV5KonydU=;
 b=OD+0z9c9/KmrO1eC1fJ0qlfhKAUjON+kVQnoo97YUGKdHhZtLipTZp1J3hgxvmRllB
 82SkPZerCIjV77jLkJU7HuwdGUgnEgNwrKszB8aTTCuxGZEA13XOWG0f5LuNWOZs2D8k
 vOOEZCmuCSms8fSlARjT2CFtLWk5MpRgdZ0+JCexLRveVGJxcJwnoWrM8qQU2WbPPCSj
 9XDJdiuJGrDczPNKagPSTdbM79IK8+d1JBfMV0zaPviPs6LCA3mXggnAychfTudVWCpu
 nYoOr/6Gu6fxQBpmStbujRACDpMoH4WOXSQ2YVFqNHc6YriNSftxmlVffqDkaLJPtPeT
 eCow==
X-Gm-Message-State: AC+VfDygT/CnlEC817ceGvf+e/clYWv+mZVZprp806ZY/3KhGKcuW6lD
 BxGBNgYYvwsCG4XslWMsijXwJHbCC8c=
X-Google-Smtp-Source: ACHHUZ5xhUSBZ5rxBzbJ7EyZiY0YcavrIPFXa84fchSuhHSlqj0NRwI7dsi2tHS13XnHCunZVq8tvA==
X-Received: by 2002:a05:6512:4c6:b0:4f5:17c3:c23a with SMTP id
 w6-20020a05651204c600b004f517c3c23amr3597260lfq.60.1686220944665; 
 Thu, 08 Jun 2023 03:42:24 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:24 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 00/33] target/mips: Finalise the Ingenic MXU ASE support
Date: Thu,  8 Jun 2023 13:41:49 +0300
Message-Id: <20230608104222.1520143-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:53 -0400
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

This patch series is aimed to add complete support of the=0D
Ingenic MXU extensions of version 1 revision 2.=0D
The serie doesn't split revision 1 and revision 2 of the=0D
MXU ASE as it ought to be, because I have no hardware which=0D
supports revision 1 only. The MXU version 2 is not the subject=0D
of the patch series either.=0D
=0D
All added/fixed instructions were tested on real hardware=0D
via set of fuzz tests written for that purpose, although=0D
the tests aren't subject of this patch series.=0D
=0D
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>=0D
=0D
Siarhei Volkau (33):=0D
  target/mips: Add emulation of MXU instructions for 32-bit load/store=0D
  Add support of two XBurst CPUs=0D
  target/mips: Add emulation of LXW LXB LXH LXBU LXHU instructions=0D
  target/mips: Add emulation of S32MADD/MADDU/MSUB/MSUBU instructions=0D
  target/mips: Add emulation of Q8SLT Q8SLTU instructions=0D
  target/mips: fix MXU D16MAX D16MIN Q8MAX Q8MIN instructions=0D
  target/mips: Add emulation of MXU S32SLT D16SLT D16AVG[R] Q8AVG[R]=0D
    insns=0D
  target/mips: Add emulation of Q8ADD instruction=0D
  target/mips: Add emulation of MXU S32CPS D16CPS Q8ABD Q16SAT insns=0D
  target/mips: Add emulation of MXU D16MULF D16MULE instructions=0D
  target/mips: Add emulation of MXU D16MACF D16MACE instructions=0D
  target/mips: Add emulation of MXU D16MADL instruction=0D
  target/mips: Add emulation of MXU S16MAD instruction=0D
  target/mips: Add emulation of MXU Q16ADD instruction=0D
  target/mips: Add emulation of MXU D32ADD instruction=0D
  target/mips: Add emulation of MXU D32ACC D32ACCM D32ASUM instructions=0D
  target/mips: Add emulation of MXU D32ADDC instruction=0D
  target/mips: Add emulation of MXU Q16ACC Q16ACCM D16ASUM instructions=0D
  target/mips: Add emulation of MXU Q8ADDE Q8ACCE D8SUM D8SUMC=0D
    instructions=0D
  target/mips: Add emulation of MXU S8STD S8LDI S8SDI instructions=0D
  target/mips: Add emulation of MXU S16LDD S16STD S16LDI S16SDI=0D
    instructions=0D
  target/mips: Add emulation of MXU S32MUL S32MULU S32EXTR S32EXTRV=0D
    insns=0D
  target/mips: Add emulation of MXU S32ALN S32LUI insns=0D
  target/mips: Add emulation of MXU D32SARL D32SARW instructions=0D
  target/mips: Add emulation of MXU D32SLL D32SLR D32SAR instructions=0D
  target/mips: Add emulation of MXU Q16SLL Q16SLR Q16SAR instructions=0D
  target/mips: Add emulation of MXU D32/Q16- SLLV/SLRV/SARV instructions=0D
  target/mips: Add emulation of MXU S32/D16/Q8- MOVZ/MOVN instructions=0D
  target/mips: Add emulation of MXU Q8MAC Q8MACSU instructions=0D
  target/mips: Add emulation of MXU Q16SCOP instruction=0D
  target/mips: Add emulation of MXU Q8MADL instruction=0D
  target/mips: Add emulation of MXU S32SFL instruction=0D
  target/mips: Add emulation of MXU Q8SAD instruction=0D
=0D
 target/mips/cpu-defs.c.inc      |   46 +=0D
 target/mips/tcg/mxu_translate.c | 3935 +++++++++++++++++++++++++++++--=0D
 target/mips/tcg/translate.c     |    7 +-=0D
 3 files changed, 3787 insertions(+), 201 deletions(-)=0D
=0D
-- =0D
2.40.0=0D
=0D

