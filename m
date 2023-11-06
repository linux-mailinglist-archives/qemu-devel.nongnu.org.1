Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E97E1EA4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzx25-0001Yr-GB; Mon, 06 Nov 2023 05:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qzx1o-0001TZ-2R; Mon, 06 Nov 2023 05:40:20 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qzx1e-0007hG-EZ; Mon, 06 Nov 2023 05:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=oTzSlnwFiwNNyo9+XLJSozlV3tES1c1DD/ZmREeHw24=; b=AFLH666BhTE9iLsKwkcxfjYYVk
 EK1GRnKx1eeQSIv4t+AlzQ51FcOiV4PCFI+D9tzyDeaMe6dga8PYsEugIJlk8ThSR6cXwK2AKXIxM
 vYAXj7UM09WBHcehjYNl+F4q/IdDbIauXkudVIoN/MgOzhWFA+Pyh9VobKDkjCaBQ0r3+ac+bZ7f4
 vjf/MzboSSR81s4957qqdvrSVWv9ufNI6hAQ3y8jvHLmnO/b1ZYN4vlIQa8/WUDuCtsOyPoL13Siu
 1oguA+OYtjBq95Y5Tnq77a8QjdpITiik2VpWIa7KX8H7aNQBgSFdL60drlP/vZ+JFZUNtSuxNPsF8
 R+CngbmA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qzx1P-005R1i-Rt; Mon, 06 Nov 2023 10:39:56 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1qzx1Q-000qGH-0X; Mon, 06 Nov 2023 10:39:56 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org
Subject: [PULL 6/7] hw/xen: take iothread mutex in xen_evtchn_reset_op()
Date: Mon,  6 Nov 2023 10:39:54 +0000
Message-ID: <20231106103955.200867-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106103955.200867-1-dwmw2@infradead.org>
References: <20231106103955.200867-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org;
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

The xen_evtchn_soft_reset() function requires the iothread mutex, but is
also called for the EVTCHNOP_reset hypercall. Ensure the mutex is taken
in that case.

Cc: qemu-stable@nongnu.org
Fixes: a15b10978fe6 ("hw/xen: Implement EVTCHNOP_reset")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/kvm/xen_evtchn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3d6f4b4a0a..b2b4be9983 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1135,6 +1135,7 @@ int xen_evtchn_reset_op(struct evtchn_reset *reset)
         return -ESRCH;
     }
 
+    QEMU_IOTHREAD_LOCK_GUARD();
     return xen_evtchn_soft_reset();
 }
 
-- 
2.41.0


