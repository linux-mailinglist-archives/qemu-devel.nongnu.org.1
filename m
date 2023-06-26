Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B573D9D5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:33:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhfF-0005Jf-J7; Mon, 26 Jun 2023 04:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhf4-0005JH-2s
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhf2-0005gq-MJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/R7mjvgRqQdzLxJ6rW4RHpXVnGDITGnDOKe3jufbj18=;
 b=aexLvuUTnPlk8brucaRvbPwStcOxWoRQGEaT4ZZWCznHNfIVTkltm22hk/h+Zt8YdCOKDr
 +PFkWqdUNOlJxwOOZ+jH49RYXcnGpoaTqguNwUo7TT5g2EdVBGQj6T+RIRbxt8wm0QY8lo
 kQV+sFUyr0XDOUi5Ui0lCQqU1vTddww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-lnE_3hChMPuCtIAerdVhZg-1; Mon, 26 Jun 2023 04:33:21 -0400
X-MC-Unique: lnE_3hChMPuCtIAerdVhZg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1112960f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768400; x=1690360400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/R7mjvgRqQdzLxJ6rW4RHpXVnGDITGnDOKe3jufbj18=;
 b=jddiA9vxSebulfN3jvTyYqedM65C9QUpQnulCKmEq8WBVnLoiFK5NEjnCmp1YvYiu4
 w51xUaM/7pLEAH+O8+HgfWH1ahEmx10p/KlsYvgJBvYeRM4JkQwGernoI0ojweco6JSO
 z7HHLN68UMVyyxW6vWgpvp+Fp5phdC7Man56kSBVwg8GFQz+m6N4EmMeT78Aipx6JhW7
 pyDN2qeAuqm/Iomb+0RPFtcxAzd6cAaisADcCaSBvm4m/rvMAXtm3iyqxZkKLTMUCJ8J
 0dMXQuLfG1aSMOcTqbSmNWPf0A9nzJ+RbnxsmDyIokCtO/XdoVWKMweAdgP6et7cneke
 tYfQ==
X-Gm-Message-State: AC+VfDzErRdObOMPjPSPmja7iXjbnihsf88Cs5oI+uhxBIEYv9BpgUMX
 GuvBeWCp/+R8naQBXwtG2/JJE3lG1Vqgnp++4CCd1S+39NMCdsv+9sDSL7qmQgkmxjZUAwuowBX
 Cm1DTe5HxrJqMsVJ/U8VZ7FBLjw4es0GSssZoZtMUeVmdI2p0FIoFpl4ZGHkjyl6ZgmSacSeUcU
 Q=
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr18274631wrs.69.1687768400104; 
 Mon, 26 Jun 2023 01:33:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cpTo/R8xAypl+96pluWe/JmtwS55QKW1JfACD0PNEFfy5xycLNlXbJ9gcNdvKkVsH1FiMbg==
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr18274620wrs.69.1687768399836; 
 Mon, 26 Jun 2023 01:33:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a0560001b0400b00307a86a4bcesm6661500wrz.35.2023.06.26.01.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 01:33:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] target/i386: ignore ARCH_CAPABILITIES features in user
 mode emulation
Date: Mon, 26 Jun 2023 10:33:15 +0200
Message-ID: <20230626083317.144746-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626083317.144746-1-pbonzini@redhat.com>
References: <20230626083317.144746-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

ARCH_CAPABILITIES is only accessible through a read-only MSR, so it has
no impact on any user-mode operation (user-mode cannot read the MSR).
So do not bother printing warnings about it in user mode emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c0fb6b3ad92..8387843c4d9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1069,6 +1069,13 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
         },
+        /*
+         * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
+         * cannot be read from user mode.  Therefore, it has no impact
+         > on any user-mode operation, and warnings about unsupported
+         * features do not matter.
+         */
+        .tcg_features = ~0U,
     },
     [FEAT_CORE_CAPABILITY] = {
         .type = MSR_FEATURE_WORD,
-- 
2.41.0


