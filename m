Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01485E11E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 16:30:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoW8-0005Us-2G; Wed, 21 Feb 2024 10:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rcoNO-0006ZR-0A
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rciYP-0008TV-Nd
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708506372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UPjJejj58221Ttl6dUSopoBHFGsM0Vk/itah4E5d9Lg=;
 b=OFzF8pY8cXSSKjTrlPAWzikUWcdhnNUpNqPPKtRpFT3bKfdOWaILSk19j6QgZezI17QJ0j
 GNEYRg6ifdtfzI+Ug/qxvtjJLNpxQf3QWsWfx6j//FV3VuQsW6jiE4Sq9ypfFXvqHUHU7m
 RlxizXGPBDjzQMeZo6cwx1LOD8XDN9E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-pYqxiNthNuyUHrBHasR3aA-1; Wed,
 21 Feb 2024 04:05:05 -0500
X-MC-Unique: pYqxiNthNuyUHrBHasR3aA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD0E4381202F;
 Wed, 21 Feb 2024 09:05:04 +0000 (UTC)
Received: from dhcp-8-237.nay.redhat.com (dhcp-8-237.nay.redhat.com
 [10.66.8.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AC3C10800;
 Wed, 21 Feb 2024 09:05:02 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH 1/1] qga/linux: Add new api 'guest-network-get-route'
Date: Wed, 21 Feb 2024 17:04:58 +0800
Message-Id: <20240221090459.48938-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
- Replace snprintf() to g_strdup_printf() to avoid memory problems.
- Remove the parameter 'char ipAddress[16]' in function 'char *hexToIPAddress()'.
- Add a piece of logic to skip traversing the first line of the file

Dehan Meng (1):
  qga/linux: Add new api 'guest-network-get-route'

 qga/commands-posix.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 80 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)

-- 
2.35.1


