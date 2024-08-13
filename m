Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18313950868
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Aug 2024 17:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdt1r-0003Sd-7m; Tue, 13 Aug 2024 11:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdt1o-0003OX-KK
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:01:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sdt1k-0002Bk-Tv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:01:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EA3B227CF;
 Tue, 13 Aug 2024 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1723561293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O976Fc3DrgEzbe04El083w45+f2XZtPjk5T2oCyzRXo=;
 b=pAY4UXBV/0bgcuAEYEGQgp45txozMqbL2kJEI26zr0GGSktUWbe+GtU04uGkJN+Oh4gdT8
 EkGl+9nqfT8d5iAwVzT/gHdGE1mz0bXppRTGITtidAAnzrtYePv8nJtm2NGTFmpbnZm3TD
 /NTvMdUJXJKFoPTpWvACWvCB39rnxkM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1723561293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O976Fc3DrgEzbe04El083w45+f2XZtPjk5T2oCyzRXo=;
 b=pAY4UXBV/0bgcuAEYEGQgp45txozMqbL2kJEI26zr0GGSktUWbe+GtU04uGkJN+Oh4gdT8
 EkGl+9nqfT8d5iAwVzT/gHdGE1mz0bXppRTGITtidAAnzrtYePv8nJtm2NGTFmpbnZm3TD
 /NTvMdUJXJKFoPTpWvACWvCB39rnxkM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD27713983;
 Tue, 13 Aug 2024 15:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFgOKEx1u2Z/NAAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Tue, 13 Aug 2024 15:01:32 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v5 00/16] Introduce support for IGVM files
Date: Tue, 13 Aug 2024 16:01:02 +0100
Message-ID: <cover.1723560001.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Here is v5 of the set of patches to add support for IGVM files to QEMU. This is
based on commit 0f397dcfec of qemu.

This version addresses the review comments from v4 [1] plus changes required to
rebase on the master commit. As always, thanks to those that have been following
along, reviewing and testing this series. This v5 patch series is also available
on github: [2]

For testing IGVM support in QEMU you need to generate an IGVM file that is
configured for the platform you want to launch. You can use the `buildigvm`
test tool [3] to allow generation of IGVM files for all currently supported
platforms. Patch 11/17 contains information on how to generate an IGVM file
using this tool.

Changes in v5:

* Fix indentation and apply minimum version check for IGVM library in meson.build
* Remove unneeded duplicate macro definitions in confidential-guest-support.h
  and igvm-cvg.h
* Make igvm-cfg object file parameter mandatory instead of optional. Removed
  unused 'igvm_process()' function that checked the file was provided.
* Rename all QEMU IGVM functions and structs using QIGVM/qigvm prefix.
* A few small readability/style fixes.
* Address review comments on error handling, including removal of the v4 patch
  6: "Fix error handling in sev_encrypt_flash()".
* Update `FirmwareMapping` union in firmware.json to include `igvm`.

Patch summary:

1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
SEV-SNP and native platforms. 

12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 

16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
from IGVM VMSA to KVM.

[1] Link to v4:
https://lore.kernel.org/qemu-devel/cover.1720004383.git.roy.hopkins@suse.com/

[2] v5 patches also available here:
https://github.com/roy-hopkins/qemu/tree/igvm_master_v5

[3] `buildigvm` tool v0.2.0
https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0

Roy Hopkins (16):
  meson: Add optional dependency on IGVM library
  backends/confidential-guest-support: Add functions to support IGVM
  backends/igvm: Add IGVM loader and configuration
  hw/i386: Add igvm-cfg object and processing for IGVM files
  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
    IGVM
  sev: Update launch_update_data functions to use Error handling
  target/i386: Allow setting of R_LDTR and R_TR with
    cpu_x86_load_seg_cache()
  i386/sev: Refactor setting of reset vector and initial CPU state
  i386/sev: Implement ConfidentialGuestSupport functions for SEV
  docs/system: Add documentation on support for IGVM
  docs/interop/firmware.json: Add igvm to FirmwareDevice
  backends/confidential-guest-support: Add set_guest_policy() function
  backends/igvm: Process initialization sections in IGVM file
  backends/igvm: Handle policy for SEV guests
  i386/sev: Add implementation of CGS set_guest_policy()
  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2

 backends/confidential-guest-support.c      |  43 +
 backends/igvm-cfg.c                        |  52 ++
 backends/igvm.c                            | 964 +++++++++++++++++++++
 backends/igvm.h                            |  23 +
 backends/meson.build                       |   5 +
 docs/interop/firmware.json                 |  30 +-
 docs/system/i386/amd-memory-encryption.rst |   2 +
 docs/system/igvm.rst                       | 173 ++++
 docs/system/index.rst                      |   1 +
 hw/i386/pc.c                               |  12 +
 hw/i386/pc_piix.c                          |  10 +
 hw/i386/pc_q35.c                           |  10 +
 hw/i386/pc_sysfw.c                         |  31 +-
 include/exec/confidential-guest-support.h  |  86 ++
 include/hw/i386/x86.h                      |   3 +
 include/sysemu/igvm-cfg.h                  |  47 +
 meson.build                                |   8 +
 meson_options.txt                          |   2 +
 qapi/qom.json                              |  17 +
 qemu-options.hx                            |  25 +
 scripts/meson-buildoptions.sh              |   3 +
 target/i386/cpu.h                          |   9 +-
 target/i386/sev.c                          | 850 ++++++++++++++++--
 target/i386/sev.h                          | 124 +++
 24 files changed, 2446 insertions(+), 84 deletions(-)
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c
 create mode 100644 backends/igvm.h
 create mode 100644 docs/system/igvm.rst
 create mode 100644 include/sysemu/igvm-cfg.h

-- 
2.43.0


