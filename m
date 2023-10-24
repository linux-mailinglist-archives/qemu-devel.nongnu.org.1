Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F427D54A7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIwm-00083F-H6; Tue, 24 Oct 2023 11:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvIwc-0007wG-7s
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvIwZ-00086D-IL
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698159822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qxh93brjwOYPH6j8/NAiATZr+Rzwyx6BBxGPfYIkju8=;
 b=WgDY94u2HmJnogLMUnya1XjMh5fNVvQbOIho8G5TkKj9tRftezbn04rGIUfyyGGfBwM7vL
 DYuP7C0PW6vDMMK3H4r3qxF0oYHrhaPAgXLKrokJtEGkXTUYOMOkYb6K1HqboEsmWHoic5
 9qKj/HZmPJrvIKvL7wAUrmJZsVKIMiE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-DbdldmYVOTqyN0TfeyGzrg-1; Tue,
 24 Oct 2023 11:03:39 -0400
X-MC-Unique: DbdldmYVOTqyN0TfeyGzrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B72961C06EF6;
 Tue, 24 Oct 2023 15:03:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABF4925C0;
 Tue, 24 Oct 2023 15:03:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 0/1] migration: Check for duplicates on vmstate_register()
Date: Tue, 24 Oct 2023 17:03:35 +0200
Message-ID: <20231024150336.89632-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

on this v3:
- rebase on top of pull migration-20231024
- only one patch leaft.

Based-on: Message-ID: <20231024131305.87468-1-quintela@redhat.com>
          [PULL 00/39] Migration 20231024 patches

Please review.

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

Juan Quintela (1):
  migration: vmstate_register() check that instance_id is valid

 include/migration/vmstate.h | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.41.0


