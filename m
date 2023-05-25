Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1E710E3F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bku-0004Wx-VZ; Thu, 25 May 2023 10:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkk-0004N1-Ha
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkh-0007WZ-Hh
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5drnXA6SgUQJDXAu28pcFqA5t2u0OhlFOz64eCdeV1Q=;
 b=TM0VKw3SxiS7ZDLXDYNASJ3afwIHRIVLUHWRWjCe7322IzdZZEdMzR+2inCqzk6J4XU9S4
 OyFoa7gTaXHQ84t6kdGITmdr0Jz+5bajeWUUqxMavWM9Vr9xOEh4aEay01duuDb7E3qVb7
 vwaAbjokTLhpwg4/vkYk9W2O3HsJHbk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-kO9w2wqSNgySFdehLEnmIA-1; Thu, 25 May 2023 10:15:36 -0400
X-MC-Unique: kO9w2wqSNgySFdehLEnmIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so68417466b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024134; x=1687616134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5drnXA6SgUQJDXAu28pcFqA5t2u0OhlFOz64eCdeV1Q=;
 b=NJFNcYd7n+uE4bFwnL75tJ8YjLuCC8iTEAyUviLis9gTdwZC3/gDzbMLD2zuIC3zdl
 WzgHUpHZNR38zdB8Ca51c4ddsyv0ymYTvKr/wRhAfgqTKwuQbfUc0UQKfQdQfXMAsX0/
 e8SYqpRuYRtxdYGEmmZWaNCzPLHdLhEU/ENkaqNu5jD4Lcnzt4opLiIGtkCF1YwGUf9C
 SegnzgrzZlb58U35AOj7XigVWBea8Ks2AL+XeX6z5reLqZbhuV5+sVjy/ab1EsM3coAU
 QHO73RrzdOoDGM92AH2u4SRvW+C4YcMgf/8ZyU/wh/OyIQNHgXh8fiSKz5YH+RkTCs56
 3X6Q==
X-Gm-Message-State: AC+VfDznyc1cJ9ed6U8JBuqebNM93KshaDBOjBRI1OPhF41yBo+7rYpl
 PiPz2lhEOK5gk6K78jIF9i2W/hqBtt6QcxYqWnRx+je0hrnphXCz86eLziZe2c3m9rkF1y7JPfW
 rc2Fth1WkSHbzFOa+RTygTwQc2tQkC5SUX2YQP0v0yyiyyAEIMUPwb1kG0Hmtw1j9aIRKgbOxZR
 Y=
X-Received: by 2002:a17:907:a0a:b0:96f:d67b:80af with SMTP id
 bb10-20020a1709070a0a00b0096fd67b80afmr1858904ejc.75.1685024133738; 
 Thu, 25 May 2023 07:15:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59/KhNyIbNHSdTT7FtDEnLKZR0359QC/kO1iu/9+t+oH0kdv4/NswimkRI6TxZK1F1YO9qBQ==
X-Received: by 2002:a17:907:a0a:b0:96f:d67b:80af with SMTP id
 bb10-20020a1709070a0a00b0096fd67b80afmr1858864ejc.75.1685024133232; 
 Thu, 25 May 2023 07:15:33 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 bh1-20020a170906a0c100b0094f44bdf7acsm906037ejb.57.2023.05.25.07.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] Misc patches for 2023-05-25
Date: Thu, 25 May 2023 16:15:12 +0200
Message-Id: <20230525141532.295817-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:

  Merge tag 'pull-qapi-2023-05-17-v2' of https://repo.or.cz/qemu/armbru into staging (2023-05-22 15:54:21 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to cd9b15bb62e4c422c3ed5fd69c613ecd5409838e:

  monitor: do not use mb_read/mb_set (2023-05-25 15:40:13 +0200)

----------------------------------------------------------------
* hot-unplug fixes for ioport
* purge qatomic_mb_read/set from monitor
* build system fixes and cleanups
* OHCI fix from gitlab
* provide EPYC-Rome CPU model not susceptible to XSAVES erratum

----------------------------------------------------------------
Maksim Davydov (1):
      target/i386: EPYC-Rome model without XSAVES

Mark Cave-Ayland (3):
      softmmu/ioport.c: allocate MemoryRegionPortioList ports on the heap
      softmmu/ioport.c: QOMify MemoryRegionPortioList
      softmmu/ioport.c: make MemoryRegionPortioList owner of portio_list MemoryRegions

Nicolas Saenz Julienne (1):
      meson.build: Fix glib -Wno-unused-function workaround

Paolo Bonzini (15):
      meson: fix rule for qemu-ga installer
      meson: move -no-pie from linker to compiler
      tests/docker: simplify HOST_ARCH definition
      tests/vm: fix and simplify HOST_ARCH definition
      Makefile: remove $(TESTS_PYTHON)
      usb/ohci: Set pad to 0 after frame update
      monitor: use QEMU_LOCK_GUARD a bit more
      monitor: allow calling monitor_resume under mon_lock
      monitor: add more *_locked() functions
      monitor: do not use mb_read/mb_set for suspend_cnt
      monitor: cleanup detection of qmp_dispatcher_co shutting down
      monitor: cleanup fetching of QMP requests
      monitor: introduce qmp_dispatcher_co_wake
      monitor: extract request dequeuing to a new function
      monitor: do not use mb_read/mb_set

 hw/usb/hcd-ohci.c             |   2 +
 include/monitor/monitor.h     |   3 ++
 meson.build                   |  21 +++++---
 monitor/hmp.c                 |  41 ++++++++--------
 monitor/monitor-internal.h    |   5 +-
 monitor/monitor.c             |  72 ++++++++++++----------------
 monitor/qmp.c                 | 108 +++++++++++++++++++++++++++---------------
 qga/meson.build               |   2 +-
 softmmu/ioport.c              |  61 +++++++++++++++++++++---
 target/i386/cpu.c             |  10 ++++
 tests/Makefile.include        |   8 ++--
 tests/docker/Makefile.include |   2 +-
 tests/qemu-iotests/051.out    |   4 +-
 tests/qemu-iotests/051.pc.out |  20 ++++----
 tests/vm/Makefile.include     |   7 ++-
 15 files changed, 225 insertions(+), 141 deletions(-)
-- 
2.40.1


