Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B881737035
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6R-0003VI-N6; Tue, 20 Jun 2023 11:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6N-0003T2-Ke
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6M-0007RP-7P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrX4qvW6uvMTDaXl0T3F6y1r/ZtScSoh9oMeF9M0nyg=;
 b=H78nZVauaqjlgaMni/iQC98ecMNmH6wbcIGbMiarGQ6ZfIJRvJ8ALu60Y81dAolef5Ez+A
 Vs99JavCxonWvIbSIAj3DTHdeiqF035+seVvxBPHDgRaSnTzucqKnMDndkf8+kWN+PJDA1
 FajMkKS7G09VQiOtPJRWOAzp9X3HlKI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-we1LHgIUNtuFjE20Trr-aA-1; Tue, 20 Jun 2023 11:16:51 -0400
X-MC-Unique: we1LHgIUNtuFjE20Trr-aA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987accb96dbso232445966b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274209; x=1689866209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HrX4qvW6uvMTDaXl0T3F6y1r/ZtScSoh9oMeF9M0nyg=;
 b=FLQZL6/Vktj95GvC4MYo7ZMkr3bkncLu77UrN0bIzZCXBIzTyTRviFarguNTqhO6zs
 N9hxfXol925whJb4NDSLPO+GIugtdT7q422ROohCeLIDycL2gKSOSbpeMlTxSmEv7jom
 kxgTRuVxV01rutKwRE+PDnfdZJWqIy3F9J7bajZwTOkTnBGPWk+CJL7jQKWR6upbhJIv
 jR6h67b9/PaEDo42zlBXCL1z2VoEDK+Kq4M/0HFO+Tg7wqjfTb9R2klJz0Yv6mvDMAaA
 huceMWoNWRrwWQM80wH7Y0wYYbfjVmxSy6qsz7zO8IEp0x/+AmA7IU0/BfwISKkzQXRe
 eaig==
X-Gm-Message-State: AC+VfDyBy+kdso49DQjVbQatWOUfahEIPHxEVUgvlmiQfMTkFfM0Np+D
 vqhGC9Hv5tOfglOlBwPXm//sbWh9uulzJXnUYuACa7dbq+LOR04dzfU0Pw2aJC9xh/sVuiDHVCa
 6Ux4EMwXMfyHooHfjh/49eCZtm8DprMXfc8JlPQitI/d7U89lgNa4LbPfDGeYkYhn9/3FP9trDp
 E=
X-Received: by 2002:a17:907:971f:b0:989:2264:fa86 with SMTP id
 jg31-20020a170907971f00b009892264fa86mr2136715ejc.17.1687274209460; 
 Tue, 20 Jun 2023 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ILzAhfor91F9uq77qNWYFmEBErlGXIdMgErIiKueNoch4idMSeMW5IgzoGJlKQXad6fSl+g==
X-Received: by 2002:a17:907:971f:b0:989:2264:fa86 with SMTP id
 jg31-20020a170907971f00b009892264fa86mr2136698ejc.17.1687274209121; 
 Tue, 20 Jun 2023 08:16:49 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a170906359300b009895af2580asm423517ejb.36.2023.06.20.08.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 07/10] target/i386: sysret and sysexit are privileged
Date: Tue, 20 Jun 2023 17:16:31 +0200
Message-Id: <20230620151634.21053-8-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9aec7ec8288..c58f5f24ab3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5675,7 +5675,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* For Intel SYSEXIT is valid on 64-bit */
         if (CODE64(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1)
             goto illegal_op;
-        if (!PE(s)) {
+        if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysexit(cpu_env, tcg_constant_i32(dflag - 1));
@@ -5697,7 +5697,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
-        if (!PE(s)) {
+        if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysret(cpu_env, tcg_constant_i32(dflag - 1));
-- 
2.40.1


