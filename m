Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A3739D78
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGhn-0000jh-3V; Thu, 22 Jun 2023 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhi-0000im-HA; Thu, 22 Jun 2023 05:34:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGhf-0002ts-V3; Thu, 22 Jun 2023 05:34:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b5452b77b4so44400055ad.3; 
 Thu, 22 Jun 2023 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426446; x=1690018446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wGq1yIzNjRPww6SOy4+fqHGahDdLFedI858KNg6DDy0=;
 b=ghXWa9cuPtPmgZY17+W9uTxZmxvF7rrmagfQqNOPyMYwieL4D8RnzgqVMlfmhes+kf
 /43EXODQA7dIQfH8b7VoUwIQgFH8e9+BdBp/WchpuQrrFIrqBMzaPjcOum4wvg45ivrV
 AkqktslsqtSJPlQ5dWPi1kWH9cdyJafKQjdSSBqNlnvWsyBWsV+Xq2VPvcBXPwRz77fY
 pPJq0XyMwId/F/xJFO8sazS5pkp37fSbMrZTwNLRpE5iKXJrHZvv2lPUSLGCtfe+eGjC
 zCYvgoja7dlX2OOCa4Kz2VsDzzk45W00Jfk+/oR+sjydSzmTpOhgRZxmILehjS4fI9PT
 OfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426446; x=1690018446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGq1yIzNjRPww6SOy4+fqHGahDdLFedI858KNg6DDy0=;
 b=dRLl/IQROs4VDQcOqvNnK79qiKs22aPkt27d4xomPL4BhB33W8E1VO+Fk0TH9NMC4p
 nA3LIcZfHlf9mB2yB/64hSf5kEYvn7Nt26UOgKX5eau0hM8+EExO/KJCGkN5qJEGW1cH
 wjE6TCrThAClvkuVo0xmWwfUYCq0DJjJRc9HTe9ZBCPPtIy4xRXg4I43eq/TTx5TFjFA
 CJuITPo+cKwFSp34+SjFqvDrst0uFAADS89iKGzu7gPtIBCbs/Ou9rnMNO/WrjoAZSfP
 rBpyK9OOGGQLVnUcHSe8eZoyZwzGxYxYeUZxbd5F0RRFuV97GaFs6mYgPRPCVngEHtJe
 2ntg==
X-Gm-Message-State: AC+VfDwN3Iw2giCZf5hx2SQ9jGeraO5XEisSd7kfU5c5Dl4L3ra0tOQu
 DTpQ3KIG3vvqwQlsdyMwTXoLLZXbT28=
X-Google-Smtp-Source: ACHHUZ5fWgS24W79/dV+Xj7DxcfwBNr7zslfvMHk+EFSfxSvvnFS4tRgHeoLPKwTM3r7XriydyXyDw==
X-Received: by 2002:a17:903:25c9:b0:1b5:694:b1a9 with SMTP id
 jc9-20020a17090325c900b001b50694b1a9mr15671230plb.32.1687426446518; 
 Thu, 22 Jun 2023 02:34:06 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7]  target/ppc: TCG SMT support for spapr machine
Date: Thu, 22 Jun 2023 19:33:50 +1000
Message-Id: <20230622093357.255649-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

This series is based on some previously posted TCG fixes, in particular
the CTRL register fix is required.

Also added the Philippe's patch in the series to prevent conflict.

Since v1, main changes are just some tidying of comments and changelogs,
and addition of avocado tests to boot Linux on SMT machine and make sure
the CPUs come up, as suggested by Cedric.

Thanks,
Nick

Nicholas Piggin (6):
  target/ppc: Add initial flags and helpers for SMT support
  target/ppc: Add support for SMT CTRL register
  target/ppc: Add msgsnd/p and DPDES SMT support
  spapr: TCG allow up to 8-thread SMT on POWER8 and newer CPUs
  tests/avocado: boot ppc64 pseries to Linux VFS mount
  tests/avocado: Add ppc64 pseries multiprocessor boot tests

Philippe Mathieu-Daudé (1):
  hw/ppc/spapr: Test whether TCG is enabled with tcg_enabled()

 hw/ppc/ppc.c                 |  6 ++++
 hw/ppc/spapr.c               | 16 ++++++---
 hw/ppc/spapr_caps.c          | 14 ++++++++
 hw/ppc/spapr_cpu_core.c      |  7 ++--
 include/hw/ppc/ppc.h         |  1 +
 target/ppc/cpu.h             |  9 +++++
 target/ppc/cpu_init.c        |  5 +++
 target/ppc/excp_helper.c     | 30 +++++++++++++---
 target/ppc/helper.h          |  2 ++
 target/ppc/misc_helper.c     | 69 ++++++++++++++++++++++++++++++++----
 target/ppc/translate.c       | 46 +++++++++++++++++++++++-
 tests/avocado/ppc_pseries.py | 62 ++++++++++++++++++++++++++++----
 12 files changed, 243 insertions(+), 24 deletions(-)

-- 
2.40.1


