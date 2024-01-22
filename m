Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AA2836594
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:38:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvOv-0006Rf-N8; Mon, 22 Jan 2024 09:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOs-0006OC-36
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRvOo-0003Zv-St
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:35:45 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40ea5653f6bso25560665e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705934139; x=1706538939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf0m1wyMlr7cRTuzG2EUgLd0A0rBjsSs6MaGJHgZJIU=;
 b=s4rQMHhRMd1CgM93Icgh2ZujbhE4igpyF6r11+Aax3kPqg0sfmixKTApnErNRYqhhZ
 5XJDSc4ixMGnkeRSxbxfXXfgb9jesHMmdPiw0BA7gMIYwklRFJ7Aak3jh1DoqNN19MAm
 r1Ey76JhWLt0CcO9bw3y+uWCFNBd+pXNg1+6ugdxMUvNH0Q4fenpJsgo2V/ncBLyBfdY
 Ws6J804oY15COHG+4Xja6Yb5MOPO3HFGDvY9tcH/lJ8RnYPeCTfdv4YP6l2Sr199fyKY
 5kLPJxL+rioEQLL+gcRPgWYwAsqjeODAzvavSs5NPCBkKbN89DU5BK/fQb93oBHR9pLW
 UiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934139; x=1706538939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf0m1wyMlr7cRTuzG2EUgLd0A0rBjsSs6MaGJHgZJIU=;
 b=lCg5KTG92Yjib3gBIwJ+/mKfZmPxFashfNFb17ZFrLzs7Nm0h86yWUXQ/ZzRmNADZE
 F4J9zrd/8cD7LAoJhBHS0quSobuEeyQoKiFG5OvBP1+8MneF/08jUnEpCJnmlsrk3iAM
 HkCyckHM78C4flnahIaqpIkc8mJKyNkPNPUKrg1hexaKY/0vc6Ws0OEvoWC5R4gsLH4a
 3oN3RDcL3INpEjyR5nYLiNzmfA67kDUwO6EKXwhzaGeQLnxQaTRCAyEby33Y8eXa83Cp
 uKHa5s7VzsiS7wb30iVRSHA70PaWfsFt8yf0o/rDqT+gNN4jDa2Hho8MQms/VnFuKn30
 RxkA==
X-Gm-Message-State: AOJu0Yzmkno9tt2KadtPewB7Bd2zIkgXbH9DzBaVLw7gS3T2mDgyfPcx
 hMrgPNpfiUw/Q985ilc8ow69qR/+SoWzJQ1WaZUebs1jM/CgSvaQxoP6jdpv0XQ=
X-Google-Smtp-Source: AGHT+IF8sdG0+dctXBnw3tmaMBDFzj8AB+Ey0OiCFKkZ+u5TmYWSDPKY6dDH++s6ytwkf82PKzlrJw==
X-Received: by 2002:a05:600c:3c93:b0:40e:596a:9850 with SMTP id
 bg19-20020a05600c3c9300b0040e596a9850mr2217878wmb.240.1705934138939; 
 Mon, 22 Jan 2024 06:35:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm39559584wmb.41.2024.01.22.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:35:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 0/3] virt: wire up NS EL2 virtual timer IRQ
Date: Mon, 22 Jan 2024 14:35:34 +0000
Message-Id: <20240122143537.233498-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patchset wires up the NS EL2 virtual timer IRQ on the virt
board, similarly to what commit 058262e0a8b2 did for the sbsa-ref board.

Version 1 was an RFC patchset, originally sent back in autumn:
https://patchew.org/QEMU/20230919101240.2569334-1-peter.maydell@linaro.org/
The main reason for it being an RFC is that the change, while correct,
triggers a bug in EDK2 guest firmware that makes EDK2 assert on bootup.
Since the RFC, we've upgraded our in-tree version of the EDK2 binaries
to a version that has the fix for that bug, so I think the QEMU side of
these patches is ready to go in now.

To accommodate users who might still be using older EDK2 binaries,
we only expose the IRQ in the DTB and ACPI tables for virt-9.0 and
later machine types.

If you see in the guest:
     ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48

then your options are:
 * update your EDK2 binaries to edk2-stable202311 or newer
 * use the 'virt-8.2' versioned machine type
 * not use 'virtualization=on'
                   
I'll put something about this into the release notes when this
goes into git. (There are other reasons why you probably want a
newer EDK2 for AArch64 guests, so this is worth flagging up to our
downstream distros who don't take our pre-built firmware binaries.)

changes v1->v2:
 * the change in DTB and ACPI tables is now tied to the machine version
 * handle change of the ARCH_TIMER_*_IRQ values from PPI numbers to INTIDs
 * bump the FADT header to indicate ACPI v6.3, since we might be using
   a 6.3 feature in the GTDT
 * the avocado tests now all pass, because we have updated our copy
   of EDK2 in pc-bios/ to a version which has the fix for the bug
   which would otherwise cause it to assert on bootup
 * patch 2 commit message improved to give details of the EDK2 assert and
   state the options for dealing with it (this will also go into the
   QEMU release notes)

thanks
-- PMM

Peter Maydell (3):
  tests/qtest/bios-tables-test: Allow changes to virt GTDT
  hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
  tests/qtest/bios-tables-tests: Update virt golden reference

 include/hw/arm/virt.h     |   2 ++
 hw/arm/virt-acpi-build.c  |  20 +++++++++----
 hw/arm/virt.c             |  60 ++++++++++++++++++++++++++++++++------
 tests/data/acpi/virt/FACP | Bin 276 -> 276 bytes
 tests/data/acpi/virt/GTDT | Bin 96 -> 104 bytes
 5 files changed, 67 insertions(+), 15 deletions(-)

-- 
2.34.1


