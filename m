Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9AB1F264
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Aug 2025 07:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcTX-0001tF-9k; Sat, 09 Aug 2025 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTV-0001sn-7b
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTS-0002Hf-Nh
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754718633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8STwwrBJYcYwqTQnBTm+Dh8pn1ht5aP6l3EsrmXF+2E=;
 b=ISLGTiolRS08PfIVSP/EemmBY1BoA/L95dQxcGKfDqFWgWkIAioxr/J1q98U3y5OiA4C1n
 se7KlchPZc/DGbiZGXPhDVk9RPIYryiVQvKDbcqq3wbC39fZTYPkFRVarl3S/JzEojWxqK
 Q6BhwmsX/1aAEKsG2OytOtm3bi0LlPQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-7b6vl5qCMACUsF40jkwTBw-1; Sat,
 09 Aug 2025 01:50:31 -0400
X-MC-Unique: 7b6vl5qCMACUsF40jkwTBw-1
X-Mimecast-MFC-AGG-ID: 7b6vl5qCMACUsF40jkwTBw_1754718630
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A55B18003FC
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6B7518002B4
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E964421E6924; Sat, 09 Aug 2025 07:50:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 1/3] docs/devel/qapi-code-gen: Add two cross-references we
 missed
Date: Sat,  9 Aug 2025 07:50:24 +0200
Message-ID: <20250809055026.2944835-2-armbru@redhat.com>
In-Reply-To: <20250809055026.2944835-1-armbru@redhat.com>
References: <20250809055026.2944835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Missed in commit 9c66762a601 (docs/qapi-code-gen: add
cross-references).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250731054044.4011789-2-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index dfdbeac5a5..138921b386 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -646,9 +646,9 @@ Member 'event' names the event.  This is the event name used in the
 Client JSON Protocol.
 
 Member 'data' defines the event-specific data.  It defaults to an
-empty MEMBERS object.
+empty MEMBERS_ object.
 
-If 'data' is a MEMBERS object, then MEMBERS defines event-specific
+If 'data' is a MEMBERS_ object, then MEMBERS defines event-specific
 data just like a struct type's 'data' defines struct type members.
 
 If 'data' is a STRING, then STRING names a complex type whose members
-- 
2.49.0


