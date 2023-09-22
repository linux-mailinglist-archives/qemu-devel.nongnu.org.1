Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83C7AAE15
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVk-0004in-Oa; Fri, 22 Sep 2023 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVd-0004iB-PJ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVa-0003Lu-V7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXr0dDzaioo9uY5bLIe7ScF/gjUT2yjP9YjbogdmloQ=;
 b=Dvfrkqyk0ZXzO/gLzOuf747tq2/ijmXqSVegLAH3KpXeFc6vcqSLMkMYq0zSp9Wj2l+v3u
 4WrFK09WqgSg6CyD7FeYfTGQGY6v3mA6Kj9TNs+sWU/PVJMUDMjK/NxBTXh7PunkSLSZAz
 BkeUeYgUC8aUzl64yQZNU464cmgrL9g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-WKlffD0BP4GKmG5jvWIZcw-1; Fri, 22 Sep 2023 05:31:32 -0400
X-MC-Unique: WKlffD0BP4GKmG5jvWIZcw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32153a4533eso1275247f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375091; x=1695979891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXr0dDzaioo9uY5bLIe7ScF/gjUT2yjP9YjbogdmloQ=;
 b=qRcGg7ickxXC9Zhhc7Tuqu/IKqa6i/KDYv54+1AUJVfg985D000e2yVl4bXTr+tAmC
 l8NS+sM7rJ8koRHioT1dj8AJsFQtLoz4Zh3+Q9uBU/VT5so7r1YkTf6gsRppFRtDvCNl
 a6M+1gigQKXLPnPySfVB7ycLRugbEnY/rWiWLE3e6YNXW9vDgwqK408TcxA1I/kR1Mwo
 XNAy6Y4uWd2vO0RUEXJTvNb2hjQHItR5hElKc1CSUDYP8Cm0tnk2AAOBqC6Qr4/mme8B
 SlEgLF4aqZeJ1nQRuWHXd2+dy0i5iGFW4s5ih21knzt1W5WPgmZ0fTTOUGn8OZgqTrD3
 wZ4A==
X-Gm-Message-State: AOJu0YzkDZcz+4AitBvIgDElsuYWa6NW6RAG75Hst2t2ZoC8WVz553Oj
 SVdTF0o3zuWnQTtBbtenmKlFTVW2aqwd3noMlSDtuHEFRLezBW1egjdZDVQQl8sllSBA+iM3cTl
 SCUyhalCd24s/94u2fNMKPBLbuDwHuHjFcT87ZbO0cW+RH9Qo8ryeBMHp9j+81hykOfGlmkdciR
 w=
X-Received: by 2002:adf:e385:0:b0:31f:db12:f5db with SMTP id
 e5-20020adfe385000000b0031fdb12f5dbmr6744842wrm.32.1695375091189; 
 Fri, 22 Sep 2023 02:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKG1P9Q0331y8BXfy5K8NpJhVvRyDeMQfzRn5y5ezx/uzVzxvAsZh9tSD+5t4TuTOIymc1bw==
X-Received: by 2002:adf:e385:0:b0:31f:db12:f5db with SMTP id
 e5-20020adfe385000000b0031fdb12f5dbmr6744831wrm.32.1695375090934; 
 Fri, 22 Sep 2023 02:31:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0032008f99216sm4031115wrq.96.2023.09.22.02.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PULL 02/12] target/i386: Export GDS_NO bit to guests
Date: Fri, 22 Sep 2023 11:31:15 +0200
Message-ID: <20230922093126.264016-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Gather Data Sampling (GDS) is a side-channel attack using Gather
instructions. Some Intel processors will set ARCH_CAP_GDS_NO bit in
MSR IA32_ARCH_CAPABILITIES to report that they are not vulnerable to
GDS.

Make this bit available to guests.

Closes: https://lore.kernel.org/qemu-devel/CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com/
Reported-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Message-ID: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d48607b4e1e..f9e51a9d87e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
-- 
2.41.0


