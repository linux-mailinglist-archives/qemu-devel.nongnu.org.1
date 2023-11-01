Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E237DE161
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyB5E-0000G2-0n; Wed, 01 Nov 2023 09:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB5C-0000Fk-3e
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:30 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qyB59-0003cf-T4
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:16:29 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-586cf3eccbeso2592118eaf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698844586; x=1699449386;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BtHevg6SDFOZoCNQO78iStIGCiDAqZmXuTORjfVCjXM=;
 b=zKlZguybxE1MkoRb2+lLk9McqvFXVYPzUErSYMnoDHTSzo4EyJn31dBcssE/HVwicU
 lxF1ECgH0HE2geKB0R1Mas5O4ZvxrZcf1aICFGQC8TxuYJgvNGmD76QVb6R4AgI+XUoS
 HLrPhdp+ZC7tz7IQGqZgKBGWT+PaujtI+PaTeGm2QEH7yiekKkDyVc+rjiR9b4r5EfEH
 qo3x26Fknvy/Sb2nu6NRCHp6Gt/niGD119F2WJ/I81J0CsMD8BfErRIowloEg8m0SbtG
 EOaSqxi91bhT5AsuhM5jcqxe/qoBrn83QKahwwej8uI2oX/hfpSfxpXd5sMLu2VLRWxm
 7DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698844586; x=1699449386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtHevg6SDFOZoCNQO78iStIGCiDAqZmXuTORjfVCjXM=;
 b=V77nF8jvahsafhxDWLIfwW86xSi9ijSsVZ0mO5czxTPmcuVF6NjvJDCkJyBjqZU1Ea
 R9Mr3Bct9q+7sMKHE2Q1558i3E3V4jYNlgVXwcZ4rchGupxQiwJfqUpREshlcJXyYuYS
 evQzkr0lLj6OFkkZM/le3Or3/XvZZ7qVcjFKb7bJovUZzK7P3cPY8Aar1gqt01cgTn5E
 S0aFKpv5YYmDTMTp1z2LURi9fslPYQkAWAYqsA7DOxH/7FlMI/0UKIF//EN4p2yhcKKX
 RT7WEysIT+BExKbF6Y+OHJJHMPkGO2uw+WnOZgX/oTM0Q2OtNyZpC8IkGNA/NycEuMbV
 dsrA==
X-Gm-Message-State: AOJu0YzQn+zGUJvvTR/465JAi+rsx9LY4LlAtr3Laxj9eMVykL33APFN
 2qJeP+TB3R7gHu0SbyKO1Sp4BQ==
X-Google-Smtp-Source: AGHT+IEWcwEttcp/vEkEDPC+rJ6YQAUaO0TftteSe8V284vBlMfSAZ8xiDsUuk0aivNs8Fg6p1rLng==
X-Received: by 2002:a05:6870:4154:b0:1e9:a050:3d60 with SMTP id
 r20-20020a056870415400b001e9a0503d60mr15680135oad.48.1698844586150; 
 Wed, 01 Nov 2023 06:16:26 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a056870e3c600b001d4d8efa7f9sm238148oad.4.2023.11.01.06.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:16:25 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 peterx@redhat.com
Cc: john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v6 0/5] Support message-based DMA in vfio-user server
Date: Wed,  1 Nov 2023 06:16:06 -0700
Message-Id: <20231101131611.775299-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series adds basic support for message-based DMA in qemu's vfio-user
server. This is useful for cases where the client does not provide file
descriptors for accessing system memory via memory mappings. My motivating use
case is to hook up device models as PCIe endpoints to a hardware design. This
works by bridging the PCIe transaction layer to vfio-user, and the endpoint
does not access memory directly, but sends memory requests TLPs to the hardware
design in order to perform DMA.

Note that more work is needed to make message-based DMA work well: qemu
currently breaks down DMA accesses into chunks of size 8 bytes at maximum, each
of which will be handled in a separate vfio-user DMA request message. This is
quite terrible for large DMA accesses, such as when nvme reads and writes
page-sized blocks for example. Thus, I would like to improve qemu to be able to
perform larger accesses, at least for indirect memory regions. I have something
working locally, but since this will likely result in more involved surgery and
discussion, I am leaving this to be addressed in a separate patch.

Changes from v1:

* Address Stefan's review comments. In particular, enforce an allocation limit
  and don't drop the map client callbacks given that map requests can fail when
  hitting size limits.

* libvfio-user version bump now included in the series.

* Tested as well on big-endian s390x. This uncovered another byte order issue
  in vfio-user server code that I've included a fix for.

Changes from v2:

* Add a preparatory patch to make bounce buffering an AddressSpace-specific
  concept.

* The total buffer size limit parameter is now per AdressSpace and can be
  configured for PCIDevice via a property.

* Store a magic value in first bytes of bounce buffer struct as a best effort
  measure to detect invalid pointers in address_space_unmap.

Changes from v3:

* libvfio-user now supports twin-socket mode which uses separate sockets for
  client->server and server->client commands, respectively. This addresses the
  concurrent command bug triggered by server->client DMA access commands. See
  https://github.com/nutanix/libvfio-user/issues/279 for details.

* Add missing teardown code in do_address_space_destroy.

* Fix bounce buffer size bookkeeping race condition.

* Generate unmap notification callbacks unconditionally.

* Some cosmetic fixes.

Changes from v4:

* Fix accidentally dropped memory_region_unref, control flow restored to match
  previous code to simplify review.

* Some cosmetic fixes.

Changes from v5:

* Unregister indirect memory region in libvfio-user dma_unregister callback.

I believe all patches in the series have been reviewed appropriately, so my
hope is that this will be the final iteration. Stefan, Peter, Jag, thanks for
your feedback, let me know if there's anything else needed from my side before
this can get merged.

Mattias Nissler (5):
  softmmu: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     | 104 +++++++++++++++++++++----
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  41 +++++++++-
 include/hw/pci/pci_device.h   |   3 +
 subprojects/libvfio-user.wrap |   2 +-
 system/dma-helpers.c          |   4 +-
 system/memory.c               |   8 ++
 system/physmem.c              | 141 ++++++++++++++++++----------------
 10 files changed, 226 insertions(+), 89 deletions(-)

-- 
2.34.1


