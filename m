Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262BF70E61F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y7L-0000Oq-Mu; Tue, 23 May 2023 15:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y7J-0000NK-GN; Tue, 23 May 2023 15:56:21 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y7H-0006Rs-Rw; Tue, 23 May 2023 15:56:21 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-96f818c48fbso3549866b.0; 
 Tue, 23 May 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871777; x=1687463777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TjoUGtEA0nlcsDiZadtRY2aihoK2mUP2djsEyFXTOOA=;
 b=egL0lw1VBg26AAMDdm9J+ORUQdRSpBb7x+wJ8/CaZKWLRgyttmKAQz9yeWeCq65sTC
 CrJk+i6Psj+5BLYSYam4D8drR/RENsRoeko4im320I6UT0YG0HfPC/uqMuKBOa/+ATBL
 LpnRhbBzL8EgJcm1s974z3Hp64KhZplzTFCB5bpv+XpQFfTqMBEksrzNhNwEM0ED81tE
 72KUnMgSmQwfaZg93Y5JG1zxZ9xSs63cndQlZ5cqW3mLEzasNqsJRX+f9KhlnxVqE0P9
 4GffUcH51HzBHPo51OfTNEkS/HtaKA9SQfY6IxD2F/ydGAZkWNdK7VweQCJnbQqf1wxX
 mx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871777; x=1687463777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TjoUGtEA0nlcsDiZadtRY2aihoK2mUP2djsEyFXTOOA=;
 b=BD1J60DwnSzHSYK/P1Rit5nY4JZfEXS2VLnRPh/crkvrgynAgHdefUqpSMX/KzXq9d
 KOyMGhtKhHqpnMPDqUtbafMeB5FmuQIpMvU4b8EKzDyxlknAGzjh74JlCa9vpoMAb6Oz
 pmB5aAfZY0HWLaRY1r81q7WAxZLmVbT++ri4y6AjKJVr23FnYl3aFHq1AA0HYboGgEzB
 qmQwiJ7ww2TPHyyvj+TYbKzSSQrbBw12nY0zCDf7ZvyZoZWydB0ZxUbCqZhED0CGefm9
 ikVJe+osatBtVdpkpVX9dsjfmuiBp3duRrEg47urEIvoXnndTMhskKVF98WzytChNk9q
 Q1Qw==
X-Gm-Message-State: AC+VfDwpM6y5+EnGchDTgLDC6tCU17weEMog08xE+EuXKIzY07DwZD3g
 drohzbN5JginSC14HxStN3m3XsdLlgQ=
X-Google-Smtp-Source: ACHHUZ6VcavKfRkHdNL3f79Zzi8Tvtjq7ObLR0BZ5P5W9MfsVLairTMGEoimwG7bvi3y7wcRw2RRYw==
X-Received: by 2002:a17:907:7d9f:b0:96f:905e:6117 with SMTP id
 oz31-20020a1709077d9f00b0096f905e6117mr12518386ejc.56.1684871776894; 
 Tue, 23 May 2023 12:56:16 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 dk13-20020a170906f0cd00b00965af4c7f07sm4737740ejb.20.2023.05.23.12.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:56:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/3] Trivial cleanups
Date: Tue, 23 May 2023 21:56:05 +0200
Message-Id: <20230523195608.125820-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

This series:=0D
* Removes dead code from omap_uart and i82378=0D
* Resolves redundant code in the i8254 timer devices=0D
=0D
v3:=0D
* Drop TYPE_ISA_PARALLEL since they became obsolete by=0D
  https://lore.kernel.org/qemu-devel/20230522115014.1110840-9-thuth@redhat.=
com/=0D
=0D
v2:=0D
* Export ParallelState and ISAParallelState (Mark)=0D
=0D
Testing done:=0D
* `make check`=0D
=0D
Bernhard Beschow (3):=0D
  hw/timer/i8254_common: Share "iobase" property via base class=0D
  hw/arm/omap: Remove unused omap_uart_attach()=0D
  hw/isa/i82378: Remove unused "io" attribute=0D
=0D
 include/hw/arm/omap.h   | 1 -=0D
 hw/char/omap_uart.c     | 9 ---------=0D
 hw/i386/kvm/i8254.c     | 1 -=0D
 hw/isa/i82378.c         | 1 -=0D
 hw/timer/i8254.c        | 6 ------=0D
 hw/timer/i8254_common.c | 6 ++++++=0D
 6 files changed, 6 insertions(+), 18 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D

