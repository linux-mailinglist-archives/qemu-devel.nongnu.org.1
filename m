Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC77E9A5F
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:35:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UHB-0004wE-BM; Mon, 13 Nov 2023 05:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2UH9-0004uy-Aj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2UH7-0003on-0T
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 05:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699871674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iVq1Wg0U6CNdEVHe7JKqbz9R3T3J/OMt9QYqknADCbI=;
 b=dMK5+CabNipaDoNZovIXdJ+GwTQKxtHHoF0eKlfe82H8heB0KE3w69yyLd6Pb0CTNIYsr1
 TpUm7yGdKiJLu23zKo8iYzpHMRP3eXb7Zl4wCXQRwfH43u7xw/Ed9BAGFO1C1sKwkZyokZ
 5KK2NkFgb7aR0E4hCupvdP0W4uJqa8k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-f09ngCdpN6isvqcurCzYPg-1; Mon,
 13 Nov 2023 05:34:33 -0500
X-MC-Unique: f09ngCdpN6isvqcurCzYPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C02E92810D47
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F91C502E
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:34:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BAA021E6A1F; Mon, 13 Nov 2023 11:34:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/3] QAPI patches patches for 2023-11-13
Date: Mon, 13 Nov 2023 11:34:28 +0100
Message-ID: <20231113103431.913394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-11-13

for you to fetch changes up to 5c24c3e2f3b22f1b77d556a14dd3bb8deed1f976:

  tests/qapi-schema: Tidy up pylint warnings and advice (2023-11-13 10:36:51 +0100)

----------------------------------------------------------------
QAPI patches patches for 2023-11-13

----------------------------------------------------------------
Markus Armbruster (3):
      qapi: Fix QAPISchemaEntity.__repr__()
      sphinx/qapidoc: Tidy up pylint warning raise-missing-from
      tests/qapi-schema: Tidy up pylint warnings and advice

 docs/sphinx/qapidoc.py         | 2 +-
 scripts/qapi/schema.py         | 3 ++-
 tests/qapi-schema/test-qapi.py | 9 ++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

Markus Armbruster (3):
  qapi: Fix QAPISchemaEntity.__repr__()
  sphinx/qapidoc: Tidy up pylint warning raise-missing-from
  tests/qapi-schema: Tidy up pylint warnings and advice

 docs/sphinx/qapidoc.py         | 2 +-
 scripts/qapi/schema.py         | 3 ++-
 tests/qapi-schema/test-qapi.py | 9 ++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.41.0


