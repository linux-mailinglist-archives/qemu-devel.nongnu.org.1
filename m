Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02658904A1A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 06:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHFjV-0007EA-II; Wed, 12 Jun 2024 00:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHFjU-0007Dy-0i
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 00:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHFjS-0000UT-L7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 00:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718167029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SrPmXAa27xscV/3MOBy7pJT+ntgDtpZwdgANC6pFgs0=;
 b=MztYT8902u/H/9iNFVUrZw8QuaCCLOEwMPynRB4nzu9C7MsnM2mFmjjOlgexzoy3L5YhO9
 Vd6L7i1XdS+7goy1X1ngCb4a7xC6rchdIyc85RtXfBhO8VHqIK0A+0kAucCiawsv4xrHUL
 eBeUKLsGEAGXFEg51w28wDr9K3Wm2ow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-SQ73EhU_OhOKr8l--FDXpw-1; Wed,
 12 Jun 2024 00:35:58 -0400
X-MC-Unique: SQ73EhU_OhOKr8l--FDXpw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 696F11956094; Wed, 12 Jun 2024 04:35:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.216])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FB8C30000C4; Wed, 12 Jun 2024 04:35:53 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v4 0/1] qga/linux: Add new api 'guest-network-get-route'
Date: Wed, 12 Jun 2024 12:35:46 +0800
Message-Id: <20240612043547.282552-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

v3 -> v4
- Fix some indentation issues
- Update 'Since 8.2' to 'Since 9.1'
- Remove useless enum and adjust this change.

v2 -> v3
- Remove this declaration and make the function 'hexToIPAddress' as static.
- Define 'IFNAMSIZ' from kernel instead of a hardcode
- Remove 'GUEST_NETWORK_ROUTE_TYPE_LINUX'
- Set flags 'has_xxx' for checking if a field exists or has a value set

v1 -> v2
- Replace snprintf() to g_strdup_printf() to avoid memory problems.
- Remove the parameter 'char ipAddress[16]' in function 'char *hexToIPAddress()'.
- Add a piece of logic to skip traversing the first line of the file

Dehan Meng (1):
  qga/linux: Add new api 'guest-network-get-route'

 qga/commands-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

-- 
2.40.1


