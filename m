Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D485E79EDF8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSQn-0006Pz-OK; Wed, 13 Sep 2023 12:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgSQj-0006Pa-S5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgSQh-0008Bp-Sa
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694621367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yN9ulhstEfYSpc5PFwjoauD7eWs5GEeGc+5scU/R5LE=;
 b=aAUhLVmjgH8uXSXQqkgikT3bo8b/8LAKFarnx1ckNlhCqLbf1Md3/FQkiTEpnpo2OujM8+
 VV3Edq939tFMlvj3DA4YbMd7yl+Cy6E9r4ODVxbOcgfiiTCQJv/86/nhHJwme1DDyopQJe
 2HFzUTfPG+nLuDtP3Iy59vtnPsbcikk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-t2mlwEo7M2yOUP5FV_FOOQ-1; Wed, 13 Sep 2023 12:09:24 -0400
X-MC-Unique: t2mlwEo7M2yOUP5FV_FOOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3580E101B457;
 Wed, 13 Sep 2023 16:09:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 054082026D4B;
 Wed, 13 Sep 2023 16:09:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/2] hw/mips/jazz: Rework the NIC init code
Date: Wed, 13 Sep 2023 18:09:20 +0200
Message-ID: <20230913160922.355640-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

The NIC init code of the jazz machines is rather cumbersome, with
a for-loop around it that is always left after the first iteration.
This patch series reworks this a little bit to make the code more
readable and shorter.

v2:
- Dropped the first patch from v1 since it has been solved
  differently by the patch "trivial: Simplify the spots that
  use TARGET_BIG_ENDIAN as a numeric value" recently
- Rebased the code on top of that RARGET_BIG_ENDIAN change

Thomas Huth (2):
  hw/mips/jazz: Move the NIC init code into a separate function
  hw/mips/jazz: Simplify the NIC setup code

 hw/mips/jazz.c | 81 ++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

-- 
2.41.0


