Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35563BB7486
	for <lists+qemu-devel@lfdr.de>; Fri, 03 Oct 2025 17:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hJj-00025J-6P; Fri, 03 Oct 2025 11:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4hJa-00020s-H0
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v4hJK-0006EF-It
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759503774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uj3fGEj2FunP3THKyw714AXURql7wz/YMs/mY0tp41E=;
 b=bW09V2fGF0eyOGtE26FX/8+JeShmErRNvyzO+TEjI7aEM4yrcGzO5Q+cPbVPKkMz0lPMWJ
 ZIxnJwXWEiywhg+vQb3IkjNv4/xXHz4yffZL29OA253xqlEbkIee36uuUiMRjxn/NwqOfv
 72CXgd7xISSCMddB9nF02iiU4IbfSDk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-vt3Jbb6hN1mZuMunrNl7Aw-1; Fri,
 03 Oct 2025 11:02:50 -0400
X-MC-Unique: vt3Jbb6hN1mZuMunrNl7Aw-1
X-Mimecast-MFC-AGG-ID: vt3Jbb6hN1mZuMunrNl7Aw_1759503769
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F0BB195605C; Fri,  3 Oct 2025 15:02:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.145])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C15F71800576; Fri,  3 Oct 2025 15:02:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Grant Millar | Cylo <rid@cylo.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH v2 0/3] io: fix crash in VNC websock server when client quits
 early
Date: Fri,  3 Oct 2025 16:02:42 +0100
Message-ID: <20251003150245.3510069-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

See patch 3 for the description of the problem and reproducer

Changes in v2:

 - Improve finalizer robustness of TLS source
 - Keep cleanup in finalizer of websock, just augment
   it in the close method
 - Fix resetting of hs_ioc_tag value when callback
   is complete
 - Add CVE assignemnt in 3rd patch

Daniel P. Berrangé (3):
  io: release active GSource in TLS channel finalizer
  io: move websock resource release to close method
  io: fix use after free in websocket handshake code

 include/io/channel-websock.h |  3 ++-
 io/channel-tls.c             | 10 ++++++++++
 io/channel-websock.c         | 33 ++++++++++++++++++++++++++-------
 3 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.50.1


