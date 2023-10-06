Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08E7BB104
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 06:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qocpn-0001nO-1v; Fri, 06 Oct 2023 00:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qocpk-0001mg-SW
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 00:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qocpj-0007cr-E8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 00:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696567982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kfzYpKU6kGWo5ne5VC2qHVIotLth3yCR+t98IuRcMPI=;
 b=QQD00XRExu0mKFUo5UJAPAKHSb9s/JdVFA+eKuSz13eksKsESWFXPArNAb0J87BSjfhY9u
 McVZhT0t98AoWxhXourulc22IC5HFNAwa0fQUoy1oOF5JiFBkMwKeN1lz80HCFZtxGHtpG
 kOOcSwVKkEiUukHoI5zSdFy5g5i/2dc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-AHeGgnHwM2yefYUQhe-1rw-1; Fri, 06 Oct 2023 00:52:59 -0400
X-MC-Unique: AHeGgnHwM2yefYUQhe-1rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB04A85A5BD;
 Fri,  6 Oct 2023 04:52:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAFC8215670B;
 Fri,  6 Oct 2023 04:52:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] scripts/xml-preprocess: Make sure this script is invoked via
 the right Python
Date: Fri,  6 Oct 2023 06:52:56 +0200
Message-ID: <20231006045256.395696-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If a script is executable and has a shebang line, Meson treats it as
a normal executable, so that this script here is run via the "python3"
binary in the $PATH. However, "python3" might not be in the $PATH at
all, or it might be a wrong version, so we should make sure to run
this script via the Python version that has been chosen for the QEMU
build process. The best way to do this is to remove the executable bit
from the access mode bits. (See also commit 4b424c757188f7a4)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1918
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/xml-preprocess.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 scripts/xml-preprocess.py

diff --git a/scripts/xml-preprocess.py b/scripts/xml-preprocess.py
old mode 100755
new mode 100644
-- 
2.41.0


