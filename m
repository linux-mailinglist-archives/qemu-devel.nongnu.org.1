Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEFD7423E1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokN-0000Ey-Tv; Thu, 29 Jun 2023 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokL-0000EH-Qj
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokK-0005nW-Em
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFRGHGkRnK6rZN55uj4I58WBJn1QFObQ0AJ+4MVDMs0=;
 b=YM5PnkqfbfCW/uo9B8gPljA+E50UyulEjnjPJarNWkFSxL3Kpl8csWVSVjgrV0vDjLwQ6h
 W0i2xzZ/lDCsupKA6/VwnYRBvVcvCKFb32XxdgZOf4EK42K9lw2l+84ZapWZff35sZjpAy
 bnuXtNrLvWC8WkWGe0xn59sagaLPqys=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592--I2YZhJPOwGp76Na9WWAsQ-1; Thu, 29 Jun 2023 06:19:26 -0400
X-MC-Unique: -I2YZhJPOwGp76Na9WWAsQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-97542592eb9so36325966b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033965; x=1690625965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFRGHGkRnK6rZN55uj4I58WBJn1QFObQ0AJ+4MVDMs0=;
 b=h1s8xG6PG8MLHKXubq18ByGvLvTDASSzkg9BLTVOJonCMDERThugDcEavufotpyqy5
 yifLrMUwEUs+NKa8Sdsg/fJvSwD/qHWWOyUc9l2h+4MM5E4ApxGxc+nNptaxL3gfZCVq
 ayU2Z0a3jyL7P8ZebAWfQgPix7jS2owTAVrstq33sIO62L6BYINN/VJgyi0lCVNXfCgH
 UJ9OnWhkBud5jkFFGGmeVsIcuo6Gzk+BO8p4OGN6osbMFKSbK+NmaTI8ewQGlslG0XqA
 dUaCzdkigfnEe/1VTovK7g8u7HgDdCWajpb0ur5FldsWpHNjVjFETAYNSaCAElxlwc/x
 XA/Q==
X-Gm-Message-State: AC+VfDxKjAIP12Es7NnII5fAzFD+XQ2Rw3aflw5vXM9D7ZS0awSYj2q0
 9uuvpvSQttAoITx8poccrxyFGI+P17+uOyjytj72jd8oD75G8Ey2PSh1PDRBwfo525Nd0XIIf+V
 I5Y5NcHosXj6iYKH76pBNxIP5tOPaFmXhJKxgyUYSGOFLxXugEHsOM976fKfJ1IO2RYkRCb85bT
 4=
X-Received: by 2002:aa7:ce01:0:b0:51a:5d43:ab8b with SMTP id
 d1-20020aa7ce01000000b0051a5d43ab8bmr21392590edv.33.1688033964828; 
 Thu, 29 Jun 2023 03:19:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57DsRcEHBw92nDzNR+lhSrOL9SjWRYHuuY1Vm3kPEMLv+D6uwZFfzAu29NWwg0hFfx6QTKKQ==
X-Received: by 2002:aa7:ce01:0:b0:51a:5d43:ab8b with SMTP id
 d1-20020aa7ce01000000b0051a5d43ab8bmr21392571edv.33.1688033964320; 
 Thu, 29 Jun 2023 03:19:24 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r16-20020aa7da10000000b0051d2968b26asm5668357eds.77.2023.06.29.03.19.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] target/i386: ignore ARCH_CAPABILITIES features in user
 mode emulation
Date: Thu, 29 Jun 2023 12:19:16 +0200
Message-ID: <20230629101918.9800-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
References: <20230629101918.9800-1-pbonzini@redhat.com>
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

ARCH_CAPABILITIES is only accessible through a read-only MSR, so it has
no impact on any user-mode operation (user-mode cannot read the MSR).
So do not bother printing warnings about it in user mode emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b96a609d966..328779874f2 100644
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


