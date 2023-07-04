Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ED746FDF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeAf-0001mc-CI; Tue, 04 Jul 2023 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAc-0001m3-UR
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAZ-0002BE-Pd
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=glQPnpYy4P4TFjIUPUDJqAsiDDp+kjK/Az3pHLzqACI=;
 b=ArzHkgKkk9JOtRIX6aCNl7BQbGcwT6b4ls/oVSA2uF03tazpDVimK88HJPW4dicB+wMaX3
 IV9o5iGaoyRadz0XG/iyrQqMvZ/QjNm3M+zlOHYnSrnT08PKnR6QWKPam6GdCFsgggm7Eu
 Lvqb8crSIRSH/p/VXJLQBWWjNhxB4AM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-4Lakcf3ONDi1vcDZFLEnfw-1; Tue, 04 Jul 2023 07:26:05 -0400
X-MC-Unique: 4Lakcf3ONDi1vcDZFLEnfw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-666e7b83930so5432760b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469964; x=1691061964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=glQPnpYy4P4TFjIUPUDJqAsiDDp+kjK/Az3pHLzqACI=;
 b=NtwZdkZ3TFFbLHpZ9md5S6J/E0nTM38LqDePH2d85j1D4jhttgzHU6tjUKtyY5QZmD
 YQ15LN90VIttFxpv8KPxgiEx7Y9UopuvdzGe6T+YXG29NSF+wFZ0XH8uO4EXMqKJ1cE7
 4fCgMAUVQSZ4NZyygEVoMYh724HX/Mne7CEBPXvlayvirx02/91ZO6snRsPAzPNQEZY4
 YrzDzd+UgMLqmgXpS9OzPdK4qlS7bX0aSPe89Rtzc/JGRyC3NXvyYFB0fzgR27L6G93H
 4oUkN1I//+s9gopPVZWA4YCjYGFfWK/C6mQeW0d+Tk/RGvGpVab128VqtYelJv2vPI8C
 ys9w==
X-Gm-Message-State: ABy/qLY71xzt6Z1C2hZOJngSBf9jXwIdnEBfOpqX9AbMasfRunP3jPfb
 QiNStWc/s7FeisezFXhOmSa35t7yDOZ2M1djfHKBxlTIgSYiad71vhQNI3vSFpVCNLP1w4+Xrhe
 fYkvqo88chtPsaTh4w7JnhAs3WRIdzV0VPAGxAsrzxbuI5UYomFaqw4NsNQGIc+KOTclFaBbz5M
 4=
X-Received: by 2002:a05:6a20:1397:b0:110:9210:f6ac with SMTP id
 hn23-20020a056a20139700b001109210f6acmr732695pzc.37.1688469964239; 
 Tue, 04 Jul 2023 04:26:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdu2LYuuFfpK58iBBYEzOjfDkQAFT+XoapoQMPE7MniEiQB3kPq4/v7nxH5cjzXHBkmWFNPg==
X-Received: by 2002:a05:6a20:1397:b0:110:9210:f6ac with SMTP id
 hn23-20020a056a20139700b001109210f6acmr732671pzc.37.1688469963843; 
 Tue, 04 Jul 2023 04:26:03 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.170])
 by smtp.googlemail.com with ESMTPSA id
 o7-20020a170902bcc700b001b8a897cd26sm780608pls.195.2023.07.04.04.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:26:03 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v7 0/6] test and QEMU fixes to ensure proper PCIE device usage
Date: Tue,  4 Jul 2023 16:55:49 +0530
Message-Id: <20230704112555.5629-1-anisinha@redhat.com>
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
  hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port
  hw/pci: add comment explaining the reason for checking function 0 in
    hotplug

 hw/pci/pci.c                      |  27 ++++++++++++++++++++++++---
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.39.1


