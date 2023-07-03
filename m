Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A07459FF
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGd7-00010O-4Z; Mon, 03 Jul 2023 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcM-0000GK-CV; Mon, 03 Jul 2023 06:17:23 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcK-0000uu-NK; Mon, 03 Jul 2023 06:17:14 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-553a1f13d9fso3408348a12.1; 
 Mon, 03 Jul 2023 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688379430; x=1690971430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8jJ0a8ZNnjuNe5GOK37cgfMjGB70BFKbwcujqK7Ucqo=;
 b=VJDiL39BbPwUvotG4AYsHA++rD1QamBFduvr58SG2lz/DkNeYASYX1wi6NGcZnOn33
 fav4eVm0w1v02JlqC0tueqVI9bz1eTrdNFAxxyunmLN94o6bnmsIn+x9AcmPuaLIUtxF
 7w6Cb3X65nvS8vuzvo1UfjkepRb7aqrVeK0oSHnacV08YLjNFoCOLY9az0GXPAoc7gHt
 r0FRwZfOZHaZ9cFWrNJMqZq53vjQrjFaP2rA8x3kGllBBZ35cMrnM9JhYKaMCselcIkK
 r6iyg7q1gdZcg3Am9TLKB79/445R5fUif8TjhIeec1s8iVU8uvmsvuMC91lDzhFn4f0u
 OESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379430; x=1690971430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jJ0a8ZNnjuNe5GOK37cgfMjGB70BFKbwcujqK7Ucqo=;
 b=Eb9nhwaZ3IqeDgxnLnZUvQo+HTc/3lF9Yb08uVyTZktQce33cWDS8Ard8eVyk3Vv4B
 QiQTT+d/QKX6wqVlHD+tAb3uWEEHIyGCeDwm+4EssEKqul/9DvEVP+fLPl4I9dsY+B3D
 aOIGk1TPTRxP2CrQ3quc+QJ6tLCMrF0qkxcknaqbsU1zp/tgNSgMDgYBeeibpHKQSaBY
 yK38Z++tvDQOI/50ULQiUeFXhLSV88v1au9Lo/w0zxLhQJ2g4kExQDaZUPtJFH8lpjgd
 WP4SXFJQDGo5NIKXhRnv8OC+gNinTZAyuirG+cMFV86ImfJAfUy3GsyMIa0dCB/9x2R7
 NfIQ==
X-Gm-Message-State: AC+VfDzWv2hUJckfc6HmyNZUowbunkoqe5PVH8iYfOj0PDuYBRuSBzUH
 VbS9yjKSQGwyvk242KKydt8=
X-Google-Smtp-Source: ACHHUZ6AjPPZf9Yunz9QrhJF4OPYDZrKIPAoepLpmdbvuMnSX+Hzs2eB2tgA6JpZf/6YoJWjaziKyg==
X-Received: by 2002:a05:6a20:258d:b0:11d:2764:d9c1 with SMTP id
 k13-20020a056a20258d00b0011d2764d9c1mr12664866pzd.51.1688379429953; 
 Mon, 03 Jul 2023 03:17:09 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 o2-20020aa79782000000b006826c9e4397sm3887727pfp.48.2023.07.03.03.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:17:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/4] ppc/pnv: SMT support for powernv
Date: Mon,  3 Jul 2023 20:16:56 +1000
Message-Id: <20230703101700.24064-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

These patches implement enough to install a distro, boot, run SMP KVM
guests with libvirt with good performance using MTTCG (as reported by
Cedric).

There are a few more SPRs that need to be done, and per-LPAR SPRs are
mostly not annotated yet so it can't run in 1 LPAR mode. But those can
be added in time, it will take a bit of time to get everything exactly
as hardware does so I consider this good enough to run common
software usefully.

Thanks Joel and Cedric for reviews and testing.

Since RFC:
- Rebased against ppc-next (no conflicts vs upstream anyway).
- Add patch 4 avocado boot test with SMT, as was added with pseries SMT.
- Renamed POWERPC_FLAG_1LPAR to POWERPC_FLAG_SMT_1LPAR since it implies
  SMT.
- Fixed typos, patch 1, 3 changelogs improvement (hopefully).

Thanks,
Nick

Nicholas Piggin (4):
  target/ppc: Add LPAR-per-core vs per-thread mode flag
  target/ppc: SMT support for the HID SPR
  ppc/pnv: SMT support for powernv
  tests/avocado: Add powernv machine test script

 hw/ppc/pnv.c                 | 12 +++++
 hw/ppc/pnv_core.c            | 13 +++---
 hw/ppc/spapr_cpu_core.c      |  2 +
 target/ppc/cpu.h             |  3 ++
 target/ppc/cpu_init.c        | 14 +++++-
 target/ppc/helper.h          |  1 +
 target/ppc/misc_helper.c     | 21 +++++++++
 target/ppc/spr_common.h      |  1 +
 target/ppc/translate.c       | 32 ++++++++++++--
 tests/avocado/ppc_powernv.py | 86 ++++++++++++++++++++++++++++++++++++
 10 files changed, 173 insertions(+), 12 deletions(-)
 create mode 100644 tests/avocado/ppc_powernv.py

-- 
2.40.1


