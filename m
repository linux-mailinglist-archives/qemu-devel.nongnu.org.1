Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B1C0ECA3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 16:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOm5-0007X2-AC; Mon, 27 Oct 2025 11:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOlx-0007Vo-2M
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:04:38 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOlr-0002hO-OT
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:04:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso13125395e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761577463; x=1762182263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aD2sMtX6YVLwVzBVDv2pc4h1OiBzvGxiRIpUw8HWTDA=;
 b=bcZFVGZB8AYnEq7B8xgF8Fxy3afMZudlD5UF5cXADkOTWDK/ZWRPBch4IIxKK+8TEh
 aeDuIK5bAnujwGTqAYf4wiAfqcs+NsM010JaL+lF+X87ygnRsUOZXekPfu1J69QcVtkI
 bojIX+YM5D5rMEYqKWRKpXk/yyNMAJl55gTunojJvMqUvhAd1RR99ywQTf8A/LGyMt91
 +r5u2xHuLVmOzchKDfg80AjaY/kj9ErdvVbvwcq2zaeM9mFzvOcdqsTTkBEqGwqKn1Fg
 rTTNk+aJgXriL1qMs25jMmINimgDSEqGvwbXP/uJ47TBsLiIO+x6I1EvQoMc/z4mqd0W
 0dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761577463; x=1762182263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aD2sMtX6YVLwVzBVDv2pc4h1OiBzvGxiRIpUw8HWTDA=;
 b=XlqEL6M4lfRH3V9P9P8PjXK+SwDcqcjNOpErXiZ//BHjQFpo9QW3brTJTrmxuuHKVc
 OeGgz7POY7czx8Cwpxm4zyje5psBTvSIM6MqPxTwW5bDWXdfOjZK+I25q8NxrmsjvK04
 zij65ZM/xOwTX4H2iT2XzI/uWBnNKXVyrI8wkyf+Gv2vSsZaPfJAeKWV0ISVzVL1rA9g
 CjcoQjLqVvJ1128TVAlaamjuc7JD9V9ZJqOXkzwuZWznPyOu4r5Ut/N15SRcLo5edELa
 ZlOFcR6Z/ZnHEWVn47+OXRh6BO4wxBRDulJtmCvmp8rx1gCWagbKZAV5Cja1vlwtvsxK
 VZwA==
X-Gm-Message-State: AOJu0Yz2MRQK9pHrHqXuphqbUpy7clB7ugwOuEKkpLQ7KE0xVjktLVRf
 QAqdzYH9tlSuN6mkdNQuA9eJG7dRwMydZaeuiWg7Bm+ULkQghr00fcID1bpHD6CgVXchgS2uYxq
 kFnju
X-Gm-Gg: ASbGncu0oKR+aRdQelCWlp6/Z/prjOaDifvIek7dI4LtIIg7BqOSfYgCQfNAT45EfyC
 BLN/ZlJWHKxQW7kLS8rI8bfchBQUVrtERR0R4eeO2K7C4Tpn/9/Hh10o7ifQJHjs1XwUWwpUJ27
 9sRHIeba4JIKT3mOJHh6OSdoBGba0BKyCTjB4vi55awZoP+jaVrjfQ9s8EUlJSz0AnYg2yfhJo6
 yacplU5zM1UxlSGzEvkb6p3Woz7vUwIPWCRwuBcHENXNyq3f9W9LnzkdIBP33gk66XgygjDN/kx
 twMbd8QAfjVX5bV75H4dCVI7UgM65xtsMGhTvD+W7sLVX+0A+JAJoADqAjbEi5r91k+dwM80pRl
 Sp3JT6rJE4wSBcA1AX8eUMNptF1IsPN4eUfKg0A7HpFb/rX3BndM2Bgkuw4X/+3sS/BzFIa9tyG
 Jtd2Afgg==
X-Google-Smtp-Source: AGHT+IGctE/iEVGkezHrClG9/ap3mI1hSyHynqCScnHoyOi1s9wMMOq7sIJVhFx9Q2VCqxQVbzU4zw==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id
 5b1f17b1804b1-47117876a19mr318439035e9.6.1761577463570; 
 Mon, 27 Oct 2025 08:04:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dcff7569sm71653245e9.1.2025.10.27.08.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 08:04:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] docs/system/sriov.rst: Fix typo in title
Date: Mon, 27 Oct 2025 15:04:20 +0000
Message-ID: <20251027150420.2762687-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Fix a typo in the title of the sriov.rst document.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/sriov.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
index d12178f3c31..b19e787339b 100644
--- a/docs/system/sriov.rst
+++ b/docs/system/sriov.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-Compsable SR-IOV device
-=======================
+Composable SR-IOV device
+========================
 
 SR-IOV (Single Root I/O Virtualization) is an optional extended capability of a
 PCI Express device. It allows a single physical function (PF) to appear as
-- 
2.43.0


