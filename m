Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF97853FE
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkB9-000537-HF; Wed, 23 Aug 2023 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB6-0004xc-Q4
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB4-0006YF-W4
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a68d23f51so1688541b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782965; x=1693387765; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uO1W2dHGD6sHE/KMmXIEouDaKZk6Dh4aLT0Yhz5H8HM=;
 b=lqNvYEVumTf4nkNS/xvuKzHq/lS/dfMVmG7dccS+E4TCvW9BH8llISaF4yBvas5InE
 f6VLSE9/QWqY6FM6+wfQ+wbWr/5WVRvR3Kou3vEEOOzuaBxUzsdcozr+mYN5c7yiK6mH
 S4ncqRr4dhNpGzUKO/oPNt7otj+8eGueYQnD4MrIpPq2DhfeEQyxgE6fWvDo+Ba9boLn
 ZdnLTiNojTZjTmCvVOxAwVl35fgc6oO49Zl5UZQIu+NIGQpsD0nT80l1SdroTYJ1xOm3
 ww9JK+xjFGALv07X2i8kjOWgRuX86AQjuukjfNv9NnZWYtOxdG5TmumKf2l21hb6aY7M
 0fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782965; x=1693387765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uO1W2dHGD6sHE/KMmXIEouDaKZk6Dh4aLT0Yhz5H8HM=;
 b=V4BMs0HZ2iB0GF+hDSNGajHSLLsf6l538943rAwmyfr3nVzYWNBGfeL8b3oWMak6a5
 k9RgkdliiEWZcmapMOhSeZm1V4x2wXQh4YFbw7GkR1WXL0IqmrLwOJFOAp7pFaT7+fzO
 jkdZIsvFnzud9qf+5FC4mi8egWCvnEnYq7mJ8VUs2oBx2vp/op0F0qx7SwGjU6AePr9V
 iSn+FKQewE+xyjn9bh+wrUIDxKxLj9s9dwSXzcZaEwQ2HTRf7FhVHg3c0inBItcSxUzZ
 njrl+YhYpCcKGp9ebvAxUDcuZsW9bu0Tvo9aYLpc2nOSGP8Am0pAILGURYTVjzOOFBuO
 pWtA==
X-Gm-Message-State: AOJu0Yy+2MBm6pcsH4DjApJf1ksZ97PIypGLZ/hramxJH+3dFwjDAeeG
 EtRjFVfVsyqwSYdSFY5O+1nzkLZOqpBcEwsHBvU=
X-Google-Smtp-Source: AGHT+IGbVxEENFh+eGiy5AanNpxGEBr1eQ5vqykW3VaMeVt+4SDAOhtpfS3dQgwGZwB3wz+on3QNdg==
X-Received: by 2002:a05:6a00:2303:b0:689:efec:fc76 with SMTP id
 h3-20020a056a00230300b00689efecfc76mr14298644pfh.18.1692782965096; 
 Wed, 23 Aug 2023 02:29:25 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm1169462pfd.163.2023.08.23.02.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:29:24 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v2 0/4] Support message-based DMA in vfio-user server
Date: Wed, 23 Aug 2023 02:29:01 -0700
Message-Id: <20230823092905.2259418-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x431.google.com
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

Mattias Nissler (4):
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/remote/trace-events        |  2 +
 hw/remote/vfio-user-obj.c     | 88 +++++++++++++++++++++++++++++++----
 include/sysemu/sysemu.h       |  2 +
 qemu-options.hx               | 27 +++++++++++
 softmmu/globals.c             |  1 +
 softmmu/physmem.c             | 84 ++++++++++++++++++---------------
 softmmu/vl.c                  |  6 +++
 subprojects/libvfio-user.wrap |  2 +-
 8 files changed, 165 insertions(+), 47 deletions(-)

-- 
2.34.1


