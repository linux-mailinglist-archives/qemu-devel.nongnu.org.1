Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D0919F12
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jun 2024 08:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJW-0004LM-Jm; Thu, 27 Jun 2024 02:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJT-0004Dz-5k
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:55 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJR-0003fE-NZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:54 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-700d3ffc28cso654066a34.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468531; x=1720073331;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=ihNe4cqlzcHUTJmP29uHE3p2I923yEFjpx9/IVCcPnH8UQYMyN+62BlEwOgTQo9j8V
 XpDAlyUagDxZsVPwdWwGL0Om2LlxBpMAkBMZ9AozVXIBdiS5GAiX1R9xKSjCcHKQvJJ1
 jfw5P4C8vIS8wECVnh5Nxf6OK1P5FU1BwlXbJMiUtwmyAUvo5tGnhqoJxlxtaPtXyRqw
 ThfJc7VHnq4tx+1iQ6e9FcD3D1DhRHKnH1D8gO34SfXizkdahnt6CoNoy5gJyVKQMmHs
 wpTFNtMMXFTo1VSf8e2r+OXsAhumSiDVWS76AeiV7s83socG9MWnIuWwVzR9PKYFKFMS
 NbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468531; x=1720073331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tfsLBSp5P9Enjc3prc0IqWrh95La08LAkdzlIXsS/A=;
 b=cjimX3ibp0wqM9XBcpb4x403yIQP6vYApula8hH5vDICO6hJ0PqeyBjUXjgCE+Kvw2
 6QEWY/0uXPS9xuMsouM+LxO9bedfLzAawhSxLwsPm0IcT5tiKTGsxhnPuosfWQoaVhwg
 E61GEyXU+P4Wf4HKYdgcbHu1h7GQIJqM/92rK2gwFarm0o43fu/9nG79z4OewH7cdpUJ
 fOww07Y3SoUpCY0jrC5ijeWkDPbYGTo3aV1aaPBPRxYr0eraZ8J29hB0OJNDUfNpVUU0
 HTZd8VbZCzUZMwb9XB3U2KKms7IUmXuGs1Oh4eKD6MUuLEip0D8Dpy+hnmS44FM2AA0l
 hofA==
X-Gm-Message-State: AOJu0YzDRPl6dBxWDM/TPkVY280JUpdx+AS+8Haw+LvWrPz3xl/B+SED
 23L+GLO1hWtBufq/FH8VpHacSf0LnYjr4e7jnK2mTCfBPZp4+65GjfVex3GyhOw=
X-Google-Smtp-Source: AGHT+IE6O8HXL+GGbiBhl/kO1z4u4/c27KIuooAeJkTF12c2wTdhQbn4p6RDHraRK3/R4ZhA4efWTA==
X-Received: by 2002:a9d:65c4:0:b0:6fa:c6f:2237 with SMTP id
 46e09a7af769-700afa0772bmr13792835a34.25.1719468531413; 
 Wed, 26 Jun 2024 23:08:51 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-72748e8531fsm439450a12.72.2024.06.26.23.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:56 +0900
Subject: [PATCH v10 07/12] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-7-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index faadb0d2ea85..9bd7f8acc3f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -99,6 +99,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.45.2


