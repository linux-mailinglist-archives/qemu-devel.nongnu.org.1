Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB7285EF53
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Feb 2024 03:55:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rczEW-0004zC-TL; Wed, 21 Feb 2024 21:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczEV-0004yp-B4
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczEU-000447-3J
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708570484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJp20RBQGQ6FqkMDbkxfU3Fvt35vHW6R7eodzLmBRQ0=;
 b=NCUdd+q+oDtba8nMyf8bcAB4dJF2VmQrsf4cSH/GFYYAKvBNt5umQgLmHK0vFTKMOAK8j1
 WH/h1D0+Kuib63r63O/yiZxs86M3ZGOUR89YVP/bP+cmcDZW2A4/CW6/+ATLopdZsXPe8v
 Pr3bAKWpfYSyhm+VgnhVhxQ9KKYiXxU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-pUbp7O0rMjucwFCi4pq59w-1; Wed,
 21 Feb 2024 21:54:43 -0500
X-MC-Unique: pUbp7O0rMjucwFCi4pq59w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B28C11C05ACF;
 Thu, 22 Feb 2024 02:54:42 +0000 (UTC)
Received: from dhcp-8-237.nay.redhat.com (dhcp-8-237.nay.redhat.com
 [10.66.8.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE2C9200B436;
 Thu, 22 Feb 2024 02:54:40 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v2 0/1] update the array size
Date: Thu, 22 Feb 2024 10:54:36 +0800
Message-Id: <20240222025437.58996-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

v1 -> v2
update the array size "WIN_10_0_SERVER_VERSION_MATRIX" in case 
array out of range elements.

Dehan Meng (1):
  qga-win: Add support of Windows Server 2025 in get-osinfo command

 qga/commands-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.35.1


