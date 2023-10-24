Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590137D5130
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHDz-0003e0-Dn; Tue, 24 Oct 2023 09:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHDy-0003da-CA
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvHDw-0000z0-Jo
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 09:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698153211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vVStn45zlI2oCjFE2/vsf7UCgmC3FjJotEBpdVmEU6U=;
 b=fb7cdbpdDADS3yxbuW8dChpSaRx2xWdBXKKlKOZjpiSq8t4UAfmGZopAV4tcm5m9DX3qHl
 I7OiTSWLYxlCMbZLoEtKCiCi2xYurQXUv3NpgNF1K6ORkdC2P7NvODBHFjL+Fp1zQGNn3R
 LsDah9SOl3ZyvGBbnQDgqYz8ECOn/tE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-L8pqZkEkMdOA9vCoRWnNIw-1; Tue, 24 Oct 2023 09:13:15 -0400
X-MC-Unique: L8pqZkEkMdOA9vCoRWnNIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09556857C23;
 Tue, 24 Oct 2023 13:13:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3A71C060B6;
 Tue, 24 Oct 2023 13:13:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Corey Minyard <minyard@acm.org>, Li Zhijian <lizhijian@fujitsu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 libvir-list@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org
Subject: [PULL 00/39] Migration 20231024 patches
Date: Tue, 24 Oct 2023 15:12:26 +0200
Message-ID: <20231024131305.87468-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit a95260486aa7e78d7c7194eba65cf03311ad94ad:

  Merge tag 'pull-tcg-20231023' of https://gitlab.com/rth7680/qemu into staging (2023-10-23 14:45:46 -0700)

are available in the Git repository at:

  https://gitlab.com/juan.quintela/qemu.git tags/migration-20231024-pull-request

for you to fetch changes up to 088f7f03da3f5b3487091302b795c22b1bfe56fb:

  migration: Deprecate old compression method (2023-10-24 13:48:24 +0200)

----------------------------------------------------------------
Migration Pull request (20231024)

Hi

In this PULL:
- vmstate registration fixes (thomas, juan)
- start merging vmstate_section_needed changes (marc)
- migration depreactions (juan)
- migration documentation for backwards compatibility (juan)

Please apply.

----------------------------------------------------------------

Juan Quintela (31):
  migration/doc: Add contents
  migration/doc: Add documentation for backwards compatiblity
  migration/doc: How to migrate when hosts have different features
  migration/doc: We broke backwards compatibility
  migration: Receiving a zero page non zero is an error
  migration: Rename ram_handle_compressed() to ram_handle_zero()
  migration: Give one error if trying to set MULTIFD and XBZRLE
  migration: Give one error if trying to set COMPRESSION and XBZRLE
  migration: Remove save_page_use_compression()
  migration: Make compress_data_with_multithreads return bool
  migration: Simplify compress_page_with_multithread()
  migration: Move busy++ to migrate_with_multithread
  migration: Create compress_update_rates()
  migration: Export send_queued_data()
  migration: Move ram_flush_compressed_data() to ram-compress.c
  migration: Merge flush_compressed_data() and compress_flush_data()
  migration: Rename ram_compressed_pages() to compress_ram_pages()
  migration: Create vmstate_register_any()
  migration: Use vmstate_register_any()
  migration: Use vmstate_register_any() for isa-ide
  migration: Use VMSTATE_INSTANCE_ID_ANY for slirp
  migration: Hack to maintain backwards compatibility for ppc
  migration: Improve example and documentation of vmstate_register()
  migration: Use vmstate_register_any() for audio
  migration: Use vmstate_register_any() for eeprom93xx
  migration: Use vmstate_register_any() for vmware_vga
  qemu-iotests: Filter warnings about block migration being deprecated
  migration: migrate 'inc' command option is deprecated.
  migration: migrate 'blk' command option is deprecated.
  migration: Deprecate block migration
  migration: Deprecate old compression method

Marc-André Lureau (2):
  migration: rename vmstate_save_needed->vmstate_section_needed
  migration: set file error on subsection loading

Peter Xu (1):
  migration: Check in savevm_state_handler_insert for dups

Thomas Huth (5):
  hw/ipmi: Don't call vmstate_register() from instance_init() functions
  hw/s390x/s390-skeys: Don't call register_savevm_live() during
    instance_init()
  hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
    property
  hw/s390x/s390-stattrib: Don't call register_savevm_live() during
    instance_init()
  migration/ram: Fix compilation with -Wshadow=local

 docs/about/deprecated.rst        |  35 ++
 docs/devel/migration.rst         | 532 ++++++++++++++++++++++++++++++-
 qapi/migration.json              |  93 ++++--
 include/migration/vmstate.h      |  30 +-
 migration/ram-compress.h         |  10 +-
 migration/ram.h                  |   3 +-
 audio/audio.c                    |   2 +-
 backends/dbus-vmstate.c          |   3 +-
 backends/tpm/tpm_emulator.c      |   3 +-
 hw/display/vmware_vga.c          |   2 +-
 hw/i2c/core.c                    |   2 +-
 hw/ide/isa.c                     |   2 +-
 hw/input/adb.c                   |   2 +-
 hw/input/ads7846.c               |   2 +-
 hw/input/stellaris_input.c       |   3 +-
 hw/intc/xics.c                   |  18 +-
 hw/ipmi/ipmi_bmc_extern.c        |  29 +-
 hw/ipmi/isa_ipmi_bt.c            |  34 +-
 hw/ipmi/isa_ipmi_kcs.c           |  50 +--
 hw/net/eepro100.c                |   3 +-
 hw/nvram/eeprom93xx.c            |   2 +-
 hw/pci/pci.c                     |   2 +-
 hw/ppc/spapr.c                   |  25 +-
 hw/ppc/spapr_nvdimm.c            |   3 +-
 hw/s390x/s390-skeys.c            |  35 +-
 hw/s390x/s390-stattrib.c         |  71 ++---
 hw/timer/arm_timer.c             |   2 +-
 hw/virtio/virtio-mem.c           |   4 +-
 migration/block.c                |   3 +
 migration/migration-hmp-cmds.c   |  10 +
 migration/migration.c            |  10 +
 migration/options.c              |  36 ++-
 migration/ram-compress.c         | 112 +++++--
 migration/ram.c                  | 114 ++-----
 migration/rdma.c                 |   8 +-
 migration/savevm.c               |  34 +-
 migration/vmstate.c              |   5 +-
 net/slirp.c                      |   5 +-
 tests/qemu-iotests/183           |   2 +-
 tests/qemu-iotests/common.filter |   7 +
 40 files changed, 1041 insertions(+), 307 deletions(-)

-- 
2.41.0


