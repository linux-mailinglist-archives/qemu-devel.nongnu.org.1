Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7673E460
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoq5-0007RA-SZ; Mon, 26 Jun 2023 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDopx-0007Q9-JS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDopw-0002gO-5H
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gp36klPpu8846eEti20WEH7zFaCLgDMvMjRbXbQqez8=;
 b=Drgw+cBTRxOeFUTio85B4pDxI+q6edyEJKKUgEtTs9PXTnjbcuSBDSA2qx29xVR1Lpm0HU
 oOv1U+F/rAvgyL090lcLaZLITC4X7wBkji/Vmo9of66omthy4NCJfFLiXzH8Tv9Wn5bC9g
 X3fjdqwlJia4qkoF5+JAnfNHwOt07ww=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205--J-vEbDPO_SRfUJIWd1X1w-1; Mon, 26 Jun 2023 12:13:02 -0400
X-MC-Unique: -J-vEbDPO_SRfUJIWd1X1w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-39edcb52625so2989715b6e.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795981; x=1690387981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gp36klPpu8846eEti20WEH7zFaCLgDMvMjRbXbQqez8=;
 b=Kqs5pJfKFkTSmACoa4x1/Q3TOuvc98utw/vA59ZeQ/QwLZQqaYr5Ig8W4mYXuVuwSq
 a4AhiW2mSN1T09qd6xb7Me8Mg8aEkqCjaMdf6oVzrtm8ylCyA9wNbL1yhFyLKMaBt4hB
 tumKZXVmhqDvl12wtaSV6IjkTCZdh/BqJ7sRh6YufilTKTdOsXbPqZ2cXlVL7tk3buYq
 Hw8LVQ8UO0uMd1p/VGGupaEX/sMCdJwAWXQdkBae2Dc033/RKfYk68JGGtAnWtMi/ppY
 21A2lMAjMdFIyxDfpg8QmH2tTzudFTGqopfkAEr+HJdVdwMwwzkM88KEgask+/ad0diV
 Wqvg==
X-Gm-Message-State: AC+VfDxJXBQIAdWDh2Ani9nIzY7wOobDBiUbpfL4SkUwYX7RnNuG8jI9
 Z/q5814Czr07+PYgz4DjZiX8in3e0ns4A4EzHPzE7YA/+25qwhA4uxYQn2FMEy4oP29maQNa/06
 6DB261pYWjHyifAvast7XjC82UgqU0qiWONckr8nhFRzbd/0WqbGHhsBrLgSHQZBhG9e83dkP8V
 M=
X-Received: by 2002:a05:6808:682:b0:38d:e632:8302 with SMTP id
 k2-20020a056808068200b0038de6328302mr30091554oig.14.1687795981134; 
 Mon, 26 Jun 2023 09:13:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ468m7g6cpfSIKJg530ArYBArX+QGXNVC6XbGjjkNr0UafAOGKInbVt3Dw9HR7K85divovocg==
X-Received: by 2002:a05:6808:682:b0:38d:e632:8302 with SMTP id
 k2-20020a056808068200b0038de6328302mr30091505oig.14.1687795980215; 
 Mon, 26 Jun 2023 09:13:00 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a631f45000000b0051b7d83ff22sm4318745pgm.80.2023.06.26.09.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:12:59 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [RESEND PATCH v5 0/5] test and QEMU fixes to ensure proper PCIE
 device usage
Date: Mon, 26 Jun 2023 21:42:39 +0530
Message-Id: <20230626161244.4145-1-anisinha@redhat.com>
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
===========
v5: no code changes - correct a mistake in the commit log message.

v4: reword commit log for patch 4.

v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 

v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.

The patches are added in the right order.


Ani Sinha (5):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot on the
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
  tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
    simplify test
  hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port

 hw/pci/pci.c                      |   6 ++++++
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.39.1


