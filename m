Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC073E41A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDogK-0006g5-Bm; Mon, 26 Jun 2023 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofp-0006Dg-FO
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofn-0007x3-S8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rndfCe1AHJVkGmEEW/Tgel/sotCE0o96ZaTS3rzE4K0=;
 b=ca91tyjUdJPRG9PPCcXg38Up4ahk4O1qX637uA9Ua7Sy2L52DmOPCPFVEqMOY6+oBjRAOP
 HHhgqwRBaPd8+HulqFRFOr/knbFGY7eqlUZp935b4k/X6DXikz863vU8QCSaoMKfGJ3w3u
 sza/vMe6glqNVT9fPZZhwCU0UWbxr9M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-OXqQw86pNsinUe7FhMlpmg-1; Mon, 26 Jun 2023 12:02:32 -0400
X-MC-Unique: OXqQw86pNsinUe7FhMlpmg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-54ff478ab88so1189965a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795329; x=1690387329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rndfCe1AHJVkGmEEW/Tgel/sotCE0o96ZaTS3rzE4K0=;
 b=ln0AERck5K6OfD+51oACOyoH4GcS5vSfLgQcXXYgJ1KZFPvujrNald/d6b7XZ6Uet8
 ClTiZ/jCZOJgaEtch5B3wwoO429EUrWXpcyJXTgFJpdw7xqFdNZgTB4ouZYxlDDfUefc
 j5xTCnSxB+DlpkobI0M7YgzNsDZOtg1h7kL+rf5Z99k1Eu+asFryALzP9lp/wbph69g9
 uRAXRqhMukTBXClkoQFDNDMXfoeTncGrNE06Mp3mcmVlzmqByDvmBJdcGervPyGs44J6
 3V0V2p4E1hiabhR48FceiORI/jBOiN/femeQ/MS8+ac1fSqEpYCggVfN7K4j2LX4tIs3
 BpGA==
X-Gm-Message-State: AC+VfDyAZ6tH9Wra6Pkpxpm0kwg08TlT9YSja78m4z6tYuqX+QYtlsw9
 oD7Ytz2lDcgLXLwil6Yj7UQsgfoLGbMIML9vZiAskRRXpLtvyCwVhK9I+I7IAi/v3XYratvRj4r
 AXM8Ww3WuqSU9atZmmN5afj/tu/TF+kVWK0cE7/vtHAE7wYMMq3bse5exaeBjurVo4KmtqV0yWh
 M=
X-Received: by 2002:a05:6a20:7347:b0:111:ee3b:59b1 with SMTP id
 v7-20020a056a20734700b00111ee3b59b1mr23294569pzc.2.1687795328900; 
 Mon, 26 Jun 2023 09:02:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6r7aFuZVK64suj0gQscplxCOyPdkPguA384Jk4D88Zl6iTYBW1y9vGTHNd3kGcuYU3zyZpcA==
X-Received: by 2002:a05:6a20:7347:b0:111:ee3b:59b1 with SMTP id
 v7-20020a056a20734700b00111ee3b59b1mr23294529pzc.2.1687795328461; 
 Mon, 26 Jun 2023 09:02:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 l23-20020a62be17000000b0065ebeb9bb23sm4120174pff.149.2023.06.26.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:02:08 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v5 0/5] test and QEMU fixes to ensure proper PCIE device usage
Date: Mon, 26 Jun 2023 21:31:51 +0530
Message-Id: <20230626160156.3938-1-anisinha@redhat.com>
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
=========
v5: no code changes - correct a mistake in the commit log message.

v4: reword commit log for patch 4.

v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 

v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.
The patches are added in the right order.


Ani Sinha (4):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot on the
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
  tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
    simplify test

Peter Maydell (1):
  Revert "cputlb: Restrict SavedIOTLB to system emulation"

 include/hw/core/cpu.h             |   6 ++----
 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 tests/qtest/hd-geo-test.c         |  18 ++++++++----------
 4 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.39.1


