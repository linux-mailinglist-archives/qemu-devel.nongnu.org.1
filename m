Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC9763F08
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAB-0003rJ-8C; Wed, 26 Jul 2023 14:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9p-0003qO-1p; Wed, 26 Jul 2023 14:22:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9n-0008QY-KI; Wed, 26 Jul 2023 14:22:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6686a05bc66so125794b3a.1; 
 Wed, 26 Jul 2023 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395761; x=1691000561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2II+fYqZBc1CEvPiY2247804mv7Uqmq4zLyfC+64ZSY=;
 b=M8+WedE/9fTb6Vd1B42g88Xe4L/4gpDQ23czGQgPg8557iJvw0hyKN6OPu2KvfWTSa
 FwgbQs0WrvqtIDn6mGX7wpXFFOx5pHUnyiuyxJBFE+punZoLg4G9xCJ3vx5ppwtSW8ho
 5q9fI1Mf86I8UDG5oKZXQGozl3EyrYa4Qg2kD5lRIAdOcfH5RovF2em5aiOhQvgoRm8I
 2fmA7gjsigQqL7QEbM1nVLTTL2LNA2XUW/PMmPFF/ukFeQHUVB77oFCAp8szMhOVmrYv
 jWl7QM7NVPfSXjtB6bFxhGAh4CTqqtkInqK3QpZVUM+31X7bLjWhbdclkLglh7SswGCZ
 m5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395761; x=1691000561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2II+fYqZBc1CEvPiY2247804mv7Uqmq4zLyfC+64ZSY=;
 b=WhUshYp2p6U596XU8efocwjMMQj2eArUdFcjAvB/RA1Henmx8kvWZBM7jkSYiIAftJ
 M8+DlDsQhyrHoH9aXAuMdln/wDXWJOqKYEcihQo5Lg+a284DtfWFo6rZJidZtwmJ70SR
 yaC5pXfAX48eIXy75uosOp5GllWPgIy98tnmQ4WOV3kEcqPKWHNFGW7Lip7IPFPCMPOw
 XTaNo8rtVV021qGsl6ExUkmlkEqEZuEeFmK+knYkeuZeSx/qwXiIKeqRRzHnnK2AtG6B
 E6RkNLu9KpSXkw4QGijkkfXvBdEMwx8QCWmGs1Hi4wfMu9DGdY2y1a3PFB8ORYFF2Jkj
 wucQ==
X-Gm-Message-State: ABy/qLYpixwdIQgm5GM3hf6tJGSAD3mejJmTjbXHaW4dNELu/nINu9X+
 lomUqwtemN7hnUadzp2qLwI=
X-Google-Smtp-Source: APBJJlH7OTA8LfnPxHVX0YYRftlr/frSZElxXN1q7RH3aSYry0BV6Wdxs20dzDA8UFR09nP0wFNpag==
X-Received: by 2002:a05:6a20:7d82:b0:135:6ef6:17f with SMTP id
 v2-20020a056a207d8200b001356ef6017fmr3136090pzj.43.1690395761213; 
 Wed, 26 Jul 2023 11:22:41 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:22:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/6] ppc fixes possibly for 8.1
Date: Thu, 27 Jul 2023 04:22:24 +1000
Message-Id: <20230726182230.433945-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Sorry for the delay following up on the fixes, I got sucked down
the decrementer rabbit hole that took longer than expected.

Question about what is suitable for merge at this time and what
should be stable. The first 3 have caused crashes or hangs running
Linux and other software. Second 3 fix some issues with dec that
could cause problems, especially with migration. But they affect
more machines in more complex ways than the first 3.

No changes to the first 3 already posted except to add Fixes:
tags.

Thanks,
Nick

Nicholas Piggin (6):
  target/ppc: Implement ASDR register for ISA v3.0 for HPT
  target/ppc: Fix VRMA page size for ISA v3.0
  target/ppc: Fix pending HDEC when entering PM state
  hw/ppc: Avoid decrementer rounding errors
  hw/ppc: Always store the decrementer value
  target/ppc: Migrate DECR SPR

 hw/ppc/ppc.c             | 47 +++++++++++++++------------
 target/ppc/excp_helper.c |  6 ++++
 target/ppc/machine.c     | 14 +++++++++
 target/ppc/mmu-hash64.c  | 68 ++++++++++++++++++++++++++++++----------
 4 files changed, 98 insertions(+), 37 deletions(-)

-- 
2.40.1


