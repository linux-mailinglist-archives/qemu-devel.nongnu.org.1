Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C734FA6D068
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Mar 2025 18:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPPE-0002vW-NT; Sun, 23 Mar 2025 13:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOZ-0002Y3-LJ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOW-00040F-OD
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742751954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TgjrKvs+Rgek0Ip1Pq2Qg415rEQxe4MGbST0j3Bs/10=;
 b=C8X4Pyd/S9HHzKaU+wlecqzA8Bdlr9DKK0kx7b9yyLLWGiUe1YGMGkfVIRaPf1FV7AMshU
 Zm9hrDi+54B/FOVVpypmQrr5uJhK0i2Pq/lYGZWEezPs5vuYvZF50Hq9w1dPtNpL6knT3h
 2lIMqVe90D6eMCMktH5/j4uehr6qVjQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-rew5AWrSMyGFDy01fL3bNw-1; Sun,
 23 Mar 2025 13:45:52 -0400
X-MC-Unique: rew5AWrSMyGFDy01fL3bNw-1
X-Mimecast-MFC-AGG-ID: rew5AWrSMyGFDy01fL3bNw_1742751951
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA852196D2CD; Sun, 23 Mar 2025 17:45:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B1951956095; Sun, 23 Mar 2025 17:45:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/3] aspeed queue
Date: Sun, 23 Mar 2025 18:45:38 +0100
Message-ID: <20250323174541.406860-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 527dede083d3e3e5a13ee996776926e0a0c4e258:

  Merge tag 'pull-request-2025-03-19' of https://gitlab.com/thuth/qemu into staging (2025-03-20 08:41:25 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250323

for you to fetch changes up to 78877b2e06464f49f777e086845e094ea7bc82ef:

  hw/misc/aspeed_hace: Fix buffer overflow in has_padding function (2025-03-23 18:42:16 +0100)

----------------------------------------------------------------
aspeed queue:

* Fix AST2700 SoC model

----------------------------------------------------------------
Jamin Lin (1):
      hw/misc/aspeed_hace: Fix buffer overflow in has_padding function

Steven Lee (1):
      hw/intc/aspeed: Fix IRQ handler mask check

Troy Lee (1):
      aspeed: Fix maximum number of spi controller

 include/hw/arm/aspeed_soc.h | 2 +-
 hw/intc/aspeed_intc.c       | 2 +-
 hw/misc/aspeed_hace.c       | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)


