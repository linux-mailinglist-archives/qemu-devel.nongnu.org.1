Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D3A45BC9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 11:30:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEex-0004HB-El; Wed, 26 Feb 2025 05:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEev-0004G8-2W
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEep-0003fc-Mk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740565728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SG8udyNgcXPK4khZdpXuLvQKpbrngN6G82L4C6A6YgM=;
 b=Kyi+A5dKbqiUh+81/z4Zlw4JnZOXraHPDj/Qye7m7A7BZar+ILYTGGE8t+AMMFWYNUOP7e
 NH1F/9/0Ttmu5qhs96WZaSKlI+eFYvz11JgygZK2YS38L/rVeQwPgzFBfDifM11iPXZFs6
 lRX2HDXviGJ7W7AKj/jegIPUyMpUK/U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-giNQthmDPs2hSe6NrAYXLw-1; Wed,
 26 Feb 2025 05:28:46 -0500
X-MC-Unique: giNQthmDPs2hSe6NrAYXLw-1
X-Mimecast-MFC-AGG-ID: giNQthmDPs2hSe6NrAYXLw_1740565725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C417519373D9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C7501800367
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9384921E65E0; Wed, 26 Feb 2025 11:28:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 2/6] qapi: update pylintrc config
Date: Wed, 26 Feb 2025 11:28:38 +0100
Message-ID: <20250226102842.3721046-3-armbru@redhat.com>
In-Reply-To: <20250226102842.3721046-1-armbru@redhat.com>
References: <20250226102842.3721046-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

If you've got a newer pylint, it'll whine about positional arguments
separately from the regular ones. Update the configuration to ignore
both categories of warning.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-2-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/pylintrc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index c028a1f9f5..d24eece741 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -17,6 +17,7 @@ disable=consider-using-f-string,
         too-many-arguments,
         too-many-branches,
         too-many-instance-attributes,
+        too-many-positional-arguments,
         too-many-statements,
         useless-option-value,
 
-- 
2.48.1


