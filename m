Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38C74E1C4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzv1-0005tk-IB; Mon, 10 Jul 2023 19:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuy-0005cM-Fo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuw-0004JU-RH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbUuQwrEGr4xi2bvWM77xOceCJpPOzjb+5zsk5++7pk=;
 b=SNKvXMnav4SXsiuRKjUSIjsyvhKfSuElhodeXlf9D0qsjaFweM1KtFqcHFewEQcJvJ9FFL
 F9Wt0TZzirExJBJ3QFH9TlYbJ4//d1YVoSABql3rpSX1BxK9g9zfFrx6TQjrC18OTRYjsF
 whvqFe+Jui23JM2zIgrBU4W6RxbqB3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-kHRfZt9jMj26DSX6YDzAMA-1; Mon, 10 Jul 2023 19:03:41 -0400
X-MC-Unique: kHRfZt9jMj26DSX6YDzAMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa9a282fffso29957805e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030219; x=1691622219;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dbUuQwrEGr4xi2bvWM77xOceCJpPOzjb+5zsk5++7pk=;
 b=MT/2ud36+dy2fnzQ5uBDRssxxXwjjAEK/yH64FwXPgU8Nlkcs/HccpZFYClTOQYyAF
 e4x7wejyGZULYNj4uNLsPjIQzoc3J0UuFypyEn8b518svAdPI4KmiC4yxTCLMGNc0/cj
 9GiJhKsP3J5Wii1b1ztPWOS39cm00Xya9jTPgzAl8GVzb4937YGpP3+CL3zCM+srPnmQ
 2RR3bivx+EMwZVAfEcngH+dQIUCYzx+28bt0nWYorB/UzLFhjs49mVmqWZtCJerS2g9f
 HDi9KeUbvZrc3Nbe9iEk5uf8lhwjV+hRzbkbhxMG1cRYkAiA9TnhTtmWRLy4x6uqss5I
 07vw==
X-Gm-Message-State: ABy/qLYejH00xf6Sl2hKBC98mDiflEHHg5WAfYyjrzcXfCYzoC6NY2C9
 JPwvleRu2pvIDtiJh0aNiXUQfTMzPhvIV9CTjQUrwlpHq8EnqSTGsX74zRhvYFY0PWoi510sRVi
 3TSBk2oip2En63bZVCqVT483jfFDMEye4YPuH+fAv+0jfv1DiTLN1jf9ZkiKjdXi9LZ4b
X-Received: by 2002:a05:600c:ad8:b0:3fb:fa61:a4ed with SMTP id
 c24-20020a05600c0ad800b003fbfa61a4edmr9451245wmr.26.1689030219514; 
 Mon, 10 Jul 2023 16:03:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGvihms63n2ABlA862hXbtpDhmK9ZIE7P1sSctfVX+/QUkuFip4xLI4LrZy8pQliMqLeU9V0A==
X-Received: by 2002:a05:600c:ad8:b0:3fb:fa61:a4ed with SMTP id
 c24-20020a05600c0ad800b003fbfa61a4edmr9451229wmr.26.1689030219151; 
 Mon, 10 Jul 2023 16:03:39 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v15-20020a1cf70f000000b003fa8158135esm11398974wmh.11.2023.07.10.16.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:38 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 25/66] hw/pci-host/i440fx: Replace magic values by existing
 constants
Message-ID: <cda39f134ba197e2c8c9660dd3fb8fddf4c8647b.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-10-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/i440fx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index d95d9229d3..b7c24a4e1d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -276,8 +276,8 @@ PCIBus *i440fx_init(const char *pci_type,
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
+                             f->pci_address_space, SMRAM_C_BASE, SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(f->system_memory, SMRAM_C_BASE,
                                         &f->smram_region, 1);
     memory_region_set_enabled(&f->smram_region, true);
 
@@ -285,9 +285,9 @@ PCIBus *i440fx_init(const char *pci_type,
     memory_region_init(&f->smram, OBJECT(d), "smram", 4 * GiB);
     memory_region_set_enabled(&f->smram, true);
     memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, 0xa0000, 0x20000);
+                             f->ram_memory, SMRAM_C_BASE, SMRAM_C_SIZE);
     memory_region_set_enabled(&f->low_smram, true);
-    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
+    memory_region_add_subregion(&f->smram, SMRAM_C_BASE, &f->low_smram);
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram));
 
-- 
MST


