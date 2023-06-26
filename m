Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E073573E124
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmex-0004tg-KY; Mon, 26 Jun 2023 09:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmew-0004tP-Cj
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDmev-000605-0P
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xbac3VfUqLzjseJNFogj4AyX/OF+bqpvoNNKZCUxGmk=;
 b=V2VhHI1SF3epD1IVGlBebZuetIaFuHIzEFPUBQA5gAZxcrFFz6K39XWofpa68rAnjjN5uN
 UZjtSYdBrXYVeMUBQvBi6NbkBGJFvJ3rQOqzowdDgHe9FFJL0ImQsYVVhyFva5ScIGCmLc
 LbpnM+O4d+nW3mNi/69QfDnP4OTbzrw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-va7IfiD_OSuqD0nNWAXcOA-1; Mon, 26 Jun 2023 09:53:34 -0400
X-MC-Unique: va7IfiD_OSuqD0nNWAXcOA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5578082558eso1096332a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787613; x=1690379613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xbac3VfUqLzjseJNFogj4AyX/OF+bqpvoNNKZCUxGmk=;
 b=KOXZ49dmdWAD5QK+5YYe4yFm4OlSAsDNWPNwd6ytVWxdvuThG1loYdCBE8Bw7c/KOG
 EYmdm9BeypTzH75lss25wqFsoMvjFBSb8Zuhuk9KHX57MoLk15kYO10xqfSj9nZ2Wg+L
 mqnV1f8OZduvmGAX32IQLXaCxcsWx2LfeyahAHEJ4gY0tR7JaqdNcFjEdeLK/hH6O4Q+
 YJvmRUxvFA9LxY3yeyDScJp1eJ+MuBS2UqsJCKVIbIn8LtQT12REgQ56Q9/hUx2bTx0f
 +gh2tgJTn/Lx1f9o/J7FZ8HjqtRMNXTgKxq2v48SFp+Hh5Sav7EJnQ02yMbIwyFrvMOu
 93Pg==
X-Gm-Message-State: AC+VfDzhzrOxi17evbht8uXJHNfM+kB2ZSWugx5PzYGYsP1J61kNkxhx
 +hYPeBrDvOnIdg1uj6KHFtnVHfzOSvrNoVnF+iLnTEKOElWaI8cA3DOZUEE7uO6fL6AbylwuNOk
 tAioG24ybjn2Fat+kSHClBJDcRxJIRI6mHDmdmxymlTC+O3SzdU+P6oQwSswV//TiZ5QRVosYHE
 8=
X-Received: by 2002:a17:902:d50d:b0:1b1:9f51:9ffb with SMTP id
 b13-20020a170902d50d00b001b19f519ffbmr5509890plg.26.1687787613000; 
 Mon, 26 Jun 2023 06:53:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ425QZ/WqjGwl+0UfHewQ0Ng1PE8hr5XMA/BGVxD9sUyTUIDrK1JtRr/bNvLCjdPAoJa3gh7Q==
X-Received: by 2002:a17:902:d50d:b0:1b1:9f51:9ffb with SMTP id
 b13-20020a170902d50d00b001b19f519ffbmr5509865plg.26.1687787612571; 
 Mon, 26 Jun 2023 06:53:32 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a170902904700b001b809082a69sm1559621plz.235.2023.06.26.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:53:32 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 jusual@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 michael.labiuk@virtuozzo.com
Subject: [PATCH v4 0/5] test and QEMU fixes to ensure proper PCIE device usage
Date: Mon, 26 Jun 2023 19:23:19 +0530
Message-Id: <20230626135324.10687-1-anisinha@redhat.com>
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


