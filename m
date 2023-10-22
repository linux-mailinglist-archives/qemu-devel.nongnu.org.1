Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E247D222E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfr-0001um-M5; Sun, 22 Oct 2023 05:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfm-0001kW-7q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfj-0000J8-Qr
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=T1vbezO5B4F7UUnMyZfzBXwloq3vpuaBJkF9EkZKHcNBq/SRQJZxeK1gjOA4v/+3N/zUNZ
 5pjKmLuOcBhmQils9LXFZm/rlZfkXATCXoG3t0gVivd4af9HzyU//FZFdfCFGAFMczJZ0+
 fLcLBSiugOfpoMjFlSe7hGgVjlAJppU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-9qJL3Vn2OM6aTjHa9vIfhw-1; Sun, 22 Oct 2023 05:22:55 -0400
X-MC-Unique: 9qJL3Vn2OM6aTjHa9vIfhw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a3ae32beso2195920e87.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966573; x=1698571373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=D4ahAEdlzmpsGjMtxt91J0GENneXQpxASCupSlZd8qEIKZQ/EpQBxf8Ex3ooRjOpxx
 p6+HwQbMqA7GUXVOV2CkkHuhKog8dulli67WM1V14C8aSyyfG2noefChwusdga7TBRab
 XHGemI4IhqHoEQNJhPDOAvXu4aEvO6UTsH3v6HboxDKLBWvFr5dVVaHWc+b3KMNRrnT/
 zV1ECiIqnyJ5/UWWyMAMw+3CyTQp0QSW7ZKu4UOSzHg9zkuYbH47OU0Bs03y6HW5gY3Q
 q7aBXNC28iIfMgg1O5wM3C/4r2n7jBRWsDm7bxyPFWfz1EjMn49y54pUljs24bme2S3K
 z54Q==
X-Gm-Message-State: AOJu0YwxeOiGf9Rf9NB6v5AKDpRmo9mffXIJ2VNYzkHoWyhGGjncTUgq
 IFHtzyfB4wY/oosQdJEL8/gFyr17sgtsVRso2qemFYkaKTtNxYP6KkaNnaY3Ep6YZXO3fhPEc8+
 BJjfGCs34PEFl/x0zsS4LXSwI9lcEA78gJ6pBAzFZ+1TSICxJDvrAeMhUQbT2Le4vSP2E
X-Received: by 2002:a05:6512:2090:b0:507:b942:86ba with SMTP id
 t16-20020a056512209000b00507b94286bamr3909304lfr.32.1697966573316; 
 Sun, 22 Oct 2023 02:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/7WfjhGv5Lt//l2LNRShlCk6btiW6utFhNsblCHqAVSmq4LbtQBLKM87PsrvvV7lhhw8buQ==
X-Received: by 2002:a05:6512:2090:b0:507:b942:86ba with SMTP id
 t16-20020a056512209000b00507b94286bamr3909294lfr.32.1697966573064; 
 Sun, 22 Oct 2023 02:22:53 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b004063c9f68f2sm6464342wmr.26.2023.10.22.02.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:52 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 15/62] memory: initialize 'fv' in MemoryRegionCache to make
 Coverity happy
Message-ID: <b15c18c51910ec5ef8c506f641f487507e42c79b.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

From: Ilya Maximets <i.maximets@ovn.org>

Coverity scan reports multiple false-positive "defects" for the
following series of actions in virtio.c:

  MemoryRegionCache indirect_desc_cache;
  address_space_cache_init_empty(&indirect_desc_cache);
  address_space_cache_destroy(&indirect_desc_cache);

For some reason it's unable to recognize the dependency between 'mrs.mr'
and 'fv' and insists that '!mrs.mr' check in address_space_cache_destroy
may take a 'false' branch, even though it is explicitly initialized to
NULL in the address_space_cache_init_empty():

  *** CID 1522371:  Memory - illegal accesses  (UNINIT)
  /qemu/hw/virtio/virtio.c: 1627 in virtqueue_split_pop()
  1621         }
  1622
  1623         vq->inuse++;
  1624
  1625         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
  1626     done:
  >>>     CID 1522371:  Memory - illegal accesses  (UNINIT)
  >>>     Using uninitialized value "indirect_desc_cache.fv" when
  >>>     calling "address_space_cache_destroy".
  1627         address_space_cache_destroy(&indirect_desc_cache);
  1628
  1629         return elem;
  1630
  1631     err_undo_map:
  1632         virtqueue_undo_map_desc(out_num, in_num, iov);

  ** CID 1522370:  Memory - illegal accesses  (UNINIT)

Instead of trying to silence these false positive reports in 4
different places, initializing 'fv' as well, as this doesn't result
in any noticeable performance impact.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Message-Id: <20231009104322.3085887-1-i.maximets@ovn.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/exec/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 653a32ea10..9087d02769 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2793,6 +2793,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
 {
     cache->mrs.mr = NULL;
+    /* There is no real need to initialize fv, but it makes Coverity happy. */
+    cache->fv = NULL;
 }
 
 /**
-- 
MST


