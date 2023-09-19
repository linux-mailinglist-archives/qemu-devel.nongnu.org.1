Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0E7A689C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidHW-0001ox-PD; Tue, 19 Sep 2023 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHL-0001nH-QQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:47 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHG-0004gC-Ke
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c43166b7e5so40513175ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695139720; x=1695744520;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p6Dfw5nXdG1KaTAXJxxWtlHGXg9g55Oz1nL1iQCVLII=;
 b=sj2H+zCB7SN6usjCUb8N15cuPmpI5tA8/ows9Q0dH+tXzunkV0xcwOZKv0PAc1U4ay
 JTwPaQYqEx2dGNeBlQ1aKddMj+xWvgVeRbL0mNPx0brzlHkh7l9l7N73JXbWuTtruXEu
 j9zTAH0+0znkBrnIeGosIK5QHepllty8zwxfPuW7F3TQ+hbHrGtvL36xvNNWq9NCDou9
 tV3Xh4L/+8FH5KTjjOKXlltLUA76HO3VlwNzgFoCFqfYrGi8q5un2CM4h86SkReYOfZ4
 aDAFapOHTbr0tdZQLbDNwFu6Ak/q/huv52EocKtYzEro50JxGtSLxCf1QRO7XHGkbOXa
 sTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139720; x=1695744520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6Dfw5nXdG1KaTAXJxxWtlHGXg9g55Oz1nL1iQCVLII=;
 b=NBfe4P6I49Ijssf1CuHz3Wj5uhEErOicHrhbO+nt/T9sYymD0pqA6UXYTIKQyC39zS
 xrtpCfpJ9a9aLvfRf6WXMh+1juoX+tvvriNZ7m0d337Y6bJ/+FkGe4l5g3dWEfL0Tw1F
 oTjdMs1KLcXIJUeH0mlvVN3jjESf/3PpVQ1yy+LUCF9+ca9hiruI4cxkXJ0lseFNfiyz
 R2M2BhUCHNXaLhsc7FX/qgI05esR8r9y9lBhSRLf3aIJrR7Pe1V9nJYIsSVS5sf4xLKo
 tTyKPTSizeBM9NPshtfvxvb1qkmlt2+x3QP3C8Dr6aLC8Xa4rHspc+Pj36mDQq9wQ+Yl
 Glww==
X-Gm-Message-State: AOJu0YyymSTlcSbrJQ5/4o7QvBWvU2h+ThE6fLMFjMIqUGF6dUEjyRzl
 wcNxECmVg/57wpsSDaDCO9eCS31bzBaIIc8yPFA=
X-Google-Smtp-Source: AGHT+IETLhW1Fut5+eOnAyzrkY4B7disx5+mUBEQ1iT4KmnIaU8GOIdRWkfJGRfl1A+3Q1Af6x2c2w==
X-Received: by 2002:a17:902:9684:b0:1b8:8af0:416f with SMTP id
 n4-20020a170902968400b001b88af0416fmr11306642plp.1.1695139720283; 
 Tue, 19 Sep 2023 09:08:40 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001b8a1a25e6asm8086308plk.128.2023.09.19.09.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:08:39 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v4 0/5] Support message-based DMA in vfio-user server
Date: Tue, 19 Sep 2023 09:08:08 -0700
Message-Id: <20230919160814.3343727-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62c.google.com
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

Mattias Nissler (5):
  softmmu: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     |  88 ++++++++++++++++++--
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  41 +++++++++-
 include/hw/pci/pci_device.h   |   3 +
 softmmu/dma-helpers.c         |   4 +-
 softmmu/memory.c              |   8 ++
 softmmu/physmem.c             | 149 ++++++++++++++++++----------------
 subprojects/libvfio-user.wrap |   2 +-
 10 files changed, 221 insertions(+), 86 deletions(-)

-- 
2.34.1


