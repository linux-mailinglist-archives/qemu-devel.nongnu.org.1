Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB5886DDE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Mar 2024 14:52:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfIw-0004xY-He; Fri, 22 Mar 2024 09:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfIu-0004wu-Ee
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfIs-0007jk-Ml
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 09:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711115484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F2j3MGbPvnryVhZQN2FWP7gAyDeQ6czpXAsXLIytySQ=;
 b=bQ+8EyvFIqoDJUGjjJTot5+Mbb8HKwzxEmlVzWaiTDGhQ7PnqDEkU5UGcBCuAFLoZ8l4af
 WItniaYJMM/NgpJMjhlPOd99uYcy8uynDF0mTOYB04NYxRlsusvN0A9agTIVx5ThHQVqUv
 xTmyrk3U/gDoJ+OsaGAlyxVtvYantU8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-0d-9fLo8NsCA0Bd937TRzA-1; Fri,
 22 Mar 2024 09:51:22 -0400
X-MC-Unique: 0d-9fLo8NsCA0Bd937TRzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DBC03C021A7;
 Fri, 22 Mar 2024 13:51:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D9C41121306;
 Fri, 22 Mar 2024 13:51:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F84521E6145; Fri, 22 Mar 2024 14:51:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, berrange@redhat.com
Subject: [PATCH 0/3] qapi/migration: Doc fixes
Date: Fri, 22 Mar 2024 14:51:14 +0100
Message-ID: <20240322135117.195489-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

I'd like to get these into the release.  Please review.

Markus Armbruster (3):
  qapi: Improve migration TLS documentation
  qapi: Resync MigrationParameter and MigrateSetParameters
  qapi: Fix bogus documentation of query-migrationthreads

 qapi/migration.json | 91 +++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

-- 
2.44.0


