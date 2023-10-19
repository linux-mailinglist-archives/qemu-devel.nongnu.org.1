Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A47D01B9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhN-0000QY-Pt; Thu, 19 Oct 2023 14:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfY-0006u5-HN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfV-0000nk-Gq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=GrDi3LZSnNwdvte7QS1jn4iHhxmI/k5K6IDKzSvAed5ufaRSUwXGNGhklnXB+alVs4Z24D
 /onS+d5QwDEaNfWwIPJwNqTjspJ9QmNEQN86QFRrAssEr2ofrvENH5hjRXsuNc05gSiKJZ
 Dy/kSdjuHToD8BynogSLjjDs5eRBXYM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Y7kTLzHAPMSJ1TXjy_dq7g-1; Thu, 19 Oct 2023 14:22:38 -0400
X-MC-Unique: Y7kTLzHAPMSJ1TXjy_dq7g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50234741eso66283451fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739756; x=1698344556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=wwV1Fns4zUygu0BC2KGqoGXf1V5TV8u9DWdxvP3biM9/ixluU1e9lzWlSE2kvooH/y
 +AO1xko4G75dqIB3USVQUWj7iMnrEKDjWjEq7+aVNnGK2QXzPg+GZrlRwwDadqCANbHj
 n73x55IOGMXtw2mcwwn1Xma/atQpHqrrRMJLDucGXa6tdUQiWBpMaLA+vVgsHba8iCMm
 klO1ZXV6VzvNZ41OAqrIS8Sos7tPR5Qm2qJQSenhtYfmW8/qiCN30iHDXPNc3VnxTH1q
 FAgc4KUef+6CXJHBo9oGQKtk1zUoUcqynxEORHR27W/cOQan9NZOcCNc/aqtwrXmzfNR
 v0DA==
X-Gm-Message-State: AOJu0Yw5W9ZJebFY3ZP/bGPrZitECNZ2xyq0a5yEv7iobC8Gp1+C8lBg
 1PCYxid9bUSOKaBwGF39jFftCdHYgzIyqpz3XzSgfydPrXTPYVRtjB1Q/JpnLaJ7w2M/LVs8ti4
 r6GWm29qSLEguQQfgNVdPV20IByNAHZtlBgjlEau3aOXDSHAKNn1nptG6hzUU8rtwiLm2
X-Received: by 2002:a05:651c:a0d:b0:2c5:275b:c5fc with SMTP id
 k13-20020a05651c0a0d00b002c5275bc5fcmr2556405ljq.0.1697739756204; 
 Thu, 19 Oct 2023 11:22:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/UfhEvTKJjIMbIxtpHHlQN+tDgB2VtcQL3eUQCnS5N8d31YLHJodRT5PyvG+tv6w9RGAI9A==
X-Received: by 2002:a05:651c:a0d:b0:2c5:275b:c5fc with SMTP id
 k13-20020a05651c0a0d00b002c5275bc5fcmr2556386ljq.0.1697739755847; 
 Thu, 19 Oct 2023 11:22:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c138300b003fc0505be19sm201198wmf.37.2023.10.19.11.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:35 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 31/78] memory: initialize 'fv' in MemoryRegionCache to make
 Coverity happy
Message-ID: <1653545368d4849af5e1ed3e7c1815900c004b12.1697739629.git.mst@redhat.com>
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


