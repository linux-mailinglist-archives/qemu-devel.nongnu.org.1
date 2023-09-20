Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55FB7A7559
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:07:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qisES-0005bw-Nd; Wed, 20 Sep 2023 04:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisEP-0005Xt-0I
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:45 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisEM-0002nZ-Kv
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:44 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59c2ca01f27so41965577b3.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695197201; x=1695802001;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RD1CZB2w6f2iZVC4JDHZL/cwSTTDRoZLn1mXm+34v5c=;
 b=hFarsga+q7DcDWbFLeNR7iZZcQyQ7w4CgdEuSyEKHzTOCpKcRjZYV1CUjRTL1EKkPY
 NCbPQmwpNU+OskOj7M7WwulY1tB2MTFCgnWmwhq6QdCZXxkrvjXxnhqdY4Ll+N4VxR71
 Nw3XvDPCpJmVW6eYSfbLsF1FsNDUXZ3WJMBQO9PtZuLoWOHe2+Ypz15/FjX59eoECv7L
 UR34YTFbGP0Bx2TY1xNtc7gbG36+1jU9g7IJcy4RCpG5VU8LKecRI7oVtZ10mVHH5Lrx
 s0otQIaUpTuBPEk+LNd/0xYo+LR4NRenFMxD1H3A+ssORXHHAMA5gF+CVqNoI+ndyl9X
 N6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695197201; x=1695802001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RD1CZB2w6f2iZVC4JDHZL/cwSTTDRoZLn1mXm+34v5c=;
 b=f6r5qFE7cK/G4VLbXVoiZ1CurxgmK0erZ/VTULzZC1AK8NVgEWkBklKKUOD9ErMyiQ
 wvnINjZG6Xe8FcE/41mcc1cNJapCTa78fx+ZFfF5jOuokQuPOlNSMTG3hW2qmYr9Ri7/
 YuZAx+tAFU4Rb1R9IAsRM3hWt6Pn7V7AAqm0C7NfKo+/B9qdAne3yhsOQmpAtVFtkgcO
 fSTaNPxNZMh/hua05kr/ECayKnYiqTwXtJeSgeov3MaMKNs4piDlpEfinMcw/CkU7FJE
 LTEtAhIilnFHflWAz27+LAtHzgYML5V95Jm9FO2L3LtS84Ss0YKOxgW6v6Jmyyg5Ak0i
 rpdQ==
X-Gm-Message-State: AOJu0YzhNDPZQ+lpRQnIhuW+CkCVdqtgddC4OESfH1qLVymRJjCs3q0U
 2+Yz4rziLIeG9z5QqCwGnLXAUWu0OT2hVpx6qv/GtA==
X-Google-Smtp-Source: AGHT+IHnqz0OTZ8ogbaxjbOvW/4oGXZ9Qh7FtD5gpXQpU6taomoKroYyMy1Yf0/fiZotXnHzGzcmsQ==
X-Received: by 2002:a0d:e852:0:b0:59b:d872:5ca8 with SMTP id
 r79-20020a0de852000000b0059bd8725ca8mr2013421ywe.22.1695197200835; 
 Wed, 20 Sep 2023 01:06:40 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b006862b2a6b0dsm2378596pfo.15.2023.09.20.01.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 01:06:40 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, peterx@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v5 0/5] Support message-based DMA in vfio-user server
Date: Wed, 20 Sep 2023 01:06:17 -0700
Message-Id: <20230920080622.3600226-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=mnissler@rivosinc.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mattias Nissler (5):
  softmmu: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     |  88 ++++++++++++++++++---
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  41 +++++++++-
 include/hw/pci/pci_device.h   |   3 +
 softmmu/dma-helpers.c         |   4 +-
 softmmu/memory.c              |   8 ++
 softmmu/physmem.c             | 141 ++++++++++++++++++----------------
 subprojects/libvfio-user.wrap |   2 +-
 10 files changed, 218 insertions(+), 81 deletions(-)

-- 
2.34.1


