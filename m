Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44B763813
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOe62-0000tD-1L; Wed, 26 Jul 2023 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5f-0000lU-8x
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOe5c-0006nY-Ll
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690376283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+YgsCpeavCDz7/UaK3djr2ZoQlHT6WF+jHI1uQPD1wo=;
 b=SLf/5QyISd/pLn7RVEipNayGxxrcoEdGAfElgxM7OpILS6Zh4Ojk+F8lQAkZ4pKLEEqIPn
 5Nh8MaR4z9sCaZMRonon0QfuM/8k4bgvu2QoUlUNfKq56m4EOkX/74eXeL48siRibX0qa6
 ixW89JIYRYhFQTefWaeA4RFu9ir1oFY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-FuWCMxtlMeyEXBnTXtZYIg-1; Wed, 26 Jul 2023 08:58:02 -0400
X-MC-Unique: FuWCMxtlMeyEXBnTXtZYIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BACF1C0E0C6;
 Wed, 26 Jul 2023 12:58:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE0FF782E;
 Wed, 26 Jul 2023 12:58:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0021721E60F5; Wed, 26 Jul 2023 14:58:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 3/5] qapi/qdev: Tidy up device_add documentation
Date: Wed, 26 Jul 2023 14:57:58 +0200
Message-ID: <20230726125800.163430-4-armbru@redhat.com>
In-Reply-To: <20230726125800.163430-1-armbru@redhat.com>
References: <20230726125800.163430-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

The notes section comes out like this:

    Notes

    Additional arguments depend on the type.

    1. For detailed information about this command, please refer to the
       ‘docs/qdev-device-use.txt’ file.

    2. It’s possible to list device properties by running QEMU with the
       “-device DEVICE,help” command-line argument, where DEVICE is the
       device’s name

The first item isn't numbered.  Fix that:

    1. Additional arguments depend on the type.

    2. For detailed information about this command, please refer to the
       ‘docs/qdev-device-use.txt’ file.

    3. It’s possible to list device properties by running QEMU with the
       “-device DEVICE,help” command-line argument, where DEVICE is the
       device’s name

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20230720071610.1096458-4-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/qdev.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 2d73b27c2a..6bc5a733b8 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -53,12 +53,12 @@
 #
 # Notes:
 #
-# Additional arguments depend on the type.
+# 1. Additional arguments depend on the type.
 #
-# 1. For detailed information about this command, please refer to the
+# 2. For detailed information about this command, please refer to the
 #    'docs/qdev-device-use.txt' file.
 #
-# 2. It's possible to list device properties by running QEMU with the
+# 3. It's possible to list device properties by running QEMU with the
 #    "-device DEVICE,help" command-line argument, where DEVICE is the
 #    device's name
 #
-- 
2.41.0


