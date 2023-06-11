Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7A72B17D
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 13:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Io2-0003NR-TF; Sun, 11 Jun 2023 07:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Io0-0003My-SY; Sun, 11 Jun 2023 07:00:20 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Inz-0004gJ-3E; Sun, 11 Jun 2023 07:00:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5147e8972a1so5921573a12.0; 
 Sun, 11 Jun 2023 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686481216; x=1689073216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ko+FFLYmdcftn0u1vmgRraBDi/dPXRFwCbTwUl5J2R0=;
 b=C6KrpBFLQY7xK/VgSE+a2+I2jXHl80x1flx7Fn3REciOsX+nYs130niDySRDhbZgW/
 9cRajHp29dS1yADbgxpyajSm4aEbEH9UqVBaIvRxzQGbkcwifyj/vdPIWeWWMSotqbff
 QZhBpZ3Us/rzzejoH8eXPZkPMJOBXQ/ahFgnsLp07RHgmqqPWdlo1QJ7jDrLokL1y8eH
 BbI0dtFeTP4KF+3U56E9GboyP4mYPdu5mrHA5gjS6BtxE9QY5DYtwmmqpwvgrL7urbQ4
 mrTDapZKf2k2IIRKm+gFQXf1aF4KCNOozEcA3dJqbczqbXJtXM9UyWiWmgdCKi9jvHWN
 kmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686481216; x=1689073216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ko+FFLYmdcftn0u1vmgRraBDi/dPXRFwCbTwUl5J2R0=;
 b=APImvnSzWfj/b2O29MF3wK+vMcekmQ2oT3NL4dr8XEi+nkyQAzmjr4QKO7X+nD8H35
 04qPDrg/Mt1ZAM5+QdjG9sFMmA9m/LY0VguXUJqYxwLQCySFREC1rILprXCemqXziGBR
 D2lmKGl+SqCMYlESQInFz5cxSGM3dCr/+gqwsrSLe20slHXGwX6BhgXMPge3ZtEn8Uxl
 4WhcyBH/v2lOzYi1xgj1FEM4GCSDXzi7RkAZPSJbhHcG8XF5Y/69x2si+EO1B6/S7ARP
 w3XujMwYVyp+HzkdO/MNf6uXtwrOObIf6YmHLzMmN+rnMpV2pvLha8CAxr8jwrUvscmM
 aeWw==
X-Gm-Message-State: AC+VfDx+OqNMBjAjRiqfGi8pGYK54Io4rQc371ME6+8CMXO7wp3PEc4e
 s8yKQx3DyRr9bifDUuLUGEEJAkeNttA=
X-Google-Smtp-Source: ACHHUZ6FEdKq75wpmWu3yzdKy63uSdBb5JPRH+z3BOZRsB/riAVFMQdLCUgDOoyJdgP9zctSS6Z1Zg==
X-Received: by 2002:a17:907:7f0d:b0:974:9aa9:be3 with SMTP id
 qf13-20020a1709077f0d00b009749aa90be3mr7536286ejc.28.1686481216326; 
 Sun, 11 Jun 2023 04:00:16 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 n11-20020a1709062bcb00b00977eec7b7e8sm3708411ejg.68.2023.06.11.04.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 04:00:15 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] Export struct ISAParallelState
Date: Sun, 11 Jun 2023 13:00:06 +0200
Message-ID: <20230611110008.32638-1-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

