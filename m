Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D47D93EF
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHY-0002PZ-Si; Fri, 27 Oct 2023 05:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHV-0002Ou-O9
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHU-0002mQ-7D
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ywjPwjRLke68BV18p+1KU6PhpkhXaeIg2Ghfm880p0=;
 b=YiyK/ARUvujV9AJd3DIiALXV1e4YT0X2YW8avxYSDu38yLKwXpbSbrAFxboAhYzrk06ZdS
 JfQ8VD7yDXkS6VmLRmbtNoDVOXLSBOLyywjOl7eDPY3u1TxolwCXXpf9/4FQm3mCHcbhz8
 m1Ml5woGj86pzVi6UpJzZE3B8TAbth8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-bUrHg5m5PE21Iq3pHJG8RQ-1; Fri,
 27 Oct 2023 05:37:25 -0400
X-MC-Unique: bUrHg5m5PE21Iq3pHJG8RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A11F828237D8;
 Fri, 27 Oct 2023 09:37:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 531451121319;
 Fri, 27 Oct 2023 09:37:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/11] docs/about: Mark the old pc-i440fx-2.0 - 2.3 machine
 types as deprecated
Date: Fri, 27 Oct 2023 11:37:08 +0200
Message-ID: <20231027093710.273558-10-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

As we've seen in the past, it's useful for deprecating old machine
types to finally be able to get of legacy code or do other clean-ups
(see e.g. commit ea985d235b868047 that was used to drop the PCI code in
the 128k bios binaries to free some precious space in those binaries).

So let's continue deprecating the oldest pc machine types. QEMU 2.3
has been released 8 years ago, so that's plenty of time since such
machine types have been used by default, thus deprecating pc-i440fx-2.0
up to pc-i440fx-2.3 should be fine nowadays.

Message-ID: <20231006075247.403364-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/i386/pc_piix.c         | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2febd2d12f..4e0eb2fe02 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -247,6 +247,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+These old machine types are quite neglected nowadays and thus might have
+various pitfalls with regards to live migration. Use a newer machine type
+instead.
+
+
 Backend options
 ---------------
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 334d9a0299..26e161beb9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -849,6 +849,7 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0


