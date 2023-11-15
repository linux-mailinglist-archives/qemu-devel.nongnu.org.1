Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D87EC9AC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jfw-00061d-Cb; Wed, 15 Nov 2023 12:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a72437c23eaab18a7e37+7388+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r3Jft-0005yT-D1; Wed, 15 Nov 2023 12:27:37 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a72437c23eaab18a7e37+7388+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r3Jfr-0007kk-9x; Wed, 15 Nov 2023 12:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=xZ0wYBocgdl60a2Ke1KkDB2txC+xjHjAaO8lJ+NcfrU=; b=XVzGDFHvHAQS7pHVQQYtQa/lLp
 2UoxL3xy8yAGaXIpD3HnYS1Nexe0T24xp6GGBlvQ7XnNUTTstfnTk6JlEbkW5tWd+k2do+YX/362E
 DR5UB6NSCYhGk+b+vs5WIXsgrFrJDP7bLVsNGhATvHJ5BhcEdIqcKo6n8SZfmYmTNktVgO9yvE0To
 lL4uY0PRJ2LnFAT8Taclm5kj3ZIOvAhgMiso1mBHsxWMEw3yskvBkxdFtKIfnJX9zYIOmdsjOjaet
 wboDj3DcmL97sWedEbN1B8S2cnCwgMANT5vxhwvHjC9jx+OdXSY0/Ve02cQI9oX+Z9PYILTBqBQBr
 baiYoa1A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r3Jfi-004Bc0-25; Wed, 15 Nov 2023 17:27:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r3Jfh-004sFA-0O; Wed, 15 Nov 2023 17:27:25 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Subject: [PATCH 0/3] Misc fixes for 8.2
Date: Wed, 15 Nov 2023 17:24:34 +0000
Message-ID: <20231115172723.1161679-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+a72437c23eaab18a7e37+7388+infradead.org+dwmw2@desiato.srs.infradead.org;
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

Fix a use-after-free (or double-free) due to net_cleanup() freeing NICs
that don't belong to it, fix a newly-introduced launch failure with a
documented command line, and clean up code to avoid a Coverity warning.

David Woodhouse (3):
      net: do not delete nics in net_cleanup()
      vl: disable default serial when xen-console is enabled
      hw/xen: clean up xen_block_find_free_vdev() to avoid Coverity false positive

 hw/block/xen-block.c | 24 +++++++++++++++++++++---
 net/net.c            | 28 ++++++++++++++++++++++------
 system/vl.c          |  1 +
 3 files changed, 44 insertions(+), 9 deletions(-)



