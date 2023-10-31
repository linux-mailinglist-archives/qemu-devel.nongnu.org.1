Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB3B7DCF96
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:48:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq2J-0006Ja-Dj; Tue, 31 Oct 2023 10:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qxq2H-0006G2-N3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qxq2F-0002qc-QD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698763681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EKvXdVJCPAevUzJp7/69hur5m+pIRFpp/konyGDQ600=;
 b=JN0hVNic0lnNaL0MaLLvZ0JVsP0j9b4KB/Rf/5JX2nv4DJezcip5SStcdTfZCCsIXSnksu
 cE6/ztdWyuNmsMXnzrMXMLuDSn76qbSHleSQCzoVJupe7W2se2+OEugTR+bPXyfvLAKbas
 6D08QFMjmM2aOAcTnsd1C4aGDkohWko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-xXQLbCgqPpaOcVqzcBZ_AA-1; Tue, 31 Oct 2023 10:46:17 -0400
X-MC-Unique: xXQLbCgqPpaOcVqzcBZ_AA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7289310B7AA9
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:46:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A765C1290F;
 Tue, 31 Oct 2023 14:46:16 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, berrange@redhat.com,
 Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH v2 0/3] Add support for RAPL MSRs series
Date: Tue, 31 Oct 2023 15:46:00 +0100
Message-ID: <20231031144605.64822-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Hello,

This v2 patch series tries to overcome the issue of the CVE 2020-8694
[1] while trying to read the RAPL MSR for populating the vitrual one on
KVM/QEMU virtual machine.

The solution proposed here is to create a helper daemon that would run
as a priviliged process and able to communicate via a socket to the QEMU
thread that deals with the ratio calculation of the energy counter.

So first it adds the SO_PEERCRED socket option in QIO CHANNEL so that
the helper daemon can check the PID of the peer (QEMU) to validate the
TID that is in the message. 

Then the daemon, called qemu-vmsr-helper, is added in the tools folder.
The daemon is very similar to the qemu-pr-helper in terms of operation.
However comminucation protocol is simplier and requires only one
coroutine to handle the peer request. Only the RAPL MSRs are allowed to
be read via the helper.

And to finish the last commit adds all the RAPL MSR in KVM/QEMU like the
v1 but, instead of reading directly the MSR via readmsr(), reads the
value through a socket comminucation. 

This is a follow-up of the V1 sent mid-june [2].

v1 -> v2
--------

- To overcome the CVE-2020-8694 a socket communication is created
  to a priviliged helper

- Add the priviliged helper (qemu-vmsr-helper)

- Add SO_PEERCRED in qio channel socket

RFC -> v1
---------

- Add vmsr_* in front of all vmsr specific function

- Change malloc()/calloc()... with all glib equivalent

- Pre-allocate all dynamic memories when possible

- Add a Documentation of implementation, limitation and usage

Regards,
Anthony

[1]: https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/running-average-power-limit-energy-reporting.html#cve-2020-8694
[2]: https://lore.kernel.org/qemu-devel/20230616140830.316655-1-aharivel@redhat.com/

Anthony Harivel (3):
  qio: add support for SO_PEERCRED for socket channel
  tools: build qemu-vmsr-helper
  Add support for RAPL MSRs in KVM/Qemu

 accel/kvm/kvm-all.c             |  26 ++
 docs/specs/index.rst            |   1 +
 docs/specs/rapl-msr.rst         | 131 +++++++++
 docs/tools/index.rst            |   1 +
 docs/tools/qemu-vmsr-helper.rst |  89 ++++++
 include/io/channel.h            |  20 ++
 include/sysemu/kvm_int.h        |  12 +
 io/channel-socket.c             |  17 ++
 io/channel.c                    |  12 +
 meson.build                     |   5 +
 target/i386/cpu.h               |   8 +
 target/i386/kvm/kvm.c           | 308 +++++++++++++++++++
 target/i386/kvm/meson.build     |   1 +
 target/i386/kvm/vmsr_energy.c   | 278 +++++++++++++++++
 target/i386/kvm/vmsr_energy.h   |  82 ++++++
 tools/i386/qemu-vmsr-helper.c   | 507 ++++++++++++++++++++++++++++++++
 tools/i386/rapl-msr-index.h     |  28 ++
 17 files changed, 1526 insertions(+)
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 target/i386/kvm/vmsr_energy.h
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 tools/i386/rapl-msr-index.h

-- 
2.41.0


