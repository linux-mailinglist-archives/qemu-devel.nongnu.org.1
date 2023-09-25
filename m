Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663367ADABB
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmwu-0006lg-Hs; Mon, 25 Sep 2023 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmv0-0003i0-IX
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmuy-0000VS-J8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdQvSGGskotYWZpKXDQn2G8WmDCjN0olqxObSweRAeI=;
 b=JZR3kNV5dLTnLMVcCoXWrhghKDGtzHj4GtskJO7lM89jXeysJh8FvY+HnVvqnJMwf/gWGZ
 /zswnBpiSXecGVoQ+qHbYao2a6FqtuL151PJkuliWNDCKMO4rAdSL5PGkKag5oWaOMZRX7
 HlZTyZDAYH9Bl6W+KL/gLWP+xRIM0jk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-vDzy-sngOAyAkQ6lQ7P6NQ-1; Mon, 25 Sep 2023 10:50:34 -0400
X-MC-Unique: vDzy-sngOAyAkQ6lQ7P6NQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-321544abeeeso5188528f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653432; x=1696258232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdQvSGGskotYWZpKXDQn2G8WmDCjN0olqxObSweRAeI=;
 b=QjZ5vM9CXSamLy1vOhOiGi/UUBQpYgkhzWQCWhwyQ6eV3Iz3Id3fR2wxwtn8LWv5da
 26DJde59a3q93dMrWd8JgOOqf1E5n5IQi59Vp6DJmVbcoJvMfjCMCfnOfTVKVLrfE8hy
 Tbuoa59rfFRQHdikpca0HE8POyH++N6kqkP6oUDgMJvNwOZpAd3S0bbXvEggDlxarH4U
 2i7rigT3wgDRBULGnOrsbG7YXjuzfjN1E9yBPJTOrmHF6sgYCmX7wJ64ua51lC5n5yv3
 yZIBzuvovWjQX3bBNR7MSnyld28laDUdPPj58FpCdo36oWOo/sHFDoU2QWxyyc6U0KcF
 CLaA==
X-Gm-Message-State: AOJu0YzNNH1T5zdhOsTu2iqZCyA07Vm76DmGx7cP9Ivr9FmQxMYhfCkK
 gdETJVbRPc9ocn1tuTOyPiB7iRRdfUlMH9ZV7KR1QgdFxYiJI0/Dutw4ElMRzeLJejGDRFHBdMv
 NdkTtX3dwN6TbYMKm9x35k94ZpLtJXoEZ/xqyXd1a54xnQYB8QlpMJhb7lJVbJXNQe9X4zf6Fty
 I=
X-Received: by 2002:adf:f34b:0:b0:319:6001:978c with SMTP id
 e11-20020adff34b000000b003196001978cmr7121787wrp.53.1695653432377; 
 Mon, 25 Sep 2023 07:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjdi+VZq/FvhsddwirYU82gpvdtA9cM4ibymnWFNlJCnmr8oNPN2sltWdQP7DN8jl1AXeszQ==
X-Received: by 2002:adf:f34b:0:b0:319:6001:978c with SMTP id
 e11-20020adff34b000000b003196001978cmr7121767wrp.53.1695653431967; 
 Mon, 25 Sep 2023 07:50:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a5d5083000000b003198a9d758dsm12133035wrt.78.2023.09.25.07.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:50:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berange@redhat.com
Subject: [PATCH] ui/vnc: fix enabling of VNC_FEATURE_XVP
Date: Mon, 25 Sep 2023 16:50:30 +0200
Message-ID: <20230925145030.530569-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

VNC_FEATURE_XVP was not shifted left before adding it to vs->features,
so it was never enabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 6fd86996a54..3d13757b72b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2205,7 +2205,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
         case VNC_ENCODING_XVP:
             if (vs->vd->power_control) {
-                vs->features |= VNC_FEATURE_XVP;
+                vs->features |= VNC_FEATURE_XVP_MASK;
                 send_xvp_message(vs, VNC_XVP_CODE_INIT);
             }
             break;
-- 
2.41.0


