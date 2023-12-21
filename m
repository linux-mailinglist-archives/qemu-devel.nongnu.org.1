Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC281BD07
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMia-0007Y4-Ba; Thu, 21 Dec 2023 12:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiX-0007X1-1i
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiN-0004S8-QK
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3hJTSyc2uiGPcu6bJCctGSCd9dZfRuMpKvvvos+YS9U=;
 b=hDCbgt7bZKGPcxbU6xT6DV2/eq1AokOl9aLRVIQtvRbcU6Wi3qMc+SIKaXypnV2gkxY7Hj
 CdiLDljzKtQhJX2X/9ICLMMnFMhVUkkgpUuWASlWcuoK/mGkwjdgnstZmc7QMWUnK5x1Ol
 xpcwlQzrPHKixxwonFg99TsSkB0Vs4c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-cAbLYpfqO1uFAjj-MwYqVg-1; Thu, 21 Dec 2023 12:20:02 -0500
X-MC-Unique: cAbLYpfqO1uFAjj-MwYqVg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2cc6bc4cc87so8049911fa.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179201; x=1703784001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hJTSyc2uiGPcu6bJCctGSCd9dZfRuMpKvvvos+YS9U=;
 b=xHBC0lVUt4xe4+izLRcdOi2H86zfEAzDuk8eMxBRHp7JONyiFZCX4rf6NmnWdJAC5h
 B7VEBEqXOax9vjaJR7E/yTaKJ3l2obVmeGOMTZOK82NtLtAskDJ0dzAjouUOqQRuL+gb
 RHNdBTRZ+bYdleAuyzaXm2ATEUaI0qgs0GlIPcbVa4oFZugXHL2ah1NWjbfcX6wibbVr
 6WwYeVdVb7FSRKYIAuQLA+LW+Oy6319jvOV/ns9TlALqzRxG3e2qqSfPnYtx2zC7Sp5V
 bN7WSjxiIRM9An57rgcdGJQa+J6uJ4RCHO14mwVoEXFqCvmkz+Cs2gPbb21oY5th1PJF
 h5ZA==
X-Gm-Message-State: AOJu0YzsUcxXoOXpTZzw6AvtnSE3God2cc/+0qNz52xeGYVWKX4tiLaG
 5YrF3ZRPmc5LlYloD3VYhoDDGejm20r/JC0pVUbIX9YdlT/uULjsgMO7gDSxnVKQ6cj51lQxS7d
 eX5GakC2AeOwix4yePz0EbUyZ7N4Hz/0X/NRY8oTOOOt6Rku+kD8fBkSkAW5TdcHUzFR5uJu7v0
 I=
X-Received: by 2002:a2e:a4dc:0:b0:2cc:a7da:49c with SMTP id
 p28-20020a2ea4dc000000b002cca7da049cmr79ljm.53.1703179200836; 
 Thu, 21 Dec 2023 09:20:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk9Mts0Mf++2TECwyMIE32Mh1xLAXakOVr2n4w+otqSfBIMBdFn/WyXk/CHMe0Yly0JD63xg==
X-Received: by 2002:a2e:a4dc:0:b0:2cc:a7da:49c with SMTP id
 p28-20020a2ea4dc000000b002cca7da049cmr76ljm.53.1703179200346; 
 Thu, 21 Dec 2023 09:20:00 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a2e7003000000b002cc7dc3d9f3sm315301ljc.92.2023.12.21.09.19.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:19:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/21] Build system cleanups for QEMU 9.0
Date: Thu, 21 Dec 2023 18:19:37 +0100
Message-ID: <20231221171958.59350-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These are cleanups that we can do with a completed conversion
and a global view of meson.build, including:

1) removal of CONFIG_ALL

2) regrouping of root meson.build into better-defined sections

3) renaming of targetos into host_os

4) cleaning up of probe_target_compiler

Plus a bunch of small cleanups here and there.

Paolo

Paolo Bonzini (21):
  meson: fix type of "relocatable" option
  meson: remove unused variable
  meson: use version_compare() to compare version
  Makefile: clean qemu-iotests output
  configure: remove unnecessary subshell
  configure: unify again the case arms in probe_target_compiler
  meson: always probe u2f and canokey if the option is enabled
  meson: remove OS definitions from config_targetos
  meson: remove CONFIG_POSIX and CONFIG_WIN32 from config_targetos
  meson: remove config_targetos
  meson: remove CONFIG_ALL
  meson: rename config_all
  meson: add more sections to main meson.build
  meson: move program checks together
  meson: move option validation a bit closer
  meson: separate host-specific checks from option validation
  meson: keep subprojects together
  meson: move CFI detection code earlier
  meson: move config-host.h definitions together
  meson: move subdirs to "Collect sources" section
  configure, meson: rename targetos to host_os

 Makefile                             |   1 +
 accel/tcg/meson.build                |   4 +-
 backends/meson.build                 |  10 +-
 block/meson.build                    |  11 +-
 bsd-user/meson.build                 |   2 +-
 chardev/meson.build                  |  28 +-
 configure                            | 154 +++---
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
 hw/mem/meson.build                   |   1 -
 hw/mips/meson.build                  |   2 +-
 hw/net/meson.build                   |   2 -
 hw/pci-bridge/meson.build            |   2 -
 hw/pci/meson.build                   |   1 -
 hw/ppc/meson.build                   |   8 +-
 hw/remote/meson.build                |   1 -
 hw/smbios/meson.build                |   5 -
 hw/usb/meson.build                   |   8 +-
 hw/virtio/meson.build                |   2 -
 meson.build                          | 779 +++++++++++++--------------
 meson_options.txt                    |   2 +-
 net/can/meson.build                  |   4 +-
 net/meson.build                      |  10 +-
 plugins/meson.build                  |   4 +-
 qga/meson.build                      |  50 +-
 scsi/meson.build                     |   8 +-
 storage-daemon/meson.build           |   2 +-
 system/meson.build                   |   4 +-
 target/arm/meson.build               |   2 +-
 target/mips/meson.build              |   2 +-
 tcg/meson.build                      |   2 +-
 tests/bench/meson.build              |   6 +-
 tests/fp/meson.build                 |   4 +-
 tests/meson.build                    |   4 +-
 tests/plugin/meson.build             |   2 +-
 tests/qemu-iotests/meson.build       |   2 +-
 tests/qtest/meson.build              |  20 +-
 tests/unit/meson.build               |   8 +-
 ui/dbus-display1.xml                 |  10 +-
 ui/meson.build                       |  17 +-
 util/meson.build                     |  58 +-
 52 files changed, 630 insertions(+), 671 deletions(-)

-- 
2.43.0


