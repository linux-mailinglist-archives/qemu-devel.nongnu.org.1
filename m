Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0E73DD11
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBl-00037L-VC; Mon, 26 Jun 2023 07:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBb-0002zf-Rk
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBX-0000Zo-Th
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+pEuHC8o7MIoT+wKHzEIawfzSJZUmTJZ+8IUDyuCdo=;
 b=jTNV4JCDTveyX1B+qp2erp975Qe16ebzSTQGxmlzzpkyxF4QV8wdw20vcSHzxUcg+zbwI3
 O2Y6UfzkbdejPsCqXUkg6vFRKcKCBCgUaKnSvBzh3mB/GqhOpcntJhk3Otdco7wMHiMn50
 QL/+l6AWRFJSwMMuB3BIBksK8wdm/bs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-fUSPXegHNGS1Uyw9MKWyHA-1; Mon, 26 Jun 2023 07:15:03 -0400
X-MC-Unique: fUSPXegHNGS1Uyw9MKWyHA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31275d62506so1160945f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778102; x=1690370102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+pEuHC8o7MIoT+wKHzEIawfzSJZUmTJZ+8IUDyuCdo=;
 b=Mdeysgt6WzT29tOaH3l5LBRrIVDNMQCB3AE6Kj7oLxsAjDkVIsMcPXAx1lJdiUFPEu
 IhxYGMn5QqOf3DXjmNyOni86FPabSYoqhSm/nRfZFGoKZcyMZMbXln+yNV8/ZZ0aOe8P
 HSuuoyeq7jzmVV+LSQE1t9jH4yKXUJHJ1wBr0PVXcpeQ0bFN8o2RBNO1NyU2waWkkm2U
 /aeeysL0YWLaLup5T3OyLQJY9Qe8+86Ye+Pswv6jyQPeJMkiRYFyWh67G6ZQIvv5r/Dn
 SOFxVIRK5YV5OR7ULeECVuS/xaI9fA+aEgDmUqAUQlkdPWHFGdx2rstW0HSlrlL1ulhg
 9uOw==
X-Gm-Message-State: AC+VfDz2hGaKOKmbOyh+trG2AIhszCcqoKFtRMrmowINfhhkbOJWOa6e
 w7rHCdhu+ms5u2dybtY5aiEh9sKEFztLy7MyoGIb2JsuqYAj55f8sAjPAyASr+pOnFzLrpdCt93
 U7wZs7i9qoJOyvvxL4k0KwQOsoZmQXz7JVkzFKot5ViAwA350No5/DiML0kQxgm5mxdD8RWG7hD
 E=
X-Received: by 2002:a05:6000:1962:b0:311:9a5:2d63 with SMTP id
 da2-20020a056000196200b0031109a52d63mr8513242wrb.42.1687778102232; 
 Mon, 26 Jun 2023 04:15:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KFOH9NcNvddI73Ze3O9Q03vCyHLKNnaZWC4CQ0glXoNBuFZb7Plooys5KLWpPdEubFH+wtA==
X-Received: by 2002:a05:6000:1962:b0:311:9a5:2d63 with SMTP id
 da2-20020a056000196200b0031109a52d63mr8513231wrb.42.1687778101958; 
 Mon, 26 Jun 2023 04:15:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5d4f8d000000b003063db8f45bsm7084271wru.23.2023.06.26.04.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/18] target/i386: do not accept RDSEED if CPUID bit absent
Date: Mon, 26 Jun 2023 13:14:37 +0200
Message-ID: <20230626111445.163573-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0de068d4b79..4ef45bbd71e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3925,12 +3925,20 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         case 7: /* RDSEED */
+            if (mod != 3 ||
+                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_RDSEED)) {
+                goto illegal_op;
+            }
+            goto do_rdrand;
+
         case 6: /* RDRAND */
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
+        do_rdrand:
             translator_io_start(&s->base);
             gen_helper_rdrand(s->T0, cpu_env);
             rm = (modrm & 7) | REX_B(s);
-- 
2.41.0


