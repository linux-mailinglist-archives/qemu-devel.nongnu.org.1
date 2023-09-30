Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5C7B4072
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxb-0007ev-SD; Sat, 30 Sep 2023 09:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxY-0007eP-MV
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:40 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxT-0007eq-OV
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:40 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-9a645e54806so1996655066b.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696080270; x=1696685070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MO04h6rq43VqIPPeoEeCZDzqS9bn+jX8IzZLeinSlns=;
 b=oRo3tpfyYUfpIM2TN7hDmjYjx5xAcLqLgcSq5Ipm2/YNu0Q6IWw31XnsE/R6deW0lm
 XyR8eoCByV6rExDEcqDeCRsBKZKpH4/3+Anb3s+ki7NZkm57C/NSZ6NtN4mzm0jcFZze
 EphsZZ5UpkXhinpGMPLUdYmYNgwDe+fYBSp/qyonjoqHXsJlkUQLfdODbZf+8sfoGvg5
 j//pXGww1lE3EWFqsKZE7BD/mNKdNgQJOxJUn9HtVhzgrU0e+tvx8h4NCgoGQRdMQP6J
 LFIo/2g+DhHVm8i60VceGv2RWSuNj7b9ah5YOLSAoD2W193R8OCpfrUiifew/1qtvHhH
 M+vg==
X-Gm-Message-State: AOJu0YyXh8vQkXObJgB/kBMGeZx5gbc0sFOZV7Hr6qblYTPjlClyw3QY
 mBDJYJDwIBFYm+0BoH+J3OA4bEr3ysw=
X-Google-Smtp-Source: AGHT+IEP76lswC/PSa3RRLwhhK5+BAySUTCbuUUi8ONwyIA520yu43xB78p8J2cNduilnRuoMcu1jQ==
X-Received: by 2002:a17:906:783:b0:9ae:5fe1:ef00 with SMTP id
 l3-20020a170906078300b009ae5fe1ef00mr5543145ejc.45.1696080269698; 
 Sat, 30 Sep 2023 06:24:29 -0700 (PDT)
Received: from fedora.. (ip-109-43-177-123.web.vodafone.de. [109.43.177.123])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906944f00b00993928e4d1bsm13919471ejx.24.2023.09.30.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 06:24:29 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/5] m68k: Instantiate ESP and next-net in the next-cube
 machine
Date: Sat, 30 Sep 2023 15:23:46 +0200
Message-ID: <20230930132351.30282-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.708, SPF_HELO_NONE=0.001,
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

Mark Cave-Ayland recently asked me about the ESP patches for the
next-cube machine that I once posted a long time ago, but never
got it merged (since Mark is currently working on improving the
ESP device). With his help, I dusted off the ESP patch, but we
had to discover that the firmware also wants to see the NIC
device in the MMIO region, otherwise it often crashes or hangs.
So here's now the current set of patches for the next-cube machine.
Both, the ESP SCSI controller and the NIC do not properly work
yet, but at least the next-cube firmware gets much further now
during it selftest, so I think this is a good base for future
work and experiments.

Thomas Huth (5):
  hw/m68k/next-cube: Mirror BIOS to address 0
  hw/scsi/esp: Work around problem with PIO data read for the NeXT-Cube
    machine
  m68k: Instantiate the ESP SCSI controller for the NeXTcube machine
  hw/m68k/next-cube: Remove unused NEXTDMA_EN code
  m68k: Add NeXTcube network controller

 hw/m68k/next-cube.c         | 194 +++++++++----
 hw/net/meson.build          |   1 +
 hw/net/next-net.c           | 538 ++++++++++++++++++++++++++++++++++++
 hw/scsi/esp.c               |   2 +-
 include/hw/m68k/next-cube.h |  10 +
 5 files changed, 692 insertions(+), 53 deletions(-)
 create mode 100644 hw/net/next-net.c

-- 
2.41.0


