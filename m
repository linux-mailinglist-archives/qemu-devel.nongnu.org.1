Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E77A0831
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnmL-00014n-Af; Thu, 14 Sep 2023 10:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmJ-0000yY-U3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmH-0004Nk-UU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so952319f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694703428; x=1695308228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yEBzd2ULRxk3ymaTMon7B6wcT3mZDM7Z+7Or36OEaEY=;
 b=RXLnXqXEPtjSr3GnYPUcY8xnaWDfvlshP/1v2eZjlsyfAhvqk6euyeSRCtpRBiqGJy
 XQrkhOt4W7bcci+TDzUsDqtOedhUaDscSki+5b23KKE2K0tJOxqdbH4zbYISIjKJCkpd
 g7rcW/RoMz+VwfHBJWRVr7MgUjwv8ofcoikp+M1Wprd8Q0PxLI97OqEFZMcls9Ar3MYM
 VskP3dCWJKBQX7qL3wR9XtfSXM8znITxBtico49LA5srYr7HZiiseu6iIi+SH6sin3KS
 c988xdtBRPGCgrERwuPKwaJjbZmdqTnkPaAfA8azpWACqFRi4GoNeu8SVcNEsfah/JYl
 hIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694703428; x=1695308228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yEBzd2ULRxk3ymaTMon7B6wcT3mZDM7Z+7Or36OEaEY=;
 b=GeXNkW/2a8NwlrmtYXdFV1C3YOHNUGkhHfru9fn/vTXsXLiQlM6ebluwOSnt9jzDvn
 oiUf1B0fz/V+O2f+s8zkyEkery74u1MqKR5i1SnbFJMVY54V2LY0DnIXwAjG9Q1lTGFX
 QDcpG4D2m5ysWLrh0fM1HPerBQP9smJ1R8YiEuEEj60ALNqFiOUUlscBDWXmoGkIjFis
 G1snDYlw2P+mesnLux/2nYJVkwwh5ohsXSwC1cicu9NX7A6JvLqonIfkVS3PCM9R0k+M
 eJLbwF9Dbw1Aydw1t38NRhijWc9jSIoYnSUfF4CTvwg9mSlPaYbZSGrQil3maJ29b8qa
 O3Bw==
X-Gm-Message-State: AOJu0YxBQbxZyqSQ1qaDCuxfSQ+06CjDquERUtb48GnW3UrtR6WUsC8g
 BYmS07S56B+ywIoIZgfWCQiv3aEYlbYnbOIOdYw=
X-Google-Smtp-Source: AGHT+IFVfkOMtRnVCjzY1cLZDAajrVOuGCz8wk99bJtQJWsg6w+L3GNmQyarXsfFPeY9XAL7C+jRBg==
X-Received: by 2002:adf:978a:0:b0:31f:dc60:13b5 with SMTP id
 s10-20020adf978a000000b0031fdc6013b5mr2223423wrb.25.1694703428137; 
 Thu, 14 Sep 2023 07:57:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a5d470f000000b0031981c500aasm1978483wrq.25.2023.09.14.07.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:57:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH 0/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX
Date: Thu, 14 Sep 2023 15:57:02 +0100
Message-Id: <20230914145705.1648377-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
supported, so we should theoretically have implemented it as part of
the recent S2P work.  Fortunately, for us the implementation is a
no-op.

This feature is about interpretation of the stage 2 page table
descriptor XN bits, which control execute permissions.

For QEMU, the permission bits passed to an IOMMU (via MemTxAttrs and
IOMMUAccessFlags) only indicate read and write; we do not distinguish
data reads from instruction reads outside the CPU proper.  In the
SMMU architecture's terms, our interconnect between the client device
and the SMMU doesn't have the ability to convey the INST attribute,
and we therefore use the default value of "data" for this attribute.

We also do not support the bits in the Stream Table Entry that can
override the on-the-bus transaction attribute permissions (we do not
set SMMU_IDR1.ATTR_PERMS_OVR=1).

These two things together mean that for our implementation, it never
has to deal with transactions with the INST attribute, and so it can
correctly ignore the XN bits entirely.  So we already implement
FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
that we need to.

Patches 1 and 2 in this series do a little bit of tidy up
on the ID register bit code. Patch 3 is the one-liner to
advertise SMMUv3.1-XNX in the ID register.

thanks
-- PMM

Peter Maydell (3):
  hw/arm/smmuv3: Update ID register bit field definitions
  hw/arm/smmuv3: Sort ID register setting into field order
  hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature

 hw/arm/smmuv3-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c          |  5 +++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.34.1


