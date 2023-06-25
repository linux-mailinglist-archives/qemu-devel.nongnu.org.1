Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC273D0C1
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 14:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDOSn-0007Pw-VZ; Sun, 25 Jun 2023 08:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSm-0007Pi-Et; Sun, 25 Jun 2023 08:03:28 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDOSk-0006Ze-T6; Sun, 25 Jun 2023 08:03:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5535efe37b7so1094687a12.3; 
 Sun, 25 Jun 2023 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687694605; x=1690286605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8O3ucBq+PV4i3kNSSsCBTLnVuNqadU0IZOPR6UgUim0=;
 b=FG0fBKZADkRm0+5cKJACGDg6P6FryFu9726GweV5DUTB6kKDVbPv++Icf6gNGlDIbB
 T3aaIX/P4Hzd8LZalat0sPwRtbcAgyND0V2NgubSuwVjLpO2dLzb1K+I+ojp6/7SNmQX
 Vc/luB9xM+3k3ki9L2ro4nxX396ILfVeQiXNrqVnbH0WbwaDFgnH60TR2ivgkg24wltZ
 zPLp2gR/0Kq7sxyIqZWuuHYwmp+vH1e70IyqAJKiW6bY3/OW7RrxUJgWsp2nS5e1uto6
 MGWPo3uTHv0ypR4qBn0LigRc9PTcfzxiFkYYGZ9Td++Y6c7pVrPIHUOSXZEKPr+KmqD6
 o6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687694605; x=1690286605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8O3ucBq+PV4i3kNSSsCBTLnVuNqadU0IZOPR6UgUim0=;
 b=hf/jqLkhkAV1khk9R/lBWGcJc7lPl7+myVcLGCkD53M0S9hayY1xXV4t4MMNEJiBaL
 OUyuimfsqO+LUEFuYLTkyW8YN7j6vRnsnlviLDisAd6UhHFVxAhudkGhxm6HdSreilwn
 zPpFJ5Y9nnuxyXARFzoehBz6ygx09omsiVfIXJ4i3975h67AQTitzohQLecnf4s2ZL4t
 QWcMEivuZMJoLPgV7+IeXs+z2fKvHDi5t1kjLe4MFPqssbsAE51DeFxzwHTWR2zZhJ5f
 PVKzKkEYU8QLot7vOw6F3mEFPn+s5Wvj1BhqBgw2bh5qwyUUZ/np2tOg7HM6A/wLXjNu
 dsig==
X-Gm-Message-State: AC+VfDx0Ceg8y7iRLWfzfRZ+Tfe31qe9nT1sfeBpq3iWnUqlcp0gIZgI
 4E1ZQ9NLtb+hL3bACIQX6JMXhk5NUF4=
X-Google-Smtp-Source: ACHHUZ4b+nYL2+lyyuTaHHgiZeZE2VW1d1tgWyBIdOol2rk6iXIQHSK1zftno9VH6zXLdV/U9haEEQ==
X-Received: by 2002:a05:6a21:788a:b0:125:1ca4:a013 with SMTP id
 bf10-20020a056a21788a00b001251ca4a013mr7442693pzc.25.1687694604820; 
 Sun, 25 Jun 2023 05:03:24 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 c4-20020aa78804000000b0064f51ee5b90sm2190772pfo.62.2023.06.25.05.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 05:03:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 0/2] target/ppc: Easy parts of the POWER chiptod series
Date: Sun, 25 Jun 2023 22:03:15 +1000
Message-Id: <20230625120317.13877-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

Cedric kindly reviewed these already so I think they should be
good to go now. This is just a rebase and slight rewording the
changelog. Still haven't completed the main chiptod device yet.

Thanks,
Nick

Nicholas Piggin (2):
  target/ppc: Tidy POWER book4 SPR registration
  target/ppc: Add TFMR SPR implementation with read and write helpers

 target/ppc/cpu_init.c        | 82 ++++++++++++++++++++++++------------
 target/ppc/helper.h          |  2 +
 target/ppc/spr_common.h      |  2 +
 target/ppc/timebase_helper.c | 13 ++++++
 target/ppc/translate.c       | 10 +++++
 5 files changed, 82 insertions(+), 27 deletions(-)

-- 
2.40.1


