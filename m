Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B247737038
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6O-0003TP-Kn; Tue, 20 Jun 2023 11:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6F-0003Qp-9g
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6D-0007Qa-RP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fQMCnjJCg8Y838otnp0NMndVXXw22VXtOlY0YuT7SM=;
 b=EqkfLz0JMqVFAiA2z2CSMkLjT19yW3ZUJeJr4t4c+Se4mwWFO5oV3Se0fF4VQ0dFSV+G8f
 rR4ruGnvlpmHSjEszJ0ZqhFR7OUR8TszLG+Z9YU+ccuD2VKXNN4GXIoyuPox0claoqa4kk
 ohfOThopQzOZG171fOn1pVTJJWnkdjw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-mdowiSvsNWuvhzWkcD6QWw-1; Tue, 20 Jun 2023 11:16:39 -0400
X-MC-Unique: mdowiSvsNWuvhzWkcD6QWw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5161e17f374so6581612a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274198; x=1689866198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fQMCnjJCg8Y838otnp0NMndVXXw22VXtOlY0YuT7SM=;
 b=Im/WmTaNmc+ly7u87ya1QrMlqoO2gC9Dnr5LJAyoCl44DEsZrMzYhO4Tw9NXie5Gf9
 A/N0MDvDvrEmozaXIzrUG1DN3zCfQaC72+dNxSkPqeyG1yrEW6IujZnBxzyVh0ABv36k
 Q34pk69lqYKQifKAF7y3o8biIpuyiPuO+cKZjVHwh7Ecl3T8EaHV1dE7DfVW8nXIMnwK
 i7DmdtmnKdSzIByGFiBOgclydw6asTYOM6RSU1K2NF0ExiUUE33JINsiN7/tc4NWgCJ0
 bX4rTM0r3abdRo6T7QsgkIt3P3sVRTr1WtzYYJYkeqVpvamZr66q0j+ck2f+tOxQoQzX
 uPtw==
X-Gm-Message-State: AC+VfDy6oam3nEvvIOOqBDIdpw5r9Pwr7kTcqBoASrQ83Y03i5ypa4qW
 hGSRYGhDx3Je1R2uXfUoGOvngA89FEZVpXhekO9S3zQOwrZqEIsEg3nkHp5OpnqCEnQHhPicKtY
 dF7xKrHc4PZXxqLxqx98dBlknUJzM1MKOysJ6qkcMtA+n2R+h7CrgBr2JxQmU8/f5TVkROlHYwG
 U=
X-Received: by 2002:a05:6402:5112:b0:514:387c:930 with SMTP id
 m18-20020a056402511200b00514387c0930mr18485860edd.5.1687274198108; 
 Tue, 20 Jun 2023 08:16:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XmAXTr97Q6NNR27CZQmdBCqlt+Xj/uGSuzckXNF+MggKCQM3XwpDsAPiT+Y8OTqtqHN1MOg==
X-Received: by 2002:a05:6402:5112:b0:514:387c:930 with SMTP id
 m18-20020a056402511200b00514387c0930mr18485843edd.5.1687274197854; 
 Tue, 20 Jun 2023 08:16:37 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a056402121100b005158563be4asm1355459edw.33.2023.06.20.08.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 01/10] target/i386: fix INVD vmexit
Date: Tue, 20 Jun 2023 17:16:25 +0200
Message-Id: <20230620151634.21053-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Due to a typo or perhaps a brain fart, the INVD vmexit was never generated.
Fix it (but not that fixing just the typo would break both INVD and WBINVD,
due to a case of two wrongs making a right).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a60..0ef4d98ce79 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6119,7 +6119,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x108: /* invd */
     case 0x109: /* wbinvd */
         if (check_cpl0(s)) {
-            gen_svm_check_intercept(s, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
+            gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
         }
         break;
-- 
2.40.1


