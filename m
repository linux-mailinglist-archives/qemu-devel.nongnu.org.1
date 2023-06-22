Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB55739E97
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHd4-0002xa-8k; Thu, 22 Jun 2023 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHcw-0002xD-KM
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qCHcu-0006b9-Ou
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687429999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oAwRpxWWTD40A5nkSpAnR6wbSwXPD/kg7mGgslTa0d8=;
 b=BsQwgXERjgHYwDo8+Dpd7G7LniCqdMF3lWLXalmSabp/Fuva6hPYV5Wnhp8YJK6AUwVhX2
 RAHMKf+ttAM1p5MDblgFkTXci5PM4jhUWWzLeIk3VIkTInHkDbT+q2cPlBO3WmRR7AwUVd
 Fidql5U71kIw1HB9uDv/Zk/9DG/KSIg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-OH6XAz_yMIqX54Q4KUxKtw-1; Thu, 22 Jun 2023 06:33:18 -0400
X-MC-Unique: OH6XAz_yMIqX54Q4KUxKtw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-25e78cf986dso3571016a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687429997; x=1690021997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAwRpxWWTD40A5nkSpAnR6wbSwXPD/kg7mGgslTa0d8=;
 b=emthwMdaurdTd07ZEkZEg4FX3T6wqNOPPtQW7SNYo4IzolPwHHD0k2jKhLpnrIKUYI
 I/FObvboJuDWbqEhEtct6yWky7VyCsQS10nlHMn5dKJlDYfGoxvUVMulU4AkLZNtVXEb
 WklwR3i008xfXF+qIhPGA3srT1X3FWAHTwmv+ehxZ0rD9ConZQIOF4XlAU1rKOwYCtpL
 pmqy80p/CLnez+Ok8oSTLIKTLGRVxihT+vgLORJmBa+QE2NL6DlKHZ1Kmvw0YnSvbQEQ
 q8xHo8hHwLTvK+vKa1q7BE++wWuDh4T702ezoO5mvt/8p1JAZ/nxf9lgzkcWsrP8KkxH
 kjFw==
X-Gm-Message-State: AC+VfDyBEsolEm8wpa7vE9Yq6EVPuXc9DDOKWw+bN3lUumgB5iMBuvs2
 l6btDAVtUCv0FNjD+ElusmgTJ0l/DbbY0Lk2mK2TIU0CodOS7j7lm+hB5N8DMn6/m/S8AfwbahR
 uHmE7j0FBlG31GCg7NYINJIld2aCDmjRroWY4ppz6KACHEy9hCcQWgYHh7Go8bodsf/VMdBmwUk
 E=
X-Received: by 2002:a17:90a:6a8d:b0:25e:8550:5182 with SMTP id
 u13-20020a17090a6a8d00b0025e85505182mr13143095pjj.39.1687429996771; 
 Thu, 22 Jun 2023 03:33:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Nw0EqMBhJwDLXxFfe7YXwJobP3BOaZV8S/FHTvfAfOn1KqjHEMAdu5PpRvIDzTZDizOyj7w==
X-Received: by 2002:a17:90a:6a8d:b0:25e:8550:5182 with SMTP id
 u13-20020a17090a6a8d00b0025e85505182mr13143071pjj.39.1687429996390; 
 Thu, 22 Jun 2023 03:33:16 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.213])
 by smtp.googlemail.com with ESMTPSA id
 29-20020a17090a035d00b0025eb3b237b4sm11004872pjf.44.2023.06.22.03.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 03:33:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v2 0/5] test and QEMU fixes to ensure proper PCIE device usage
Date: Thu, 22 Jun 2023 16:02:50 +0530
Message-Id: <20230622103255.267289-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The test fixes must be applied before the QEMU change that checks for use
of a single slot in PCIE port.

CC: mst@redhat.com
CC: imammedo@redhat.com
CC: jusual@redhat.com
CC: thuth@redhat.com
CC: lvivier@redhat.com
CC: michael.labiuk@virtuozzo.com

Changelog:
v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.
The patches are added in the right order.

Ani Sinha (5):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot on the
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
  tests/qtest/hd-geo-test: fix test by removing unnecessary
    pcie-root-port
  hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port

 hw/pci/pci.c                      |   6 ++++++
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.39.1


