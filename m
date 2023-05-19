Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F00709AA7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01SG-0003ef-MZ; Fri, 19 May 2023 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SE-0003c2-4F
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SC-0003fk-Ey
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SxaVYbD07JQoLxbrFvNgYxKeREtojHgH3ZDGsvoJASA=;
 b=XZYwhtAThJw9gV45CkVFlLWrpkwQOEoW3sd7VAKYrjBYhWcyEPUesnLT2PQ2DnXMlQ7k4v
 qbW26LrXh0eS81XOfHGZOpwOPCVuw9oVhOZauxCtYXVlOH/oFsgDXZMBZS/aBdDkO/lKQF
 SjZtcYD+a3EzCQ7pY0kaaQM+ostoLI8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-TDxwn4ADO3yr72IQqO8cSA-1; Fri, 19 May 2023 10:51:34 -0400
X-MC-Unique: TDxwn4ADO3yr72IQqO8cSA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f37c82f185so2130562e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507893; x=1687099893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxaVYbD07JQoLxbrFvNgYxKeREtojHgH3ZDGsvoJASA=;
 b=cJBEMn6vDFM4InVtkYgPRiCFjEKbxXm1wE49CtIOsuUu0nCKGVISMVNSErjTaxlLsP
 b2yDq/yE5Q1cX7T66mfq8WZpdKV1JeiJ0FsZmed5ABu3Y1DuyqSfT2PbkZH2Ghj5UTGD
 FchGqgINA4FZk2X4DmLUZX8QpvmLJsKjZQH5Pwc9AebqwFwh2ZzIjMtQsDuQhSiJg+oK
 py4cJymATHXUDL3qZBLUMsfkhTrB8v12p4/eDTiabyZ3l4ZCA65tYUsyJPBfK+inVWIc
 NHxHiWjosNLoWjFMGycxrTFfJkBanjRRSmZ2NOV5ia5d8kV69c5XWcKWc9R4lwUnhAso
 W/pQ==
X-Gm-Message-State: AC+VfDyEc9qxsCOlEt+hXnty2txaOCdzbz0s2wjBna7Bm7x/OTGc1cZz
 PPtzKwaT4Z9fuIF2J5is6jJH1exM4520ZmCKH7WwtF/Tp/6iLnufeXBbIZzCwEehGiNigLbFbIL
 Gb8fR51CXhoQEk+Z1kldlx0jO/obA30q9UdpNchsuUMVrw7fUgBEsSPeDos5EMwT4e1C0
X-Received: by 2002:ac2:48b1:0:b0:4f3:a944:bb61 with SMTP id
 u17-20020ac248b1000000b004f3a944bb61mr917986lfg.55.1684507892843; 
 Fri, 19 May 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y2NkEGvGzRFZ2JZ3kR4jNFbBRwaCGks83+5ixLlaX0l5PcW5R0DwRQJpJ9SqyploynSBpsw==
X-Received: by 2002:ac2:48b1:0:b0:4f3:a944:bb61 with SMTP id
 u17-20020ac248b1000000b004f3a944bb61mr917975lfg.55.1684507892500; 
 Fri, 19 May 2023 07:51:32 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 24-20020ac24858000000b004cb43eb09dfsm623155lfy.123.2023.05.19.07.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:31 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 21/40] vhost-user: Remove acpi-specific memslot limit
Message-ID: <bab105300bdeb7b651dd1b1f666ecb8e44be6d71.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

Let's just support 512 memslots on x86-64 and aarch64 as well. The maximum
number of ACPI slots (256) is no longer completely expressive ever since
we supported virtio-based memory devices. Further, we're completely
ignoring other memslots used outside of memory device context, such as
memslots used for boot memory.

Note that the vhost memslot limit in the kernel is usually configured to
be 509. With this change, we prepare vhost-user on the QEMU side to be
closer to that limit, to eventually support ~512 memslots in most vhost
implementations and have less "surprises" when cold/hotplugging vhost
devices while also consuming more memslots than we're currently used to
by memory devices (e.g., once virtio-mem starts using multiple memslots).

Note that most vhost-user implementations only support a small number of
memslots so far, which we can hopefully improve in the near future.

We'll leave the PPC special-case as is for now.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230503184144.808478-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 40974afd06..e3ec8727da 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -42,17 +42,7 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_BACKEND_MAX_FDS     8
 
-/*
- * Set maximum number of RAM slots supported to
- * the maximum number supported by the target
- * hardware plaform.
- */
-#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
-    defined(TARGET_ARM) || defined(TARGET_AARCH64)
-#include "hw/acpi/acpi.h"
-#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
-
-#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
+#if defined(TARGET_PPC) || defined(TARGET_PPC64)
 #include "hw/ppc/spapr.h"
 #define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
 
-- 
MST


