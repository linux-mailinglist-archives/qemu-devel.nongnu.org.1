Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4447362EF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 07:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBTVr-0002BD-MB; Tue, 20 Jun 2023 01:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTVD-00027h-9W; Tue, 20 Jun 2023 01:02:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTV3-0001Co-NF; Tue, 20 Jun 2023 01:01:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b4fef08cfdso20319475ad.1; 
 Mon, 19 Jun 2023 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687237302; x=1689829302;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acxLko0yddl5shP/MXi2WWagE+JWecvxwBaSLdBnWV0=;
 b=o1r/5/csyi4qHQm5n3yHHYcDNTQSKBw7sadsoLa5E67J7cQbbm5It6bEkVIprEOToK
 qBFrkJy9r5Y4SUiTk56+9aExBq7nveXr+8Ym5mxMWJwVVTkhlLtMq5rcdY3c5IlCo0r4
 sXIwtYayJUg5ayMzFVcynAdbN5lI5DsWzqhcMLnAucvog7SGdWDJSa0qNR2JWl7TVLgx
 wcXCuvbJz0eoqplVoFVS5srm27aPKhdpxccyYmHyVFKgcX8F8bWtZ+zVvsb7XXRMTShz
 2PYWhwscGZaWjKlZJSvGZG2fwQx13O4yWkag6TrZb/Qjp2khfjmO2UIrZqBmHy8bPyB2
 WOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687237302; x=1689829302;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=acxLko0yddl5shP/MXi2WWagE+JWecvxwBaSLdBnWV0=;
 b=XUzSft+aYHgF6romU9xPHQsKlXJwXFfzdFVno7HGEZeQgnfSZJb9+Av+umzo6zXc5J
 YjZh/0WMi8BIk/AzIiDLoRPPNNH7IPxTak9ZPm6j44y/49sWGJCHwfNXN943OVHvJGFS
 lyMSdg/5QyCcVqvk/gXi9lJ8HuwIDBfQTSYBoPLi6MW9GNfVbOWus/YfTzp6UNrU8Xj0
 Xmp8uUo1X+ILBgmPNuc6+wXk6HP1BlY21Kduq93GMyLySxaP92YGK5Yfs0zLN/l2TA3S
 EtcFHpjGp97XKwqUKgKlO3x7r3djGxw3e1UuEVVGgDUjLGQnQvofXsvGjTQPImgx28Sj
 J3Xg==
X-Gm-Message-State: AC+VfDwTeiq9UucP85YY/OGVTHh5WdDmbtL2+R4yFrdhofmXqdxXkZSC
 eJJVpIxe2r6Dx9GJlsOuCNA=
X-Google-Smtp-Source: ACHHUZ7LuzaHhZMBjzqnZVO1i5VqbG58aJ66yYqXUwuFdV8vdEJ+QVKYY7ttVL/WQ9WFm9q5TqBySA==
X-Received: by 2002:a17:902:d50c:b0:1b5:58c3:7f8d with SMTP id
 b12-20020a170902d50c00b001b558c37f8dmr3684541plg.32.1687237302379; 
 Mon, 19 Jun 2023 22:01:42 -0700 (PDT)
Received: from localhost ([1.146.127.111]) by smtp.gmail.com with ESMTPSA id
 o9-20020a170902bcc900b001b526ec4a84sm584628pls.279.2023.06.19.22.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 22:01:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 15:01:36 +1000
Message-Id: <CTH7PDFL53VP.4NBZCKHLVRV9@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v3 05/14] target/ppc: Remove some more local CPUState
 variables only used once
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <aa34e449552c6ab52d48938ccbe762fc06adac01.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <aa34e449552c6ab52d48938ccbe762fc06adac01.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> Some helpers only have a CPUState local to call cpu_interrupt_exittb()
> but we can use env_cpu for that and remove the local.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I have less issue with this one.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/excp_helper.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 122e2a6e41..a175865fa9 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2551,8 +2551,7 @@ void helper_store_msr(CPUPPCState *env, target_ulon=
g val)
>      uint32_t excp =3D hreg_store_msr(env, val, 0);
> =20
>      if (excp !=3D 0) {
> -        CPUState *cs =3D env_cpu(env);
> -        cpu_interrupt_exittb(cs);
> +        cpu_interrupt_exittb(env_cpu(env));
>          raise_exception(env, excp);
>      }
>  }
> @@ -2589,8 +2588,6 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
> =20
>  static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
>  {
> -    CPUState *cs =3D env_cpu(env);
> -
>      /* MSR:POW cannot be set by any form of rfi */
>      msr &=3D ~(1ULL << MSR_POW);
> =20
> @@ -2614,7 +2611,7 @@ static void do_rfi(CPUPPCState *env, target_ulong n=
ip, target_ulong msr)
>       * No need to raise an exception here, as rfi is always the last
>       * insn of a TB
>       */
> -    cpu_interrupt_exittb(cs);
> +    cpu_interrupt_exittb(env_cpu(env));
>      /* Reset the reservation */
>      env->reserve_addr =3D -1;
> =20
> --=20
> 2.30.9


