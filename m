Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F544822279
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 21:20:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKlEQ-000664-8v; Tue, 02 Jan 2024 15:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKlEM-00065W-Fb
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1rKlEK-0005d9-SP
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704226753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M35FDrds7nsyL3BqFj865YC4K75Z01CHjlCPyxRcQw8=;
 b=X1tosQ0BqY4BNSJDOWTHj23RpFJS+cf2/e08UDQnxVk2OeIYJgsl6ygbsBx5vdeaKX7dc3
 q+Zz9KCENdzWwWSTvkx/JCVNxY+jO2XZ2lVI3Sl5EqfE4lY6iHUm/j+ASeL8bWlfdRBr5c
 EHUTmLbfoqEzYKZAdDW78+1TYNr8I6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-gPN5Ol03P1qFnFnwq7Acaw-1; Tue, 02 Jan 2024 15:19:11 -0500
X-MC-Unique: gPN5Ol03P1qFnFnwq7Acaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2F0F85A588;
 Tue,  2 Jan 2024 20:19:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBA81121306;
 Tue,  2 Jan 2024 20:19:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@trasno.org,
	Juan Quintela <quintela@redhat.com>
Subject: [PATCH 0/1] Leaving Red Hat
Date: Tue,  2 Jan 2024 21:19:06 +0100
Message-ID: <20240102201908.1987-1-quintela@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

Hi

After so many years it has been a difficult decision to make, but I am
leaving Red Hat, and with it I am leaving QEMU development and
Migration Mainteinership.

I leave you in good and capable hands with Peter and Fabiano.

I have really enjoyed working with all of you.  I have learned a lot
working with you.

Looking at git logs, it appears that my 1st commit is from:

commit 4f3a1d56e45bcd325f1e8a976290142bc8662bee
Author: Juan Quintela <quintela@redhat.com>
Date:   Thu Jun 25 00:07:59 2009 +0200

    Rename OBJS to obj-y

So it have been almost 15 years.

As you can see for the commit, I changed the configure script to make
it more configurable and the change was so bad that Paolo ended
rewriting all of it in meson :-)

I am cc'ing my personal account because I lost access to this address
today.

Again, thanks for everything.

Later, Juan.

Juan Quintela (1):
  Leaving Migration

 MAINTAINERS | 3 ---
 .mailmap    | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.43.0


