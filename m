Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0047359A8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFte-00024v-CP; Mon, 19 Jun 2023 10:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFss-0000ee-LJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0002Gs-BP
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f90b8acefeso15542395e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184969; x=1689776969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NI6UwYNEBMwFDagdkUVm7AUEy/k4n7TnuACIpknFIYg=;
 b=sp70xA4RWw5A6piT8JSXreZF6x7BoillK9qDflhBejeIebW+SWvMNpk1uCwxfNbZam
 1j8Gi4ctBF1PF2wJYpRQx4hXekKWxz+7Q2WiqDPbaddzcW7sHP3/IgLn4nq0H4/Cu91M
 DjxwHsoRVTkL0hOEwHnhU2l7S4YVmyrRHC7JYgwj4jDBZ9xYgwbaOMJwRgQ4/t4pOYOb
 Ukl1q6YBqzs5j8l+FjHlfTSFw7R8iXXTQ06piVwWTqLI9X4f5LEUj6662tbNicaHb8YL
 ePk3/F039k12wNj4iNCcBNU++SLtF7O4QQsNlKx4Jvfv9EGsh+469TA7rZ4f5YppMw/S
 DCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184969; x=1689776969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NI6UwYNEBMwFDagdkUVm7AUEy/k4n7TnuACIpknFIYg=;
 b=chl4X45QE+p2aq5Gtg6EnRyFr9aVybYIOKRsaVtpEmFfup5cd4s5ae2LFPLlbWWH1W
 nQ4LuwbM4EH1/BEQlNKYafuRuscx9nv8Nbi/fGNNvGD/hkjOPnfivzZItH417vgQJQOR
 ViSSgD2DaOAwZuGo0yelGxGHjLnN2VjlC6jnTi3uFlABkFimApsfNGfGqIhC20UY36Qp
 IbcC1c9r7wn8MrGq00rf0aKkWbIWKdHeKfHpInSue7YQvwMdp5Ud9qGOD+e/rBH2xiG0
 zwXNEUS//KlBGfQ5rjmPvBj6etkDsurcWtrmTAtFN1FTAXJKd3iShoMF3HE3xrVedTsz
 8Vpg==
X-Gm-Message-State: AC+VfDztpar/aH3M+WGSQ4LAW9R5YAzegNIUh0C6T4KduG0BQ+y5kNHD
 2XFvb/boP763zcWbINM5+3g0Yz5qsjq0E81h4rM=
X-Google-Smtp-Source: ACHHUZ4uR6zDvnEjZDitR8995SosALGXNHWSCkmh+SCftWScnYjSsHeywI9AmpeqT3fmwYexJO6mcA==
X-Received: by 2002:a1c:7904:0:b0:3f9:5db4:e8d8 with SMTP id
 l4-20020a1c7904000000b003f95db4e8d8mr2706758wme.18.1687184969307; 
 Mon, 19 Jun 2023 07:29:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] docs: sbsa: document board to firmware interface
Date: Mon, 19 Jun 2023 15:29:10 +0100
Message-Id: <20230619142914.963184-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

We plan to add more hardware information into DeviceTree to limit amount
of hardcoded values in firmware.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20230531171834.236569-1-marcin.juszkiewicz@linaro.org
[PMM: fix format nits, add text about platform version fields from
 a comment in the C source file]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index 016776aed82..f571fe645e7 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -6,12 +6,7 @@ any real hardware the ``sbsa-ref`` board intends to look like real
 hardware. The `Server Base System Architecture
 <https://developer.arm.com/documentation/den0029/latest>`_ defines a
 minimum base line of hardware support and importantly how the firmware
-reports that to any operating system. It is a static system that
-reports a very minimal DT to the firmware for non-discoverable
-information about components affected by the qemu command line (i.e.
-cpus and memory). As a result it must have a firmware specifically
-built to expect a certain hardware layout (as you would in a real
-machine).
+reports that to any operating system.
 
 It is intended to be a machine for developing firmware and testing
 standards compliance with operating systems.
@@ -19,7 +14,7 @@ standards compliance with operating systems.
 Supported devices
 """""""""""""""""
 
-The sbsa-ref board supports:
+The ``sbsa-ref`` board supports:
 
   - A configurable number of AArch64 CPUs
   - GIC version 3
@@ -30,3 +25,32 @@ The sbsa-ref board supports:
   - Bochs display adapter on PCIe bus
   - A generic SBSA watchdog device
 
+
+Board to firmware interface
+"""""""""""""""""""""""""""
+
+``sbsa-ref`` is a static system that reports a very minimal devicetree to the
+firmware for non-discoverable information about system components. This
+includes both internal hardware and parts affected by the qemu command line
+(i.e. CPUs and memory). As a result it must have a firmware specifically built
+to expect a certain hardware layout (as you would in a real machine).
+
+DeviceTree information
+''''''''''''''''''''''
+
+The devicetree provided by the board model to the firmware is not intended
+to be a complete compliant DT. It currently reports:
+
+   - CPUs
+   - memory
+   - platform version
+   - GIC addresses
+
+The platform version is only for informing platform firmware about
+what kind of ``sbsa-ref`` board it is running on. It is neither
+a QEMU versioned machine type nor a reflection of the level of the
+SBSA/SystemReady SR support provided.
+
+The ``machine-version-major`` value is updated when changes breaking
+fw compatibility are introduced. The ``machine-version-minor`` value
+is updated when features are added that don't break fw compatibility.
-- 
2.34.1


