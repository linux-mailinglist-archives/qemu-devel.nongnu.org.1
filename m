Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB07AC496B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 09:41:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouL-00041X-Ak; Tue, 27 May 2025 03:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouJ-00040k-J5
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007r9-EP
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTCpHezVaWawe0D6ROo+zGOmqiwfq843Ti5PzOcC6Vw=;
 b=jRvUyCyWTaGGUcKoyBQrbmyOesM6wQwKOfGeQN3PdRnPt2DnLnAR5QqQpgIxKTiNtaN191
 M0gUOLGjRKyWja3oO782f/fq6SHyg/YCRP+G60uE6sU6e/g1oJdTbUarzgHlN7JmZRMaL9
 Bbbsv3sbKESqz0en1Miniau9K4w32a4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-gGgAcXZyM_GLC8qE7A1jog-1; Tue,
 27 May 2025 03:39:23 -0400
X-MC-Unique: gGgAcXZyM_GLC8qE7A1jog-1
X-Mimecast-MFC-AGG-ID: gGgAcXZyM_GLC8qE7A1jog_1748331562
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D1611800EC8; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30C0630001A1; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33C2A21E66BC; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 05/13] qapi: Drop a problematic (Since: 2.11) from
 query-hotpluggable-cpus
Date: Tue, 27 May 2025 09:39:08 +0200
Message-ID: <20250527073916.1243024-6-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 47e915a2e3..ab4e0585f8 100644
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


