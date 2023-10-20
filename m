Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ADD7D0B1D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlTx-00037E-Vo; Fri, 20 Oct 2023 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlTt-00032g-HE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlTr-0005Ae-QL
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YpSXkSExCLWND3UOS6rl5xmtJOtuXQPJE15D7cnE9HM=;
 b=Yxb6h7IFooF6AmLmVxR71Tp/Xcz+eLEt3IBcmidANLvPPDfNLwuhNUR4ngoF6smDxL36x9
 GQvff4sUP+rmLi2VxMdRRM01EfoEsjVvuSP8iwy6Dhby2nkSQfSwssFa9DfFIE7NTEyn1J
 qoHeiKgdNeL8aU8L7NiZhQGe7TLfZ7w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-O_3ADSKhMgSdeuPCpJ9I8A-1; Fri, 20 Oct 2023 05:07:38 -0400
X-MC-Unique: O_3ADSKhMgSdeuPCpJ9I8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96483827977;
 Fri, 20 Oct 2023 09:07:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5417D2166B26;
 Fri, 20 Oct 2023 09:07:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 00/13] migration: Check for duplicates on vmstate_register()
Date: Fri, 20 Oct 2023 11:07:18 +0200
Message-ID: <20231020090731.28701-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Hi

Hi

on this v2:
- rebased on top of master (no conflicts)
- handled reviewed by
- improved documentation
- Changed the ppc hack to maintain backwards compatibility.

Please review.

[v1]
This series are based in a patch from Peter than check if a we try to
register the same device with the same instance_id more than once.  It
was not merged when he sent it because it broke "make check".  So I
fixed all devices to be able to merge it.

- I create vmstate_register_any(), its the same that
  vmstate_register(VMSTATE_INSTANCE_ID_ANY)
- Later I check in vmstate_register() that they are not calling it
  with VMSTATE_INSTANCE_ID_ANY
- After that I change vmstate_register() to make sure that we don't
  include a duplicate.

And we get all the errors that I change in patches 3, 4, 5, 6, 7.
After those patches: make check works again.
And then I reviewed all the rest of vmstate_register() callers.

There are the cases where they pass a device_id that is generated
somehow, that ones are ok.

Then we have the ones that pass always 0.  This ones are only valid
when there is a maximum of one device instantiated for a given
machine.

- audio: you can choose more than one audio output.
- eeprom93xx: you can have more than one e100 card.

- vmware_vga: I am not completely sure here, it appears that you could
  have more than one.  Notice that VMSTATE_INSTANCE_ID_ANY will give
  us the value 0 if there is only one instance, so we are in no
  trouble.  We can drop it if people think that we can't have more
  than one vmware_vga.

- for the rest of the devices, I can't see any that can be
  instantiated more than once (testing it is easy, just starting the
  machine will make it fail).  Notice that again, for the same
  reasoning, we could change all the calls to _any().  And only left
  the vmstate_register(... 0 ...) calls for devices that we know that
  we only ever want one.

What needs to be done:

- icp/server: We need to rename the old icp server name.  Notice that
  I doubt that anyone is migrating this, but I need help from PPC
  experts.  As said in the commit message, it is "abusing" the interface:
  - it register a new device
  - it realizes that it is instantiting an old beard
  - it unregister the new device
  - it registers the old device

- rest of devices:

  * pxa2xx devices: I can't see how you can create more than one
    device in a machine
  * acpi_build: I can't see how to create more than once.
  * replay: neither
  * cpu timers: created in vl.c
  * global_state: only once
  * s390 css: not a way that I can think
  * spapr: looks only one
  * or1ktimer: I can only see one
  * tsc*: I see only use in pxa2xx and one by board

- And now, another abuser:

vmstate_register(VMSTATE_IF(tcet), tcet->liobn, &vmstate_spapr_tce_table,

tcet->liobn is an uint32_t, and instance_id is an int.  And it just happens that is value is < VMSTATE_INSTANCE_ID_ANY.

Please, review.

Juan Quintela (12):
  migration: Create vmstate_register_any()
  migration: Use vmstate_register_any()
  migration: Use vmstate_register_any() for isa-ide
  migration: Use vmstate_register_any() for ipmi-bt*
  migration: Use VMSTATE_INSTANCE_ID_ANY for slirp
  migration: Use VMSTATE_INSTANCE_ID_ANY for s390 devices
  migration: Hack to maintain backwards compatibility for ppc
  migration: vmstate_register() check that instance_id is valid
  migration: Improve example and documentation of vmstate_register()
  migration: Use vmstate_register_any() for audio
  migration: Use vmstate_register_any() for eeprom93xx
  migration: Use vmstate_register_any() for vmware_vga

Peter Xu (1):
  migration: Check in savevm_state_handler_insert for dups

 docs/devel/migration.rst    | 12 ++++++++----
 include/migration/vmstate.h | 34 ++++++++++++++++++++++++++++++++++
 audio/audio.c               |  2 +-
 backends/dbus-vmstate.c     |  3 +--
 backends/tpm/tpm_emulator.c |  3 +--
 hw/display/vmware_vga.c     |  2 +-
 hw/i2c/core.c               |  2 +-
 hw/ide/isa.c                |  2 +-
 hw/input/adb.c              |  2 +-
 hw/input/ads7846.c          |  2 +-
 hw/input/stellaris_input.c  |  3 +--
 hw/intc/xics.c              | 17 +++++++++++++++--
 hw/ipmi/ipmi_bmc_extern.c   |  2 +-
 hw/ipmi/ipmi_bmc_sim.c      |  2 +-
 hw/ipmi/isa_ipmi_bt.c       |  2 +-
 hw/ipmi/isa_ipmi_kcs.c      |  2 +-
 hw/net/eepro100.c           |  3 +--
 hw/nvram/eeprom93xx.c       |  2 +-
 hw/pci/pci.c                |  2 +-
 hw/ppc/spapr.c              | 25 +++++++++++++++++++++++--
 hw/ppc/spapr_nvdimm.c       |  3 +--
 hw/s390x/s390-skeys.c       |  3 ++-
 hw/s390x/s390-stattrib.c    |  3 ++-
 hw/timer/arm_timer.c        |  2 +-
 hw/virtio/virtio-mem.c      |  4 ++--
 migration/savevm.c          | 32 ++++++++++++++++++++++++++++++++
 net/slirp.c                 |  5 +++--
 27 files changed, 139 insertions(+), 37 deletions(-)

-- 
2.41.0


