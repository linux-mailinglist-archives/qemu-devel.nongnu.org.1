Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095F70B74F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10ai-0004MC-2R; Mon, 22 May 2023 04:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q10af-0004Lt-UN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q10ad-0000KD-Vo
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684742903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fGc3RW3NoflUSRRZoMJKe+V6bTFIiWhjDLKKgWS4PKw=;
 b=Bj77jpWZ8xUZ9HFRltQ1AB+J3gJn40Eg/QmSpSasPo2CspHQoURj18OJRqQsK/IOxmyUMV
 vKIxPQIu+HUyu4GJwrJ4UN7oe3hYbU58aGxpeoBHkV2ADccE09lVbEnWr5aQAkg3VK9XZc
 w3YoRv0ayxM07mrhXNcg+0hIf/lcI1Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425--yO25nK4OGuC7fMHIUB-Xg-1; Mon, 22 May 2023 04:08:19 -0400
X-MC-Unique: -yO25nK4OGuC7fMHIUB-Xg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-510ec47c66aso3815005a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 01:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684742898; x=1687334898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGc3RW3NoflUSRRZoMJKe+V6bTFIiWhjDLKKgWS4PKw=;
 b=e5Xa+y2roVTOXO7C8xD4WmmVN9KqDb/3B/SzOYt6BJHG6SIkiwteU+Rcu4ZDaGrMBv
 NwnIlF7m//3AADJHCdRPUHnDS57HIYrAKFT9pQu9Q6XC5kdzhGDeH2D+7lKxNYlbV0TG
 YcPfs01pNX6Xm4dNU0c5fzcXQ4qug5M120TTSkdJ0SbaomrJyngD1ohfRdrqaHe4I951
 V3GmbNzjyB3azRhrfNMTftQx/z5gGfXQLMRetuxlbY+YNZEAUrLpZJxzSKLdICdqAnOT
 5FymFQr960PW1vddxUsYRoX5sM+eFPOyJLNWMSdvAvZT0uJAN1v9L8Noc2bKC8iHKiRm
 Yb1w==
X-Gm-Message-State: AC+VfDyqCeWFRIR68S4Te040X+8W/WYd6GgC7AZs99TO6kB3ufFPzqRu
 anGa7UfCKMhJI7QsVhola7i7cP/gzjANmYMr+iZjtT98WBO1APp33CIZZpH5W993AU5JC+pDEOZ
 w3cnRz+cMwS3tewKaoQgFLfmtJS6czRqwvdtwoyPxn6s7fwmA4O2UXh12oJcs6rO8kSYemMWeMF
 4=
X-Received: by 2002:aa7:d619:0:b0:50d:f881:1afc with SMTP id
 c25-20020aa7d619000000b0050df8811afcmr7787994edr.23.1684742898121; 
 Mon, 22 May 2023 01:08:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eMVGmP6knKm+DIwTN1Nb2A8ThMINI4H3GtdepXlYLHqlzoYRRfTX52DfF1KMhA9+1/aTE3Q==
X-Received: by 2002:aa7:d619:0:b0:50d:f881:1afc with SMTP id
 c25-20020aa7d619000000b0050df8811afcmr7787981edr.23.1684742897765; 
 Mon, 22 May 2023 01:08:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a05640212c300b0050d8b5757d1sm2735745edx.54.2023.05.22.01.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 01:08:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: vr_qemu@t-online.de,
	marcandre.lureau@redhat.com
Subject: [PATCH] meson: remove -no-pie linker flag
Date: Mon, 22 May 2023 10:08:16 +0200
Message-Id: <20230522080816.66320-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The large comment in the patch says it all; the -no-pie flag is broken and
this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
("build: move remaining compiler flag tests to meson", 2023-05-18).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 0a5cdefd4d3d..6733b2917081 100644
--- a/meson.build
+++ b/meson.build
@@ -267,10 +267,15 @@ endif
 # has explicitly disabled PIE we need to extend our cflags.
 if not get_option('b_pie')
   qemu_common_flags += cc.get_supported_arguments('-fno-pie')
-  if not get_option('prefer_static')
-    # No PIE is implied by -static which we added above.
-    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
-  endif
+  # What about linker flags?  For a static build, no PIE is implied by -static
+  # which we added above.  For dynamic linking, adding -no-pie is messy because
+  # it overrides -shared: the linker then wants to build an executable instead
+  # of a shared library and the build fails.  Before moving this code to Meson,
+  # we went through a dozen different commits affecting the usage of -no-pie,
+  # ultimately settling for a completely broken one that added -no-pie to the
+  # compiler flags together with -fno-pie... except that -no-pie is a linker
+  # flag that has no effect on the compiler command line.  So, don't add
+  # -no-pie anywhere and cross fingers.
 endif
 
 if not get_option('stack_protector').disabled()
-- 
2.40.1


