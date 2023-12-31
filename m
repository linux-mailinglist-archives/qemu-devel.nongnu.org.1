Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F561820A87
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSH-0004G9-L7; Sun, 31 Dec 2023 03:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSF-0004FT-Jx
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSE-0000kT-7t
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C7Csfkgif0d2DH8bfPmHRJfMScsORLAfEbNEqOAzmU=;
 b=Eib7sx5wXDoYMgy0YfyFomj2cbEov/rcNupsvuHMrFZJbNSG5BDEUXzLiDKiEUvMeBR2jp
 VpuZADiyksT8lP+nm6sboWlWsvt8wg9wBXuff2s0tOo4aGd2Dqz4k1cWI5zBN03AAsctDv
 XnC/Ie4SeCbeZLVCVMHG79UNcJdeQSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-y30pSgtYOOacnkfYsgbICw-1; Sun, 31 Dec 2023 03:45:50 -0500
X-MC-Unique: y30pSgtYOOacnkfYsgbICw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a27c3388fb7so37793566b.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012349; x=1704617149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7C7Csfkgif0d2DH8bfPmHRJfMScsORLAfEbNEqOAzmU=;
 b=Vk7WtO9E6od5LBj8vUWu3J4eg9zEIirgc0jHLTgyHZAoBP9l9HSqXkDOLuwxLZMSiS
 06WMtM1eFAB+z0KvQGHQV14xNBuX+sgRJ4lUeH3RAnF43Gl3cV2qwYlKyNmlnulgWN8M
 AGhjSQUlQdxKlJFG8BmkIeuKv6UwQn+spTzzldHeWCEsXdPhXSEkOdseUR844/iZmKDQ
 7jkmnj2AGUdZeyLdlDvASs8rWuyeZXzDG1MMeyP/o44Fr9ZBAl3gcf9sNUv+yvhuk6yP
 a4AysYjd+fxnLueH76V6fzsz5afPLUuVuWH08xqDVGNqk6f0pjtC6ndyp8AloGINd1qU
 D5HA==
X-Gm-Message-State: AOJu0Yz7rcQ+MQp2lpIoU9jebOpmqnsR9unLQjoqHVKoXHHShmeXmHZ3
 HZk/Q3RqAoNqHWnYGPMca0tK0gZTq9/QqZlOOeq/t7unLiFy7QBT6XGtgMzV5vC9WAfOcY/YBHF
 uog1wQ40zd8RAjZjUVlASmLjfrMKveS9KW8NnIT8oP4hce5D2V6RpjThaHUCMb2RQ/RTdoqXaq0
 X1pzVxaJc=
X-Received: by 2002:a50:c101:0:b0:555:bebd:4f70 with SMTP id
 l1-20020a50c101000000b00555bebd4f70mr1507661edf.0.1704012349047; 
 Sun, 31 Dec 2023 00:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAvcTx4RSn+HhuLT8H6ZTGfZVt2OlM29hF9HBi8p4Au8VFE5EpLKXMZOKlqHFQHjPFkaZKJA==
X-Received: by 2002:a50:c101:0:b0:555:bebd:4f70 with SMTP id
 l1-20020a50c101000000b00555bebd4f70mr1507654edf.0.1704012348792; 
 Sun, 31 Dec 2023 00:45:48 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g25-20020aa7c859000000b005532b0414aesm13295952edt.51.2023.12.31.00.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/46] target/i386: do not use s->tmp4 for push
Date: Sun, 31 Dec 2023 09:44:32 +0100
Message-ID: <20231231084502.235366-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just create a temporary for the occasion.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


