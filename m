Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35788773A04
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLRS-00082J-4W; Tue, 08 Aug 2023 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLRJ-00081W-2w
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLRC-00039R-Ri
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691496226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDpiSRBkRVqIOjZj8B0XMEbI4X90+GIWA1+GsNLrDD4=;
 b=GEOr7DQbLloN4QI2LzCN+XdZYMUxOrRtZEj0uygg/ky8TsGeQLZHm5ZZJ3Opcef05Ev2iT
 rbRhQRs3p+hzrZHrhTLxs3TYI69Q6abgF9MC0+H7yhQG2C13DQ34VcNKW213w+r2Ny0+6q
 WVkTlyK41Tlz0t9IAWICcGiyhXmFLR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-tg3ilEuXPtOA6cBg3apq5A-1; Tue, 08 Aug 2023 08:03:44 -0400
X-MC-Unique: tg3ilEuXPtOA6cBg3apq5A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3178e3f46b1so2593392f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 05:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691496222; x=1692101022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDpiSRBkRVqIOjZj8B0XMEbI4X90+GIWA1+GsNLrDD4=;
 b=DrCNYhWd+GUIx67EbZqsOn8vJCEBz8Jzt+JUk8SFqpomupOK7kqJoZTssLCvJfGwwv
 BhK976yIl6FkBxugpvlIx1x1+gRsWHPJozlCai4CEnX1t1Bs/tEjTBOP6BEBB3iktGpq
 KcY6HVN59RJ8RrRiI4lIe9aN5Zud1anhdcOlypPYzy76fg2+izABhhj2gwHd7cl/jy7O
 NJduj1QHYt3bmhTAznlj0Xv5nvYcaNwQHfKzYlUvQLEe7UvnMop1AH2Ysgo19KIGR+H5
 YQ4ebo3aS8wuvrmZhsCM8HRckjlxZiZeK/uvJQfrsz/5EeAUdHRt08YcQlVNBVUBWpwr
 iGAg==
X-Gm-Message-State: AOJu0YxLYMMMVTXazmOaQgUSHbdMhQ6pe1sQbBwpCmOG6M7+fvtyydGW
 iDxB7yVAvLwuUG7yDFHB1lQjwnSRimXbqd+MluPA1uKGn4wlD5U7O+V1Iwr3GXjhgPzMjRKTATf
 8sQM9MLuN77I2ESyY9+OiMIfwln9dlEkM0e5LB+Kzb4Qje5Uzz3RObmDHrMwgYYfnikroqn5u5+
 g=
X-Received: by 2002:a05:6000:1181:b0:317:6ef1:7939 with SMTP id
 g1-20020a056000118100b003176ef17939mr7772936wrx.23.1691496222283; 
 Tue, 08 Aug 2023 05:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIgDgzlMclEIz0rlVCg0h5X+27y1d4LDVob7n4SlPtPAmLQGnftCUwGjEsVQloDy1XeSFiIA==
X-Received: by 2002:a05:6000:1181:b0:317:6ef1:7939 with SMTP id
 g1-20020a056000118100b003176ef17939mr7772910wrx.23.1691496221727; 
 Tue, 08 Aug 2023 05:03:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adfe8c2000000b00317ddccb0d1sm9560839wrn.24.2023.08.08.05.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 05:03:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, iii@linux.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/3] configure: fix detection for x32 linux-user
Date: Tue,  8 Aug 2023 14:03:01 +0200
Message-ID: <20230808120303.585509-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808120303.585509-1-pbonzini@redhat.com>
References: <20230808120303.585509-1-pbonzini@redhat.com>
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


