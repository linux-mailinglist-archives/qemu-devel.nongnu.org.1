Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65A8307AF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:13:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6et-0004dS-Uu; Wed, 17 Jan 2024 09:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6ep-0004YA-8C; Wed, 17 Jan 2024 09:12:43 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6en-0002kr-9y; Wed, 17 Jan 2024 09:12:42 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-598ee012192so1522836eaf.1; 
 Wed, 17 Jan 2024 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500759; x=1706105559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HpxjPSm9VAceL5ZTrekEjcGVpIcoW4HcwTmmc44yAcE=;
 b=SF83zdqpzrgXa+DezvuUqoxDbmeuPLqCFPPG+9paADVhuMbezp/NO49UnM7s7/CYJ+
 ZHCVQhVJuN328SsrpP26JgLCbTK6XJKKgWSfRbMvSDGRwvhP8XfEYZmyUkqmsN2ixkCH
 QLxUNZvwKpLAbJhFNs9NG/ZeqbdJRg4/mGYahOs5idlg6e742dgRBnFglS0ESsSqMWJn
 bf3nOWHJrXOhY+MuBYe1Of5xRs6XPNr0cqyyjUk1HUypc9J8PQdBuyghc2a0dLOH/VTY
 tA9OezDNOKKaOS9R/k1OalUW2vJBSM10t0kkhfx9hxuwo7vdyKmfp4BSbizgtHhLDGRA
 3ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500759; x=1706105559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HpxjPSm9VAceL5ZTrekEjcGVpIcoW4HcwTmmc44yAcE=;
 b=PFIy/ftdeaOlvJFx/sUSfdoEYvjx7uuu3COnV4LrScWbZBXkqFjT3CS0bIN6fo9K6E
 0kpCYK3PEGvg+aWViY9xXLrw+DdUkJakLXeiNSmpjtnYfzMV6EUTXdgtgtbljy3wcZcp
 tS71RANR2Dr/5AP/az4VuOuFblHNbpmyu0SFCD/neER7hs4YK9LNnypy4UdmnSC9/cio
 QDFr4PJTk1oWQJp29zMRbr31abgr67qZ1UkZ4b4lZB5YAMkMaijHP5zqwm/0MoWT1dCt
 uqGhPmFd/gEm3LLM/hH9nhSCmhxm9Q1eMqQErehCtjLSjJC7YJQwqzpuyIjQ2E74EDYi
 kShQ==
X-Gm-Message-State: AOJu0YxinSGd9IZuoOV/Y53lkhM4xQGEYcRij0kBMukwQUoDTKagl4vB
 /gXUEBT+9iqTXzVGtzRHmSVIPjC5eRQ=
X-Google-Smtp-Source: AGHT+IEC2VxcjHmezcQXnfliXMeVTgwDIfSURd0NiWHk+8TTmVb2biNplHIQqtdw9YtkW72Ptihw7w==
X-Received: by 2002:a05:6359:2e1a:b0:175:6b96:95d1 with SMTP id
 ro26-20020a0563592e1a00b001756b9695d1mr5408723rwb.47.1705500758906; 
 Wed, 17 Jan 2024 06:12:38 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:12:38 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 0/8] tests/avocado: ppc additions and other fixes
Date: Thu, 18 Jan 2024 00:12:15 +1000
Message-ID: <20240117141224.90462-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc33.google.com
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

Thanks for the feedback and comments on these before. I would like to
put these in the ppc tree soon (modulo the x86 patch 2). Happy for more
feedback but could make them as incremental changes too.

Changes since v1:
- Patch 1 (s390x fix) merged.
- Use existing SPEED=slow convention instead of new
  AVOCADO_ALLOW_LONG_RUNTIME (Thomas)
- Add slightly more guideline help text for SPEED=slow (Cedric)
- Fix hypervisor test to use KVM instead of forcing TCG always (Cedric)
- Fix hypervisor test avocado syntax issue (Cedric)
- Add powernv9 FreeBSD boot test, which is a bit tricky since powernv
  does not have a boot loader and not sure how to pass boot options to
  FreeBSD kernel directly.

Haven't done the BE FreeBSD test yet that Cedric suggested, will save
that for later.

Thanks,
Nick

Nicholas Piggin (8):
  tests/avocado: mark boot_linux.py long runtime instead of flaky
  tests/avocado: Mark x86-64 boot_linux.py TCG tests as long runtime
  tests/avocado: Enable replay_linux.py on ppc64 pseries
  tests/avocado: ppc add powernv10 boot_linux_console test
  tests/avocado: Add ppc pseries and powernv hash MMU tests
  tests/avocado: Add pseries KVM boot_linux test
  tests/avocado: ppc add hypervisor tests
  tests/avocado: Add FreeBSD distro boot tests for ppc

 MAINTAINERS                         |   1 +
 docs/devel/testing.rst              |  11 ++
 tests/avocado/boot_freebsd.py       | 174 ++++++++++++++++++++++++
 tests/avocado/boot_linux.py         |  32 +++--
 tests/avocado/boot_linux_console.py |   8 ++
 tests/avocado/ppc_hv_tests.py       | 203 ++++++++++++++++++++++++++++
 tests/avocado/ppc_powernv.py        |  23 +++-
 tests/avocado/ppc_pseries.py        |  20 ++-
 tests/avocado/replay_linux.py       |  76 ++++++++++-
 9 files changed, 525 insertions(+), 23 deletions(-)
 create mode 100644 tests/avocado/boot_freebsd.py
 create mode 100644 tests/avocado/ppc_hv_tests.py

-- 
2.42.0


