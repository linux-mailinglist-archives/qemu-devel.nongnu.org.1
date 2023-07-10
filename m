Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819174D474
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIowB-0005tI-El; Mon, 10 Jul 2023 07:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIow6-0005sh-S4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIow4-0007JB-CW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688988005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eUm1RZPEhPH3R6DeO5eDI43wOXNW+jOvzyvjk6bWYu4=;
 b=D1bjE5zjm+m9hBdfAaSetrnf+2kG73iO6D9uIjSVPBz+WIOOOGWG6JDQLIlecgKe16GdXw
 m8CHm+uTp36A5c33T1WIcMZBDWPbk3uzzSE/VXLeBlZfVOy7GnvPooBSYU1PC3yXe9Bi8z
 svBK2kUCBSjEDbskyklLbYRBS7w5pPE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-gNYPio65N0KsVMW5C4dhhA-1; Mon, 10 Jul 2023 07:20:04 -0400
X-MC-Unique: gNYPio65N0KsVMW5C4dhhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CC912A59562;
 Mon, 10 Jul 2023 11:20:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F05CF40C206F;
 Mon, 10 Jul 2023 11:20:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D71B221E6A1F; Mon, 10 Jul 2023 13:19:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/2] QAPI patches patches for 2023-07-10
Date: Mon, 10 Jul 2023 13:19:57 +0200
Message-ID: <20230710111959.637011-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:

  Merge tag 'pull-tcg-20230709' of https://gitlab.com/rth7680/qemu into staging (2023-07-09 15:01:43 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-07-10

for you to fetch changes up to fd658a7b8cf1091ae2914655add4511865d7edc0:

  migration.json: Don't use space before colon (2023-07-10 07:47:36 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-07-10

----------------------------------------------------------------
Andrei Gudkov (1):
      qapi: better docs for calc-dirty-rate and friends

Juan Quintela (1):
      migration.json: Don't use space before colon

 qapi/migration.json | 117 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 36 deletions(-)

-- 
2.41.0


