Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E176BBD6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtdJ-0005FU-Jo; Tue, 01 Aug 2023 13:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0bb5590960a200a619e8+7282+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qQtdG-0005Ei-85
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:06 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0bb5590960a200a619e8+7282+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qQtdE-0003DN-1Q
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rfKodFpuUvMf8xRxS1F9RNhEDLvbGFAcnQWQWwOY7tc=; b=d0gSji5iVq/dhOJJq3mlDgWSEF
 W5CC2OZsHD5r1nN/ukFweI2QrtYfk2hzeZjq/QRMRjjgKAK7cAUf8KHvrZFUSWWqui9CyVhnYQESN
 bPy6J3vGoLulgVnlgFHsGq+x/AKzbGDYb34LdIga8k+r4wWjewLB1xKdyFel0oaIdUTeXKCIvBy32
 G5+y5hUkXxR8myGfDLsB+dVjhpibxSdZ62cJYUmt5KVjfBF1zYWGSiVPYyV8CeslqdPDHNgmGh9WB
 hJM/lm4ffbZXEte6WV8JatCGMRK0IsSMHRXZhHI/vQGiXbplfwvNtkOb7cKh79jLZYyyKyZ+mIwBQ
 IoOo+dzA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qQtd2-00EpEM-0s; Tue, 01 Aug 2023 17:57:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qQtcz-000bxm-1j; Tue, 01 Aug 2023 18:57:49 +0100
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
Subject: [PATCH for-8.1 3/3] hw/xen: prevent guest from binding loopback event
 channel to itself
Date: Tue,  1 Aug 2023 18:57:47 +0100
Message-Id: <20230801175747.145906-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801175747.145906-1-dwmw2@infradead.org>
References: <20230801175747.145906-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+0bb5590960a200a619e8+7282+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

Fuzzing showed that a guest could bind an interdomain port to itself, by
guessing the next port to be allocated and putting that as the 'remote'
port number. By chance, that works because the newly-allocated port has
type EVTCHNSTAT_unbound. It shouldn't.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/kvm/xen_evtchn.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 0e9c108614..a731738411 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1408,8 +1408,15 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdomain)
         XenEvtchnPort *rp = &s->port_table[interdomain->remote_port];
         XenEvtchnPort *lp = &s->port_table[interdomain->local_port];
 
-        if (rp->type == EVTCHNSTAT_unbound && rp->type_val == 0) {
-            /* It's a match! */
+        /*
+         * The 'remote' port for loopback must be an unbound port allocated for
+         * communication with the local domain (as indicated by rp->type_val
+         * being zero, not PORT_INFO_TYPEVAL_REMOTE_QEMU), and must *not* be
+         * the port that was just allocated for the local end.
+         */
+        if (interdomain->local_port != interdomain->remote_port &&
+            rp->type == EVTCHNSTAT_unbound && rp->type_val == 0) {
+
             rp->type = EVTCHNSTAT_interdomain;
             rp->type_val = interdomain->local_port;
 
-- 
2.40.1


