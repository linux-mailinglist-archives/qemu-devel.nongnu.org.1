Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27EACC04C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 08:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLHC-0007x6-CX; Tue, 03 Jun 2025 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGa-0007jO-Ig
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMLGY-0003R7-DZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748932613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XUGSxN51OLohv8fvmaAoOjtoyORALr4taS/zHagj5c=;
 b=ah3g/AAotAPeUd0bZUir82maotD9xAHIYlJuV/w9M8t1Zbsftj49rLdLx9BBRM/c5rBpXn
 vzw2qMrdflHX0PNic7HOkurrA84XAgpGBeV1ltUaikFrMw5k4d8BpNu4WphwpDT4VpwHvQ
 uFuFApFevlJz0dQwDM8z9ofZRwkrH5k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-o-bmm1xyMQCbzImjLqpJsQ-1; Tue,
 03 Jun 2025 02:36:51 -0400
X-MC-Unique: o-bmm1xyMQCbzImjLqpJsQ-1
X-Mimecast-MFC-AGG-ID: o-bmm1xyMQCbzImjLqpJsQ_1748932611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CA97180045B
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B89A918008DC
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 06:36:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F271221E661C; Tue, 03 Jun 2025 08:36:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 05/13] qapi: Drop a problematic (Since: 2.11) from
 query-hotpluggable-cpus
Date: Tue,  3 Jun 2025 08:36:36 +0200
Message-ID: <20250603063644.3953528-6-armbru@redhat.com>
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There is a (Since: 2.11) in a query-hotpluggable-cpus example.
Versioning information ought to be in the command description, not
examples.  The command description is basically empty (there is a TODO
about it).

What exactly didn't work before 2.11 is not quite clear from the
documentation.  The example was added in commit 4dc3b151882 (s390x:
implement query-hotpluggable-cpus), which suggests the command failed
for the s390x target until then.  This was almost eight years ago, and
I doubt anyone still cares about this detail.  Simply delete
the problematic (Since: 2.11).

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250527073916.1243024-6-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5eb67fc4e9..230b9b20dd 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1089,7 +1089,7 @@
 #    :annotated:
 #
 #    For s390x-virtio-ccw machine type started with
-#    ``-smp 1,maxcpus=2 -cpu qemu`` (Since: 2.11)::
+#    ``-smp 1,maxcpus=2 -cpu qemu``::
 #
 #     -> { "execute": "query-hotpluggable-cpus" }
 #     <- {"return": [
-- 
2.48.1


