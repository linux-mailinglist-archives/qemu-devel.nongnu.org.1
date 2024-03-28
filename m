Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D5870329
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 14:47:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8dk-0000c9-8x; Mon, 04 Mar 2024 08:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8dY-0000Zn-Ac
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8dU-0000uq-4j
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709559942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1nFQj4CjJ+IggkqrNmL8xsnI4ujHd8sd976jGH+SGw=;
 b=NbahAeBNFMF0UjWXdbDxkFodWvFzatspMdKrgeLJfie7LZ0DP1l8KAxPduA31xu+byz5/A
 FOo7ol12+6PDkxX0G/5uTlpmCmct8TaxNnvwgNYZ1y5WRS7RKn91M7sNchLcSgNdsrowY+
 6y+XiYtnyyjqykaszjhkXqfGO7SKL5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-6aHCxK3SMWWBPI0_ZpHoRg-1; Mon, 04 Mar 2024 08:45:38 -0500
X-MC-Unique: 6aHCxK3SMWWBPI0_ZpHoRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F48C8350E5;
 Mon,  4 Mar 2024 13:45:38 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97BC224D;
 Mon,  4 Mar 2024 13:45:37 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH v4 3/3] qga-win: Add support of Windows Server 2025 in
 get-osinfo command
Date: Mon,  4 Mar 2024 15:45:32 +0200
Message-ID: <20240304134532.28506-4-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-1-kkostiuk@redhat.com>
References: <20240304134532.28506-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

From: Dehan Meng <demeng@redhat.com>

Add support of Windows Server 2025 in get-osinfo command

Signed-off-by: Dehan Meng <demeng@redhat.com>
Message-ID: <20240222152835.72095-4-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a830f1494e..d1cf1a87db 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2153,6 +2153,7 @@ static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
+    {26040, "MIcrosoft Windows Server 2025",    "2025"},
     { }
 };

--
2.44.0


