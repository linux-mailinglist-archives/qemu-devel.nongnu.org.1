Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7682B34A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:48:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyD5-0007Aa-El; Thu, 11 Jan 2024 11:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyCz-000798-KC
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyCy-0003mE-2l
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704991626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyIDGIbxXYd/oGpGGhzPzh90GZVlbZnXmz4mwowZw6E=;
 b=c8dY2fYG4H7nViQQnOuiMdbguJwizixVsmneBoEdMPlz1Y3YDIBc1romZ6OIbEMMAYMdE4
 mLxMsuVJT4Lxlbf4UkMZLRuK/a53dkz2SwE9GSgTZx3pJpIfVV0n6CiqAVnqsmXBTIw6OQ
 Qj3PVL6HAzvGrQQB/bundC1h+aNUf0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-jLCGGv3RPGyvRbilKRlIsQ-1; Thu, 11 Jan 2024 11:47:02 -0500
X-MC-Unique: jLCGGv3RPGyvRbilKRlIsQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1F1E85A588;
 Thu, 11 Jan 2024 16:47:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D28FD492BC7;
 Thu, 11 Jan 2024 16:46:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] docs/about: Deprecate the old "power5+" and "power7+" CPU
 names
Date: Thu, 11 Jan 2024 17:46:52 +0100
Message-ID: <20240111164652.908182-3-thuth@redhat.com>
In-Reply-To: <20240111164652.908182-1-thuth@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

For consistency we should drop the names with a "+" in it in the
long run.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2e15040246..7fdd2239b4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -245,6 +245,15 @@ Nios II CPU (since 8.2)
 The Nios II architecture is orphan. The ``nios2`` guest CPU support is
 deprecated and will be removed in a future version of QEMU.
 
+``power5+`` and ``power7+`` CPU names (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+The character "+" in device (and thus also CPU) names is not allowed
+in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
+``power7+`` and ``power7+_v2.1`` are currently still supported via
+an alias, but for consistency these will get removed in a future
+release, too. Use ``power5plus_v2.1`` and ``power7plus_v2.1`` instead.
+
 
 System emulator machines
 ------------------------
-- 
2.43.0


