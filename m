Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF217AEE80
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9H1-0000Kw-1o; Tue, 26 Sep 2023 10:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9Gt-0000KW-Vh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql9Gr-0005sN-Mn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695739361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mtjjTnUerucCiyNIMPJeYAwJdtWoG3/3/FvlOkMVhzo=;
 b=XmTyzCvyaajR4SsD36CGwzNebLyDPE8IcRJbTIW/chXryUZhxNLA0yUStQ4yGnVWhfyRSB
 ajdT1yW5brl6xVsQ9T0gz7PQzqlQ55xcjt+wNHGsbxNuedSaOL0dhJGEjeOGW/ZcrUIemS
 RZ4gyelKFkXaXSibD/J2/Ts2oYBrTik=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-_AZAL7JgPJq_gGrgRPSc5w-1; Tue, 26 Sep 2023 10:42:39 -0400
X-MC-Unique: _AZAL7JgPJq_gGrgRPSc5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49E83816CA5;
 Tue, 26 Sep 2023 14:42:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 802B01004058;
 Tue, 26 Sep 2023 14:42:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EB0221E6900; Tue, 26 Sep 2023 16:42:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Brian Cain <bcain@quicinc.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason
 Wang <jasowang@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Michael S. Tsirkin <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [v2] Help wanted for enabling -Wshadow=local
Date: Tue, 26 Sep 2023 16:42:37 +0200
Message-ID: <87y1gtnggy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Brian, Gerd, Jason, Marc-Andr=C3=A9, Michael, we need your help to enable
-Wshadow=3Dlocal.

Paolo, you already took care of several subsystems (thanks!), except you
left a few warnings in target/i386/tcg/seg_helper.c.


Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
on polling error".

Enabling -Wshadow would prevent bugs like this one.  But we have to
clean up all the offenders first.

People responded quickly to my first call for help.  Thank you so much!

I'm collecting patches in my git repo at
https://repo.or.cz/qemu/armbru.git in branch shadow-next, output of
git-shortlog appended.  I'm happy to do pull requests.  I don't mind
maintainers merging patches for their subsystems; interference should be
minimal.

My test build is down to 19 files with warnings.  Sorted by subsystems,
files covered by multiple subsystems marked "(*NUMBER*)":

Guest CPU cores (TCG)
---------------------
Hexagon TCG CPUs
M: Brian Cain <bcain@quicinc.com>
    target/hexagon/gen_helper_funcs.py
    target/hexagon/mmvec/macros.h
    target/hexagon/op_helper.c
    target/hexagon/translate.c

X86 TCG CPUs
M: Paolo Bonzini <pbonzini@redhat.com>
M: Richard Henderson <richard.henderson@linaro.org>
M: Eduardo Habkost <eduardo@habkost.net>
    target/i386/tcg/seg_helper.c

Devices
-------
Network devices
M: Jason Wang <jasowang@redhat.com>
    hw/net/vhost_net.c(*2*)

USB
M: Gerd Hoffmann <kraxel@redhat.com>
    hw/usb/desc.c
    hw/usb/dev-hub.c
    hw/usb/dev-storage.c
    hw/usb/hcd-xhci.c
    hw/usb/host-libusb.c

vhost
M: Michael S. Tsirkin <mst@redhat.com>
    contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
    contrib/vhost-user-gpu/vugpu.h(*2*)
    hw/net/vhost_net.c(*2*)
    hw/virtio/vhost.c

virtio
M: Michael S. Tsirkin <mst@redhat.com>
    hw/virtio/virtio-pci.c
    include/hw/virtio/virtio-gpu.h(*2*)

virtio-gpu
M: Gerd Hoffmann <kraxel@redhat.com>
    include/hw/virtio/virtio-gpu.h(*2*)

vhost-user-gpu
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
R: Gerd Hoffmann <kraxel@redhat.com>
    contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
    contrib/vhost-user-gpu/vugpu.h(*2*)

Subsystems
----------
Overall Audio backends
M: Gerd Hoffmann <kraxel@redhat.com>
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    audio/audio.c

Open Sound System (OSS) Audio backend
M: Gerd Hoffmann <kraxel@redhat.com>
    audio/ossaudio.c

Dump
M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    dump/dump.c


Patches collected so far:

Alberto Garcia (1):
      test-throttle: don't shadow 'index' variable in do_test_accounting()

