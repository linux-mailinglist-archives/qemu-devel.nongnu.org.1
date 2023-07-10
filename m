Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6474E1F1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuf-0004Rx-Gy; Mon, 10 Jul 2023 19:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzud-0004Mx-2C
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzub-0004Da-NZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zw2umn06AtI1S+/Gxf3HhoyuNucsi0r5jYKqy/7dleU=;
 b=E1mHWq6NZv9hvh0AVJqmo/7t0YqBIZq1nL+dJPVi/2eHWorzO/4Y58YvbBfLCptmZd3z6h
 43qYC1G0JOl1eCyCAeVfYTTYasn9dd7bCMhPYxB5C/QsUAPG0BossIDneC2rgcsbDhqe+a
 OKSelAONfZFkIAcv0rwvOCL/9yVbTMA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-iIR8NbpNNKGRmoJN2qiplA-1; Mon, 10 Jul 2023 19:03:19 -0400
X-MC-Unique: iIR8NbpNNKGRmoJN2qiplA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3143b999f6eso2883531f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030198; x=1691622198;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zw2umn06AtI1S+/Gxf3HhoyuNucsi0r5jYKqy/7dleU=;
 b=SzKiEC239Gh2/gAGxnLy8rGD5bA0vEEkfLYRGwH0Tz0cyn32FFgSuQaSKWJJdqtCGu
 bFM7XaN8zeW3EHvn5QzRAI/QP3zk+v5qCNNwQhtqHl1ThEgfWuVfO6PN3bARhemc22qX
 0XMCivkZ6sQHcTION7X0g8um+mBcXpzlSdx+TJCO4pLYc0nJZF5gE5OUUqZM/60A2wNo
 dx3G8oH7dTmul2q+tkhSzs/hWVWyldKP/Sfc5QDJq+MOEq6jSCOjuS52Sl7phhw6DlQf
 VW8qpUO3pkZmuYlYr5c09Q04r45ShNcddiLx41fCZ8fHWDEi3iIQMrkuaw7ys/bWiids
 uYHw==
X-Gm-Message-State: ABy/qLZ896xh6MsQ1Z/cDbAzOWmEXTBijG6YuWNkA+obh3IZUTQxRWID
 jKZDRmyUzKjcXFPBpD6cXXCFrUgg/JvuR0wJ+mlD9lS16eOuz7JEmZeKrgULHvh8k2QhgmGT5Ur
 RruyebxcaJ1HVuu7ErH84aSaO42Uy9/XqwKhjZTYetHdlSo6VEv78xK6dY2SlUFhDQIzy
X-Received: by 2002:a5d:670e:0:b0:314:172b:a7d5 with SMTP id
 o14-20020a5d670e000000b00314172ba7d5mr12887297wru.27.1689030198214; 
 Mon, 10 Jul 2023 16:03:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9CYtlRdsp0AnU+APOSHfjA6NJrKEa9ztnKJLJah7sjms3Edpph6hB4xBOVusj/TP1vEhAvw==
X-Received: by 2002:a5d:670e:0:b0:314:172b:a7d5 with SMTP id
 o14-20020a5d670e000000b00314172ba7d5mr12887273wru.27.1689030197914; 
 Mon, 10 Jul 2023 16:03:17 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 c7-20020a5d4147000000b003141a3c4353sm601517wrq.30.2023.07.10.16.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:17 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 18/66] hw/pci-host/q35: Fix double, contradicting .endianness
 assignment
Message-ID: <8cf08065b1b19cea1958a43187755cec6546a5d0.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

Fixes the following clangd warning (-Winitializer-overrides):

  q35.c:297:19: Initializer overrides prior initialization of this subobject
  q35.c:292:19: previous initialization is here

Settle on little endian which is consistent with using pci_host_conf_le_ops.

Fixes: bafc90bdc594 ("q35: implement TSEG")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fd18920e7f..84137b9ad9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -285,7 +285,6 @@ static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps blackhole_ops = {
     .read = blackhole_read,
     .write = blackhole_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
-- 
MST


