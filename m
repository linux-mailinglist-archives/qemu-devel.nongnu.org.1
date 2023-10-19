Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57447D01D5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhZ-00018T-Es; Thu, 19 Oct 2023 14:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfh-00073e-HN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfg-0000rU-0k
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uQ6e9TBmbkGr/609GK2LAExHu2tk4bgtDcm3tAT8ROI=;
 b=UpUIrvfREORpG1V15tAEYdT23DRQWruzbalNXapyQTWf8VN89ZnNRsntCy3CV947L0qjaw
 IPR9YXNKR1gnaghW3R9QRT0cqqBBjNdlLUQ25rTkxBq6dQ2CyISaru8nW1AMAqGknQEcX0
 JqmqSirNJaNN437GI4A97VzKdd8JD00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-QHpBg04QOB-U-mO3NDQomA-1; Thu, 19 Oct 2023 14:22:53 -0400
X-MC-Unique: QHpBg04QOB-U-mO3NDQomA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084001846eso12320885e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739772; x=1698344572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQ6e9TBmbkGr/609GK2LAExHu2tk4bgtDcm3tAT8ROI=;
 b=oc4FyvImYxmnSWDcMugXd1suYA6r3GIRWeqZNcSy941VlkfrJNlLq5w/8s6CrxyjJI
 8DjeDKmCbvnpxu1RSgbA3MRPAFWF0tekSLeFFBhfNHbA79Qae93MsvAoc+rNAT291dKE
 ntqibr222Wjd0bYO5EkMOtFolZgT0ABjs0gmB3FMZqZrn11MYwBnA1SZKRncajvxeE8V
 Tn+9lm8aL6Hr/K1Y3tX+PkdzL2DL0d6k5mZKDRosBolx/JrJgfjJgt5O6kTMW1Z+fTAp
 VTFmQEIqSysDS0zJIBn7Ero5suOnX6lWh3PSmnP8n7ARZwMY93AVtLl06BbCFq4lfRiS
 G+kw==
X-Gm-Message-State: AOJu0Yw4+49hKRqxatHZ8PcznLRB195zV+edX21puAU4YhYmytJklASB
 siQBhzpRIw3/kt2YSIlhNclUK8B2g42IQmBqPfBMuC6AI8Jq+gZTBoqJ+BHTd8UMKrsPQy4XZYt
 cXFxBoJshPrXVN4r+sLpygdVkgzznveqXFPBi1jLtJoeBUUhehLEbmbWQIYLOwtMcW3zA
X-Received: by 2002:a05:600c:1c93:b0:405:458d:d54 with SMTP id
 k19-20020a05600c1c9300b00405458d0d54mr2476655wms.33.1697739771817; 
 Thu, 19 Oct 2023 11:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKTW2iXmpUIhhnkeTYOYJf2Muu0BoXT6SERX+CgMpjUWGGWcSyx5WEm5j4bHWO+cAUktpj7Q==
X-Received: by 2002:a05:600c:1c93:b0:405:458d:d54 with SMTP id
 k19-20020a05600c1c9300b00405458d0d54mr2476641wms.33.1697739771547; 
 Thu, 19 Oct 2023 11:22:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b00407752f5ab6sm224337wmo.6.2023.10.19.11.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:51 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Albert Esteve <aesteve@redhat.com>, Matheus@redhat.com,
 Tavares@redhat.com, Bernardino@redhat.com, &lt@redhat.com
Subject: [PULL v2 37/78] hw/display: fix memleak from virtio_add_resource
Message-ID: <8d87983478a6db3679b15af601bb3df0d18ee09a.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

When the given uuid is already present in the hash table,
virtio_add_resource() does not add the passed VirtioSharedObject. In
this case, free it in the callers to avoid leaking memory. This fixed
the following `make check` error, when built with --enable-sanitizers:

  4/166 qemu:unit / test-virtio-dmabuf   ERROR 1.51s   exit status 1

  ==7716==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 320 byte(s) in 20 object(s) allocated from:
      #0 0x7f6fc16e3808 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cc:144
      #1 0x7f6fc1503e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
      #2 0x564d63cafb6b in test_add_invalid_resource ../tests/unit/test-virtio-dmabuf.c:100
      #3 0x7f6fc152659d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x7a59d)
  SUMMARY: AddressSanitizer: 320 byte(s) leaked in 20 allocation(s).

The changes at virtio_add_resource() itself are not strictly necessary
for the memleak fix, but they make it more obvious that, on an error
return, the passed object is not added to the hash.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Message-Id: <c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic_mathbern@quicinc.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href="mailto:quic_mathbern@quicinc.com" target="_blank">quic_mathbern@quicinc.com</a>&gt;<br>
---
 hw/display/virtio-dmabuf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 4a8e430f3d..3dba4577ca 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -29,7 +29,7 @@ static int uuid_equal_func(const void *lhv, const void *rhv)
 
 static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
 {
-    bool result = false;
+    bool result = true;
 
     g_mutex_lock(&lock);
     if (resource_uuids == NULL) {
@@ -39,7 +39,9 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        result = g_hash_table_insert(resource_uuids, uuid, value);
+        g_hash_table_insert(resource_uuids, uuid, value);
+    } else {
+        result = false;
     }
     g_mutex_unlock(&lock);
 
@@ -57,6 +59,9 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
     vso->type = TYPE_DMABUF;
     vso->value = GINT_TO_POINTER(udmabuf_fd);
     result = virtio_add_resource(uuid, vso);
+    if (!result) {
+        g_free(vso);
+    }
 
     return result;
 }
@@ -72,6 +77,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
     vso->type = TYPE_VHOST_DEV;
     vso->value = dev;
     result = virtio_add_resource(uuid, vso);
+    if (!result) {
+        g_free(vso);
+    }
 
     return result;
 }
-- 
MST


