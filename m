Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2390719EAB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4icP-0007pV-8X; Thu, 01 Jun 2023 09:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icK-0007ox-G5; Thu, 01 Jun 2023 09:45:28 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4icH-00087d-ET; Thu, 01 Jun 2023 09:45:28 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f3b39cea1eso1042998e87.3; 
 Thu, 01 Jun 2023 06:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627121; x=1688219121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h45ZE4RSOZgdndZiFusKiJgOMBv4RUgJcvgsXvq6New=;
 b=H+sR844cWL3i2RU9Mm8BPj9NAJ1WJeG9mOR72K9gHRQIK/1tcQrMKR1eD0SJroY/m0
 HTqIqcEy4vr+glB8+QZHHguBl90MO9MUGZBSjyL+OAr6VmJz7yVZTun8eWpHy93I4W+S
 KUiipfCVKmeDKu81QHfJ01W7+X7/7bp1Oz42MUhYG8BF+meRXs8PnD3XIEX2vqh37tWd
 bW2xSxIEJT1lqHhzvxKXsAiadcV9YDhTwzD4bR+n53TgGQ8eUDOouck6IOrWsSdlKbot
 L1BOKW1QlRJO/4+Ed3K0jB9w9ogNn9SAsxbU+6SAUzUGg/FMK+r18/+2sL7mZetFFic4
 MU+Q==
X-Gm-Message-State: AC+VfDyF7korErEfeNymjpCWqsw7/xRwK320q3NRwEl0SJDisyWTaVaQ
 0ZI+0OsrcbeuwSE8GJXB/SM1O1MgDpKvTg==
X-Google-Smtp-Source: ACHHUZ7rQA1IPdOPyFQJ7ehUv3PoEFBkhOLMWLT7a9xAUfihbxsnXEKrZREsMsT4hRar1huHiU0bLw==
X-Received: by 2002:a19:7604:0:b0:4f5:e688:25c3 with SMTP id
 c4-20020a197604000000b004f5e68825c3mr1487375lff.44.1685627121122; 
 Thu, 01 Jun 2023 06:45:21 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 w17-20020a05651204d100b004f1d884a4efsm1090753lfq.242.2023.06.01.06.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:45:20 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 8EE934E8; Thu,  1 Jun 2023 15:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627119; bh=lkpzRjRjR10M8bOxOdDgIgd1V3261IV3j6rJ+kA5l6A=;
 h=From:To:Cc:Subject:Date:From;
 b=LMrGVyAvb14SHZEP7aOHW+r2gbt2VWC6gq7r6aN3Ly9ptZhPl3k93410fWiTfq0Tw
 LZOtGx9PyQj8LP6Q2QPtJ3WlYNpFgIUnJP3XxdFvkfbNVaU11z9OBUDyKp5WMiyHf+
 ZCGtSLjmqYFT6S6owA02InzlIZoiCgbr4C9eoYEA=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 916DA18B;
 Thu,  1 Jun 2023 15:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627108; bh=lkpzRjRjR10M8bOxOdDgIgd1V3261IV3j6rJ+kA5l6A=;
 h=From:To:Cc:Subject:Date:From;
 b=beEY8GSR0174dx5NH9WhGFrHQDuoE4o/kFJRNZSJzUNJreTp9aWpeUmB0mGN3WGfn
 1hk36q1rUHlx9vJ6m3NMtlfkhiN1XUpWPFeenWPM5m0occrKjKmmlXyRlcU2uDgNMz
 FM23bYapOGhUxkpkVaTDn6tEM6H8MAE0EjZ3prSw=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 0/8] misc AHCI cleanups
Date: Thu,  1 Jun 2023 15:44:26 +0200
Message-Id: <20230601134434.519805-1-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Hello John,

Here comes some misc AHCI cleanups.

Most are related to error handling.

Please review.

(I'm also working on a second series which will add support for
READ LOG EXT and READ LOG DMA EXT, but I will send that one out
once it is ready. (It might take a couple of weeks still, since
I've been a bit busy lately.))


Changes since v1:
-Picked up Reviewed-by tags.
 (I did not convert your ACK to explicit Acked-by tags, since I assume
 that the patches will go via your tree).
-Rebased on master in order to fix a conflict in patch
 "hw/ide/ahci: simplify and document PxCI handling".
-Dropped patch "hw/ide/ahci: trigger either error IRQ or regular IRQ, not both"
 for now, as it caused a boot time regression in SeaBIOS.
 This appears to be a bug in SeaBIOS, for more info see:
 https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/RIHV3FZ4EVMAJA4TEDPASKNYV7V72O4C/
 I will resend the QEMU patch separately once the SeaBIOS patch has been
 merged, and once QEMU has updated to a SeaBIOS tag that includes the fix.


Kind regards,
Niklas

Niklas Cassel (8):
  hw/ide/ahci: remove stray backslash
  hw/ide/core: set ERR_STAT in unsupported command completion
  hw/ide/ahci: write D2H FIS on when processing NCQ command
  hw/ide/ahci: simplify and document PxCI handling
  hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
  hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
  hw/ide/ahci: fix ahci_write_fis_sdb()
  hw/ide/ahci: fix broken SError handling

 hw/ide/ahci.c | 112 +++++++++++++++++++++++++++++++++++---------------
 hw/ide/core.c |   2 +-
 2 files changed, 81 insertions(+), 33 deletions(-)

-- 
2.40.1


