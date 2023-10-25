Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558297D7021
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfEj-00067B-PK; Wed, 25 Oct 2023 10:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfE4-0005CF-FP; Wed, 25 Oct 2023 10:51:18 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfDp-000760-7f; Wed, 25 Oct 2023 10:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Q/tyhQvSuMwg2Gh5kOIH6qsA0eNCoglo/BC/VrIl6Es=; b=KDYI3aY4tMOqlZWdfNfO3LfWji
 oD5wYOBY7+ELSt03QoqbH58su+Ih3wGW5y4L029rvsFpFws8RSdxkpx1kvzrlS+TR8NZrSvLHKS2E
 SjvLuuRm8b/GnqIqaDOe5rDZTyJ/8Guse6k/gguUsxYD44GH6Tn/1C0kqkUq3glxbg20jjPwKv8u9
 Utgyvf4duButgytsgIFvJi/gbUd0SSA1jqoxw3sxA0TP7WEocX4xU//yXPAlhMq2BmAgFO6SYdQxX
 O1MwfOqd73UkIrEQm5B9gRr0qBVYQsayxRgtHc1M0nfSNSW/4X7QtGGxiam1VQgi1BhfsTGnBKIs/
 5Klyv7rQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qvfDZ-00GPLw-00; Wed, 25 Oct 2023 14:50:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qvfDX-002dEB-38; Wed, 25 Oct 2023 15:50:43 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v3 04/28] hw/xen: don't clear map_track[] in xen_gnttab_reset()
Date: Wed, 25 Oct 2023 15:50:18 +0100
Message-Id: <20231025145042.627381-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025145042.627381-1-dwmw2@infradead.org>
References: <20231025145042.627381-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The refcounts actually correspond to 'active_ref' structures stored in a
GHashTable per "user" on the backend side (mostly, per XenDevice).

If we zero map_track[] on reset, then when the backend drivers get torn
down and release their mapping we hit the assert(s->map_track[ref] != 0)
in gnt_unref().

So leave them in place. Each backend driver will disconnect and reconnect
as the guest comes back up again and reconnects, and it all works out OK
in the end as the old refs get dropped.

Fixes: de26b2619789 ("hw/xen: Implement soft reset for emulated gnttab")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/kvm/xen_gnttab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 21c30e3659..839ec920a1 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -541,7 +541,5 @@ int xen_gnttab_reset(void)
     s->entries.v1[GNTTAB_RESERVED_XENSTORE].flags = GTF_permit_access;
     s->entries.v1[GNTTAB_RESERVED_XENSTORE].frame = XEN_SPECIAL_PFN(XENSTORE);
 
-    memset(s->map_track, 0, s->max_frames * ENTRIES_PER_FRAME_V1);
-
     return 0;
 }
-- 
2.40.1


