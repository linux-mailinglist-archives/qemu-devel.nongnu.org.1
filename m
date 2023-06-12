Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A61572B9F9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8cfg-00019q-Vc; Mon, 12 Jun 2023 04:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfV-00015a-SF; Mon, 12 Jun 2023 04:12:54 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfT-0002Q9-5Q; Mon, 12 Jun 2023 04:12:52 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f63a2e1c5fso4670433e87.2; 
 Mon, 12 Jun 2023 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686557567; x=1689149567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HOEqzFSrin5gmX0JDUeP2hg2RhP1PtWraFlhD+j+YFU=;
 b=k62nstcpnJ5qIcmYpJoKkQSzCqANGBVR3fZjZ3+XSpN+XbErGSj3qOOP8Zlz9lqZs9
 TtDRRJz7+OqqePTPJJKJBRb5oEq6jNNWgA7oHPVMEWVMEJVkj9qwhnnhgX4A0cijJiXv
 5p5AI3haqaLV8MBAJoOByiA+dTlqgpAuOCenyAMDmP1zny45tGg8CR8oeZdRTXzuL1Xx
 cD5UL7Ef2FlTJ6QqRH0UWoHOnO/VH2DcloZF+eNZiJjoWOQE1vR7QaZGCEuCDUHdorzs
 dFWtQ0aIQG688LtC7AfrnetE3OuHn+4kxnTX+YKHtroCPalcRxOVhdq8c74hkFvPTKF6
 yU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686557567; x=1689149567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOEqzFSrin5gmX0JDUeP2hg2RhP1PtWraFlhD+j+YFU=;
 b=IHOOFA2mNPleqU5Kpv59LUlRPNeEvJOsLoXZvSpXz5inCHTxiEhIWOWK4Oaoxj07tR
 XQjjIfOkJbXL7MPMfyrsVCrC2CuYIr3dQBlPkATL7/qyM71nj3+pl6NgUScvsQ3P9tlU
 RGZuKGJtCIzpNsxYIyK5mv+q3UM/JoF1NTZpjizQSJ5pIK2xTBzuLuFoXCb2V0Y6Y7CP
 0mBZfDF1bkj+baR/jrcVoO/Evtuv9ClOiO8Qt2REylU47wTRS/ia6upvSUhK/NRvQ5Wu
 E8KASOQ6mCAgKyC38NHYlCrlxbhYzrjQmTpI5CXSgChqe41GaDtUzALoIkZdOyaELe2A
 u0nQ==
X-Gm-Message-State: AC+VfDw/vXLTFpzynZH6VHayQuicOr2+J6GwMaEoPHe7xtQ3t98N8q17
 bFsuE9ynIasi5cZiIrDSe/LYV6FJk2A=
X-Google-Smtp-Source: ACHHUZ66fzbe7vmqT3v5lLJLtI2MiJgZYC38TVLIJlooYeqeQeGsO8f+gbV0qrPzzCYfwWqtm/S6zA==
X-Received: by 2002:a2e:8898:0:b0:2af:b260:fd4d with SMTP id
 k24-20020a2e8898000000b002afb260fd4dmr2377664lji.44.1686557567100; 
 Mon, 12 Jun 2023 01:12:47 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7f9.dynamic.kabel-deutschland.de.
 [95.91.215.249]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa7d617000000b005148e981bd3sm4678514edr.12.2023.06.12.01.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 01:12:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/2] Export struct ISAParallelState
Date: Mon, 12 Jun 2023 10:12:36 +0200
Message-ID: <20230612081238.1742-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series incorporates rebased versions of the ISAParallelState patches o=
f=0D
[1] as requested by Mark.=0D
=0D
v2:=0D
* Add forgotten SoB tags (Zoltan, Phil)=0D
=0D
Changes since [1]:=0D
* Don't export register definitions (Phil)=0D
* Rephrase commit message of second patch (Zoltan)=0D
=0D
[1] https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/=0D
=0D
Bernhard Beschow (2):=0D
  hw/char/parallel: Export struct ParallelState=0D
  hw/char/parallel-isa: Export struct ISAParallelState=0D
=0D
 include/hw/char/parallel-isa.h | 46 ++++++++++++++++++++++++++++++++++=0D
 include/hw/char/parallel.h     | 21 +++++++++++++++-=0D
 hw/char/parallel-isa.c         |  1 +=0D
 hw/char/parallel.c             | 32 +----------------------=0D
 hw/i386/pc_piix.c              |  2 +-=0D
 hw/i386/pc_q35.c               |  2 +-=0D
 hw/isa/isa-superio.c           |  1 +=0D
 hw/sparc64/sun4u.c             |  2 +-=0D
 8 files changed, 72 insertions(+), 35 deletions(-)=0D
 create mode 100644 include/hw/char/parallel-isa.h=0D
=0D
-- =0D
2.41.0=0D
=0D

