Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3E7BB68B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj92-00050i-AT; Fri, 06 Oct 2023 07:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8j-0004xZ-A5
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8f-00006K-Rj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yluy/YwgqNF73NfJJooCpvQpnWBo9Ep+5I4zHk4Zlo8=;
 b=VRYeNHHt9YOC+bXbBnPyCzlwPz2NUpaH1B24R5b7v0WLvatRFHVHPH7o6yJoLyp3VeLUf1
 oIuVOMKV3FevUxO+8Rn//KKyB0WJ5QIvQYuI4tunCv96Ec13bjMI8WhTcYNOtfvlKNmUBm
 25U/AndEHXxzcM9wCPiL6gLJ1NXdfps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-PBee-99pPSmtV9dwGiKngw-1; Fri, 06 Oct 2023 07:36:58 -0400
X-MC-Unique: PBee-99pPSmtV9dwGiKngw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F7F4101A590
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 532F6202696C
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 11:36:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55F5921E6904; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/32] -Wshadow=local patches patches for 2023-10-06
Date: Fri,  6 Oct 2023 13:36:25 +0200
Message-ID: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-shadow-2023-10-06

for you to fetch changes up to 77c9f177e02dccd8688eba9550a4fb961742a638:

  linux-user/syscall.c: clean up local variable shadowing in xattr syscalls (2023-10-06 13:27:48 +0200)

----------------------------------------------------------------
-Wshadow=local patches patches for 2023-10-06

----------------------------------------------------------------
Ani Sinha (1):
      hw/i386: changes towards enabling -Wshadow=local for x86 machines

Cédric Le Goater (2):
      target/ppc: Rename variables to avoid local variable shadowing in VUPKPX
      target/ppc: Clean up local variable shadowing in kvm_arch_*_registers()

Jonathan Cameron (1):
      hw/cxl: Fix local variable shadowing of cap_hdrs

Laurent Vivier (5):
      linux-user/flatload: clean up local variable shadowing
      linux-user/mmap.c: clean up local variable shadowing
      linux-user/syscall.c: clean up local variable shadowing in do_ioctl_dm()
      linux-user/syscall.c: clean up local variable shadowing in TARGET_NR_getcpu
      linux-user/syscall.c: clean up local variable shadowing in xattr syscalls

Philippe Mathieu-Daudé (16):
      hw/audio/soundhw: Clean up global variable shadowing
      hw/ide/ahci: Clean up local variable shadowing
      net/net: Clean up global variable shadowing
      os-posix: Clean up global variable shadowing
      plugins/loader: Clean up global variable shadowing
      qemu-img: Clean up global variable shadowing
      qemu-io: Clean up global variable shadowing
      qom/object_interfaces: Clean up global variable shadowing
      semihosting: Clean up global variable shadowing
      ui/cocoa: Clean up global variable shadowing
      util/cutils: Clean up global variable shadowing in get_relocated_path()
      util/guest-random: Clean up global variable shadowing
      semihosting/arm-compat: Clean up local variable shadowing
      softmmu/vl: Clean up global variable shadowing
      sysemu/tpm: Clean up global variable shadowing
      trace/control: Clean up global variable shadowing

Song Gao (1):
      target/loongarch: Clean up local variable shadowing

Thomas Huth (6):
      audio/ossaudio: Fix compiler warning with -Wshadow
      hw/net/vhost_net: Silence compiler warning when compiling with -Wshadow
      hw/virtio/virtio-pci: Avoid compiler warning with -Wshadow
      hw/virtio/vhost: Silence compiler warnings in vhost code when using -Wshadow
      dump: Silence compiler warning in dump code when compiling with -Wshadow
      hw/usb: Silence compiler warnings in USB code when compiling with -Wshadow

 include/hw/audio/soundhw.h      |  2 +-
 include/net/net.h               |  6 +++---
 include/qemu/guest-random.h     |  8 ++++----
 include/qemu/plugin.h           |  4 ++--
 include/qom/object_interfaces.h | 16 ++++++++--------
 include/semihosting/semihost.h  |  2 +-
 include/sysemu/os-posix.h       |  4 ++--
 include/sysemu/tpm.h            |  2 +-
 trace/control.h                 |  4 ++--
 audio/ossaudio.c                |  1 -
 dump/dump.c                     |  8 ++++----
 hw/audio/soundhw.c              |  6 +++---
 hw/cxl/cxl-device-utils.c       |  8 ++++----
 hw/i386/acpi-microvm.c          |  4 ++--
 hw/i386/pc.c                    |  1 -
 hw/i386/x86.c                   |  2 --
 hw/ide/ahci.c                   |  4 +---
 hw/loongarch/virt.c             |  2 +-
 hw/net/vhost_net.c              |  8 ++++----
 hw/usb/desc.c                   |  2 +-
 hw/usb/dev-hub.c                |  8 ++++----
 hw/usb/dev-storage.c            |  6 +++---
 hw/usb/hcd-xhci.c               | 10 +++++-----
 hw/usb/host-libusb.c            |  2 +-
 hw/virtio/vhost.c               |  8 ++++----
 hw/virtio/virtio-pci.c          | 20 ++++++++++----------
 linux-user/flatload.c           |  8 ++++----
 linux-user/mmap.c               |  6 +++---
 linux-user/syscall.c            | 36 ++++++++++++++++++------------------
 net/net.c                       | 14 +++++++-------
 os-posix.c                      | 12 ++++++------
 plugins/loader.c                |  4 ++--
 qemu-img.c                      | 22 +++++++++++-----------
 qemu-io.c                       |  4 ++--
 qom/object_interfaces.c         | 16 ++++++++--------
 semihosting/arm-compat-semi.c   |  5 ++++-
 semihosting/config.c            |  8 ++++----
 softmmu/tpm.c                   |  6 +++---
 softmmu/vl.c                    | 26 +++++++++++++-------------
 stubs/semihost.c                |  2 +-
 target/ppc/int_helper.c         | 12 ++++++------
 target/ppc/kvm.c                |  4 ----
 trace/control.c                 |  4 ++--
 util/cutils.c                   |  1 -
 util/guest-random.c             |  6 +++---
 ui/cocoa.m                      |  4 ++--
 46 files changed, 170 insertions(+), 178 deletions(-)

-- 
2.41.0


