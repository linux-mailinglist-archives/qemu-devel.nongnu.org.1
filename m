Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F0734E81
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:50:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBAZh-0001LM-U7; Mon, 19 Jun 2023 04:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBAZN-0001Fk-Td
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBAZG-00024Z-V7
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687164532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iKdoVULisYsGh6aMjrQmThEmOlIJ7FGW2j+eN6OAuX8=;
 b=CpWImGvi2HbPsROjn490+Q7Qg3pmnzy1EqQ0FUMeKmqdA43i8WKlXrSClbXzFxsKRVRz+o
 IFQtHARS9GfDiqjRBpIHjwOBRKTKoTKAZkzZFYg+/P4TOuhratQTjRvO3xM49i0a/l9gAN
 pY7t8cwCf5Zf0DOO5uLi/RwCJMEmZ8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-9m2X63OuOUKurZLdtrIzYA-1; Mon, 19 Jun 2023 04:48:47 -0400
X-MC-Unique: 9m2X63OuOUKurZLdtrIzYA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BACF43C025BB
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:48:46 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.225.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4F240F01A
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:48:46 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Subject: 
Date: Mon, 19 Jun 2023 10:48:12 +0200
Message-ID: <20230619084841.453130-2-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Expose the recently added multi touch support on the UI DBus backend

Bilal Elmoussaoui (2):
  ui/touch: Move event handling to a common helper
  ui/dbus: Expose a touch device interface

 include/ui/console.h | 15 ++++++++++
 ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-console.c    | 59 +++++++++++++++++++++++++++++++++++++++-
 ui/dbus-display1.xml | 45 ++++++++++++++++++++++++++++--
 ui/gtk.c             | 61 ++++-------------------------------------
 ui/trace-events      |  1 +
 6 files changed, 187 insertions(+), 59 deletions(-)

From: Bilal Elmoussaoui <belmouss@redhat.com>
Reply-To: 
Subject: 
In-Reply-To: 



