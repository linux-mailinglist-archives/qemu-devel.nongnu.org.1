Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F369749787
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKOC-0007yB-Cs; Thu, 06 Jul 2023 04:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKNv-0007xv-1V
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKNs-00014N-Nz
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FPKz3yUCJ0INz4Xs3zxvgjPnggE/eYR21ynKzcBoWgM=;
 b=RrAr8TGYqKRZ75HCLeOPo8YcGfX2DWL99PpP5bkWOHDwugCWiS2n6c/FXNa9aUnYwCHOhV
 gfzVrXD1jCHLzUA8pBii6Lgv0sybrE00C5J63FgnU0bAoidoZMPfqceoN4TSIXlQNJB98o
 BWcq2+63NIzYi4iQE7ck7ZHLac7PKnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-oLpc7cUNMQW6U_qQ6GslZg-1; Thu, 06 Jul 2023 04:30:38 -0400
X-MC-Unique: oLpc7cUNMQW6U_qQ6GslZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 194E880006E;
 Thu,  6 Jul 2023 08:30:38 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.224.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6C62166B25;
 Thu,  6 Jul 2023 08:30:36 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 0/3] qga: Add new option --allow-rpcs
Date: Thu,  6 Jul 2023 11:30:32 +0300
Message-Id: <20230706083035.623802-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

The allow-rpcs option accepts a comma-separated list of RPCs to
enable. This option is opposite to --block-rpcs. Using --block-rpcs
and --allow-rpcs at the same time is not allowed.

resolves: https://gitlab.com/qemu-project/qemu/-/issues/1505

Konstantin Kostiuk (3):
  qga: Rename ga_disable_not_allowed -> ga_disable_not_allowed_freeze
  qga: Add new option --allow-rpcs
  qga: Add tests for --allow-rpcs option

 docs/interop/qemu-ga.rst |  5 +++
 qga/main.c               | 91 ++++++++++++++++++++++++++++++++++++----
 tests/unit/test-qga.c    | 31 ++++++++++++++
 3 files changed, 118 insertions(+), 9 deletions(-)

--
2.34.1


