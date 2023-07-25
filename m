Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81671761E72
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:26:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKqi-0005NC-Pe; Tue, 25 Jul 2023 12:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKqe-0005Mf-Lz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOKqZ-00041l-6d
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690302301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TKbDNc7KTFIFHpk8Vh5Ld9dDIM1QLJGoZHPlu5Ndo2k=;
 b=KgKQ1C90FjFiYTFfaveFYnoaBi7f8W7X7XNWCejP3LgpEz6Iroo7c+aEu1jXq3+fUk92pQ
 2flIBSmFtqYxjDQw1TL776MtvbkAayLQx3fk922RgIEGpwqDarboLTUf7/Mg8VU0NNKaYq
 8U/f4JjQ2G/rfqUBZHpjrex1CF4ZN5Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-G6-n8JrsOwSVDV6cdbRfeQ-1; Tue, 25 Jul 2023 12:24:59 -0400
X-MC-Unique: G6-n8JrsOwSVDV6cdbRfeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44FB42804602;
 Tue, 25 Jul 2023 16:24:59 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B732166B26;
 Tue, 25 Jul 2023 16:24:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Canokeys.org" <contact@canokeys.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>
Subject: [PULL 0/2] Misc next patches
Date: Tue, 25 Jul 2023 17:24:55 +0100
Message-ID: <20230725162457.156429-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

for you to fetch changes up to 0e6b20b9656174e815751cf8b21f5e326148bb99:

  hw/usb/canokey: change license to GPLv2+ (2023-07-25 17:24:12 +0100)

----------------------------------------------------------------
Miscellaneous fixes

 * Switch canokey license from Apache to GPLv2+
 * Fix uninitialized variable in LUKS driver

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


