Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA89820A77
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRd-00047z-3R; Sun, 31 Dec 2023 03:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRb-000463-AQ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRX-0000aE-My
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AN7LTp+FCNhBLEfmpjo29Pm9RvI6J+OYyDTx+5rUJ6Y=;
 b=b9DEw+rQxwdCaZ3wyxu8RForlJK+YLNZh00Y9L0EUIVJ90mgD/9AzcyvwqCs0CeoswgeD5
 Gye1JPiXnLeoSxHFxLzXYWVMsh4REWl8OmzF4+Uvpgb1/zbr8iw9QbQlSlxyticWfyvfgV
 1T5ZY/ADA75WJamJ1AViFsSTdrxKuRo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-PpdAI1GMMwWBd4yirCfiYA-1; Sun, 31 Dec 2023 03:45:07 -0500
X-MC-Unique: PpdAI1GMMwWBd4yirCfiYA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-554a0bbb411so2816356a12.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012306; x=1704617106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AN7LTp+FCNhBLEfmpjo29Pm9RvI6J+OYyDTx+5rUJ6Y=;
 b=fviXGGTYtz065q9FrYPI6LdFo/cPurONDukOSU6ZmVPhKYV4ptjWG4PuGNU/m1jmRf
 swLTriIe06v4h3jd/hoxDTGHCwG/3iNy9fVuduFbmxh/22Kzoew/3c84Gb1yCT6Aba3w
 m2GXge8Z0f696S8GIRXBJAWg9nAY59bsyWcI7aCBZthHZG5TjwrKzad68fGK14dirQZ1
 AAL8fHYduLFsxfai08oxx2RinFb4TjvKMgMpecQQDXGF4sgFRp4tobmOPvXTl67IrldC
 J2cvBpDT+3ILrTMD9LUmzzzuexrV2DYlLR9aQ56x/C/bYXxnywXAXDMbXJbweYaO/kHk
 uUdg==
X-Gm-Message-State: AOJu0Yzo0CnWKYT09wYypKy81pHlcdenrJ2ZoB6j0f1D7wGIYMsfknS+
 Xz50hcnx+Mt5P85ZLWNhLIasbAmyQ0iN5lHo40x4Mhqr9+5S5HgOPloe4fImfuVr2IgZH3y1N3e
 MkWRaxLit5W/2MpSXJ/VGcgLP+QL1x2CDojhBbxAUPBwOo/jbE7yyNi5L6D2NS7KyrpLqLXtMxB
 GExan5vLc=
X-Received: by 2002:a50:8e13:0:b0:54c:5f17:1163 with SMTP id
 19-20020a508e13000000b0054c5f171163mr9768662edw.58.1704012306239; 
 Sun, 31 Dec 2023 00:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1sxJV9Xj+fG18jRQrpAf69eSH54gOIRy8SaFdR3B4SxijGqC2s2qMbuf27oH5hAjxbKgSLg==
X-Received: by 2002:a50:8e13:0:b0:54c:5f17:1163 with SMTP id
 19-20020a508e13000000b0054c5f171163mr9768654edw.58.1704012305746; 
 Sun, 31 Dec 2023 00:45:05 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a056402110c00b0054c9211021csm13141298edv.69.2023.12.31.00.45.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] (mostly) target/i386 and meson changes for 2023-12-31
Date: Sun, 31 Dec 2023 09:44:16 +0100
Message-ID: <20231231084502.235366-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

The following changes since commit 191710c221f65b1542f6ea7fa4d30dde6e134fd7:

  Merge tag 'pull-request-2023-12-20' of https://gitlab.com/thuth/qemu into staging (2023-12-20 09:40:16 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f705c1f25d9a075534f8279048082af4ce2066bf:

  meson.build: report graphics backends separately (2023-12-31 09:11:29 +0100)

----------------------------------------------------------------
* configure: use a native non-cross compiler for linux-user
* meson: cleanups
* target/i386: miscellaneous cleanups and optimizations
* target/i386: implement CMPccXADD
* target/i386: the sgx_epc_get_section stub is reachable
* esp: check for NULL result from scsi_device_find()

----------------------------------------------------------------
Alex Bennée (1):
      meson.build: report graphics backends separately

Alexandra Diupina (1):
      esp: check for NULL result from scsi_device_find()

