Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332657CE1EF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vJ-0005VL-He; Wed, 18 Oct 2023 11:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8u8-0003Ls-Dk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8u3-0006wO-0d
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=bE8ktpEi7yI2cgcdUGROFCKSlWT18O8srzdQYwvPgqViWohsjhyP7cFeJLFLK2zt9l5N/0
 RBtCrQBRzMvEVJfPTPvK224AbncaqQtBcLmmYxAPJPk2DdInCguwaddRZBXcmGA1UJdFla
 TLx048UU/67FI3ur5CWOvLBc7OjZpMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-d8z93-ZtMSeIgnfiWxRugA-1; Wed, 18 Oct 2023 11:56:08 -0400
X-MC-Unique: d8z93-ZtMSeIgnfiWxRugA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083fec2c30so2976305e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644567; x=1698249367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAXg1GA35XKbMBiopu3Arj0qNQ/LAhb7uC4aAavHa34=;
 b=Yxs1zkjap4psrGoVlDqe551aGqKM8Tgyvqo6sG8ZXWLpwpX9Fen+CVBojoVGHFuvMd
 irXewwXPHOkw8JU2qA55LCt2pJ3cFn3uW9OVCETiTtWxhlJ+HRMWJX/3+ORUBiEtC/Vv
 wUAFRNdliIbQ8RKUMsKY3oGgTDGB9rHwbH+pVLXdeqD9lPnD8YNcuhoI/dVzPf9dprb8
 DaUqhp+tWL0nHnRtSlD7kawfWB+Hmt8vdMuKtduCIqOEGCEBv2HENgunKw6ni8H3k2tL
 u5BR4Xt32bOqGropGRIsACb/laMxtpFWGX4bLGK38EsveQFWodtqrrOy9bRiDXU7uhl6
 jpig==
X-Gm-Message-State: AOJu0YygXZj2UUlEu2+SVCGhrwxVrTah01gs4vfQ68DW2wLiLwzkwAAD
 tNoT3Rotkl3KFydbshioOKWs/pnysLNA0gdLNYb7JDseUX38NbgvRejURwBkT8HjoYFdzHM9bap
 Lj7S0bt/fSaTN8dHn8da2kuu8v8o5eLvMxmbezuyXrY+Dc8x0Ck1H5AQkuDz1Y4SqLfXv3lc=
X-Received: by 2002:a05:600c:45cc:b0:405:1c14:9227 with SMTP id
 s12-20020a05600c45cc00b004051c149227mr4304234wmo.33.1697644566915; 
 Wed, 18 Oct 2023 08:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZueD3mHa1BRBjCgtj0WLZmW1tAHEoAOgpcxe/yLn2feyfcnsrwX+AVb0L0Nu/SgsluQPZng==
X-Received: by 2002:a05:600c:45cc:b0:405:1c14:9227 with SMTP id
 s12-20020a05600c45cc00b004051c149227mr4304212wmo.33.1697644566459; 
 Wed, 18 Oct 2023 08:56:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 g38-20020a05600c4ca600b004078d71be9csm1966656wmp.13.2023.10.18.08.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Maximets <i.maximets@ovn.org>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/83] memory: initialize 'fv' in MemoryRegionCache to make
 Coverity happy
Message-ID: <26f1dcaa0e9ff83187b8dba810545f8b2a940b5a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


