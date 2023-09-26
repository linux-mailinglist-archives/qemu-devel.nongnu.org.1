Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932C7AF171
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPN-00020P-Oa; Tue, 26 Sep 2023 12:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPF-0001ul-9F
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPD-0006b7-B3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRHQQizdCF6wyYh9tuxeDibcUPdwMO6rnTiGfbULx5Y=;
 b=A93rr2+GOGg1w8YMj+9FegYpUJxGwzW0XaHBAu8GgM+HHUqWYlBLFJFmZBUqS6H/E18IUg
 dcjcvSsbpTqzLGj7L/tfeaek5IS0ZdhQKtZH7rOoKkC23L2Sr2sP/HJZ/Mryf7pyBkUCKn
 fv2GMvK6LSQLrar6SuxSpDcEQxf/riw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-XIMlYuVyPmqY190fABWqDw-1; Tue, 26 Sep 2023 12:59:25 -0400
X-MC-Unique: XIMlYuVyPmqY190fABWqDw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso6973204f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747563; x=1696352363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRHQQizdCF6wyYh9tuxeDibcUPdwMO6rnTiGfbULx5Y=;
 b=v8HPJn0hVH2HXQaZVhu1f7uiHSab2NJ5x2cKKY2rUt8JEYBnZplteivum18bc5yURX
 KpjlbA3e3QNVkO8cKjBMZRnj60UkOdT9mHOEx2sRLVNQmes78ocA9MdiUl4i+QSqabvS
 uXcDGKvLym/h3ioBmT0IGhWa4+kyuAgea/VRy35ctoLneyxIrE1MIWpuxfnF50curaHG
 pdRLS2Zbx2o2UqKKPt3kOspFD3BTQgLk4JqWbiuXBdHGMeMzL9kcFZpbNSY5d3Hg+AUE
 NpnZTqWiP53HRvezlQVbohdVDL8l1GCwOotBkjKcn7QVEU+Gtx6Rg1xHaE2ER9Qs2xe4
 NRTA==
X-Gm-Message-State: AOJu0Yw6NAO7jIqLPg6FVIkIGzVxlOFY8f7ck8UgFFiBZsa6mP3iT+Ai
 GJf4eXlpFC9YYXLtjuOFNO2fSm/I0V6sdMEqDhPaMmE7f1GGYHMgduDqNdqwfr0s2Y+KhdxoaBa
 3KF/NXb28liZtME5zIN/+uDEE12ps0gunPgs/cduZRkxvpyI+tkqCv4yEnur+t9tNtM10OCVCWV
 Y=
X-Received: by 2002:a5d:6a43:0:b0:31a:d49a:38d with SMTP id
 t3-20020a5d6a43000000b0031ad49a038dmr9306460wrw.54.1695747563715; 
 Tue, 26 Sep 2023 09:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Q0zU69PuO9kwU4UwxTh9ixupG0LAUmm/vCPC/UyiOIvao5qL1d1CcPD/GImUsQN3ZQ3CYw==
X-Received: by 2002:a5d:6a43:0:b0:31a:d49a:38d with SMTP id
 t3-20020a5d6a43000000b0031ad49a038dmr9306444wrw.54.1695747563312; 
 Tue, 26 Sep 2023 09:59:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a0560001acb00b0032415213a6fsm58100wry.87.2023.09.26.09.59.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] user-exec-stub: remove unused variable
Date: Tue, 26 Sep 2023 18:58:59 +0200
Message-ID: <20230926165915.738719-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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


