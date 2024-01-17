Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E2B830765
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:56:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6Ol-0007wG-5l; Wed, 17 Jan 2024 08:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Oh-0007vq-PM
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rQ6Og-00089C-DB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705499761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kS2WAmOHdrkxbvPOyunFLrbVq9uDKow/7IG7tcqqxaQ=;
 b=JqIEdiGevmPaGb89YnlreUUTSf4/zmmmAp/NSAzOPITviUfUoi5GewLPC31DsuoTjVHGn8
 2ldGva9CNzZjGHuxd/I+lco8uYmQkH12t8mp+Cc1yDG7JMRJP8R+SEdqAO+bRMSYxNLUwU
 wdYYqwnel4i/zHATNn/i6aqMu/KHQYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-NOA2Dhc4Ny2H6L9NkD9ctA-1; Wed, 17 Jan 2024 08:55:57 -0500
X-MC-Unique: NOA2Dhc4Ny2H6L9NkD9ctA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D1C4185A780;
 Wed, 17 Jan 2024 13:55:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9F433C25;
 Wed, 17 Jan 2024 13:55:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mario Casquero <mcasquer@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: [PATCH v1 0/2] memory-device: reintroduce memory region size check
Date: Wed, 17 Jan 2024 14:55:52 +0100
Message-ID: <20240117135554.787344-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Reintroduce a modified region size check, after we would now allow some
configurations that don't make any sense (e.g., partial hugetlb pages,
1G+1byte DIMMs).

We have to take care of hv-balloon first, which was the case why we
remove that check in the first place.

Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Mario Casquero <mcasquer@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>

David Hildenbrand (2):
  hv-balloon: use get_min_alignment() to express 32 GiB alignment
  memory-device: reintroduce memory region size check

 hw/hyperv/hv-balloon.c | 37 +++++++++++++++++++++----------------
 hw/mem/memory-device.c | 14 ++++++++++++++
 2 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.43.0


