Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B872B16D
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IOy-0006Qv-0a; Sun, 11 Jun 2023 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOv-0006Pq-Qe
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:25 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOt-0008Hf-Mg
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5147f7d045bso4931771a12.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479662; x=1689071662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr2w0T4wWIfm+gYCVoa9rztNOplZ4s15zmuE4qvAN2Q=;
 b=iAsdlyKegbl3kHe5SGEdg/pCZzj6lRMxd9+5JDWOwD5jJacjIStMjq+Cg5Ugv7LD1c
 U6pHGsVb93YarAdHKUUvJqof8ravTHYUmCL7ULAPZ3gNI8Vr0rIJZSCH9sbDaBrIEpfx
 uwGdjfjAQVYz5+m1OTvekOYrudpe/RYabshXZIdYoV0LaqxvULT2gh7WGvKz2NUKSj19
 XdPEFc53XEqAlTg8lgY3GZ9CMDH9hhCvyE27k5Cguz0ctPyoGJtE0/XUiVa/vvMBPhH4
 fIDLT8lv+Pv9knG0GLvly/kEQuTyhiaCqWIzbFhUu/j/d5RnwYZBoElRWvESx8DrTXU1
 Ro8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479662; x=1689071662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zr2w0T4wWIfm+gYCVoa9rztNOplZ4s15zmuE4qvAN2Q=;
 b=dXhOALpqMyjGqvpQLqQFczFb/WR5Lo08eliRhHSMi83v1KQE6193R1f3Vp+5o7Etoq
 x78UVK5AHV3nWQw7iNMaigHlnjtKd8ZeOGp58Oy8OE0PjWUmYZPWQ1H9Lwl9jizp1790
 I5+fYywCqC4fbWqfuPg5La9GLgt2OVkKBV/D/JHK/7mEwMlQMGkOQgyclnp0PMWJbYVH
 9VM5ezispPHURMtLRth6PRYNjgqJBVTflfrLxwmKea+cQoVZmgcjg/F/76M4XutXjgRI
 agynTYiVaHuk1pUs/eGfC72fceZ/SZ9GEgr0gXSj+tqfpW20VEAdk68pMzM5vJPwKbqY
 8YSg==
X-Gm-Message-State: AC+VfDyMcRomUaNkmTZBNrZ0JRrOB8DIr6uVxBgo4Ss793VvdlvcXux8
 C3keew2Oxq617zRAZpLMOX3R+JPmc8k=
X-Google-Smtp-Source: ACHHUZ5jValYTwbAjEAuuZRN/qKOb3V7U183fzr+v2Kfw8S5asy0708E/OnaBSepKMpyRp7vWo+AHg==
X-Received: by 2002:aa7:d312:0:b0:514:9552:4bf6 with SMTP id
 p18-20020aa7d312000000b0051495524bf6mr3203836edq.3.1686479661986; 
 Sun, 11 Jun 2023 03:34:21 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/15] hw/pci-host/q35: Fix double,
 contradicting .endianness assignment
Date: Sun, 11 Jun 2023 12:33:59 +0200
Message-ID: <20230611103412.12109-3-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes the following clangd warning (-Winitializer-overrides):

  q35.c:297:19: Initializer overrides prior initialization of this subobject
  q35.c:292:19: previous initialization is here

Settle on native endian which causes the least overhead.

Fixes: bafc90bdc594 ("q35: implement TSEG")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fd18920e7f..859c197f25 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -290,7 +290,6 @@ static const MemoryRegionOps blackhole_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 /* PCIe MMCFG */
-- 
2.41.0


