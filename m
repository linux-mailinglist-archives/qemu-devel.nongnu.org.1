Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0C709A76
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01SE-0003Zt-0b; Fri, 19 May 2023 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SB-0003RB-MI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01S9-0003fU-4i
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3a5VBfyfVaZtQkBTAD7S89WTx9VSHLv7NsVNGa8+EsM=;
 b=cZkEWmiB/22G8ZJDVwF3nmkz+ImS0n5n8cQ7SNtB8UR7ZS9rv1yW6Hd+9v+2Z4iFD0gvS0
 vuUds51Nu1GC4F6g2WdBKi0IOvBNFVJedjJYVhWbISj049w9oaHwGqv/5yYMHED8Kn9o4c
 0dRalvjZM37fCE6Df5N/gM78EG0mo7s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-HqTJo0afNYGHSHiRVxIGuQ-1; Fri, 19 May 2023 10:51:29 -0400
X-MC-Unique: HqTJo0afNYGHSHiRVxIGuQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f020caac60so2235512e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507888; x=1687099888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a5VBfyfVaZtQkBTAD7S89WTx9VSHLv7NsVNGa8+EsM=;
 b=QMvllrWtraHUosxkhh4pgN9ygBFyNztdKnwxjv/aReDZHz1CY45j7+d8nDE7sy6Xp0
 3aqxoUWuDE0l/yTIz0pXXHmC8UgFJ0+Z5zu5zwBPGXT4yGP5aa/C90USDH6wgmGIoonD
 ydKqaAue8EmROczRUGKJrPbBNQfd8lqxpbv7+IYxaUPdUQrW3f0BphfGLn8bm8IlKiem
 bgyTFH9ttk29SX1bb1aPnRwcsUE3rgQVYOkd3I6stUylOksie6ZDwzYVeJ+3yi6I6E8Z
 LegopPGOW1LqRPa43ZCZnlajA2lWBToQ/al4obltDvpy+Xdh7VhnEbP3DCKZPmHJ2GYB
 6WLw==
X-Gm-Message-State: AC+VfDzwRzTqryYNrOrpBnO11kWzDO2sVvmihpiluNjFr6xXvFDgKBrw
 9cytnPDg8mJnQX2sL0foAKA2q6xjO3Af0mMJCVwtUvbuFneFpTp6ibuqqUzLXsmJcGyk0sZ5Ofw
 dl7k5yL3L0g+IkjkLldpfoAo3OkRX7nu/UyR2RBB5OmcwW7urx7xUaFLFFAB29oCQwJ0X
X-Received: by 2002:ac2:4d0d:0:b0:4f2:72be:22eb with SMTP id
 r13-20020ac24d0d000000b004f272be22ebmr787742lfi.55.1684507887880; 
 Fri, 19 May 2023 07:51:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dAjZT+90uKvaMdcJe08CoGHza9OmxOJ9wwq3EeDxNjuTdLB446RO7fnqIp66oHo+KE+dvJw==
X-Received: by 2002:ac2:4d0d:0:b0:4f2:72be:22eb with SMTP id
 r13-20020ac24d0d000000b004f272be22ebmr787732lfi.55.1684507887580; 
 Fri, 19 May 2023 07:51:27 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 j16-20020ac253b0000000b004f2391fe9a6sm620239lfh.266.2023.05.19.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:27 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 20/40] virtio-mem: Default to "unplugged-inaccessible=on" with
 8.1 on x86-64
Message-ID: <d5cef02574c126327a6f673c12b8718ce55f80e7.1684507742.git.mst@redhat.com>
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

Allowing guests to read unplugged memory simplified the bring-up of
virtio-mem in Linux guests -- which was limited to x86-64 only. On arm64
(which was added later), we never had legacy guests and don't even allow
to configure it, essentially always having "unplugged-inaccessible=on".

At this point, all guests we care about
should be supporting VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, so let's
change the default for the 8.1 machine.

This change implies that also memory that supports the shared zeropage
(private anonymous memory) will now require
VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE in the driver in order to be usable by
the guest -- as default, one can still manually set the
unplugged-inaccessible property.

Disallowing the guest to read unplugged memory will be important for
some future features, such as memslot optimizations or protection of
unplugged memory, whereby we'll actually no longer allow the guest to
even read from unplugged memory.

At some point, we might want to deprecate and remove that property.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230503182352.792458-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c           | 4 +++-
 hw/virtio/virtio-mem.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d761c8c775..7802dc21d9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -116,7 +116,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_8_0[] = {};
+GlobalProperty pc_compat_8_0[] = {
+    { "virtio-mem", "unplugged-inaccessible", "auto" },
+};
 const size_t pc_compat_8_0_len = G_N_ELEMENTS(pc_compat_8_0);
 
 GlobalProperty pc_compat_7_2[] = {
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 957fe77dc0..538b695c29 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1341,7 +1341,7 @@ static Property virtio_mem_properties[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
 #if defined(VIRTIO_MEM_HAS_LEGACY_GUESTS)
     DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
-                            unplugged_inaccessible, ON_OFF_AUTO_AUTO),
+                            unplugged_inaccessible, ON_OFF_AUTO_ON),
 #endif
     DEFINE_PROP_BOOL(VIRTIO_MEM_EARLY_MIGRATION_PROP, VirtIOMEM,
                      early_migration, true),
-- 
MST


