Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4073E26A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlLs-0002vG-70; Mon, 26 Jun 2023 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKu-0002Ht-CG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlKr-000310-Gc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lUSJaMnlnz/HAJShdhWd+2sdzRo2ASZhZzrf+rbuEM=;
 b=bY+Ob/AFYeiOYRKEUzbNBSBdzsVUK0gXec8m3w6aqSIcOl8dLo5cvd9RIgCIfrOtpQB4Ts
 i7YFXXtIXTBYxP0lndMLGs9NbgqhHyHK1wgV9ZsPPhi332aXiwrwuiu6yZqcQrUIPAS7oa
 dd5L/UlxGlzjRNOu/0Ejxgfto8Nqfnk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-uIW9Ob6PMR2HK3vz-V4YIA-1; Mon, 26 Jun 2023 08:28:47 -0400
X-MC-Unique: uIW9Ob6PMR2HK3vz-V4YIA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb40d90456so1352805e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782526; x=1690374526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/lUSJaMnlnz/HAJShdhWd+2sdzRo2ASZhZzrf+rbuEM=;
 b=VMLGgSf7x0UV4RjUP4kvUsdLi88baIMmkfBROIQCLFo758ZrzYNgEWbIpZcL3RbCiF
 0d8Stj5trWkHr/CYr495/8fdpVslQmdTYRbXTdKPwb+5b9fhSy4oGVskOBV7nHt6Bw3Z
 W5snp9p/1afjpfHMYHSOjtGFgjznrdrLkHjxIuG1tLYS68oc4zfppzB3W83bIvsbKCw9
 3WAAyTBu2INRGDhHUFJl30cujoPSOfZOkjT3+otAJ2wTRApe9uSr+/gpOgCm+nvTSa5N
 PpnWEUUcF4eQsPjNQDcHq0P4QMVguzrOhW//8HA396sMtN1xtD1mrzMIj5SHs49dhewf
 K5Lw==
X-Gm-Message-State: AC+VfDxbhw2p1m20PSWKDUbjXLLsMX0B/cFXRrkVlpr7OjsGatiNhPLV
 70l3LD6opB29aWWCYpiTQChKaKE0ATdJv4Pw9RjbGb4C8EVJarxS2D8k0mGNelHwuyzONG9Q/kG
 jvrF5Ip3ZLWI/mpjvCLnYVLU2+XozZGw3vG/JC6YTQVXo6SBVRxczTeWqlVYnrwOGsSdi
X-Received: by 2002:a7b:c401:0:b0:3f4:2a69:409 with SMTP id
 k1-20020a7bc401000000b003f42a690409mr26793062wmi.11.1687782526135; 
 Mon, 26 Jun 2023 05:28:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fxFdN41aRBm7SHVwgNoRmhkopLTVBDvTPf0WLpXVcz66w0wT1Bin8nPE9R/d8tEFvDr237Q==
X-Received: by 2002:a7b:c401:0:b0:3f4:2a69:409 with SMTP id
 k1-20020a7bc401000000b003f42a690409mr26793047wmi.11.1687782525911; 
 Mon, 26 Jun 2023 05:28:45 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d4533000000b0030aded83385sm7309811wra.27.2023.06.26.05.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:28:45 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:28:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 18/53] hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
Message-ID: <21e6435066bd3818969b520b69415ba62a85cd24.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Avoid accessing RAMBlock internals, use the provided
qemu_ram_get_fd() getter to get the file descriptor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230524093744.88442-7-philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 538b695c29..74e63bd47a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -135,7 +135,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
      * anonymous RAM. In any other case, reading unplugged *can* populate a
      * fresh page, consuming actual memory.
      */
-    return !qemu_ram_is_shared(rb) && rb->fd < 0 &&
+    return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
 #endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
-- 
MST


