Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C08773915
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIBX-0004ES-B1; Tue, 08 Aug 2023 04:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBU-0004DM-9x; Tue, 08 Aug 2023 04:35:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBS-0004Mw-5z; Tue, 08 Aug 2023 04:35:19 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686f090310dso5387716b3a.0; 
 Tue, 08 Aug 2023 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691483715; x=1692088515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=5vOwYaL6fkpbGTU7QBeBHYsxyip48yIkX0Ch4Msi6ds=;
 b=k/8SOBSIelhzGtHgZSCyrVh/2750CWCbKGKgs9t6cS1NxoH1isMB61XF7/bUoNZZ0d
 XjGhTAGLL4MaBMV07InvMj3V+MaAPMcG3ioHeqcSnhkiPxFr2CL6EW8h808i3kaBu85R
 pte8Lba1wd32vPev9L+H8r1KQYzUXn5XeBPJDYGC5BCxmC8vw1aT4Nqo8s+u5RHy2m/C
 t+grmtRD9yKR5crrZsKaOfbmKIhrTB/cSli3o6702AScdzZRkXLmLRnAYUtw/OKDNQ26
 iB7LIKfMqbsK0rx1fSEcXjWimgHwhKt8c9jAEkRrvsaKScJqTyiDZOGdtusALQ3Pm6x/
 fNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691483716; x=1692088516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vOwYaL6fkpbGTU7QBeBHYsxyip48yIkX0Ch4Msi6ds=;
 b=G7fNkMIeLAs3omFkh/A5ygtlAJhDEG9I2DvcOpHajTQKIYf2eNtpaDQlvy0cHpNCA1
 dTs7nc+C6TRJsCYMNuZWB0B0DmxTYWV0HNTI12k7Il+3drCYPzJ6JdqrBjOVOdZLizKp
 NXnHDijAgzCJo/6U/JHVK0NbVsUrTgR0erYuPNzIL6xWRpM9YS0ITTAxZnWXrskN+lA1
 8W8dHCE9fxWpjWpCrVFr19elNW0ZuakYEizRBSY9ppHTO1FKKoVmtX/5kB0HZZ7Kvrh2
 lrPiQmGLeRRdiIoNQpSbSlCbhtfl2Mdlqwi3UNKnaEyteXrGwWxocRioQ/n23xl+7sEw
 EUig==
X-Gm-Message-State: AOJu0YyZZxHgFxFLk2FAySmBcy5eJtMLWW95433ZV6gTsRPaY7pBMvVt
 Zs3gUgdFxPA19HWE6iyPrDw=
X-Google-Smtp-Source: AGHT+IEgpPxFR/JLQqgMZ9ROCNISblihTInoypVvLZH3zqq0LxucmJL5Lh8qR2+FvyxPiJ5Gz7YEVg==
X-Received: by 2002:a05:6a20:5483:b0:123:3f03:68f9 with SMTP id
 i3-20020a056a20548300b001233f0368f9mr16003776pzk.61.1691483715603; 
 Tue, 08 Aug 2023 01:35:15 -0700 (PDT)
Received: from voyager.lan ([45.124.203.19]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001b8062c1db3sm8368112plf.82.2023.08.08.01.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 01:35:14 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 0/3] pnv/lpc: Hook up xscoms for LPC
Date: Tue,  8 Aug 2023 18:04:42 +0930
Message-Id: <20230808083445.4613-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

P8 used xscoms for accessing the LPC bus. In P9 the LPC bus was memory
mapped, simplifying access, however the xscom registers remained. Some
firmwares use this method on P9 and P10, so wire it up in qemu.

The third patch is a hack that shows how to test this access method with
skiboot. It should not be applied.

Joel Stanley (3):
  pnv/lpc: Place mmio regs in their own memory region
  pnv/lpc: Hook up xscom region for P9/P10
  HACK: pnv/lpc: Set up XSCOM dt for P9

 include/hw/ppc/pnv_lpc.h   |  3 ++-
 include/hw/ppc/pnv_xscom.h |  6 ++++++
 hw/ppc/pnv.c               |  8 ++++++--
 hw/ppc/pnv_lpc.c           | 13 ++++++++++++-
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.40.1


