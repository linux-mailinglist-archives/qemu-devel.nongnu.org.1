Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93287CFE66
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:42:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtV8d-0002Ds-GQ; Thu, 19 Oct 2023 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8a-0002B3-5L; Thu, 19 Oct 2023 11:40:40 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtV8T-0001jS-Jy; Thu, 19 Oct 2023 11:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=qoXE4e8dR0GuGW0j5+hJCywYo6vYJihH8CE/sr/39k0=; b=fNShEHmJnqYl4Cf8Ai5HgDM7Wq
 gGMYPibBJf34QJ2TI7/MOGzj4zHcUstX5QGaDnB1ZsM8tljHG87y3uWOu8moqsQuikGAbOtaqOlNW
 DqpTrsSsm+up+0nYD/sP+a043OjR3YFg7GxFQUQnqR6bvZeEMxhnimk2v9XDH90M2BrZHf2euISoI
 2Ct/e8ST/gdSKuPdz06B8DCUSdRgLgScNe9zxfgQgZVJESrm71Y9Ic6BK5/mwNI9IuMoeESwAjYMp
 2qNvYdkHABQff/LxCOkQ1tHMTt4PGKEukRZ+BRqjTIEJQSQupKb9GQ3MNMIOZJABWYDbqDzrtXN9X
 1w8+onkQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qtV8M-009yCg-2Y; Thu, 19 Oct 2023 15:40:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtV8L-000Ptd-1q; Thu, 19 Oct 2023 16:40:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v2 0/24] Get Xen PV shim running in Qemu, add net & console
Date: Thu, 19 Oct 2023 16:39:56 +0100
Message-Id: <20231019154020.99080-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Round up a couple of outstanding fixes, add console support and fix up
per-vCPU upcall vector support (which was previously untested), and that
allows us to boot PV guests. Document it.

Having fixed up the per-vCPU upcall vector support, pull in slightly 
newer Xen headers just for the definition of the CPUID bit that lets
us tell the Linux (6.0+) kernel to use it. That'll help with testing.

v2 of this series falls down the rabbithole a little more...

Now I know how to convert drivers to the "new" XenDevice model, let's do 
so for the Xen PV network driver, which has been on the TODO list for a 
while. Fix that up for actual Xen PV guests too (-m xenfv) because 
that's hosed right now even before the conversion.

Fix up net_cleanup() so it doesn't free the NICs from underneath the
device models which own them.

Switch the avocado test to use the Xen PV network device too.

Simplify the user experience for "-device file=IMAGE,if=xen" because
that was offending me.

Update the documentation, and take the opportunity to fix up that bit
about unplug not working on Q35, because I worked out how to do that
when heckling Joel's attempt to do so.

https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenfv-pv-2

