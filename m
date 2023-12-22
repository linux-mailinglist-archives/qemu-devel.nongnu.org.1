Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3781CE53
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4Q-0000x1-IU; Fri, 22 Dec 2023 13:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4G-0000wZ-KN
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4E-00068X-Uy
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJqcWh9yKQb2lTOswMjaPmpHyr396rVt92s4avj3LM4=;
 b=Wc1JiUH53h28c+ekwMuOBWF0MOvRtUsMMKozik4qEi0yskzSJrqmh4GuVrabGF+ma3jTVk
 ZrAlaxJ2C4gpj5/6dqVQHvn/lEmL8iHu7qqBKxFxre0525HCsT2VguWqL1YuvyCiWmqAgs
 yiwvp1Z/5wfKwWnpbjemJOQdP1jSVZQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-BJ_sb4AsPiG1nEjS9CCBow-1; Fri, 22 Dec 2023 13:16:11 -0500
X-MC-Unique: BJ_sb4AsPiG1nEjS9CCBow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3367e2bd8b0so1376344f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268970; x=1703873770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJqcWh9yKQb2lTOswMjaPmpHyr396rVt92s4avj3LM4=;
 b=Bvbw3k6AhsWWjcljVwNL0xbEhouJYkRGCVtp9F2L0xalm02j4ynzhcVSrD/5LM1vzc
 pra5O+kMWfNY1HKQZY0S/ssJ8YalPIcnKy3/kERHTGqgEFuy553ksvl155td2+bE/UQ4
 w9cgITDKpFChxenDTZaU55n+nxvPD+yHGwUnNeJFhgJJykIpaxx44IbMF7loG54es7QR
 VokXdxfENkcGo/H9bgYyHsiXLj7rJ8fJBF0c2fz84L/lrlwAjj0kpO9xz8JRuB7jazub
 yn7RCCHIIRlPLfQJFrrwujPcXB89ClOU6m8htVe91VKGsSoq7tcuTe3bwIRNlOsDM72N
 kVzA==
X-Gm-Message-State: AOJu0YxGTB0LAPHXqDNPg6jC1/Kxnk8wG4TzkYFuoe187l+kDUd/QVr0
 g7VvS3Ez+azgEyBui6c3P6CtOFSMyhKg/3RMTukIO/GTSucUwlqEnNKx4Z+bhXoKQVSI+Cnh1Xt
 Y9ZwMvJBC7z0fN9sccuQrUMeLVU1+dV28txzPPhJl0o4pRzfFB2HlLYxDuvdXYN4/HDkGd7jLHI
 VVAk9cvMA=
X-Received: by 2002:a5d:456e:0:b0:336:7a65:299a with SMTP id
 a14-20020a5d456e000000b003367a65299amr1013374wrc.85.1703268970078; 
 Fri, 22 Dec 2023 10:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm9Z9b+nwjXu8YRgbFrF5WOv62YGZoIouhwFafnN0LpwcbUwZaLUbWxzeDQmQtxu8qbrTSJQ==
X-Received: by 2002:a5d:456e:0:b0:336:7a65:299a with SMTP id
 a14-20020a5d456e000000b003367a65299amr1013369wrc.85.1703268969652; 
 Fri, 22 Dec 2023 10:16:09 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d640b000000b003364e437577sm4817567wru.84.2023.12.22.10.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/22] target/i386: speedup JO/SETO after MUL or IMUL
Date: Fri, 22 Dec 2023 19:15:43 +0100
Message-ID: <20231222181603.174137-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

OF is equal to the carry flag, so use the same CCPrepare.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8fb80011a22..a16eb8d4008 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1020,6 +1020,9 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
+    case CC_OP_MULB ... CC_OP_MULQ:
+        return (CCPrepare) { .cond = TCG_COND_NE,
+                             .reg = cpu_cc_src, .mask = -1 };
     default:
         gen_compute_eflags(s);
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-- 
2.43.0


