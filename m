Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B767084C9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfRF-00070Y-Cz; Thu, 18 May 2023 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1pzfRA-000700-4F
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:21:05 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1pzfR7-0002nZ-7t
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:21:03 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-56204ac465fso6887767b3.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684423259; x=1687015259; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sTwXrNh0Ep9xOR8C05db2uNg4hHrqrdrXo6qYkVmN0c=;
 b=YKIGDrkX5aWztG25z8SJyu5AhcjNJcsZCTDWj4+tqKARDtPp/iXzNMr2svVKqDk1yW
 lXVxVAy/F0nb523AqzBHu+Z9FRWC4UTc0DT9xTRWco3Yu9Uyl+oV9XPkxMiodl+9GHaN
 Jp8RAQpvT3zeLns/S0H38euSydmzCTEjjIxsuw0yVzuW1JDWC0nNhYdOQ8Zl0mX51fUe
 +VcBQZuPDB70bzU34B7NtQvK7O4/BPRWklH465PpBDW1hHyzJBatpAlM1AsTJW+gLdcX
 84A1PudQxZFW4wgSZCdCrx4Ci9e0vuQBya9sDzS+78bWrBiQsyyhv5QTyla2oXlHKbeD
 qe1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423259; x=1687015259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sTwXrNh0Ep9xOR8C05db2uNg4hHrqrdrXo6qYkVmN0c=;
 b=aVgMRaBm95qSopD5pUVHEmZ1ncIYWdyv2GCtPGNDIoBk5QPgMui2sCXA8lM1nBdSzu
 5g9LFz1XMl5SezA7xvh57aBpwGdTdS55JZKW368YSq6qLOBl0Ar8onEfa93IBHTIN8hq
 ljRuPNdbiVw3+QQmMhkCcMNKicMmDaK9viEPFkjPUkOCBFk3ZL2pfk3WZCp2Js+LwBZk
 FWAxzuEzZrDPEwU0iYCA7W7Pbrfa0Yr3ToM3qRgg1TDEYvwvqj2uDp4sBsJYnlCMp8L4
 u7IpNeyB4VcscJwDrxD7KiQ5pLX2bIU7Nmu6Qxx33M4b+zOr2BMEelCqwUF1/3IpGw67
 sDWw==
X-Gm-Message-State: AC+VfDyW3KMDV/cEhOIbkjCdQPA1fw+CstDmBwiz8sxFZiudNjWXw4Qa
 XPRrwPiSRBnfnBxUwjEs2gWdAxzHyW2eLUSCQebXug==
X-Google-Smtp-Source: ACHHUZ5fOqVdI29uGSfPBrXkJ3RUJ9YhUxXJuyv8Bz5x7p4HkAbkTnOpkILgmgZUFRw42V5ViHu0SmzhBbhThdY2kK8=
X-Received: by 2002:a0d:cc02:0:b0:561:e7bb:1b20 with SMTP id
 o2-20020a0dcc02000000b00561e7bb1b20mr1438850ywd.34.1684423259425; Thu, 18 May
 2023 08:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230518113838.130084-1-rkanwal@rivosinc.com>
 <20230518113838.130084-3-rkanwal@rivosinc.com>
In-Reply-To: <20230518113838.130084-3-rkanwal@rivosinc.com>
From: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Date: Thu, 18 May 2023 17:20:48 +0200
Message-ID: <CAGKm2NK3+46Te9bFwmyAXkRy3RVXXe61Zz1BYdPaZqxMoJ7HHA@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/riscv: Check for async flag in case of
 RISCV_EXCP_SEMIHOST.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, 
 apatel@ventanamicro.com
Content-Type: multipart/alternative; boundary="00000000000007a7cd05fbf95a74"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=loic@rivosinc.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000007a7cd05fbf95a74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there a reason to keep RISCV_EXCP_SEMIHOST handling separate from
other exceptions?
Otherwise it could be moved in the switch block just a few lines below.

On Thu, May 18, 2023 at 1:39=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:

> RISCV_EXCP_SEMIHOST is set to 0x10, which can also be a local
> interrupt as well. This change adds a check for async flag
> before invoking semihosting logic.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 57d04385f1..c78a2a9514 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1602,7 +1602,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong htval =3D 0;
>      target_ulong mtval2 =3D 0;
>
> -    if  (cause =3D=3D RISCV_EXCP_SEMIHOST) {
> +    if  (!async && cause =3D=3D RISCV_EXCP_SEMIHOST) {
>          do_common_semihosting(cs);
>          env->pc +=3D 4;
>          return;
> --
> 2.25.1
>
>
>

--00000000000007a7cd05fbf95a74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is there a reason=C2=A0to keep RISCV_EXCP_SEMIHOST handlin=
g=C2=A0separate from other=C2=A0exceptions?<div>Otherwise it could be moved=
 in the switch=C2=A0block just a few lines below.</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 18, 2023=
 at 1:39=E2=80=AFPM Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.c=
om">rkanwal@rivosinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">RISCV_EXCP_SEMIHOST is set to 0x10, which can also =
be a local<br>
interrupt as well. This change adds a check for async flag<br>
before invoking semihosting logic.<br>
<br>
Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rkanwal@rivosinc.com" t=
arget=3D"_blank">rkanwal@rivosinc.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_helper.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index 57d04385f1..c78a2a9514 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -1602,7 +1602,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0target_ulong htval =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0target_ulong mtval2 =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if=C2=A0 (cause =3D=3D RISCV_EXCP_SEMIHOST) {<br>
+=C2=A0 =C2=A0 if=C2=A0 (!async &amp;&amp; cause =3D=3D RISCV_EXCP_SEMIHOST=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_common_semihosting(cs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pc +=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div>

--00000000000007a7cd05fbf95a74--

