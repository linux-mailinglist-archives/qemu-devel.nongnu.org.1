Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734F832D4D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpv-0000lI-UN; Fri, 19 Jan 2024 11:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpt-0000kM-Ow
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpr-0004lo-Vc
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e86a9fbd9so9884265e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682114; x=1706286914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rgg25USww6QqXq0e3S0h6sYCTJG4iwf0fcDIbuS96Xk=;
 b=AVGhrHmfuRbTIOl1YFN4LJswJzk4SsHM/5JZgbYGRQDYikZyDrIk8MDDMBgU7j23i3
 RssYps5uhUnc5lKXhbBRCsqLHrOzLE8eS5cvhk9iMTutDM4Fn2y2Qe02pGtXoA3UJuka
 7g9wtcA2OCPooSLAgoLXGg7k7NHOty9ZAOkd09yOXvPR2eCIhi20frJV3RCVkmWmFs3+
 fbPpBlvIerEsS37Z7UBJr6pe4S2b0H4qtWKEIiz4Pdu+Z9JPwTMhh6htg3a5kXNkShUk
 rmb+hhUaEUDk4Uke0g2UtEHpzs6C63BIQ/HWgUPRaIWiC4mqAnk7G0Q62GYHXUcZ8g1Q
 kt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682114; x=1706286914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgg25USww6QqXq0e3S0h6sYCTJG4iwf0fcDIbuS96Xk=;
 b=wvgwForK88T1GLGcHJenk0e/6zcah+gWeNNdfDbseB1xLMb3zkFwieuv8sb4ajwwzv
 Pvj7tyRjBkdd3df0qpzzOEfueyfNFQ+Q220NW9lnYfJQhpSv9gYR1kQbpNC0ICG2SPSh
 NKZNH9642RyyusYJ+b7/OjOKVfLyYIq9epr5InMlajbt6B7qqrnW8r5hdlKra6n8D92p
 doOL98haIbfIPOr3ulOBzkJ5CyaQ/1Y/+MytQD8lJnxK1/cVD3GX/GguEDMq71H9Kt7+
 f1fbEezpn1wijaGkzeBxAobXm+hUk2g4jZl4EnBO5JK+R0OwWGge9ZyE6K4EoTaRhNr4
 VINA==
X-Gm-Message-State: AOJu0YyTfFLengKV0agli4kIe8tpXpJt6Iot4XqbpfPitZApNHZCUwFs
 5eCO6YLbbVfr8q50nOczfQ9+MtRSU2frwnw5cn7UsnD11BwKW7GAoBPYtqnFyHLqakThhIVWriZ
 I
X-Google-Smtp-Source: AGHT+IF/n3nNMQp38qPpPRg9iGXpg4aEWsEYSsjXHa8V82Pqr96lwNeswT+YJ2KyssKLEQOW1mjS5w==
X-Received: by 2002:a05:600c:54f0:b0:40e:5fa7:db4d with SMTP id
 jb16-20020a05600c54f000b0040e5fa7db4dmr12400wmb.154.1705682114098; 
 Fri, 19 Jan 2024 08:35:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] buses: switch to 3-phase-reset
Date: Fri, 19 Jan 2024 16:35:07 +0000
Message-Id: <20240119163512.3810301-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patchset switches the handful of bus types that implement a
reset method over to using the 3-phase-reset APIs, and then removes
the transitional infrastructure from the core bus class that was
supporting the ability to have bus types that use old-style reset.

I wrote this ages ago and recently picked it back up because of a
recent PCI related reset ordering problem noted by Peter Xu.  I'm not
sure if this patchset is necessary as a part of fixing that ordering
problem (it might even be possible now to have the intel_iommu device
use 3-phase reset and put the relevant parts of its reset into the
'exit' phase), but either way we really ought to do this cleanup
to reduce the amount of legacy/transitional handling we have.

In theory this patchset should be fine and shouldn't be changing
behaviour.  On the other hand the reason I never sent it out when I
originally wrote it was that I ran into a test failure in the
BootLinuxConsole.test_sh4_r2d avocado test.  Rerunning all the
avocado tests I don't see that failing now, so maybe I was just
confused by a flaky test back then.

In any case, this could probably use a thorough soak testing with
workloads that do resets of the PCI bus; I've only done 'make check'
and 'make check-avocado' on it.  But I wanted to get it out onto the
list anyway.

thanks
-- PMM

Peter Maydell (5):
  pci: Switch bus reset to 3-phase-reset
  vmbus: Switch bus reset to 3-phase-reset
  adb: Switch bus reset to 3-phase-reset
  hw/s390x/css-bridge: switch virtual-css bus to 3-phase-reset
  hw/core: Remove transitional infrastructure from BusClass

 include/hw/qdev-core.h |  2 --
 hw/core/bus.c          | 67 ------------------------------------------
 hw/hyperv/vmbus.c      |  7 +++--
 hw/input/adb.c         |  7 +++--
 hw/pci/pci.c           | 10 ++++---
 hw/s390x/css-bridge.c  |  5 ++--
 6 files changed, 17 insertions(+), 81 deletions(-)

-- 
2.34.1


