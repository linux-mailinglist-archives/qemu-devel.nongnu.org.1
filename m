Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8394C44F
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Aug 2024 20:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7qh-0007DE-Gd; Thu, 08 Aug 2024 14:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qb-0006vi-5i
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc7qW-0000zg-EW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723141603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SncE1h/EeL+j/tz8NjXwJJEqHu/BANr04XTQmYyojaQ=;
 b=ALGLFEFl+lfXgmyvSZ/CZ3AaLkjn/RSxg7/XSLHwBhehKipd27lc8X3HoXa3wdWFgMhSaC
 iU+6emuBJkalxZIxyRk047X6ctyuCaO9DhXsIU88qaoz/nTbFmgDwRVVfNIVnfwiE4zgDi
 +uTvUdvKRkPFTnrBiBt3A2xStTKXSrc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-J8tZnwXcNkG83xDrUGw44w-1; Thu,
 08 Aug 2024 14:26:40 -0400
X-MC-Unique: J8tZnwXcNkG83xDrUGw44w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EDEB19541A0; Thu,  8 Aug 2024 18:26:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE5D1955F40; Thu,  8 Aug 2024 18:26:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CCB121E5A6B; Thu,  8 Aug 2024 20:26:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
Subject: [PATCH 3/6] qapi/crypto: Supply missing member documentation
Date: Thu,  8 Aug 2024 20:26:33 +0200
Message-ID: <20240808182636.3657537-4-armbru@redhat.com>
In-Reply-To: <20240808182636.3657537-1-armbru@redhat.com>
References: <20240808182636.3657537-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since we neglect to document the members of QCryptoAkCipherKeyType,
their description in the QEMU QMP Reference manual is "Not
documented".  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/crypto.json | 4 ++++
 qapi/pragma.json | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 97e02dbd59..67f5855a96 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -610,6 +610,10 @@
 #
 # The type of asymmetric keys.
 #
+# @public: public key
+#
+# @private: private key
+#
 # Since: 7.1
 ##
 { 'enum': 'QCryptoAkCipherKeyType',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 6ff135d8d2..fd6bdcaa6d 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -67,7 +67,6 @@
         'NetClientDriver',
         'ObjectType',
         'PciMemoryRegion',
-        'QCryptoAkCipherKeyType',
         'QCryptodevBackendServiceType',
         'QKeyCode',
         'RbdAuthMode',
-- 
2.45.0