Alistair Francis (4):
      hw/riscv: opentitan: Fixup local variables shadowing
      target/riscv: cpu: Fixup local variables shadowing
      target/riscv: vector_helper: Fixup local variables shadowing
      softmmu/device_tree: Fixup local variables shadowing

Ani Sinha (1):
      hw/acpi: changes towards enabling -Wshadow=3Dlocal

C=C3=A9dric Le Goater (13):
      hw/ppc: Clean up local variable shadowing in _FDT helper routine
      pnv/psi: Clean up local variable shadowing
      spapr: Clean up local variable shadowing in spapr_dt_cpus()
      spapr: Clean up local variable shadowing in spapr_init_cpus()
      spapr: Clean up local variable shadowing in spapr_get_fw_dev_path()
      spapr/drc: Clean up local variable shadowing in rtas_ibm_configure_co=
nnector()
      spapr/pci: Clean up local variable shadowing in spapr_phb_realize()
      spapr/drc: Clean up local variable shadowing in prop_get_fdt()
      aspeed/i2c: Clean up local variable shadowing
      aspeed: Clean up local variable shadowing
      aspeed/i3c: Rename variable shadowing a local
      aspeed/timer: Clean up local variable shadowing
      target/ppc: Rename variables to avoid local variable shadowing in VUP=
KPX

Daniel P. Berrang=C3=A9 (2):
      crypto: remove shadowed 'ret' variable
      seccomp: avoid shadowing of 'action' variable

Eric Blake (1):
      qemu-nbd: changes towards enabling -Wshadow=3Dlocal

Klaus Jensen (1):
      hw/nvme: Clean up local variable shadowing in nvme_ns_init()

Laurent Vivier (1):
      disas/m68k: clean up local variable shadowing

Markus Armbruster (8):
      meson: Enable -Wshadow as a warning
      migration/rdma: Fix save_page method to fail on polling error
      migration: Clean up local variable shadowing
      ui: Clean up local variable shadowing
      block/dirty-bitmap: Clean up local variable shadowing
      block/vdi: Clean up local variable shadowing
      block: Clean up local variable shadowing
      qobject atomics osdep: Make a few macros more hygienic

Paolo Bonzini (8):
      mptsas: avoid shadowed local variables
      pm_smbus: rename variable to avoid shadowing
      vl: remove shadowed local variables
      target/i386/kvm: eliminate shadowed local variables
      target/i386/cpu: avoid shadowed local variables
      target/i386/translate: avoid shadowed local variables
      target/i386/svm_helper: eliminate duplicate local variable
      target/i386/seg_helper: remove shadowed variable

Peter Maydell (4):
      hw/intc/arm_gicv3_its: Avoid shadowing variable in do_process_its_cmd=
()
      hw/misc/arm_sysctl.c: Avoid shadowing local variable
      hw/arm/smmuv3.c: Avoid shadowing variable
      hw/arm/smmuv3-internal.h: Don't use locals in statement macros

Peter Xu (1):
      intel_iommu: Fix shadow local variables on "size"

Philippe Mathieu-Daud=C3=A9 (23):
      tcg: Clean up local variable shadowing
      target/arm/tcg: Clean up local variable shadowing
      target/arm/hvf: Clean up local variable shadowing
      target/mips: Clean up local variable shadowing
      target/m68k: Clean up local variable shadowing
      target/tricore: Clean up local variable shadowing
      hw/arm/armv7m: Clean up local variable shadowing
      hw/arm/virt: Clean up local variable shadowing
      hw/arm/allwinner: Clean up local variable shadowing
      hw/ide/ahci: Clean up local variable shadowing
      hw/m68k: Clean up local variable shadowing
      hw/microblaze: Clean up local variable shadowing
      hw/nios2: Clean up local variable shadowing
      net/eth: Clean up local variable shadowing
      crypto/cipher-gnutls.c: Clean up local variable shadowing
      util/vhost-user-server: Clean up local variable shadowing
      semihosting/arm-compat: Clean up local variable shadowing
      linux-user/strace: Clean up local variable shadowing
      sysemu/device_tree: Clean up local variable shadowing
      softmmu/memory: Clean up local variable shadowing
      softmmu/physmem: Clean up local variable shadowing
      hw/core/machine: Clean up local variable shadowing
      hw/intc/openpic: Clean up local variable shadowing


