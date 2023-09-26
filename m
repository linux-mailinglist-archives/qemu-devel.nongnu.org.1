Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB267AF182
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPH-0001uh-5v; Tue, 26 Sep 2023 12:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPC-0001tb-Aj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPA-0006a4-Dh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VGukofrp48GzcP/hRzJU5Hb0amhgm5Ye7XaIq+70sJs=;
 b=AIe3DJqh7vCDU+POeEaYGHeRLw0QSl2PO/UvRw01VKsXNAgA4lJ8p3zWhZTecicTvuYWsm
 hDPFki7bJ5IWYlUfyQaW2c+88Pyuf62WE0z8KLQ1RLq+1fCWv4C6lEOVHRtwWvrakAkQJY
 xHXt8GgbsoWpJpMAk9PPuSGGEvqwcJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-8LYiy257NliJN6LmXA91Kg-1; Tue, 26 Sep 2023 12:59:21 -0400
X-MC-Unique: 8LYiy257NliJN6LmXA91Kg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31ff9e40977so7590335f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747558; x=1696352358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGukofrp48GzcP/hRzJU5Hb0amhgm5Ye7XaIq+70sJs=;
 b=RSRjlfj6Kwu6I5qn3XderO+EEirnYzFX7GqFzhORyxkN6Fpz3ie4GvqppZqlKTlqp6
 quNL0o4En10bISjsbm9tEb+Ip1NPj719VsTPZoE7ZWR9HxcwnIW4ES4Coxy+feDAKa4g
 +DtTYlO7sw5Maobg3AujUJANa5f8c8NrseNyoI23mIIqWE8vkezjoNv5SjF3BW0VhxEj
 uSHhFp9bRNYA2IukXNwWmEigTmqcDsL4zTsHO/rh813FK4PSK7QDRqEhcXjUqmEy8vSM
 v1Y+KKlqdT+k+PXttnZxoMsXMLkngEMNP9o1MC4wPCT/4rFzrV50Y2+hfpyip6YqGiPC
 FVKg==
X-Gm-Message-State: AOJu0Yx2uMX0tqMoP5C63AcIPsyrm+plSYChWfYD7EwSBlqVJnQDlgPc
 OxGTro4NdyxIhfCk8pHCQ8FV8bqDVXaJFG864VJpvyzOSUV/3HSfGlsvAaV6JUnBe6LfCO24jsp
 9WzMNTQQ4XhYXzRyCl/iHC4btRjxn+u/i71+wRmL5ckMumZSoELjAsm6aN9C6TISXGI029bzfIk
 w=
X-Received: by 2002:adf:ea84:0:b0:319:6327:6adb with SMTP id
 s4-20020adfea84000000b0031963276adbmr8840421wrm.70.1695747558192; 
 Tue, 26 Sep 2023 09:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7odIwW+3CC+AJ4n12TzkrRTkD+tTJXRlVrK5fcKg3Q556Nilri9+V5Ec4mwmAP/QhgP+/SA==
X-Received: by 2002:adf:ea84:0:b0:319:6327:6adb with SMTP id
 s4-20020adfea84000000b0031963276adbmr8840400wrm.70.1695747557647; 
 Tue, 26 Sep 2023 09:59:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d68cd000000b00321673de0d7sm15089367wrw.25.2023.09.26.09.59.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Misc patches for 2023-09-26
Date: Tue, 26 Sep 2023 18:58:56 +0200
Message-ID: <20230926165915.738719-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The following changes since commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014:

  Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging (2023-09-25 10:10:30 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 417f8c8ebfa32823b23fed957dcbc7108cb77dea:

  audio: remove shadowed locals (2023-09-26 18:09:08 +0200)

----------------------------------------------------------------
* new round of audio cleanups
* various shadowed local variable fixes in vl, mptsas, pm_smbus, target/i386
* remove deprecated pc-i440fx-1.4 up to pc-i440fx-1.7
* remove PCI drivers from 128K bios.bin
* remove unused variable in user-exec-stub.c
* small fixes for ui/vnc
* scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]

----------------------------------------------------------------
Paolo Bonzini (18):
      pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
      seabios: remove PCI drivers from bios.bin
      user-exec-stub: remove unused variable
      vl: remove shadowed local variables
      ui/vnc: fix debug output for invalid audio message
      ui/vnc: fix handling of VNC_FEATURE_XVP
      mptsas: avoid shadowed local variables
      pm_smbus: rename variable to avoid shadowing
      m48t59-test: avoid possible overflow on ABS
      target/i386/kvm: eliminate shadowed local variables
      target/i386/cpu: avoid shadowed local variables
      target/i386/translate: avoid shadowed local variables
      target/i386/seg_helper: introduce tss_set_busy
      target/i386/seg_helper: remove shadowed variable
      target/i386/svm_helper: eliminate duplicate local variable
      block: mark mixed functions that can suspend
      compiler: introduce QEMU_ANNOTATE
      audio: remove shadowed locals

Thomas Huth (1):
      hw/scsi/scsi-disk: Disallow block sizes smaller than 512 [CVE-2023-42467]

 accel/tcg/user-exec-stub.c          |   2 -
 audio/audio.c                       |  11 +++---
 block/io.c                          |   5 ++-
 block/qcow2.c                       |   2 +-
 block/qed.c                         |   4 +-
 block/throttle-groups.c             |   4 +-
 docs/about/deprecated.rst           |   8 ----
 docs/about/removed-features.rst     |   4 +-
 hw/i2c/pm_smbus.c                   |   4 +-
 hw/i386/pc.c                        |  60 ++---------------------------
 hw/i386/pc_piix.c                   |  73 ------------------------------------
 hw/scsi/mptsas.c                    |   6 +--
 hw/scsi/scsi-disk.c                 |   5 ++-
 include/qemu/compiler.h             |   6 +++
 include/qemu/osdep.h                |   6 +--
 pc-bios/bios.bin                    | Bin 131072 -> 131072 bytes
 roms/config.seabios-128k            |  29 +++++++++-----
 softmmu/vl.c                        |   9 ++---
 target/i386/cpu.c                   |   3 +-
 target/i386/kvm/kvm.c               |   7 +---
 target/i386/tcg/seg_helper.c        |  53 +++++++++++++-------------
 target/i386/tcg/sysemu/svm_helper.c |   2 -
 target/i386/tcg/translate.c         |   4 +-
 tests/qtest/m48t59-test.c           |  17 +++++----
 tests/qtest/test-x86-cpuid-compat.c |  10 +----
 ui/vnc.c                            |   6 +--
 26 files changed, 103 insertions(+), 237 deletions(-)
-- 
2.41.0


