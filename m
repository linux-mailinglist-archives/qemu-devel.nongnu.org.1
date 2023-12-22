Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E71681CE5E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4p-000169-La; Fri, 22 Dec 2023 13:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4j-000132-6u
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4d-0006DH-6t
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s20ri7ZvTITmjo1tFAIedPAbIGw101QMUcEf+RkyrDA=;
 b=BtXoPJHu2Bz/yazWlKu1grctF3azuIcVLHzwMyxJp6QeuXVZnCmtxHLZIFxLz3HTQyXbR2
 YUyhTNuAmk/3wudIDb1nUURYJ9e9aU9Q6zkmNMbrrAXSwjR7/H5GfVHryHZYY10YwDplk5
 HLs43vRAwHSsR/IF1S6C06qnbc/9eLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-vfh7ff79PMmbHPibY4QwqQ-1; Fri, 22 Dec 2023 13:16:36 -0500
X-MC-Unique: vfh7ff79PMmbHPibY4QwqQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d4a2a0b58so3508445e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268994; x=1703873794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s20ri7ZvTITmjo1tFAIedPAbIGw101QMUcEf+RkyrDA=;
 b=RU4VUFE0gySzoMCiRcxkXE5/cFQcFYi00ZvG1DaCKUeURIYgKXIopDlUYeF8bf6kbX
 gG6VpCHKWo7nINJTxbdYJpxT1eVWigTqu59xzXN3G2VxNgcxFYv7IKR6ylUxoEq6l0p6
 DAyDhERgahGWYohSp/yI405dUwE3rmIhgt8NtPgiaxpUweIUhqq6XcBF6biMsjJZe2r8
 MiGA5XnjgfV5ppjS0IRm/Vuwm4qIjzzLgwuzXubvk3pDshs0GmEPVKfvUWlcyc84cfT5
 fYjRmyWNYmZ6u4hYVzT85l93+YDOasPqhx99zTKxpDVfQdvj9XLu95yzSftOOQu39sKi
 v/ww==
X-Gm-Message-State: AOJu0YwFk5+JxOXri/aK+oo0deG3KiPFKCdQggCoPscJX2JR99MaESrX
 szgkmQ5EkC+6nFfo5vM+dfUOuAwj/UiaBIeDR0Z4CSqjpk40vEc9g6WdcCf87x8fJhWFmQIWqEd
 vISVm6H5z3OAFSCU6/azLVTznAlxUQdi0Tqss11v8EX274CWW/sf/M7yVTEvfXf1XvLAIzPYANW
 TguKVNYFc=
X-Received: by 2002:a05:600c:3c8a:b0:40c:31e5:49da with SMTP id
 bg10-20020a05600c3c8a00b0040c31e549damr979630wmb.136.1703268994535; 
 Fri, 22 Dec 2023 10:16:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx/EQF9fEK/IXL5sS2Ry1ZQLe7S6Zvwa49PmbCL9JGuR5KkxU7HhEqf9nj5iaxSkLGkcX36w==
X-Received: by 2002:a05:600c:3c8a:b0:40c:31e5:49da with SMTP id
 bg10-20020a05600c3c8a00b0040c31e549damr979624wmb.136.1703268994163; 
 Fri, 22 Dec 2023 10:16:34 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a170907910d00b00a26a63346ddsm1933479ejq.87.2023.12.22.10.16.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/22] target/i386: do not use s->tmp4 for push
Date: Fri, 22 Dec 2023 19:15:56 +0100
Message-ID: <20231222181603.174137-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Just create a temporary for the occasion.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b79c312465b..afe0fa6c65f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2580,7 +2580,7 @@ static void gen_push_v(DisasContext *s, TCGv val)
 
     if (!CODE64(s)) {
         if (ADDSEG(s)) {
-            new_esp = s->tmp4;
+            new_esp = tcg_temp_new();
             tcg_gen_mov_tl(new_esp, s->A0);
         }
         gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
-- 
2.43.0


