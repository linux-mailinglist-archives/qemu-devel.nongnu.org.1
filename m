Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D007EC6F6
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:15:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HaE-00044Q-CA; Wed, 15 Nov 2023 10:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZh-0003uJ-Jx
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZe-0003II-Hi
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700061181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE/PtN9h0k7LC2WHk+1a688AyRXRE9rchXSc9yKvW2s=;
 b=JI3odbZWSh4G+Yl3ATAPndt/NKZ/m+hFaaQYsBBiIT3FUiTtzJiu8SfYIIFhWqgEZ+5olg
 ju8IxFKowpyRuOHiwwkJb3qdzwf9p5VBTkqCcP1aZHxAEZlGWFd2bpbFPGy3Fgsb+qam1O
 DyBDrL58EssRSlCctnRegmnkHYpr5gc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-04SPW4wvMUSJOwM12qjJ9g-1; Wed,
 15 Nov 2023 10:12:58 -0500
X-MC-Unique: 04SPW4wvMUSJOwM12qjJ9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 570C53810D3D;
 Wed, 15 Nov 2023 15:12:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB693492BFE;
 Wed, 15 Nov 2023 15:12:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6BE4C180AC1B; Wed, 15 Nov 2023 16:12:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 graf@amazon.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 16/16] docs: add uefi variable service documentation and TODO
 list.
Date: Wed, 15 Nov 2023 16:12:38 +0100
Message-ID: <20231115151242.184645-17-kraxel@redhat.com>
In-Reply-To: <20231115151242.184645-1-kraxel@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/devel/index-internals.rst |  1 +
 docs/devel/uefi-vars.rst       | 66 ++++++++++++++++++++++++++++++++++
 hw/uefi/TODO.md                | 17 +++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 docs/devel/uefi-vars.rst
 create mode 100644 hw/uefi/TODO.md

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 6f81df92bcab..eee676704cfa 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -17,6 +17,7 @@ Details about QEMU's various subsystems including how to add features to them.
    s390-cpu-topology
    s390-dasd-ipl
    tracing
+   uefi-vars
    vfio-migration
    writing-monitor-commands
    virtio-backends
diff --git a/docs/devel/uefi-vars.rst b/docs/devel/uefi-vars.rst
new file mode 100644
index 000000000000..8da69f3545af
--- /dev/null
+++ b/docs/devel/uefi-vars.rst
@@ -0,0 +1,66 @@
+==============
+UEFI variables
+==============
+
+Guest UEFI variable management
+==============================
+
+Traditional approach for UEFI Variable storage in qemu guests is to
+work as close as possible to physical hardware.  That means provide
+pflash as storage and leave the management of variables and flash to
+the guest.
+
+Secure boot support comes with the requirement that the UEFI variable
+storage must be protected against direct access by the OS.  All update
+requests must pass the sanity checks.  (Parts of) the firmware must
+run with a higher priviledge level than the OS so this can be enforced
+by the firmware.  On x86 this has been implemented using System
+Management Mode (SMM) in qemu and kvm, which again is the same
+approach taken by physical hardware.  Only priviedged code running in
+SMM mode is allowed to access flash storage.
+
+Communication with the firmware code running in SMM mode works by
+serializing the requests to a shared buffer, then trapping into SMM
+mode via SMI.  The SMM code processes the request, stores the reply in
+the same buffer and returns.
+
+Host UEFI variable service
+==========================
+
+Instead of running the priviledged code inside the guest we can run it
+on the host.  The serialization protocol cen be reused.  The
+communication with the host uses a virtual device, which essentially
+allows to configure the shared buffer location and size and to trap to
+the host to process the requests.
+
+The ``uefi-vars`` device implements the UEFI virtual device.  It comes
+in ``uefi-vars-isa`` and ``uefi-vars-sysbus`` flavours.  The device
+reimplements the handlers needed, specifically
+``EfiSmmVariableProtocol`` and ``VarCheckPolicyLibMmiHandler``.  It
+also consumes events (``EfiEndOfDxeEventGroup``,
+``EfiEventReadyToBoot`` and ``EfiEventExitBootServices``).
+
+The advantage of the approach is that we do not need a special
+prividge level for the firmware to protect itself, i.e. it does not
+depend on SMM emulation on x64, which allows to remove a bunch of
+complex code for SMM emulation from the linux kernel
+(CONFIG_KVM_SMM=n).  It also allows to support secure boot on arm
+without implementing secure world (el3) emulation in kvm.
+
+Of course there are also downsides.  The added device increases the
+attack surface of the host, and we are adding some code duplication
+because we have to reimplement some edk2 functionality in qemu.
+
+usage on x86_64 (isa)
+---------------------
+
+.. code::
+
+   qemu-system-x86_64 -device uefi-vars-isa,jsonfile=/path/to/vars.json
+
+usage on aarch64 (sysbus)
+-------------------------
+
+.. code::
+
+   qemu-system-aarch64 -M virt,x-uefi-vars=on
diff --git a/hw/uefi/TODO.md b/hw/uefi/TODO.md
new file mode 100644
index 000000000000..5d1cd15a798e
--- /dev/null
+++ b/hw/uefi/TODO.md
@@ -0,0 +1,17 @@
+
+uefi variable service - todo list
+---------------------------------
+
+* implement reading/writing variable update time.
+* implement authenticated variable updates.
+  - used for 'dbx' updates.
+
+known issues and limitations
+----------------------------
+
+* secure boot variables are read-only
+  - due to auth vars not being implemented yet.
+* works only on little endian hosts
+  - accessing structs in guest ram is done without endian conversion.
+* works only for 64-bit guests
+  - UINTN is mapped to uint64_t, for 32-bit guests that would be uint32_t
-- 
2.41.0


