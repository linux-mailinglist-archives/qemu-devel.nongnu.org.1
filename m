Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A087C710E1C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bkt-0004Pd-QO; Thu, 25 May 2023 10:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkk-0004N0-Ga
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bki-0007Wp-Qr
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky77ChaYoDEEJhaunbK7Hu6dsIrRUOupt2rqtAIhDx8=;
 b=SocOczRyt0IxvEcmuZ5LxXDm5GXXGUPgAdE6q+gVZ7P/2y9NenInsBuG59uJKs12V8tnTd
 JXvQOZ5IcEEw4y3DLBC87cHcbo3cB6LpgAWFtG9FiYlNFfzfXZLZSpjPQCzVesvbO1tKcy
 mxt0wxvwGDMYpSSM1frcA/BzndZEDk8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-kxZR4q-GOSOni0P2WM8_sg-1; Thu, 25 May 2023 10:15:36 -0400
X-MC-Unique: kxZR4q-GOSOni0P2WM8_sg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso70711966b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024135; x=1687616135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ky77ChaYoDEEJhaunbK7Hu6dsIrRUOupt2rqtAIhDx8=;
 b=PT8mrTXr8St1JBx2lSjUf1RUilUzygGyOLfDWM12Bp+gfzfuIq888FwmNtJ8OV6Jhl
 xl3srmiV/iszV8PmQCobaCgBs+evtHBbMck9oSK0ZBpQEzej0UEf6UTPDa58VsmGPiET
 jnWtE0p0CmRVDI0xLVioOXzixd5iS8AkMFKPy163kWE57NYztzfwakwfbs7ejNobPkZs
 6n3NKFcvDi5MvTc6WL8KgxUkAQHgaJFySbgvipVJCIcM4J7dhaYogRL3YRfi2gXRGDAy
 P7RwzuBQ+2qHuLxyMnoE977LPOJGe58bdXIpjcAij+uMXqll5bUiBEzFV2AKP8/Jhki4
 aWzw==
X-Gm-Message-State: AC+VfDw2hiunGs9POIgrUIjaZMWdhWaqTDmr1+z6yDVDZVhGEeJac0A7
 7jmvKsAHV8wBJLP+nd5YCHHuYP8g5utVY/YdV+B5IW3boD4ni7jCdg4kijqggIaPJ69xO322cgc
 iC0MyxHz/Amy6OgU4FLxXLU4RNvYwReR3EdkqPXdG6ZeDfK839ucd4Y+6Jsv6IcvOHZbTVbX02V
 g=
X-Received: by 2002:a17:906:4794:b0:96a:48ed:5333 with SMTP id
 cw20-20020a170906479400b0096a48ed5333mr1988114ejc.50.1685024134795; 
 Thu, 25 May 2023 07:15:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OgAv0uw90VUZ/0e6xEIgA3IyhNagbmAzj+1dZngdwklPaUByrgqsNLHcdH9fcR8lUWwh9dg==
X-Received: by 2002:a17:906:4794:b0:96a:48ed:5333 with SMTP id
 cw20-20020a170906479400b0096a48ed5333mr1988084ejc.50.1685024134380; 
 Thu, 25 May 2023 07:15:34 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a170906410b00b0096f689848desm893371ejk.195.2023.05.25.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maksim Davydov <davydov-max@yandex-team.ru>
Subject: [PULL 01/20] target/i386: EPYC-Rome model without XSAVES
Date: Thu, 25 May 2023 16:15:13 +0200
Message-Id: <20230525141532.295817-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

Based on the kernel commit "b0563468ee x86/CPU/AMD: Disable XSAVES on
AMD family 0x17", host system with EPYC-Rome can clear XSAVES capability
bit. In another words, EPYC-Rome host without XSAVES can occur. Thus, we
need an EPYC-Rome cpu model (without this feature) that matches the
solution of fixing this erratum

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-Id: <20230524213748.8918-1-davydov-max@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a61cd6d99d1f..1242bd541a53 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4466,6 +4466,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_rome_v3_cache_info
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    /* Erratum 1386 */
+                    { "model-id",
+                      "AMD EPYC-Rome-v4 Processor (no XSAVES)" },
+                    { "xsaves", "off" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.40.1


