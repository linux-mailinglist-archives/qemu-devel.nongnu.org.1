Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4A8307AC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:12:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6dV-0001iz-34; Wed, 17 Jan 2024 09:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ6dT-0001iT-Fs
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQ6dS-0002aL-2N
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705500677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXdXnkVGUN4LL6uKIFuM+Dpppukbb5cwyjjLoWCdv1s=;
 b=YhQwSpVZNQ3XpRU9aRKneilL4N47ruSa5UQrQhzza2UvisUWQsonAkvbmxOIYb2w97U61F
 Ou8kYNTskV+ZlZf9i6Q3YW2QcJ13QVfDh/v49vS9ZT7vvMhZcpbRinAH4W7f7RdIo0hNJ+
 YjOh4Dg0BHEKmt5TcpjQymM9i2hCAWo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-X1vAAlbnNae0qBQba9EjxA-1; Wed,
 17 Jan 2024 09:11:13 -0500
X-MC-Unique: X1vAAlbnNae0qBQba9EjxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B24638143BE;
 Wed, 17 Jan 2024 14:11:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59A551121306;
 Wed, 17 Jan 2024 14:11:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/2] docs/about: Deprecate the old "power5+" and "power7+"
 CPU names
Date: Wed, 17 Jan 2024 15:10:54 +0100
Message-ID: <20240117141054.73841-3-thuth@redhat.com>
In-Reply-To: <20240117141054.73841-1-thuth@redhat.com>
References: <20240117141054.73841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

For consistency we should drop the names with a "+" in it in the
long run.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b47763330c..251723d264 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -217,6 +217,15 @@ Nios II CPU (since 8.2)
 The Nios II architecture is orphan. The ``nios2`` guest CPU support is
 deprecated and will be removed in a future version of QEMU.
 
+``power5+`` and ``power7+`` CPU names (since 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''
+
+The character "+" in device (and thus also CPU) names is not allowed
+in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
+``power7+`` and ``power7+_v2.1`` are currently still supported via
+an alias, but for consistency these will get removed in a future
+release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
+
 
 System emulator machines
 ------------------------
-- 
2.43.0


