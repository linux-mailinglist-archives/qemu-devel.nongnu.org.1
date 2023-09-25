Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E427ADAA1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmv9-0003bx-O9; Mon, 25 Sep 2023 10:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmuD-0002JJ-SZ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmuB-00006G-Pp
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oRHQQizdCF6wyYh9tuxeDibcUPdwMO6rnTiGfbULx5Y=;
 b=CoM3WumL9xOElmItEOvfviPvtZoD66+VdSIKzQbS2LrqKKBht+9rTOIVwjc8m9aidaD0aA
 k0zAOaSTQkjbEo8i77trmXWouwTpYqRtjbxCHZ1oMyHEcLJ5f4740QcVHmw1Gf4gL2syVQ
 aRa+TimrKIIt+2bDxGkFxzMVx82XOkI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-fiVR7wFDPTyyNvC10psYnw-1; Mon, 25 Sep 2023 10:49:44 -0400
X-MC-Unique: fiVR7wFDPTyyNvC10psYnw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so4851550f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653382; x=1696258182;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRHQQizdCF6wyYh9tuxeDibcUPdwMO6rnTiGfbULx5Y=;
 b=PUh8NhR+gCc6anajEAxqKwfQZjezQGki5sk0G/3Zd4RQsjdIjRQytT5Y7V7Q/iw298
 mkzBQx87G/klD3Sb6GmkjisCb2o04cfJK21pIIL/Nn/BOUSnBTQZ6JYG6uPwAZzdFGSg
 RzWtvrVcvr0pSq6HL3B10C1TeJJ8rVUb/exSWw2QDQ6n/HP5h956mZhfrkUT12b1X8Hr
 T4fwMXZXZfhYI/bOCoRn7nP4QgEVBrZ/sBQnUykIad5DXlB9ygm3nsPDRIK0kISV+Jvw
 fTnuUp0QocV/XFAhktrw7xLFwoYoRvBhqlhWt0bWq5E7a95C3m2E0bwkJIj6ZaAFvjt7
 zYMg==
X-Gm-Message-State: AOJu0YyMgiQgIEv6Hudoj0NOhFpFHhQRXnUppCqXCEhbcBol8E/ujnEC
 +wnw6qeAxVxdQWUPueyWKF8QpWKYfDyumweUkWpmr1I+ks7hc111KA27c0c7XX0oxqB8sNrhR1+
 c0Yrm4OLyrAk0GytY986pTDyahLXwXZ5Ib+y6xo53sCL+JrHfVe34wufuxNDG7P4gAKiO2UnlMM
 4=
X-Received: by 2002:a5d:5607:0:b0:321:c888:1de7 with SMTP id
 l7-20020a5d5607000000b00321c8881de7mr6499513wrv.54.1695653382234; 
 Mon, 25 Sep 2023 07:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5hj23rDqoQqlSw+ozacENoqe/AWJHLT6VRvzqj3nP5BwekVmnyP0hv8OfBrFO9530pCu4AA==
X-Received: by 2002:a5d:5607:0:b0:321:c888:1de7 with SMTP id
 l7-20020a5d5607000000b00321c8881de7mr6499499wrv.54.1695653381895; 
 Mon, 25 Sep 2023 07:49:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z17-20020adfd0d1000000b00317a04131c5sm12047603wrh.57.2023.09.25.07.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:49:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH] user-exec-stub: remove unused variable
Date: Mon, 25 Sep 2023 16:49:40 +0200
Message-ID: <20230925144940.530241-1-pbonzini@redhat.com>
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

enable_cpu_pm is only used by softmmu-specific code, namely target/i386/host-cpu.c
and target/i386/kvm/*.  It does not need a stub definition anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec-stub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 874e1f1a20e..2dc6fd9c4e8 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -2,8 +2,6 @@
 #include "hw/core/cpu.h"
 #include "exec/replay-core.h"
 
-bool enable_cpu_pm = false;
-
 void cpu_resume(CPUState *cpu)
 {
 }
-- 
2.41.0


