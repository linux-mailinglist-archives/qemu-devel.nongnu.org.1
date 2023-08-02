Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD376C731
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6TU-0005Wh-Q4; Wed, 02 Aug 2023 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TQ-0005Vq-FY
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TO-00023x-Vv
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690962046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xOy3gfyjEd7PEnJ3QxLsUNeTwwUHFY7zR1d/2vQtoII=;
 b=NR0QrKi5aFCa58MoOaOZOli/r4xJ6FH8ySzH4JUmN3Zudt4dCNedfrkeiJQulcl4vfNx9b
 leB5nBuchSXICmE8flJG1+Js2owDVKbpMLbTTEtD2+PKMpHNfxfSCE+UrvCeps8KT7N/HZ
 rcR9jxLeOKie3P+6T3UZ0/mAuzx7k3Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-5NwHuQ-6PaGlO-GfgHf0jA-1; Wed, 02 Aug 2023 03:40:43 -0400
X-MC-Unique: 5NwHuQ-6PaGlO-GfgHf0jA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7FD329AA3A5;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8CCE492B03;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97CE521E692A; Wed,  2 Aug 2023 09:40:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/3] QAPI patches patches for 2023-08-02
Date: Wed,  2 Aug 2023 09:40:38 +0200
Message-ID: <20230802074041.418954-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 38a6de80b917b2a822cff0e38d83563ab401c890:

  Merge tag 'pull-xen-20230801' of https://xenbits.xen.org/git-http/people/aperard/qemu-dm into staging (2023-08-01 07:27:31 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-08-02

for you to fetch changes up to 2b3edd95186dc505f21d823119cdd0dfb23b3ee0:

  MAINTAINERS: Add section "Migration dirty limit and dirty page rate" (2023-08-02 09:33:38 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-08-02

----------------------------------------------------------------
The patches affect only documentation.  Generated code does not change.

Hyman Huang(黄勇) (3):
      qapi: Reformat the dirty-limit migration doc comments
      qapi: Craft the dirty-limit capability comment
      MAINTAINERS: Add section "Migration dirty limit and dirty page rate"

 MAINTAINERS         |  9 ++++++++
 qapi/migration.json | 64 +++++++++++++++++++++++++----------------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

Hyman Huang(黄勇) (3):
  qapi: Reformat the dirty-limit migration doc comments
  qapi: Craft the dirty-limit capability comment
  MAINTAINERS: Add section "Migration dirty limit and dirty page rate"

 MAINTAINERS         |  9 +++++++
 qapi/migration.json | 64 +++++++++++++++++++++------------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

-- 
2.41.0


