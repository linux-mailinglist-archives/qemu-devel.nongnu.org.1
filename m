Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D38A435EE
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 08:07:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmp2D-00068W-7v; Tue, 25 Feb 2025 02:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmp2A-000683-8C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmp28-0005JA-No
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740467231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJUwcMDtze5FkBkRSan6dq0u2k5MOAPSeGdYFgAWptk=;
 b=YDlEJDQv+egOJq1dW2lviXwlM127SRRAcU2f1XK0FP3QdCS7DvWzBPG5s0kDCZsclX5uDR
 /BFeZT/CEKAYjlTMCznUkKgn/ZI7JdMdfnTN1tRmfeWuRFlnOL6kzR8UCUrrsfXVo4r/fk
 gyu1w2xmVQ7ImB4a2ltWVxfH15iX9Sk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-qfDQ1ouiP76bj2JZS0dEGQ-1; Tue,
 25 Feb 2025 02:07:07 -0500
X-MC-Unique: qfDQ1ouiP76bj2JZS0dEGQ-1
X-Mimecast-MFC-AGG-ID: qfDQ1ouiP76bj2JZS0dEGQ_1740467226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D4E7180056F; Tue, 25 Feb 2025 07:07:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 906261800352; Tue, 25 Feb 2025 07:06:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH] iotests: Stop NBD server in test 162 before starting the next
 one
Date: Tue, 25 Feb 2025 08:06:50 +0100
Message-ID: <20250225070650.387638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Test 162 recently started failing for me for no obvious reasons (I
did not spot any suspicious commits in this area), but looking in
the 162.out.bad log file, there was a suspicious message at the end:

 qemu-nbd: Cannot lock pid file: Resource temporarily unavailable

And indeed, the test starts the NBD server two times, without stopping
the first server before running the second one, so the second one can
indeed fail to lock the PID file. Thus let's make sure to stop the
first server before the test continues with the second one. With this
change, the test works fine for me again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/162 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 94dae60d304..956c2c5f339 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -65,6 +65,7 @@ done
 
 $QEMU_IMG info "json:{'driver': 'nbd', 'host': 'localhost', 'port': $port}" \
     | grep '^image' | sed -e "s/$port/PORT/"
+_stop_nbd_server
 
 # This is a test for NBD's bdrv_refresh_filename() implementation: It expects
 # either host or path to be set, but it must not assume that they are set to
-- 
2.48.1


