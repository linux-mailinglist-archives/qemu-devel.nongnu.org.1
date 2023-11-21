Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD287F2C73
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:01:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PQd-0002y1-3K; Tue, 21 Nov 2023 07:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r5PQH-0002vM-5J
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:11 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r5PQD-0005rZ-Ul
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=YT6J5t49HBLIDY1rRFmVp/qn2SVNoITzH3IqhY+Gn4U=; b=KzBP+Erv6LvVbFhY/NKGoGkcKW
 8deW3tGOi6U5U6SGQN8dpBrRIvRDPbaEg8r6If9ud6cB4Czsk/KIj6Lm6+yhEQHDoTBbIUMPF+ezs
 8UgeXqBbQtuhZ6YrIyk+DFv7tOBI94vafVOKB5HDVxl7dvmm7k3A3DH56prU6mrCCZQvNjKID+Hhz
 VEnwYHd/ygcLJElZp/w71AOWf2wnZfHICbeWVjLjQY9xDSjh2/Kx9HKdWq6gAZ6BJ3cfLdhYEl9sZ
 IRDr7FLtKsiFvAb8CceIVIqgkjaiQ/wFQ+Tp21rP1nZh5CWa8BO0Erpmh8KpgAuRbE+hyEiOPUs1Z
 lmATeAZQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r5PQ7-00BQUe-0U; Tue, 21 Nov 2023 11:59:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r5PQ5-005fd1-2E; Tue, 21 Nov 2023 11:59:57 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Paul Durrant <paul@xen.org>
Subject: [PULL for-8.2 0/2] xenfv queue
Date: Tue, 21 Nov 2023 11:59:55 +0000
Message-ID: <20231121115957.1351656-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org;
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

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/dwmw2/qemu.git tags/pull-xenfv-20231121

for you to fetch changes up to 6f7997e0047e57a9e4f6a0958569f480d07f6538:

  hw/xen: clean up xen_block_find_free_vdev() to avoid Coverity false positive (2023-11-21 11:45:06 +0000)

----------------------------------------------------------------
Xen fixes for 8.2-rc1

 • Disable default serial when xen-console is used
 • Fix Coverity warning in xen-block

----------------------------------------------------------------
David Woodhouse (2):
      vl: disable default serial when xen-console is enabled
      hw/xen: clean up xen_block_find_free_vdev() to avoid Coverity false positive

 hw/block/xen-block.c | 24 +++++++++++++++++++++---
 system/vl.c          |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

