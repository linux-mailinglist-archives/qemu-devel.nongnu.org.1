Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8972836F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:16:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HMm-0008Ey-8U; Thu, 08 Jun 2023 11:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HMj-0008DY-Cr; Thu, 08 Jun 2023 11:15:57 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HMg-0000Hn-Ob; Thu, 08 Jun 2023 11:15:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f62b512fe2so917695e87.1; 
 Thu, 08 Jun 2023 08:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237351; x=1688829351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOIcJ3vo2q75ZsESYQ1YJEhod78FJt57Uvel9+z03ZE=;
 b=bLK9LsZGGPjoy6qTtt1R/yphFN0jm3kdDCDxTguxTIwdf1NblE5dGh2+v9K235rBB7
 g18hx8j62a7W+NhXw0EwMljKDK+w+F1ckqmHmRFjrYX7Ypd6qgpiSNHOPpzzJKnAOZWg
 yL8y3pNVlNG5CZFsU526FjJHl9uSfAGGqrCdZldojp7LICLRRXFPXJNGqMAdgL9H4Wbe
 gRNrauxGBDRr9fi4OyCxS2dcuKOAeLdghM2qBRCTtaDURXrU7fkDIZML/SLrczGcIQFs
 xUMLAJOYN5Y5xi7VSX86Ds05+1zbK3zYV/ih/hAXQ30QRGpqx2KAeFR9Y3gz8bmOKWTH
 CHhg==
X-Gm-Message-State: AC+VfDxiL5KF6UA/WNZxQjlCgv/6TXBz4HF6PoutpoavWNySUxN0pUkj
 IPt7snzAOhzBED9dqIKbFK4As2tUI+XMtY2BVXY=
X-Google-Smtp-Source: ACHHUZ4Mfe5ZTc/0iAY4udWCEUwyWi4IkW5Myzqs8bdffiUUre9Ydf8TcXGPpdPMzUay1WTH69KXUQ==
X-Received: by 2002:a2e:320e:0:b0:2ac:8262:322a with SMTP id
 y14-20020a2e320e000000b002ac8262322amr3599372ljy.13.1686237350758; 
 Thu, 08 Jun 2023 08:15:50 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 d14-20020a2e330e000000b002b20d8f270asm285610ljc.74.2023.06.08.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:15:50 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 29AE11403; Thu,  8 Jun 2023 17:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237349; bh=a8ryPgbZQcKROxSi5LQx/APH34/c/ZIXKbkJAqk/t1I=;
 h=From:To:Cc:Subject:Date:From;
 b=vEKK64LEAcb9NMZK0Wv79i2Ik3IU2PrZ8D+mF1y/rF13ub/EKHw5ccVkknWm1lXIK
 fldLJ4vO8hFeKk9oKeWg3miQzke/w7GhzJF0c8wxf7wEZaQfR2B6qtxIcBCOWHljQ+
 PrEaCc/JKV7nhgTRT9uvMSieXoUJfnM8vRCbcRs4=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 6EF3112F3;
 Thu,  8 Jun 2023 17:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237341; bh=a8ryPgbZQcKROxSi5LQx/APH34/c/ZIXKbkJAqk/t1I=;
 h=From:To:Cc:Subject:Date:From;
 b=XlRa2cpliGeugG5vIWLkA8r75t2Wg/GAjGGSKgogDjTdbhQ2VnqBUiQo/rPx97D/H
 yqHirB8mDzM643CrSLDGS3Rum5kGmCZ6MVLMW70HGtuZ21DHnZPD2j/4Akaoty4O9q
 SSupFP1PM1poqxRnSOGFlflFypIRVswlD6DTj6o8=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 0/5] improve ahci test suite
Date: Thu,  8 Jun 2023 17:15:23 +0200
Message-Id: <20230608151528.143950-1-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

This series should be applied on top of the series called:
"[PATCH v2 0/8] misc AHCI cleanups"
which can be found here:
https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00038.html

This series improves the ahci test suite to be in line with
the AHCI specification when it comes to taskfile errors.

Theoretically these commits could be squashed with the corresponding
patch for the QEMU model, however, that would lose the commit log for
the test patches, so I prefer to keep them separate.

Please review.


Kind regards,
Niklas

Niklas Cassel (5):
  libqos/ahci: fix ahci_command_wait()
  libqos/ahci: fix ahci_port_check_nonbusy()
  libqos/ahci: simplify ahci_port_check_error()
  libqos/ahci: improve ahci_port_check_error()
  libqos/ahci: perform mandatory error recovery on error

 tests/qtest/libqos/ahci.c | 106 ++++++++++++++++++++++++++++----------
 tests/qtest/libqos/ahci.h |   8 ++-
 2 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.40.1


