Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9EE8010F9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9778-0002uH-5I; Fri, 01 Dec 2023 12:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976x-0002r3-Tw
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976r-0007bo-VH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2CYs28Rp3CqsaYIK536qv/Hbldr1Pwdy0LhhkG3zgPo=;
 b=Ttq9KVM8c8Xxh41rvrgJI7OXUf3kaUgnLPHtg7i51bCytz90eOY5XzPKt7EIv6piM/dg5h
 vt6jI+gDnpGlkB/EW4+pkoOJVLzyGhcda2GdquUyk0Kl5bwXDOYcHvCrrqi11v7bu6UsHW
 2mxyR6vmFyz1ku9YJDQue169hV6uN30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-aTAbCj1iM2SdReF46a64CA-1; Fri, 01 Dec 2023 12:15:13 -0500
X-MC-Unique: aTAbCj1iM2SdReF46a64CA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40b40234bd5so15739555e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450911; x=1702055711;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CYs28Rp3CqsaYIK536qv/Hbldr1Pwdy0LhhkG3zgPo=;
 b=KlfgcEHg7uRdGi8o30LIYX0BO5XxWPhZ9aVd+5DWx3V+4dWiwdoCsRZ9MCkKuSYgNK
 g5yNUwESjGtH0WVy7gzq09KzfDc2If+LDxzyPdWFKcrYV4ozhtj3q2tgT4OKivIMwfZQ
 +KcxhUiSky52KVwloYlHl6nKXZaK3B6Niw1mULx8veka3RV1JYtHqQ0hvWGD5VqBHtJm
 x1MKDrCzYzvR0zH4OJ3k4Bj53UIcnjRt107unTU++zkdqdyIhZdvZ691IXbaW1hwkg4F
 xePpKVrxpgyRNY1H+tpp3UkUD1tPrM851z643zxarls6v89fPGtXSDbWEWSHdf7EPH8e
 54ZA==
X-Gm-Message-State: AOJu0YwwraYTFWilQeXXxZaB+z3BLiip+IGLSVbHI4cDwwEpYvyiCtUt
 e3BmAjfJfaElDQdOBXc8mF1faFYCppsRJxy8LxzJWRVEhH6nNSn1jzCuX9XL8XJiXzh6L6pl8g5
 H0W4l9OM5vpdt3qbaLQKcwPvdW1h+K9NRdWiW2lMnERRnN33i1HpCvcpa2GPPOrEkOhwS
X-Received: by 2002:a05:600c:538e:b0:40b:5e21:d337 with SMTP id
 hg14-20020a05600c538e00b0040b5e21d337mr479110wmb.64.1701450911758; 
 Fri, 01 Dec 2023 09:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPQJk+XGx22V30z+YdrXNxeHbDcOUG+oul8bcw5PwT17LVBW1m97HL7RsSUZPNIN5Qeex1gw==
X-Received: by 2002:a05:600c:538e:b0:40b:5e21:d337 with SMTP id
 hg14-20020a05600c538e00b0040b5e21d337mr479103wmb.64.1701450911303; 
 Fri, 01 Dec 2023 09:15:11 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6404000000b00332e5624a31sm4637452wru.84.2023.12.01.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:10 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/15] virtio,pc,pci: fixes
Message-ID: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

We have a reported regression because of the switch to
smbios 3.0, and maybe need to revert that, but Igor asked
for a bit more time to investigate.

The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:

  Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d4ad718733df4c87b9133bb57ea77b0040923541:

  vhost-user-scsi: free the inflight area when reset (2023-12-01 12:01:45 -0500)

----------------------------------------------------------------
virtio,pc,pci: fixes

Fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      pcie_sriov: Remove g_new assertion

Ani Sinha (1):
      tests/acpi/bios-tables-test: do not write new blobs unless there are changes

Daniel Hoffman (1):
      hw/i386: fix short-circuit logic with non-optimizing builds

Eric Auger (1):
      virtio-iommu: Remove useless !sdev check in virtio_iommu_probe()

Li Feng (2):
      vhost-user: fix the reconnect error
      vhost-user-scsi: free the inflight area when reset

Manos Pitsidianakis (2):
      virtio-snd: check AUD_register_card return value
      virtio-sound: add realize() error cleanup path

Michael S. Tsirkin (2):
      osdep: add getloadavg
      netdev: set timeout depending on loadavg

Philippe Mathieu-Daudé (1):
      hw/acpi/erst: Do not ignore Error* in realize handler

Robert Hoo (1):
      msix: unset PCIDevice::msix_vector_poll_notifier in rollback

Volker Rümelin (3):
      hw/audio/virtio-snd-pci: fix the PCI class code
      hw/audio/hda-codec: fix multiplication overflow
      hw/audio/hda-codec: reenable the audio mixer

 include/qemu/osdep.h           | 10 ++++++++++
 hw/acpi/erst.c                 | 10 ++++++++++
 hw/audio/hda-codec.c           | 41 ++++++++++++++++++++++++++--------------
 hw/audio/virtio-snd-pci.c      |  2 ++
 hw/audio/virtio-snd.c          | 43 ++++++++++++++++++++++++------------------
 hw/block/vhost-user-blk.c      |  8 +++-----
 hw/i386/x86.c                  | 15 ++++++++++++---
 hw/pci/msix.c                  |  1 +
 hw/pci/pcie_sriov.c            |  1 -
 hw/scsi/vhost-user-scsi.c      | 19 ++++++++++++++++++-
 hw/virtio/vhost-user-gpio.c    |  3 ++-
 hw/virtio/virtio-iommu.c       |  3 ---
 hw/virtio/virtio.c             |  2 +-
 tests/qtest/bios-tables-test.c | 14 +++++++++++++-
 tests/qtest/netdev-socket.c    | 28 ++++++++++++++++++++++++++-
 meson.build                    |  1 +
 16 files changed, 152 insertions(+), 49 deletions(-)


