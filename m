Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97977AF173
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQ7-0002Dh-Fv; Tue, 26 Sep 2023 13:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPY-00025L-Sc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPW-0006gI-Ju
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK2AY4GFy/+B42PpuPIpzASu5VezWEnZGsFZ9M1vuME=;
 b=YWHmKVyF/VAi5050vIhvt1MaF6LNJsdJbDbGqk6E168D5EM34wWei+AqII50oAmWFxCZhZ
 gMYLjjSEndl6h2bbxF8z5FU0B7pRQMoT3dlS6o9ZX8VKennvHmlrXEmtYvNBGpIq9D6/x+
 EfnwnU1Lfana2WV5F4N25sWPTZtRqBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Y9eUkac-NbCzEdU-ByTxgg-1; Tue, 26 Sep 2023 12:59:43 -0400
X-MC-Unique: Y9eUkac-NbCzEdU-ByTxgg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-406227680a9so24369095e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747582; x=1696352382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cK2AY4GFy/+B42PpuPIpzASu5VezWEnZGsFZ9M1vuME=;
 b=TzchyO0qQGXZQtIwRIGwtNau051aS8zffDZF3tJ87cVx0G4lh017IK7e1fVu2YX/kF
 Z1hiO814/5vB5kXtB/esBWxL7HTCy7M2hf4oe/7el9FdriUWcH7mCsxjvLafU8wJpf+N
 w3AAUZTwqbIH9cq+KtEZs2jbMCHgeXrn+ac26ISIRHK1vvRvcnKv2vJu92tyipJrZXiP
 7EvR4SuqhwJyu9VygD348Y+wFBrdShMEtYR1PBiiB+IJuWuH348gkFduB6z9mKhxm+E/
 m66jD4iCvQ6AUW9zzXjTCTKWSDIfZMCAgQXGYpp4rjz81hhGREelSCxikSYraHsg0iwx
 s6kw==
X-Gm-Message-State: AOJu0Yz0a/eexLBeDPXkDsi0rXGtxTZIPriZ7N2ImXI+Cl85yPG+zo+W
 8Ekx06ZEQegcr+4TuvBbnW9lZbWhL37XVuZ/ENUVbrorUE95EpfqTVuXfxa6gqPvSldexrDOBVK
 pupHJYZ/VY1eftMUp+Sst+Woen5l5XLEaaCPsT7fFiV5R9HbBVQGtva+4v1bg3H3FEDMKP3f5CO
 w=
X-Received: by 2002:a7b:ce90:0:b0:3fe:d1e9:e6b8 with SMTP id
 q16-20020a7bce90000000b003fed1e9e6b8mr8908049wmj.12.1695747581934; 
 Tue, 26 Sep 2023 09:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP67ZvDd/Y2KLZkl9/CIX7A9WtrdFwcDVsOzvx8HL/4xKrofjhnqjVaM2zZeWb0mfQVdd9gw==
X-Received: by 2002:a7b:ce90:0:b0:3fe:d1e9:e6b8 with SMTP id
 q16-20020a7bce90000000b003fed1e9e6b8mr8908034wmj.12.1695747581582; 
 Tue, 26 Sep 2023 09:59:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b00405ee9dc69esm3223612wmj.18.2023.09.26.09.59.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] target/i386/translate: avoid shadowed local variables
Date: Tue, 26 Sep 2023 18:59:09 +0200
Message-ID: <20230926165915.738719-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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

Just remove the declaration.  There is nothing in the function after the
switch statement, so it is safe to do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c98e42f17a0..72635b87d3c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3242,7 +3242,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x30 ... 0x35:
     case 0x38 ... 0x3d:
         {
-            int op, f, val;
+            int f;
             op = (b >> 3) & 7;
             f = (b >> 1) & 3;
 
@@ -3302,8 +3302,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x81:
     case 0x83:
         {
-            int val;
-
             ot = mo_b_d(b, dflag);
 
             modrm = x86_ldub_code(env, s);
-- 
2.41.0


