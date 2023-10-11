Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D724A7C4AA1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSl7-0001u3-6m; Wed, 11 Oct 2023 02:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkm-0001su-Pv
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qqSkl-0006t1-Bh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697005890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D25CzooUJ7v1YqwcBdHB5VeRjwWXGUOkNrkeDmGkRvY=;
 b=LlrxKJEgvwMJVHf4ygUgXYNug8B58E/Zc0QKxSdO5Td/6CcpEwYIc/kJogXT/DVRDrDAnG
 sgiHD0/niAN0USGmpXOh8nOjH8c+7B5FEJUZc8g+cdTJF03XTcPg/D7QRY46ovoIPcYG0Q
 +sqy+JcRF/NI14w5byYbUwG09tX+Nog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-Ou8rWIp0OV2dxZMrjXDCJg-1; Wed, 11 Oct 2023 02:31:19 -0400
X-MC-Unique: Ou8rWIp0OV2dxZMrjXDCJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7B393857B63;
 Wed, 11 Oct 2023 06:31:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC14492B04;
 Wed, 11 Oct 2023 06:31:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	stefanha@redhat.com,
	vr_qemu@t-online.de
Subject: [PULL 3/8] hw/audio/es1370: remove unused dolog macro
Date: Wed, 11 Oct 2023 10:30:56 +0400
Message-ID: <20231011063101.258955-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231011063101.258955-1-marcandre.lureau@redhat.com>
References: <20231011063101.258955-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Volker Rümelin <vr_qemu@t-online.de>

The dolog macro is unused. Remove the macro and use the now unused
ES1370_VERBOSE macro to replace its inverse ES1370_SILENT macro.

Tested-by: Rene Engel <ReneEngel80@emailn.de>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230917065813.6692-3-vr_qemu@t-online.de>
---
 hw/audio/es1370.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 2b55e31a9a..dd09fd59e1 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -24,7 +24,6 @@
 
 /* #define DEBUG_ES1370 */
 /* #define VERBOSE_ES1370 */
-#define SILENT_ES1370
 
 #include "qemu/osdep.h"
 #include "hw/audio/soundhw.h"
@@ -243,12 +242,6 @@ static void print_sctl (uint32_t val)
 #endif
 
 #ifdef VERBOSE_ES1370
-#define dolog(...) AUD_log ("es1370", __VA_ARGS__)
-#else
-#define dolog(...)
-#endif
-
-#ifndef SILENT_ES1370
 #define lwarn(...) AUD_log ("es1370: warning", __VA_ARGS__)
 #else
 #define lwarn(...)
-- 
2.41.0


