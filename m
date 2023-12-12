Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878E80F8EC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:09:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD9zr-0000M5-UH; Tue, 12 Dec 2023 16:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rD9zq-0000Li-4E
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:08:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rD9zo-00067n-Aj
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702415331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLSgEMbJMFv1vZh1MSiOW7xVoHvqR2RDbIh36qC8mD4=;
 b=iZWr8PtLEKrVwbtN/2de3mE0SHrMYbrs6DXeZI5CjX9OKlvSGICsX5TFXSTBxfAItQX+1Y
 GKlQrIi0omKsCvcP75eGxbyG9DpSO1VGlZxsH6X/ClRWXJv3Ih45A9FY9ozdkbqd8Rx6yv
 h4Uks9CTGXF37FB91GKGhUIIA48nxbk=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-HFlWdWxXP1-uR4quRV65FA-1; Tue, 12 Dec 2023 16:08:48 -0500
X-MC-Unique: HFlWdWxXP1-uR4quRV65FA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1fafbf42404so11537652fac.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702415327; x=1703020127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLSgEMbJMFv1vZh1MSiOW7xVoHvqR2RDbIh36qC8mD4=;
 b=cQNwJZOOU9MTIy8nHtwosCFt8mbqlAp/sqm/iywZ8xArm0dnCyn7CIxBxpLWkUlDA3
 d/ViBOdYTFouWY3phJ2x06msG8WnLwR2sd3qKiKSbLsTXpCkgH2jX/+OT30QjR6imVRo
 jaGrk4Bb2DAi0mxnislSg7df4pEXkEfKnPOCy3nmPDSVoXXIW6CHbmNFLjCYSyGJz/1b
 LzELx9AaoFS97yBDxSzJipxFRHAlHXsocXVvVL4THysxGwtYQwIDGwYaPTCo/sWhNcOQ
 0iBEmAqxtAkPBhYGHsJHhfq4qjTcA39KdPk1I9tpATdEV53jFl73vjTvboxUWcIDJnmz
 8NHQ==
X-Gm-Message-State: AOJu0YziPSH2i/fxu3jA6bS0LSmAu1gBigjuHhy1T+J6CJmoghdgZ0H+
 jT2imqphTKEm9KjvUhj3Ip457h2bBmfBFysonzDd3IBC5jVa1g19TLxiayJRj7GjgXtXL4Saljo
 7vExgHpcgwFT3g/FadWQ6mM6pyazSC8aGtQxSjIPCqQ==
X-Received: by 2002:a05:6870:d60c:b0:1fb:75b:1324 with SMTP id
 a12-20020a056870d60c00b001fb075b1324mr8153700oaq.118.1702415326889; 
 Tue, 12 Dec 2023 13:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFyevnQ1Wwj79+rij0MTk/5+uH9s0jMAql0EUZeokLTRU1APmkkXDDyLybmJay8aK1ECZyQi91mHJIWMtpXMo=
X-Received: by 2002:a05:6870:d60c:b0:1fb:75b:1324 with SMTP id
 a12-20020a056870d60c00b001fb075b1324mr8153694oaq.118.1702415326593; Tue, 12
 Dec 2023 13:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20231212172510.103305-1-richard.henderson@linaro.org>
In-Reply-To: <20231212172510.103305-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Dec 2023 22:08:34 +0100
Message-ID: <CABgObfauRJmT5hS9nv1nORwAYj3biZm_xrqoMfADdqJN9_+UYg@mail.gmail.com>
Subject: Re: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Dec 12, 2023 at 6:25=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In 32-bit mode, pc =3D eip + cs_base is also 32-bit, and must wrap.
> Failure to do so results in incorrect memory exceptions to the guest.
> Before 732d548732ed, this was implicitly done via truncation to
> target_ulong but only in qemu-system-i386, not qemu-system-x86_64.
>
> To fix this, we must add conditional zero-extensions.
> Since we have to test for 32 vs 64-bit anyway, note that cs_base
> is always zero in 64-bit mode.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2022
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> This may be too late for 8.2; if not, then 8.2.1 and 8.1.next.
> I think I have found all forms of pc <-> eip, but another set
> of eyes would be appreciated.

Looks good, but perhaps you could also squash the following?

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 2c6a12c8350..83ee89579b8 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -52,7 +52,11 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
     /* The instruction pointer is always up to date with CF_PCREL. */
     if (!(tb_cflags(tb) & CF_PCREL)) {
         CPUX86State *env =3D cpu_env(cs);
-        env->eip =3D tb->pc - tb->cs_base;
+        if (tb->flags & HF_CS64_MASK) {
+            env->eip =3D tb->pc;
+        } else {
+            env->eip =3D (uint32_t) (tb->pc - tb->cs_base);
+        }
     }
 }


It wouldn't be the same bug as 2022 (it wouldn't be new with the vaddr
change) so it's okay to sort out this extra case after release.

Paolo


