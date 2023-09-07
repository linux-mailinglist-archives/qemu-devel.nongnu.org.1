Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E32417972BD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgR-00032L-AP; Thu, 07 Sep 2023 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgN-00031j-T3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:27 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgI-00082M-AG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso7077455ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091860; x=1694696660;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9cbNwYOrfX5TGIWVIMBGyKwf+EulO7udFk4XBcHvm1g=;
 b=YmU5VaTUEnvtToAaiZFboxOwBJAMlakO1/eiQX0bmmaqe/g7sGZDXTs0qVfhRDwub6
 Rghx9WezIPMDKCrDXK3+eyn4cbqn6ZeqV7IF7p+VpxEt7JOHqtNqlUiFvAWaFuap1YiO
 bcaX1R6IjiGz5JwNFuqRqwCB6dgRwKJJs3J4uCu0eeI9pOnrpbdBQ1obqJNETXMmm/jk
 XWZ75Ped7vn0BMn8hJaq9n5p9fh/zGXumtfJUqOtIYBYvX9GlbueoUFKFiP5EKDRVN3o
 6Kas6mRkWilr5zH0A2txtm3uRgfBnl2k48RPl2qu38FwwE7Tf/C/o5ioQWOis6vMsU6U
 Udqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091860; x=1694696660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cbNwYOrfX5TGIWVIMBGyKwf+EulO7udFk4XBcHvm1g=;
 b=ZwEhoDzHLYXwFZO7v1B0XiNajW7SCN6ZhJAxuwnoX/Oqys8j/YES2voE7FD4sCUzZb
 a9R3QgpkL/WLKw8MQ4fqyXOS08FnaFubzTYoQNzbvzM/qhOOKnTks+jGx7CBSN6Z4Qgf
 4ZiJA/tUpM+uJy2yEqrvtAQaZb0sfM2bRXGJFWv31n3vtgYodEmzfsjYq6DAM6DJ6LJI
 Rj4mP1nRSx+ykW+4N6AK14W1WydsrJR4lUTL+lDfgbBvXetWdGLX306jfGo8VSK5MeNW
 2GsI+cnJqFechvz9J9DLceoK4FzYWVj+DTYApMfHsqg3xPSvoUrSVs62G0a595hWRvmL
 NM1g==
X-Gm-Message-State: AOJu0YycAAb1OvdN3xKtD1XniZt3dXZNnTpACi8pLMpPcHwo2PwwIKWs
 QhRLLRWcTXqXxu38dVBE24CY+gl+2T6bHeDzz9FHXQ==
X-Google-Smtp-Source: AGHT+IGjWj/f6sALpXMjWC7a2dB/1kHSVbziZ4OhK6JmprimGu5onNvRiTcmMgeV4JMjHe94M3lXEg==
X-Received: by 2002:a17:902:d505:b0:1bd:f71c:3af3 with SMTP id
 b5-20020a170902d50500b001bdf71c3af3mr20260210plg.32.1694091860387; 
 Thu, 07 Sep 2023 06:04:20 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:19 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v3 0/5] Support message-based DMA in vfio-user server
Date: Thu,  7 Sep 2023 06:04:05 -0700
Message-Id: <20230907130410.498935-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x632.google.com
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

Note that there is some more work required on top of this series to get
message-based DMA to really work well:

* libvfio-user has a long-standing issue where socket communication gets messed
  up when messages are sent from both ends at the same time. See
  https://github.com/nutanix/libvfio-user/issues/279 for more details. I've
  been engaging there and a fix is in review.

* qemu currently breaks down DMA accesses into chunks of size 8 bytes at
  maximum, each of which will be handled in a separate vfio-user DMA request
  message. This is quite terrible for large DMA accesses, such as when nvme
  reads and writes page-sized blocks for example. Thus, I would like to improve
  qemu to be able to perform larger accesses, at least for indirect memory
  regions. I have something working locally, but since this will likely result
  in more involved surgery and discussion, I am leaving this to be addressed in
  a separate patch.

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

Mattias Nissler (5):
  softmmu: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     |  88 +++++++++++++++++--
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  39 ++++++++-
 include/hw/pci/pci_device.h   |   3 +
 softmmu/dma-helpers.c         |   4 +-
 softmmu/memory.c              |   4 +
 softmmu/physmem.c             | 155 ++++++++++++++++++----------------
 subprojects/libvfio-user.wrap |   2 +-
 10 files changed, 220 insertions(+), 87 deletions(-)

-- 
2.34.1


