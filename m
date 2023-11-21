Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 491877F351A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UkB-00089O-NH; Tue, 21 Nov 2023 12:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Uk9-00089A-H4
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Uk4-0001E3-Mp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:41:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613275so28131065e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588454; x=1701193254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EutcA51RqVFyXtH7f/WztnVV0z6x12+sZUDLWJ2Quqg=;
 b=rPOqS4TIA11770AsIsBdP1JI81IfRNKAnOp6eJvOf9XFbY9qhMGeZCNyLMubvIEOtE
 jRRYkoebPUsWPr98Fc9qKqkcFyR51o281zS81brG5gY89FjV4n+pozs78prr9VgoSB3H
 TCynersamvS12DprhiO5zLYJWtCusPP8BxOt2H0n1+avkIkxEdhD0sv+Xade+QzcMw5K
 ybErUXcxC1lIfN3d5w5Phptqokfgf3A/lF2LHPGnlxpkgS858By6y4ZW3MVaTJo1ckDb
 OjVh5M1Qpf+hxFWwsHa+5fZ1gKuqV798iPSMDNn/bxp4VQl5zQ6DaCpTYZNXAe0P/MhW
 1HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588454; x=1701193254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EutcA51RqVFyXtH7f/WztnVV0z6x12+sZUDLWJ2Quqg=;
 b=iAWh8hj+bJ2Hahc6Zf9R+691+oxQE8JUDCNsRMrxDqjk4yNh6MXwo2MeSpc2pB58cD
 b+o6fcxjt70AMon92KwOqH1/64W2JQDpkGmtCk78t0q+psXoBeeSmlOE3JsIHrvfegff
 SsaTyWmZODWMFGWkIox9md2t/nKdW3aMuEB4FRqp/qyBnvalS65OKTCugoD+NNYtAsOJ
 qKJxWwXWDxCBrZvf2BZQdwZbPKRnOLcxXw9gwNQjna3B4vQlQ25uwy5CTakavGO7i7v7
 ww8oUrf7c3Im75ZWG1z5KjgFYqWxGqJ9/rFafslw90vVCwUePDOYpkodlzVjrUPa1YhM
 oGpg==
X-Gm-Message-State: AOJu0Yyw9MhLfn2kU0zFVjv2gITRKZslIqsIshmiT9NBuFV7K2i1DdNU
 PxZwzwCPpHtn/zyFq0Ob+tMOY18HmvDSW+l+8ug=
X-Google-Smtp-Source: AGHT+IGJnw7lIpclQYprV+I3XlQVtk018K43wW4W0oyES37jxFEmnRZJq+kchPSt+zIHHyyHlWp9Wg==
X-Received: by 2002:a05:600c:3151:b0:405:34e4:14e3 with SMTP id
 h17-20020a05600c315100b0040534e414e3mr50463wmo.3.1700588454655; 
 Tue, 21 Nov 2023 09:40:54 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c190700b004064cd71aa8sm17931909wmq.34.2023.11.21.09.40.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Nov 2023 09:40:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 0/6] hw: Free DEFINE_PROP_ARRAY()'s arrays in
 instance_finalize()
Date: Tue, 21 Nov 2023 18:40:45 +0100
Message-ID: <20231121174051.63038-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In few places we forget to free the array allocated by the
DEFINE_PROP_ARRAY() macro handlers. Fix that.

Philippe Mathieu-Daudé (6):
  hw/virtio: Add VirtioPCIDeviceTypeInfo::instance_finalize field
  hw/virtio: Free VirtIOIOMMUPCI::vdev.reserved_regions[] on finalize()
  hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on finalize()
  hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on finalize()
  hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[] "pg0-lock" array
  hw/input/stellaris_gamepad: Free StellarisGamepad::keycodes[] array

 include/hw/virtio/virtio-pci.h    | 1 +
 hw/input/stellaris_gamepad.c      | 8 ++++++++
 hw/misc/mps2-scc.c                | 8 ++++++++
 hw/nvram/xlnx-efuse.c             | 8 ++++++++
 hw/nvram/xlnx-versal-efuse-ctrl.c | 8 ++++++++
 hw/virtio/virtio-iommu-pci.c      | 8 ++++++++
 hw/virtio/virtio-pci.c            | 1 +
 7 files changed, 42 insertions(+)

-- 
2.41.0


