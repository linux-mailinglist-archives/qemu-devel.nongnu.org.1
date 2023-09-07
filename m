Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27487972B7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeZ-0005QQ-1o; Thu, 07 Sep 2023 09:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdm-00046p-63
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdj-0007Sr-Pr
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2HNKEIMd5+PbfiqiQhNPm82diOnCV8my5uMrbrI4ek8=;
 b=Qc3J0NIpFmJgcFvQQ1/A+IBbzBLhHtgGwmCPVomwlAOQKrwtWMRFKs2Cs1oC4fwOJYbMKD
 UdhpMIxvOJslrQ9qEpy6sJKS7Cy9RBNj3nZ/Ukpkj5qeZuqWUGWmzdx9HAedjzbHypQcUY
 jQ9EttpKLlMWxSg+8+TIKDlypxv1hoo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-BsdP6BHHMkm68t5rjRtxGw-1; Thu, 07 Sep 2023 09:01:41 -0400
X-MC-Unique: BsdP6BHHMkm68t5rjRtxGw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso6997215e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091699; x=1694696499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HNKEIMd5+PbfiqiQhNPm82diOnCV8my5uMrbrI4ek8=;
 b=ceVNAlzeS4xcs+JcbusQ7IGZRWN3ErpdQBJmrcx5q/X14Yju+QiT8uBzRrhhUb37ID
 8YLcfu1+bTXoiNxCj3sUBVCRbXd+kPU93kMeHVUedohKHEz2th5ltx4AKywQR9ZgxfiC
 DZsFo4ucODUNTLFyg+8Gc0Jg+mQJXWQ2U5zA9WEK+e/MNp3ycFT060x6iaelublZcvSG
 QGe5/nKQg7+czdkQVkmDKJVRPhUvPnTWyM5miT4wE/z91gXpKQKFnoaHsDFJLjyV8Yb4
 jLprzVqg1JyqJpIqnUlN1dLO/FtgPdRRSEcTqSMf02CRmHiyoyHQ+6vpC6G3rxS8Dntr
 Z7UQ==
X-Gm-Message-State: AOJu0YzG/AcXuu5jEZi046a/sko+AC2dqmFz/kSIcyCTu0E919mH1ldI
 1TLE0rICK3eP/M00CObO8bFRXbU9o0APa7BBdLM1hoXB3IdeFzopNcquvaliDLnYEnz2+U3XCsd
 gIRmPyxJCnFU4dgeDdn8OomcxAAScVldMTEtZnmjdy88vAwevD/HN/nbUoTEMvs4f9NZ3sCLZKk
 s=
X-Received: by 2002:adf:cd86:0:b0:314:152d:f8db with SMTP id
 q6-20020adfcd86000000b00314152df8dbmr4636255wrj.58.1694091698921; 
 Thu, 07 Sep 2023 06:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuPos2+rvK10Y0UOMXDZj1zPBFEMSVN5necgeB+33MGVZ0ripnn3XahIuKQX53ChBqlpGP6w==
X-Received: by 2002:adf:cd86:0:b0:314:152d:f8db with SMTP id
 q6-20020adfcd86000000b00314152df8dbmr4636239wrj.58.1694091698621; 
 Thu, 07 Sep 2023 06:01:38 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 y1-20020adff6c1000000b00317a29af4b2sm23102235wrp.68.2023.09.07.06.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/51] target/i386/helper: Restrict KVM declarations to system
 emulation
Date: Thu,  7 Sep 2023 14:59:49 +0200
Message-ID: <20230907130004.500601-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

User emulation doesn't need any KVM declarations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-5-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 89aa696c6d5..2070dd0dda1 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -22,10 +22,10 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "sysemu/runstate.h"
-#include "kvm/kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
+#include "kvm/kvm_i386.h"
 #endif
 #include "qemu/log.h"
 #ifdef CONFIG_TCG
-- 
2.41.0


