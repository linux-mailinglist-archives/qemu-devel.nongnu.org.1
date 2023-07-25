Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124B9761E6C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKou-0003OO-Qd; Tue, 25 Jul 2023 12:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKot-0003OD-0C
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKor-0003m5-Bp
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690302207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6luOsGaQgoP1Q68BAZtJOgXhYnQ2RtNqlXsmVBZ/A+o=;
 b=cn4dkntD5Dm+ICwCvFmhDH3t0RGVh31MFVH81mrxmWkMnBuTaDZuPinJzbR4zOzKDc4npR
 4K7ddQPPivMtdS1OWoGyhLpQu3zEdchNSNC0sbofmUSQcfH387fhzLfOx7HpKIwVEq+17J
 lKvffFdORw87YHRPS0UxXRpsUA5RStI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-FEucH-jVMdiB3PSmOSVsRw-1; Tue, 25 Jul 2023 12:23:26 -0400
X-MC-Unique: FEucH-jVMdiB3PSmOSVsRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3F548030AC;
 Tue, 25 Jul 2023 16:23:25 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68C32145414B;
 Tue, 25 Jul 2023 16:23:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Canokeys.org" <contact@canokeys.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 0/2] Misc next patches
Date: Tue, 25 Jul 2023 17:23:00 +0100
Message-ID: <20230725162304.156157-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit a279ca4ea07383314b2d2b2f1d550be9482f148e:

  Merge tag 'pull-target-arm-20230725' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-07-25 12:44:39 +0100)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to 095be0910b89b5d156e20641bd65ac6cab3f8305:

  hw/usb/canokey: change license to GPLv2+ (2023-07-25 17:15:59 +0100)

----------------------------------------------------------------
Miscellaneous fixes

 * Switch canokey device license from Apache to GPLv2+
 * Fix uninitialized variable warning in LUKS code

----------------------------------------------------------------

Akihiko Odaki (1):
  crypto: Always initialize splitkeylen

Hongren (Zenithal) Zheng (1):
  hw/usb/canokey: change license to GPLv2+

 crypto/block-luks.c | 4 ++--
 hw/usb/canokey.c    | 2 +-
 hw/usb/canokey.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0


