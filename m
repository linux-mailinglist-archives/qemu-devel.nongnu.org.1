Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7F7745DA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRj5-0005FC-5U; Tue, 08 Aug 2023 14:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiU-0005Aj-3M
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiR-000477-OH
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691520358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Bv8JdoNTjQ+tK0TA7SxnpbKuBA0pAV9QRkRTxlQpM4=;
 b=TGT8I5vJMrPI2winFuv6kawB/tXHRi3eTUFMZEvmERk4mo1LIY2RWajyvvVq9DRJwuuoMo
 2KPC7XJJkY5hw1lq1075dINfo5xjf29e0bzQCUG6Z9DhfCqeRJOCEpILN0TtyfOLmIKrfq
 JR26eQTKb7jWnayKemyKpqRMMPJxEHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-abz8nsJDNfCTJhIoUryR7A-1; Tue, 08 Aug 2023 14:45:56 -0400
X-MC-Unique: abz8nsJDNfCTJhIoUryR7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe175fc1f8so38846825e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520354; x=1692125154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Bv8JdoNTjQ+tK0TA7SxnpbKuBA0pAV9QRkRTxlQpM4=;
 b=Ef7csR/ICYuKphNWHXtbzciMkuOVp0BKC5kujfaFp3hrK4BioQvEr2E95tps73nUFp
 sYqwDYDILrAyuao31tlOUg24pnilxRGpVKme1kvFqB5A/ONBbjb8ZsqRstxiJJkBLscg
 YRpGiZCUaRPXmPYYixg5auuMDPjeYriPS6g7qJe/RfsO1g6yDiYLH95kaeBIfDKCh6yM
 8HNH9hs8r9gmMU2+/ch/uYYcXfzfKfXei8p4vZa2FaNBqesSjdU4XxYgfBjbmXMSw7+U
 nwpcFiRfepdRFoC2H4cvTeNcxGcH+1bIVHC8m9Lb36R1U5mKPUhNbCQ7rf/ahREXcGTH
 o4MA==
X-Gm-Message-State: AOJu0YxxFIYHLkHM0ZB2Pee9bP415tr7OcKnr2XZtofO/31XRSNL2NDy
 AqIfnUZAd4/eonUeXcpaiJLb5MzYnoO7c11kr9xx6xC8Vsl133Zz+Do8H+rzQRbndjXhSIgKakg
 loE+A2SNIsFralxx9Z7tutoCuGfu0xBEdkkxxGOR/ybQH/72UQ4HuIRSuaslqlUTGNSudRAgIcd
 0=
X-Received: by 2002:a1c:7c0b:0:b0:3f9:b244:c294 with SMTP id
 x11-20020a1c7c0b000000b003f9b244c294mr539090wmc.35.1691520354570; 
 Tue, 08 Aug 2023 11:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKCWw79nwpntF3lbWpe29AGO5oZywWtq4D64Zq/3B4XPy3d5r8WIEc/SPV+cOhviLgoTL/tg==
X-Received: by 2002:a1c:7c0b:0:b0:3f9:b244:c294 with SMTP id
 x11-20020a1c7c0b000000b003f9b244c294mr539069wmc.35.1691520354141; 
 Tue, 08 Aug 2023 11:45:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a1c7414000000b003fe215e4492sm14608034wmc.4.2023.08.08.11.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 11:45:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/3] configure: fix detection for x32 linux-user
Date: Tue,  8 Aug 2023 20:45:49 +0200
Message-ID: <20230808184551.684522-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808184551.684522-1-pbonzini@redhat.com>
References: <20230808184551.684522-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

x32 uses the same signal handling fragments as x86_64, since host_arch
is set to x86_64 when Meson runs.  Remove the unnecessary forwarder and
set the host_arch variable properly in configure.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20230808120303.585509-2-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                 | 2 ++
 linux-user/include/host/x32/host-signal.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)
 delete mode 100644 linux-user/include/host/x32/host-signal.h

diff --git a/configure b/configure
index 98dc78280e6..484d38d81f4 100755
--- a/configure
+++ b/configure
@@ -472,6 +472,8 @@ fi
 case "$cpu" in
   riscv*)
     host_arch=riscv ;;
+  x32)
+    host_arch=x86_64 ;;
   *)
     host_arch="$cpu" ;;
 esac
diff --git a/linux-user/include/host/x32/host-signal.h b/linux-user/include/host/x32/host-signal.h
deleted file mode 100644
index 26800591d3b..00000000000
--- a/linux-user/include/host/x32/host-signal.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../x86_64/host-signal.h"
-- 
2.41.0


