Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF577483A7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Ab-0006Hi-Lk; Wed, 05 Jul 2023 07:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1AZ-0006Fw-52
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1AX-00010O-Ld
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mWHuwqFkfkM+bNEIQph+CaDuWiV6oRi3QbmX7k+lUgU=;
 b=iTMG9QjbLuXVY84yPT5ppHazfhlplLXdQ7aIsn+zEz1XTLUH2j/9HU+K7FhU9FRjtvE7g2
 l6HNbzeUwHQ2rjgOwI3eul+FwFXXrkgBbXYTkKO1meNrzudwmSDlnJ9/IvNYOBt7uYJhcL
 LU2qUijSkeyyP95ss8vQX2lh8o0bCvg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-VZEdIckDMvOpJXlXzQc9sQ-1; Wed, 05 Jul 2023 07:59:35 -0400
X-MC-Unique: VZEdIckDMvOpJXlXzQc9sQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b8a7735231so14565875ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558374; x=1691150374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWHuwqFkfkM+bNEIQph+CaDuWiV6oRi3QbmX7k+lUgU=;
 b=JC8RuVxalRsLSKjCLCIehGZoGVL//a/215zt5SjQUx1ZMdaIv+9qzg4NJUxCo2a/jX
 Vj+HdtBO3EMEa2cb5nMCFmxAhMhLlyJXX35XEaQeLapWjxOb6bkm+rpN9sIqO0eGM5o5
 ALl7Esmdzh/nNBZkyr7FpiFOalfVPqbRjpMhMfe9kut0zgEroCYW3Ib5DzM12H4ymXvu
 rZ20p65h6iujtmyj7+9KTfPEqSUZXtpfVmKuthkFySW3GUHAe9HsmhRUBnTLzKiPGIE2
 Tlq2lsAvj3RK6dZAO85iaWOEzMRwNG9S93Kgyx3NDoiIAHtXsU6yWPlkPQ16RIq1qcC4
 Vjfw==
X-Gm-Message-State: ABy/qLY9FgUZVD7RRBVgCiNwKBg2dFWPFamcwenvrc6BvFixLRmnUATY
 vBwOflPmH1QA3mw/4G70ARlqMa5dwD0ZVyy+nJjOHb+mNtKZD6kYJvufUUlSZQ2s0YGKfnlxvjd
 n4+KPWyJjuym3JnR/yv7UHMRq98Xv5KYX/MVgU7b+3jt2yK95aZDbZfyaDrhNW2rzybiKpPGStf
 0=
X-Received: by 2002:a17:902:ce8d:b0:1b8:2ec0:42b4 with SMTP id
 f13-20020a170902ce8d00b001b82ec042b4mr13752217plg.4.1688558374283; 
 Wed, 05 Jul 2023 04:59:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpDB002SM2p2azIKJZi9L3Zyk26NaLCkue7NE1yWsXX+RzuOS5Loxy/LGo58PUyT6cRrW9qg==
X-Received: by 2002:a17:902:ce8d:b0:1b8:2ec0:42b4 with SMTP id
 f13-20020a170902ce8d00b001b82ec042b4mr13752195plg.4.1688558373875; 
 Wed, 05 Jul 2023 04:59:33 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:33 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v8 0/6] test and QEMU fixes to ensure proper PCIE device usage
Date: Wed,  5 Jul 2023 17:29:18 +0530
Message-Id: <20230705115925.5339-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Patches 1-4:
Fix tests so that devices do not use non-zero slots on the pcie root
ports. PCIE ports only have one slot, so PCIE devices can only be
plugged into slot 0 on a PCIE port.

Patch 5:
Enforce only one slot on PCIE port.

Patch 6: add a cosmetic comment addition for better clarity of the code.

The test fixes must be applied before the QEMU change that checks for use
of a single slot in PCIE port.

CC: mst@redhat.com
CC: imammedo@redhat.com
CC: jusual@redhat.com
CC: thuth@redhat.com
CC: lvivier@redhat.com
CC: michael.labiuk@virtuozzo.com

Changelog:
===========
v8: more comment messaging. rebased to latest master. small changes in patch
description and title.

v7: added tags, rebased to latest master.
For patch 5, converted a hard error to a warning.
Added patch 6.

v6: make patch 5 ARI compliant. fix commit message (s/pcie-root-port/pcie-to-pci/)
in patch 4. Rebase patchset to latest master.

v5: no code changes - correct a mistake in the commit log message.

v4: reword commit log for patch 4.

v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 

v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.

The patches are added in the right order.

Ani Sinha (6):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot on the
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
  tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
    simplify test
  hw/pci: warn when PCIe device is plugged into non-zero slot of
    downstream port
  hw/pci: add comment to explain checking for available function 0 in
    pci hotplug

 hw/pci/pci.c                      |  31 +++++++++++++++++++++++++++---
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++---------
 4 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.39.1


