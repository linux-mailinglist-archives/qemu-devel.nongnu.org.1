Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC6782BE05
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOELf-00045Z-Bz; Fri, 12 Jan 2024 05:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELc-000451-LV
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELb-0005cc-1U
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705053666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7Hf3PazTUyDnqEFZTOBZUrmb5mGVkeujKPQoZqJCe4=;
 b=ZhnozPolTku9aMmwLklfDw3F2i2TJCfoTHBuolSex+OoSA7t53HnF0bJF58r7OW5cQuc/r
 XChOacgteoo12MPAX6VNhqrpjDlm5FcieLkiIxJigQQLuMvVMCnsfn5dH0CbNm/sGOEFmw
 8iQPLJw3s9PNmMVhE/ijhwrWPCJRN4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-ZBM2CXdJPj2YFRqqC-OeOw-1; Fri, 12 Jan 2024 05:01:02 -0500
X-MC-Unique: ZBM2CXdJPj2YFRqqC-OeOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1DAC185A781;
 Fri, 12 Jan 2024 10:01:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C27DBC08ED4;
 Fri, 12 Jan 2024 10:01:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 0/5] Remove deprecated command line options
Date: Fri, 12 Jan 2024 11:00:54 +0100
Message-ID: <20240112100059.965041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

The -no-hpet, -no-acpi, -async-teardown, -chroot and -singlestep
options have been deprecated for at least two releases, so it should
be fine if we remove them now.

Thomas Huth (5):
  qemu-options: Remove the deprecated -no-hpet option
  qemu-options: Remove the deprecated -no-acpi option
  qemu-options: Remove the deprecated -async-teardown option
  qemu-options: Remove the deprecated -chroot option
  qemu-options: Remove the deprecated -singlestep option

 docs/about/deprecated.rst       | 28 --------------------
 docs/about/removed-features.rst | 30 +++++++++++++++++++++
 system/vl.c                     | 37 +-------------------------
 qemu-options.hx                 | 46 ---------------------------------
 4 files changed, 31 insertions(+), 110 deletions(-)

-- 
2.43.0