David Woodhouse (24):
      i386/xen: Don't advertise XENFEAT_supervisor_mode_kernel
      i386/xen: fix per-vCPU upcall vector for Xen emulation
      hw/xen: select kernel mode for per-vCPU event channel upcall vector
      hw/xen: don't clear map_track[] in xen_gnttab_reset()
      hw/xen: fix XenStore watch delivery to guest
      i386/xen: Ignore VCPU_SSHOTTMR_future flag in set_singleshot_timer()
      hw/xen: Clean up event channel 'type_val' handling to use union
      include: update Xen public headers to Xen 4.17.2 release
      i386/xen: advertise XEN_HVM_CPUID_UPCALL_VECTOR in CPUID
      hw/xen: populate store frontend nodes with XenStore PFN/port
      hw/xen: automatically assign device index to block devices
      hw/xen: add get_frontend_path() method to XenDeviceClass
      hw/xen: do not repeatedly try to create a failing backend device
      hw/xen: update Xen console to XenDevice model
      hw/xen: add support for Xen primary console in emulated mode
      hw/xen: handle soft reset for primary console
      hw/xen: only remove peers of PCI NICs on unplug
      hw/xen: update Xen PV NIC to XenDevice model
      hw/i386/pc: support '-nic' for xen-net-device
      hw/xenpv: fix '-nic' support for xen-net-device
      net: do not delete nics in net_cleanup()
      tests/avocado: switch to using xen-net-device for Xen guest tests
      xen-platform: unplug AHCI disks
      docs: update Xen-on-KVM documentation

 MAINTAINERS                                    |   2 +-
 blockdev.c                                     |  15 +-
 docs/system/i386/xen.rst                       | 100 +++--
 hw/block/xen-block.c                           |  38 ++
 hw/char/trace-events                           |   8 +
 hw/char/xen_console.c                          | 539 +++++++++++++++++++------
 hw/i386/kvm/meson.build                        |   1 +
 hw/i386/kvm/trace-events                       |   2 +
 hw/i386/kvm/xen-stubs.c                        |   5 +
 hw/i386/kvm/xen_evtchn.c                       | 166 ++++----
 hw/i386/kvm/xen_gnttab.c                       |  32 +-
 hw/i386/kvm/xen_primary_console.c              | 194 +++++++++
 hw/i386/kvm/xen_primary_console.h              |  23 ++
 hw/i386/kvm/xen_xenstore.c                     |  31 +-
 hw/i386/pc.c                                   |  11 +-
 hw/i386/pc_piix.c                              |   2 +-
 hw/i386/pc_q35.c                               |   2 +-
 hw/i386/xen/xen_platform.c                     |  77 ++--
 hw/net/meson.build                             |   2 +-
 hw/net/trace-events                            |  11 +
 hw/net/xen_nic.c                               | 471 +++++++++++++++------
 hw/xen/xen-backend.c                           |  27 +-
 hw/xen/xen-bus.c                               |  17 +-
 hw/xen/xen-legacy-backend.c                    |   1 -
 hw/xen/xen_devconfig.c                         |  56 +--
 hw/xenpv/xen_machine_pv.c                      |  21 +-
 include/hw/i386/pc.h                           |   4 +-
 include/hw/xen/interface/arch-arm.h            |  37 +-
 include/hw/xen/interface/arch-x86/cpuid.h      |  31 +-
 include/hw/xen/interface/arch-x86/xen-x86_32.h |  19 +-
 include/hw/xen/interface/arch-x86/xen-x86_64.h |  19 +-
 include/hw/xen/interface/arch-x86/xen.h        |  26 +-
 include/hw/xen/interface/event_channel.h       |  19 +-
 include/hw/xen/interface/features.h            |  19 +-
 include/hw/xen/interface/grant_table.h         |  19 +-
 include/hw/xen/interface/hvm/hvm_op.h          |  19 +-
 include/hw/xen/interface/hvm/params.h          |  19 +-
 include/hw/xen/interface/io/blkif.h            |  27 +-
 include/hw/xen/interface/io/console.h          |  19 +-
 include/hw/xen/interface/io/fbif.h             |  19 +-
 include/hw/xen/interface/io/kbdif.h            |  19 +-
 include/hw/xen/interface/io/netif.h            |  25 +-
 include/hw/xen/interface/io/protocols.h        |  19 +-
 include/hw/xen/interface/io/ring.h             |  49 +--
 include/hw/xen/interface/io/usbif.h            |  19 +-
 include/hw/xen/interface/io/xenbus.h           |  19 +-
 include/hw/xen/interface/io/xs_wire.h          |  36 +-
 include/hw/xen/interface/memory.h              |  30 +-
 include/hw/xen/interface/physdev.h             |  23 +-
 include/hw/xen/interface/sched.h               |  19 +-
 include/hw/xen/interface/trace.h               |  19 +-
 include/hw/xen/interface/vcpu.h                |  19 +-
 include/hw/xen/interface/version.h             |  19 +-
 include/hw/xen/interface/xen-compat.h          |  19 +-
 include/hw/xen/interface/xen.h                 |  19 +-
 include/hw/xen/xen-backend.h                   |   1 +
 include/hw/xen/xen-bus.h                       |   4 +-
 include/hw/xen/xen-legacy-backend.h            |   3 +-
 include/sysemu/kvm_xen.h                       |   1 +
 net/net.c                                      |  28 +-
 target/i386/kvm/kvm.c                          |   4 +
 target/i386/kvm/xen-emu.c                      |  56 ++-
 tests/avocado/kvm_xen_guest.py                 |   2 +-
 63 files changed, 1585 insertions(+), 1017 deletions(-)



