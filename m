Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDAB85E33D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 17:28:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpQn-0007Mx-3g; Wed, 21 Feb 2024 11:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQk-0007LW-22
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQi-0008C6-9B
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708532802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ljwIyYpQK02meb9bEw/ZI8Rn2tnQIotIw3Gx9JYmh0s=;
 b=Q/K2SyFMurxRzeJ6BJKSSXtUDdtBiKpm592PYM0ZlaA3XEDXX7/XIuSUUC1jkEhprMJ0QG
 2rGW8DONodAyZ0Wd81SJ/wCvcytqJUnK2vQy3Ab66Lqx4a4dEf/93PLh9pX1MTjM0w4a/V
 1aWh80k8K3R4WubtCl63sTxxocfkPb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-gq90FChoNRq8n-x80QAtWg-1; Wed,
 21 Feb 2024 11:26:40 -0500
X-MC-Unique: gq90FChoNRq8n-x80QAtWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBA4B1C0BB69;
 Wed, 21 Feb 2024 16:26:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45B6F2015B7E;
 Wed, 21 Feb 2024 16:26:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/3] Replace variable length arrays in ppc KVM code
Date: Wed, 21 Feb 2024 17:26:33 +0100
Message-ID: <20240221162636.173136-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It would be good to enable -Wvla as an additional security feature
when compiling QEMU (see also Peter's explanation here:
https://lore.kernel.org/qemu-devel/20240125173211.1786196-1-peter.maydell@linaro.org/ ).
There are currently only two spots with variable lengths arrays left,
so if we fix those, we can finally enable the -Wvla compiler switch.

Peter Maydell (1):
  meson: Enable -Wvla

Thomas Huth (2):
  target/ppc/kvm: Replace variable length array in kvmppc_save_htab()
  target/ppc/kvm: Replace variable length array in kvmppc_read_hptes()

 meson.build      | 1 +
 target/ppc/kvm.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.2


