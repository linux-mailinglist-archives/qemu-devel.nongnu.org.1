Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407E7D3EA9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMT-0005Mw-DK; Mon, 23 Oct 2023 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vrY2ZQYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com>)
 id 1quzMQ-0005MB-Lb
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:06 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vrY2ZQYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com>)
 id 1quzMN-0006vz-Vi
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:06 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a909b4e079so41940157b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084542; x=1698689342; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m1XT0xBuPrAtJ1iK8mhDdZ+M7+W4QcQKUYRQGvykvRo=;
 b=t88/OzId8lTgwV62rZX6yb3EUKFuV3HRM0eJv40pyaO04zPSO0uKha5JcTJbKVOBN9
 rGBt4E7MGiqQGTTU2RonikDpADltdGuW05MnDzVyIBajpHlvDGwCNwY9fH13uvdWILWg
 zQDyHqNA5O7rgoQtwnX/W3Zow3pVwhqPxBKaR4OWQT61sSQa07mClAqxhFTE9TgTPo7Y
 iSEElNJkNU/2OypDOSGICQuh0GVGP4WgbnvMCpAKR+VY5c5mRrVD0aBnF3I6w/NZp1v3
 84GAmaZ2C2OkP2PBMCvoCQt+lnJAGD+APrHwvjnV6jei9GUDgNCpn80C+bw5o3XZC9wn
 hyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084542; x=1698689342;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m1XT0xBuPrAtJ1iK8mhDdZ+M7+W4QcQKUYRQGvykvRo=;
 b=fKcJjl30PqB1ectq6sJaoKobV/Pwytyk9PDPqYgsw7lQ4DwB8SAvWK5RvdWhSrXLfh
 ywkCdZ1S249dA1L0RcA5nMXzEM3l0WB9cQXC0HcVWlRSP7oFa4Ntn4nETNbGj3ssPHr2
 pm0dOgSmiYNJjK5cGqIMiLH2NoLgPEeUCeQg2PYTkGs44Ymsb0A3iJvRoXUadFR+QOLb
 U7FzuxIdkdvV9VF8v2m6lrYWoRDtm+WQ+OdH+1+zQ5ahWWtP46w6tIIPHIYbSYCxNRU/
 PizLX/uo5Rnrtfamkx9smvFtLfJ/Tx/Hs6d5tZqhjfI/IO5LgcANV38bimSSNgp9rWuV
 tv2Q==
X-Gm-Message-State: AOJu0YwYFDeAtdWkbgFUanUm/HZTcqQl6wkGnqdtgpbf/pdIzei2pD8A
 iOzPCCCkl7tnCi9QH/V3dZuDEIw9lck=
X-Google-Smtp-Source: AGHT+IGMKYY+xci/g1HyjRI06IQnGM7MYmlSEQCwEcgykPFPzc4fmbwPGO8C8AsSDVWyAr6FNlrgsb1Zd3M=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a0d:d50f:0:b0:59b:c6bb:babb with SMTP id
 x15-20020a0dd50f000000b0059bc6bbbabbmr225254ywd.6.1698084542321; Mon, 23 Oct
 2023 11:09:02 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-1-titusr@google.com>
Subject: [PATCH v3 0/8] PMBus fixes and new functions
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3vrY2ZQYKCjcmbmnlkZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This patch series contains fixes and improvements to PMBus support in QEMU.

The following has been added:
   - Support for block receive
   - Support for devices with fans
   - Support for the VCAP register for devices with onboard energy storage
   - A bitfield struct for the vout mode register, whose bits determine the formatting of several read commands in PMBus
Fixes:
   - String read now handles now logs an error when passed an empty string

This series is in preparation for some additional sensors that exercise
this functionality that will be incoming shortly.

Thanks

Changes in v3:
   - Added fixes to PMBus: page resets and fault clearing

Changes in v2:
   - Expanded commit descriptions
   - Added the ADM1266 device model that uses new functions

Titus Rwantare (8):
  hw/i2c: pmbus add support for block receive
  hw/i2c: pmbus: add vout mode bitfields
  hw/i2c: pmbus: add fan support
  hw/i2c: pmbus: add VCAP register
  hw/sensor: add ADM1266 device model
  tests/qtest: add tests for ADM1266
  hw/i2c: pmbus: immediately clear faults on request
  hw/i2c: pmbus: reset page register for out of range reads

 hw/arm/Kconfig                |   1 +
 hw/i2c/pmbus_device.c         | 237 +++++++++++++++++++++++++++++--
 hw/sensor/Kconfig             |   5 +
 hw/sensor/adm1266.c           | 254 ++++++++++++++++++++++++++++++++++
 hw/sensor/meson.build         |   1 +
 include/hw/i2c/pmbus_device.h |  17 +++
 tests/qtest/adm1266-test.c    | 123 ++++++++++++++++
 tests/qtest/max34451-test.c   |  24 ++++
 tests/qtest/meson.build       |   1 +
 9 files changed, 653 insertions(+), 10 deletions(-)
 create mode 100644 hw/sensor/adm1266.c
 create mode 100644 tests/qtest/adm1266-test.c

--
2.42.0.758.gaed0368e0e-goog


