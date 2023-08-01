Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58576BBD5
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtdJ-0005FT-CF; Tue, 01 Aug 2023 13:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0db2406a5cb9c31ae87a+7282+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qQtdG-0005Ey-Od
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:06 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0db2406a5cb9c31ae87a+7282+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qQtdE-0003D7-1T
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=bnuFTBlWyIdK6w7isk7gkUOUHEpTYmOFBKU1JBhPJE8=; b=ATH50OTpZn6evx3teX6g2Z5miO
 lWsTYdrNNsTAlG6DYn1fKa9g7u14+cAbMrIu7nHsPeSJJh0+MXdTHvT9iyXq/C5p9nlzd19StllfA
 bwA4cKgDpiplRHHxfWdx9JyZkdl26/Q7uNbqehsjPjqncqa8zGxKO2hl2ejrwfasrB5/AIO66BLpC
 vHFZ3QZMtlmjRWObA7sOmyr6myk12IDxx5XS5P+llbQfqUpkMCv9LMB8InA90kwrp7WQnKS8VJCnF
 k7qQJTT44tc6Llv0LNvISJ8lvop4eCUbRW3S0OHi/N0E3YZUgyzun4gFnTicpCgwyQXKXqbjPfjAl
 G1Iv2MtA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qQtd1-00ACU0-Dh; Tue, 01 Aug 2023 17:57:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qQtcz-000bxg-1P; Tue, 01 Aug 2023 18:57:49 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH for-8.1 1/3] hw/xen: fix off-by-one in xen_evtchn_set_gsi()
Date: Tue,  1 Aug 2023 18:57:45 +0100
Message-Id: <20230801175747.145906-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801175747.145906-1-dwmw2@infradead.org>
References: <20230801175747.145906-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+0db2406a5cb9c31ae87a+7282+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out (CID 1508128) a bounds checking error. We need to check
for gsi >= IOAPIC_NUM_PINS, not just greater-than.

Also fix up an assert() that has the same problem, that Coverity didn't see.

Fixes: 4f81baa33ed6 ("hw/xen: Support GSI mapping to PIRQ")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/xen_evtchn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3d810dbd59..0e9c108614 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1587,7 +1587,7 @@ static int allocate_pirq(XenEvtchnState *s, int type, int gsi)
  found:
     pirq_inuse_word(s, pirq) |= pirq_inuse_bit(pirq);
     if (gsi >= 0) {
-        assert(gsi <= IOAPIC_NUM_PINS);
+        assert(gsi < IOAPIC_NUM_PINS);
         s->gsi_pirq[gsi] = pirq;
     }
     s->pirq[pirq].gsi = gsi;
@@ -1601,7 +1601,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
 
     assert(qemu_mutex_iothread_locked());
 
-    if (!s || gsi < 0 || gsi > IOAPIC_NUM_PINS) {
+    if (!s || gsi < 0 || gsi >= IOAPIC_NUM_PINS) {
         return false;
     }
 
-- 
2.40.1


