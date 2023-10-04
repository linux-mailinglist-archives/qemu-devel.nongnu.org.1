Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E62807B7A47
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:39:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxPT-0004bt-5f; Wed, 04 Oct 2023 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnxPP-0004MQ-1P
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnxPN-0007hO-FW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696408744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OT9+Mcc/LT6uQJ0NqnDZQoF+UxtSwg3/c1KaMSMFBV4=;
 b=S3sw1dkXlh9Xlk3yosGR840hTkdnYuGhh79ILJQHAZ56Rx26sw7G3xSovW057NKcgWzrle
 anlQwx0Ni3yP4kgZBjxKoqqcFdvlxuLWPgIL9wiTZZ4YZKnYL+jeRhsZC7ME6iRLVC9tzi
 Jl+J9ZrxXn95uF3hx1zjFdgGa58SIFw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-F4Utnj9iO2q8N3Zjp14A2Q-1; Wed, 04 Oct 2023 04:39:02 -0400
X-MC-Unique: F4Utnj9iO2q8N3Zjp14A2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 115753806714;
 Wed,  4 Oct 2023 08:39:02 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-181.str.redhat.com
 [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7C8B1005B8E;
 Wed,  4 Oct 2023 08:39:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] audio/ossaudio: Fix compiler warning with -Wshadow
Date: Wed,  4 Oct 2023 10:39:00 +0200
Message-ID: <20231004083900.95856-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The "err" variable is only used twice in this code, in a very
local fashion of first assigning it and then checking it in the
next line. So there is no need to declare this variable a second
time in the innermost block, we can re-use the variable that is
declared at the beginning of the function. This fixes the compiler
warning that occurs with "-Wshadow".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/ossaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 3f31852371..c5858284a1 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -549,7 +549,6 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
                        hw->size_emul);
             hw->buf_emul = NULL;
         } else {
-            int err;
             int trig = 0;
             if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
-- 
2.41.0


