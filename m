Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D189D3005
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 22:26:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVin-0005tD-Qb; Tue, 19 Nov 2024 16:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDVih-0005pR-Iu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tDVif-0006T4-J7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732051505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NKMn6fMYeGhzOp2bAc6tUoPrS/44I1gCp29gOOd1Hdk=;
 b=Bggtepj9TjEkvTaeK4tIGMwUR+ko6MM6Xcevb9fEyeFGkVAIMRHguoNNuYC3f8ZP9cwlEO
 Hp1EXZ71I+A75jx+13wO/9UQy45D1Zt/SGy0MPD14s+nsCBBWQMOwxT3jcv9ZTUwjzfw2m
 D7X51Irsq5zP5oHISh0iPUc8lXv4vew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-MwkXQTcZPru8SzdzzciF9g-1; Tue,
 19 Nov 2024 16:25:01 -0500
X-MC-Unique: MwkXQTcZPru8SzdzzciF9g-1
X-Mimecast-MFC-AGG-ID: MwkXQTcZPru8SzdzzciF9g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B87B1955EE8; Tue, 19 Nov 2024 21:25:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DE6519560A3; Tue, 19 Nov 2024 21:24:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/1] aspeed queue
Date: Tue, 19 Nov 2024 22:24:55 +0100
Message-ID: <20241119212456.873660-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:

  Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20241119

for you to fetch changes up to 9b0a36494a477541b543fa689c635cf4912fa641:

  docs: aspeed: Reorganize the "Boot options" section (2024-11-19 19:12:12 +0100)

----------------------------------------------------------------
aspeed queue:

* Restructured the "Boot options" section in the aspeed documentation

----------------------------------------------------------------
Cédric Le Goater (1):
      docs: aspeed: Reorganize the "Boot options" section

 docs/system/arm/aspeed.rst | 99 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 13 deletions(-)


