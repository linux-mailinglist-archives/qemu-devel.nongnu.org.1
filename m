Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D780741F25
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 06:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEix1-0004Ey-Od; Thu, 29 Jun 2023 00:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEix0-0004Eo-8M
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEiwy-00015X-N4
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 00:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688011687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Npl46K/mv7PRoXfR4jPjCTwNrJ2E4gGt5Z0oOmVFrpc=;
 b=gyHGxpoMOUv/03hz/XPsHedegntnWyArvjwX+jwoJmihdVCIGZxzbMY/kdYZFbgcZ1/bP3
 aIn4oZGCM+oC3Aow5j3JCxkf6prD+H/2Rkf2yjdt/XgAPYhefjhO/pXOWQ6XgRf4BF3AaI
 rpLnBAikbh2TqhIO9jk5x2oQB+1NSrw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-N5NidJcrON6ExPZ8BUewkw-1; Thu, 29 Jun 2023 00:08:05 -0400
X-MC-Unique: N5NidJcrON6ExPZ8BUewkw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-26304c2e178so240102a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 21:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688011684; x=1690603684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Npl46K/mv7PRoXfR4jPjCTwNrJ2E4gGt5Z0oOmVFrpc=;
 b=KDx0vbYNLYtPHj8XF5YWSJUpwIHxCXwGikHB/635HDsuGjI/BX/KWX1UCw3HtrOWnq
 4eH1/wP9ln87y1vUCRvg/0x69rSj+5vges1IV3/VR/as/dsv0Wbs92mbExW1HcE+S0VN
 8gJWd6SQAMfqLveGm2UKCcPBj+sGsgprSc6Z7rVNCEn8/QPRmwTYXfB4BlOSuV9J7Fxv
 9CF5y7Hb826N0b7Ln5WOOQ+BaKoXfEfs5hAoDd4A3FHh1Xskp90xBrCtpG4B+V6gwuJC
 yWAUHJtoI24j1RaAh+iiB5Ue3YuMuyB38d00o8YOZZ4ZizHMwGJuRmioRL26JZFy1nOc
 Efcg==
X-Gm-Message-State: AC+VfDyoS8LAXj0N5DlXlA0YhUKt+F/Nvp6GnZ76HhV+pjBTNrbpI2xQ
 vcU3J7p33T7kmqrJVDT44sIiySFz5JjPoFA0OOSvlG5U0tEpAdxUyLg/m03P0uaPr9AtPd1BEPY
 fOl6aRFPCTWd4zTQRVZP+9h9BM0cwZk7gJaOs6nrUdXGpZg7uvTDpA3QOfmWH8HrGVCQJrNrw8p
 w=
X-Received: by 2002:a17:90a:1906:b0:25e:a8ab:9157 with SMTP id
 6-20020a17090a190600b0025ea8ab9157mr34067038pjg.22.1688011684392; 
 Wed, 28 Jun 2023 21:08:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LZ6bobQvK1+FwQNHPOJx0dvmuaamEu2hTx3RnhAH+abILUCT4P61bN1/tc3owvluiIwwGxQ==
X-Received: by 2002:a17:90a:1906:b0:25e:a8ab:9157 with SMTP id
 6-20020a17090a190600b0025ea8ab9157mr34067020pjg.22.1688011684031; 
 Wed, 28 Jun 2023 21:08:04 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.183])
 by smtp.googlemail.com with ESMTPSA id
 21-20020a17090a019500b00256b67208b1sm10978169pjc.56.2023.06.28.21.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 21:08:03 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v6 0/5] test and QEMU fixes to ensure proper PCIE device usage
Date: Thu, 29 Jun 2023 09:37:02 +0530
Message-Id: <20230629040707.115656-1-anisinha@redhat.com>
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
v6: make patch 5 ARI compliant. fix commit message (s/pcie-root-port/pcie-to-pci/)
in patch 4. Rebase patchset to latest master.

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

 hw/pci/pci.c                      |  15 +++++++++++++++
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.39.1


