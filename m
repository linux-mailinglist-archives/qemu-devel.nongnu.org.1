Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD681CAE3
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqv-0007fj-FM; Fri, 22 Dec 2023 08:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqV-0007Rz-W7
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:50 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqT-0004G5-3R
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:47 -0500
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-40d4a7f0d17so1759065e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252739; x=1703857539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMj5v2gUy0SwBnfzHe5Ktn8uC+1u4B1rDW8Nfib3Kyc=;
 b=A/bHdx4fY4FXg5N7NvTpbKokOxepiWXPYfr6hPOHjuIKiqzYVUdawm4qK/vE9h4zVh
 JCcBXtoNe/o5JuQtsBBX2mfLNIpqecxTWmZ+18hDbJdAX1e3ilIBHnZUUSlm74X0MDxT
 9uPlKthz1CXi3uqRGLgC1A8ZVWMkhEW0s/HlssblTxPtbNICxXJ/8BW5m24vrmJY3JNu
 knjPdz+o4pW22AxxOUX1rs7y4LHh2yJp1FbhxC1K3JaBAdzxxDifmPAbOJkxbLjzumBD
 dO8Ru2T0+mWFpf0ueZYRFb0esX2rQSMRwn476+8CAXAw0WEje8Q+vmBcjZFaJ3vrxDnB
 IYuA==
X-Gm-Message-State: AOJu0YxwNoGmiiKMKRq0SCKClSxE3B60MQo6CdVDQor/wDFxKw4EOFIj
 I451gxl2ayIpBc5xz/3CkVnHKxpV5dE=
X-Google-Smtp-Source: AGHT+IFnESHcXfLGzuJIyEmgHbN8TGKjYpHZ1WDjm6A3Q9XVuE/m0AZ/dOqrEXaTSPQH4s0gh/1PCw==
X-Received: by 2002:a1c:7209:0:b0:40c:3aae:676 with SMTP id
 n9-20020a1c7209000000b0040c3aae0676mr657527wmc.119.1703252738848; 
 Fri, 22 Dec 2023 05:45:38 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:34 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 00/11] m68k next-cube patches
Date: Fri, 22 Dec 2023 14:45:16 +0100
Message-ID: <20231222134527.15705-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.47; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f47.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

  https://gitlab.com/huth/qemu.git tags/m68k-pull-2023-12-22

for you to fetch changes up to 0d23b1ef85eb7a5ed7363da439de632783dbb37e:

  next-cube.c: move machine MemoryRegions into NeXTState (2023-12-22 14:08:26 +0100)

----------------------------------------------------------------
* Add dummy next-cube ethernet register to allow diagnostic to timeout
* Don't pulse next-cube SCSI DMA IRQ upon reception of FLUSH command
* Rework next-cube mmio ops and system control register handling functions
* Embed next-cube MemoryRegions into NeXTState

----------------------------------------------------------------
Mark Cave-Ayland (11):
      next-cube.c: add dummy Ethernet register to allow diagnostic to timeout
      next-cube.c: don't pulse SCSI DMA IRQ upon reception of FLUSH command
      next-cube.c: update mmio_ops to properly use modern memory API
      next-cube.c: update scr_ops to properly use modern memory API
      next-cube.c: update and improve dma_ops
      next-cube.c: move static led variable to NeXTPC
      next-cube.c: move static phase variable to NextRtc
      next-cube.c: move static old_scr2 variable to NeXTPC
      next-cube.c: move LED logic to new next_scr2_led_update() function
      next-cube.c: remove val and size arguments from nextscr2_write()
      next-cube.c: move machine MemoryRegions into NeXTState

 hw/m68k/next-cube.c | 525 +++++++++++++++++++++++-----------------------------
 1 file changed, 227 insertions(+), 298 deletions(-)

