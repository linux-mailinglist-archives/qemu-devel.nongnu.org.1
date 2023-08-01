Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C652376BBD7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtdI-0005FB-E4; Tue, 01 Aug 2023 13:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0bb5590960a200a619e8+7282+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qQtdF-0005Eb-Un
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:05 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+0bb5590960a200a619e8+7282+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qQtdE-0003DM-1Q
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=8I/mwzZvDUq3i74BLGvziom1tSRSihtpC0IkNTFAoFQ=; b=JzKH+x/CvRZeYDEEIseBUM+3TO
 qwuaxnuefoWln4HNkgPfJ8Q6xyJFEjSsvSJ2iQfqHn6Lg5bZK4V3wS0SVragOllrXbsGddq6JbQ8T
 8OgS+be7cQY9r/ZBkzmoZl7grZrqWtM+4N+TpeHeoOBH8LbENuy6mlAPOvHr2z7zxT+rNnqBxCbWj
 Qmtnvm/n6xh9OUkOcItSjpPLF33EgL0fXMTS90xi1BmjvvKKvwAFKV3ZAY2DxurHnjs+M1rJX4W7p
 k1/hheIbLQMq7LPWjGCNSZkPT7/m9dYMELt5NInx88+MV2uYLFp/b00BQ/XZznGuxoRrrSkI5brW0
 2scAxPIA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qQtd2-00EpEL-0o; Tue, 01 Aug 2023 17:57:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qQtcz-000bxd-1F; Tue, 01 Aug 2023 18:57:49 +0100
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
 Anthony PERARD <anthony.perard@citrix.com>
Subject: [PATCH for-8.1] Misc Xen-on-KVM fixes
Date: Tue,  1 Aug 2023 18:57:44 +0100
Message-Id: <20230801175747.145906-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
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

A few minor fixes for the Xen emulation support. One was just merged, but
there are three outstanding.

David Woodhouse (3):
      hw/xen: fix off-by-one in xen_evtchn_set_gsi()
      i386/xen: consistent locking around Xen singleshot timers
      hw/xen: prevent guest from binding loopback event channel to itself

 hw/i386/kvm/xen_evtchn.c  | 15 +++++++++++----
 target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 14 deletions(-)