Paolo Bonzini (44):
      configure: use a native non-cross compiler for linux-user
      target/i386: optimize computation of JL and JLE from flags
      target/i386: speedup JO/SETO after MUL or IMUL
      target/i386: remove unnecessary arguments from raise_interrupt
      target/i386: remove unnecessary truncations
      target/i386: clean up cpu_cc_compute_all
      target/i386: document more deviations from the manual
      target/i386: reimplement check for validity of LOCK prefix
      target/i386: avoid trunc and ext for MULX and RORX
      target/i386: rename zext0/zext2 and make them closer to the manual
      target/i386: add X86_SPECIALs for MOVSX and MOVZX
      target/i386: do not decode string source/destination into decode->mem
      target/i386: do not clobber A0 in POP translation
      target/i386: do not clobber T0 on string operations
      target/i386: split eflags computation out of gen_compute_eflags
      target/i386: do not use s->tmp4 for push
      target/i386: do not use s->tmp0 for jumps on ECX ==/!= 0
      target/i386: prepare for implementation of STOS/SCAS in new decoder
      target/i386: move operand load and writeback out of gen_cmovcc1
      target/i386: adjust decoding of J operand
      target/i386: introduce flags writeback mechanism
      target/i386: implement CMPccXADD
      target/i386: the sgx_epc_get_section stub is reachable
      meson: fix type of "relocatable" option
      meson: remove unused variable
      meson: use version_compare() to compare version
      Makefile: clean qemu-iotests output
      configure: remove unnecessary subshell
      configure: unify again the case arms in probe_target_compiler
      meson: add more sections to main meson.build
      meson: move program checks together
      meson: move option validation together
      meson: move accelerator dependency checks together
      meson: keep subprojects together
      meson: move CFI detection code with other compiler flags
      meson: move config-host.h definitions together
      meson: move subdirs to "Collect sources" section
      meson: always probe u2f and canokey if the option is enabled
      meson: remove OS definitions from config_targetos
      meson: remove CONFIG_POSIX and CONFIG_WIN32 from config_targetos
      meson: remove config_targetos
      meson: remove CONFIG_ALL
      meson: rename config_all
      configure, meson: rename targetos to host_os

 Makefile                             |   1 +
 accel/tcg/meson.build                |   4 +-
 backends/meson.build                 |  10 +-
 block/meson.build                    |  11 +-
 bsd-user/meson.build                 |   2 +-
 chardev/meson.build                  |  28 +-
 configure                            | 159 +++---
 contrib/ivshmem-client/meson.build   |   2 +-
 contrib/ivshmem-server/meson.build   |   2 +-
 contrib/vhost-user-blk/meson.build   |   2 +-
 contrib/vhost-user-input/meson.build |   2 +-
 contrib/vhost-user-scsi/meson.build  |   2 +-
 docs/devel/build-system.rst          |  15 -
 docs/devel/kconfig.rst               |   2 +-
 fsdev/meson.build                    |   6 +-
 gdbstub/meson.build                  |   4 +-
 hw/9pfs/meson.build                  |   7 +-
 hw/acpi/meson.build                  |   5 -
 hw/cxl/meson.build                   |   2 -
 hw/display/meson.build               |   8 +-
 hw/i386/sgx-stub.c                   |   2 +-
 hw/mem/meson.build                   |   1 -
 hw/mips/meson.build                  |   2 +-
 hw/net/meson.build                   |   2 -
 hw/pci-bridge/meson.build            |   2 -
 hw/pci/meson.build                   |   1 -
 hw/ppc/meson.build                   |   8 +-
 hw/remote/meson.build                |   1 -
 hw/scsi/esp.c                        |   9 +
 hw/smbios/meson.build                |   5 -
 hw/usb/meson.build                   |   8 +-
 hw/virtio/meson.build                |   2 -
 meson.build                          | 943 +++++++++++++++++------------------
 meson_options.txt                    |   2 +-
 net/can/meson.build                  |   4 +-
 net/meson.build                      |  10 +-
 plugins/meson.build                  |   4 +-
 qga/meson.build                      |  50 +-
 scsi/meson.build                     |   8 +-
 storage-daemon/meson.build           |   2 +-
 system/meson.build                   |   4 +-
 target/arm/meson.build               |   2 +-
 target/i386/cpu.c                    |   2 +-
 target/i386/cpu.h                    |   5 +-
 target/i386/tcg/cc_helper.c          |   6 +-
 target/i386/tcg/decode-new.c.inc     | 152 ++++--
 target/i386/tcg/decode-new.h         |  29 +-
 target/i386/tcg/emit.c.inc           | 224 +++++++--
 target/i386/tcg/excp_helper.c        |   7 +-
 target/i386/tcg/fpu_helper.c         |  10 +-
 target/i386/tcg/helper-tcg.h         |   3 +-
 target/i386/tcg/int_helper.c         |   8 +-
 target/i386/tcg/misc_helper.c        |   4 +-
 target/i386/tcg/seg_helper.c         |   8 +-
 target/i386/tcg/translate.c          | 160 +++---
 target/mips/meson.build              |   2 +-
 tcg/meson.build                      |   2 +-
 tests/bench/meson.build              |   6 +-
 tests/fp/meson.build                 |   4 +-
 tests/meson.build                    |   4 +-
 tests/plugin/meson.build             |   2 +-
 tests/qemu-iotests/meson.build       |   2 +-
 tests/qtest/meson.build              |  20 +-
 tests/tcg/i386/Makefile.target       |   2 +-
 tests/tcg/i386/test-flags.c          |  37 ++
 tests/unit/meson.build               |   8 +-
 ui/dbus-display1.xml                 |  10 +-
 ui/meson.build                       |  17 +-
 util/meson.build                     |  58 ++-
 69 files changed, 1188 insertions(+), 950 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c
-- 
2.43.0


