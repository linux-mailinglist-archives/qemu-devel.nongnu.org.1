Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236B76F5AB
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghi-0005uw-Hl; Thu, 03 Aug 2023 18:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghf-0005hu-Rn
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghe-0000ae-5j
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMxXfvAJzOt0WNpV9VUtDC6V3YHI5GSC1EpO+HIGguo=;
 b=L4A1jYJG8XSR6OupXB5hanAi1PuxnZ79VC5KK580ICmyqcyQnt7S1TpzCxd6S/uPRYZmYf
 242laiCP5JVTOOJN0Mtytu+ehSU85NA595F7HcO6R5EzwsRs8ap5dSXj3CsYrQ+DXKJ9Oz
 xlZWY5TKc188TvbwRHFy7Ijyqp/BmB8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-4pW5UCMHMvONhlSFHLwO4g-1; Thu, 03 Aug 2023 18:21:52 -0400
X-MC-Unique: 4pW5UCMHMvONhlSFHLwO4g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso92699866b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101310; x=1691706110;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QMxXfvAJzOt0WNpV9VUtDC6V3YHI5GSC1EpO+HIGguo=;
 b=ZZIhwjrB+M+nveXqMiNrUOvfZbTdjeD86e6GE7SLjDPR5L1Wny6eUF4U0sXeSndc6D
 yyrkDFZ65VYXL8+IeePv/QtVjbJpO6jh7DjMmPUMrGYHbyTWGvGorRfEBn7QvSzxg6yC
 ZVK3H5sP4eywQRgmqsWCAuJGtfry8vlveQCP4Z3wukSVRG6JcsypIT9DwGElH/Pvtqh5
 f1JGAwh3lA0j/Rdoh0iPKOMWmSyp5NYINo+L5Da8OIihMz2mWVmXnqhpty4CiiwBiHgt
 d205VfFCYds4VaJZ9ofMEp/fSGFV0L+0VbLuMGWj4gaWdUA5GaLHMgo8UjGgE13f5ul3
 ykRg==
X-Gm-Message-State: ABy/qLa7xBFN1izjcQt6ZvCXDDwSiRT5gvfq41n3DJNvDQ/4Om4ru+JK
 dAo/I+dL2pO3djjso+RDcVDrZFnGj/KHQsLw5JPSlfI5er5BATmSExNY+sBtCF7gt1NxadpWVIe
 FmsYgcezhKvTbuzV0YUu30TdisZXIv5LRcAJ5UV3QVfpFdwhJzAfhcvNkhA+C+i3L9X+F
X-Received: by 2002:a17:907:2716:b0:98d:1f6a:fd47 with SMTP id
 w22-20020a170907271600b0098d1f6afd47mr8673145ejk.76.1691101310751; 
 Thu, 03 Aug 2023 15:21:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmuLldzX1EJjHUX0iftmnr1cGwNbEAmSL5Tnx9QBRL46mgde7bYaSMDajlFQzGluoFPHu7sg==
X-Received: by 2002:a17:907:2716:b0:98d:1f6a:fd47 with SMTP id
 w22-20020a170907271600b0098d1f6afd47mr8673127ejk.76.1691101310472; 
 Thu, 03 Aug 2023 15:21:50 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 lt1-20020a170906fa8100b009934707378fsm376024ejb.87.2023.08.03.15.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:49 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 19/22] hw/i386/x86-iommu: Fix endianness issue in
 x86_iommu_irq_to_msi_message()
Message-ID: <37cf5cecb039a063c0abe3b51ae30f969e73aa84.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

The values in "msg" are assembled in host endian byte order (the other
field are also not swapped), so we must not swap the __addr_head here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-6-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/x86-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 01d11325a6..726e9e1d16 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -63,7 +63,7 @@ void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
     msg.redir_hint = irq->redir_hint;
     msg.dest = irq->dest;
     msg.__addr_hi = irq->dest & 0xffffff00;
-    msg.__addr_head = cpu_to_le32(0xfee);
+    msg.__addr_head = 0xfee;
     /* Keep this from original MSI address bits */
     msg.__not_used = irq->msi_addr_last_bits;
 
-- 
MST


