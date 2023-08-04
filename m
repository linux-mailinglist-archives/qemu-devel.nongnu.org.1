Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49D7704C6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwlA-0006Ot-1M; Fri, 04 Aug 2023 11:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl2-0006Ja-9K; Fri, 04 Aug 2023 11:30:28 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl0-0004Qb-Tz; Fri, 04 Aug 2023 11:30:28 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1bb75afeee3so1671266fac.0; 
 Fri, 04 Aug 2023 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163025; x=1691767825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAqK6QWaeNrKvf7OH3VDv+9xR6Z10k+UDV3PubsDTA0=;
 b=HOZHtybnY3cDgbU/UlSdpDPFOiyz8uApBIYp9YdLM3jTO1s1h56AiMN2G/3NtxW1B7
 H5VgrCInf68NmOPMqhI7IjZE/7yOBwCwvgzUytcca4Vy8xr1hFSiigvXNtTYd1LdxDcv
 z+oDSewbhNkTykxZmx8lqox1RX2Y24NOcUGoyxrhp4sKpfp6MU7EpPfCsdOutEhGsBDE
 MhTCmzQ3QXasf2S3PJvCicD+5FfxmhqbxIsHQxOEfMtjVT4v3hYpf3ken+tpJmwCBNI8
 H6kGX5C552d2TH8E1brPjvsLRWDbpqzR7vY+fRAJ6aHizab6mJV9ktQUi1YYpW9LYBL+
 F2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163025; x=1691767825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAqK6QWaeNrKvf7OH3VDv+9xR6Z10k+UDV3PubsDTA0=;
 b=LIIWfzm8kLdBO20OAsge5iG49uADe+AN6pNFu4c9VjtrWeALsuTorp4sQi1aLczUn2
 q+qiO+9n7rXHNj/CTxheNQS/trnojq/2SJEWGcK9iVHtJJRxh6iEzN0bjaodD6C79PN9
 0KtTzG3zLHGaDjFz74xJs2sTdB9ZfkbmtvXofvGgpQbO1xTUzWYmM1qvqrzy3cfPnewF
 CpkU+p7wbp33haPx/rD/0bIMCjkMUX1xy4hwUg9S8GNhuDRrUCRgGIhUjsPI2ExGX5Pq
 DkflKNyhO89QqSOFzAUXvh1qbWXHHGiZsP6dohOQb5Datqm5E8NQQiCp6/oZW/T8dbdy
 tDBg==
X-Gm-Message-State: AOJu0YxDvJHs37Zl2GubyCynDFxhPe5+yJCC0cspMznLSasPugDVhGva
 87oeupfjv7jHkeQTvIyEchZRVe85MII=
X-Google-Smtp-Source: AGHT+IHGXTuwByLLrqbdjvQQu9J+PExLuBUoVycbmjrDJhdG/oiEosehz2SLmLFm16sFTafC35wG0w==
X-Received: by 2002:a05:6870:e0d4:b0:1b4:7411:df6e with SMTP id
 a20-20020a056870e0d400b001b47411df6emr2352574oab.15.1691163024913; 
 Fri, 04 Aug 2023 08:30:24 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:24 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 4/7] ppc/pegasos2: Fix reg property of 64 bit BARs in device
 tree
Date: Fri,  4 Aug 2023 12:29:52 -0300
Message-ID: <20230804152955.22316-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The board firmware handles this correctly following the Open Firmware
standard which we missed. This fixes 64 bit BARs when using VOF.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20230721221320.1311E7456AB@zero.eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 6475acfbed..075367d94d 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -781,7 +781,11 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
             cells[j] |= cpu_to_be32(1 << 24);
         } else {
-            cells[j] |= cpu_to_be32(2 << 24);
+            if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+                cells[j] |= cpu_to_be32(3 << 24);
+            } else {
+                cells[j] |= cpu_to_be32(2 << 24);
+            }
             if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_PREFETCH) {
                 cells[j] |= cpu_to_be32(4 << 28);
             }
-- 
2.41.0


