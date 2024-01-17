Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC258307A3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6dQ-0001hT-92; Wed, 17 Jan 2024 09:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ6dO-0001h2-CO
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ6dM-0002ZS-Oa
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705500671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uNRoSKKfn2UrcpTtGU6LeXSKoj9h3oiNpbIkO1sYlFI=;
 b=QXLRYKhh0+PXVVQ+5utTWUATEP4QnpeaoQ5Q9ptMCuWamiQ2kPZDJzmH2Gxrhyriuca91C
 Su6Js5DQ9wVMEFStmLMKwYrgEU9BAxo59DzjW/W//5qanYJpQ7sU8qcjuFJnalywOWECYt
 fbBpRPf77XHDog6DO5LvQ0zLg/SBq2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-CrCUT98APZyP1wJefz1mwQ-1; Wed, 17 Jan 2024 09:11:07 -0500
X-MC-Unique: CrCUT98APZyP1wJefz1mwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FCDA870829;
 Wed, 17 Jan 2024 14:11:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF8E1121306;
 Wed, 17 Jan 2024 14:11:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 0/2] ppc: Rename power5+ and power7+ for the new QOM naming
 rules
Date: Wed, 17 Jan 2024 15:10:52 +0100
Message-ID: <20240117141054.73841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We can get rid of the "power5+" / "power7+" hack in qom/object.c
by using CPU aliases for those names instead (first patch).

I think in the long run, we should get rid of the names with a "+"
in it completely, so the second patch suggests to deprecate those,
but I'd also be fine if we keep the aliases around, so in that case
please ignore the second patch.

v2:
 - Use "power5p" / "power7p" instead of "power5plus" / "power7plus"

Thomas Huth (2):
  target/ppc/cpu-models: Rename power5+ and power7+ for new QOM naming
    rules
  docs/about: Deprecate the old "power5+" and "power7+" CPU names

 docs/about/deprecated.rst |  9 +++++++++
 hw/ppc/spapr_cpu_core.c   |  4 ++--
 qom/object.c              |  4 ----
 target/ppc/cpu-models.c   | 10 ++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.43.0


