Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7D741E88
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhqv-0002Ga-RU; Wed, 28 Jun 2023 22:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qEhqt-0002GD-Un
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 22:57:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qEhqr-00031Z-QI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 22:57:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-263315da33cso50439a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=celestica.com; s=google-201810; t=1688007464; x=1690599464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jGpbsSK6KXL9Q3SvqQNiedqCZebsR3+7uGHACF0J8c0=;
 b=lzue2hBo9BCjGuEFVi/kVVWSmcVmaiAxjlGHS2GUG7MWtCPJg0GE+gnkfzXzAcll2X
 vB0hmFHrSi4LfvA8QShjKT6F2ray6w3qvg9yO4smNDDL4njYY6iy1cmWr+esPhmbqPpN
 2IYDaq9Oet7lqs8zhCJp7/06YpjzXomiyJoBQ0HY0t+v+cZ8WRDxdMLnjas3jtiVj7S2
 EIWOuAKud6rd5pKSrw6YGFZDEo84vqt1GeDePFvT7mbUZlu0hy9cLatTiQDCIB1By0nG
 U81KBHhM1o8lxAX1pS7QTuEWduNQjheUVwUeto1CwxZ3ihcVGTzfOLWWYBnUSKF6IlCL
 AJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688007464; x=1690599464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGpbsSK6KXL9Q3SvqQNiedqCZebsR3+7uGHACF0J8c0=;
 b=OLlnLjKVZMSGlNx2JXap9GYrIG64azYcZhhjCa4yUvxJOE5o8gsCU5nYE6dP7B4ogv
 s8zrkTvDKxmqKLUMAzbShnCFCbjAIFL0HzjSCkbgcMFJVnOzZox3uJU7siIGvUis7R09
 FU67/IxkGrNkgo1faNEkcYThYZA2MtioT7xajCVtlJ7FjG/KazZxXhm9iVPguCwTMr/C
 jYdT672D/b5fg+nZpuEbgCFaa6EMYdHc28u9N4XQnUeniewBeYDoT1lG0BBgW5P/lbzM
 8hUq1qbGKWxIKtIJfInjmqydDqpfd5ijzNm07wzUZBFCv2nVJPfVjd8m3vnqrZsgiXiM
 U/CQ==
X-Gm-Message-State: AC+VfDx4nl+TUQ6MeiFFJAqSgQZhnW2LlZmyIzZiHhhZcUn4invLefCV
 MGsuvNTaRqDqxAoEa9NxwrpEro+B55P2v35TUXVPXdDzl7jNIxrTh6KKxUVDPYMQUms85G9oDmp
 KNcH6ngQsgIEKpZwxWP5/8wNA8jGlz7GeSR1W/VIrI7+C7Tx5TQ2k+pW0+fMz/RLLSetzfExL73
 A0xQNeem/pKplHfg6WGK2jvM4TcVJ7cAqpHQ==
X-Google-Smtp-Source: ACHHUZ5JYLvc09K08aUyvpZ0QhvJJBvdeyJM/gZiRhjEVQQ7ehjRunlpMD5aCJRAl3cAoM6ZGXIGV3mx6C+5rDUE9Qk=
X-Received: by 2002:a17:90b:4b4c:b0:23b:4bce:97de with SMTP id
 mi12-20020a17090b4b4c00b0023b4bce97demr43520815pjb.4.1688007463674; Wed, 28
 Jun 2023 19:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <168794501779.28884.3336012012258765799-0@git.sr.ht>
 <cd38a154-d5c3-1e22-c94f-9e1d74069f6b@kaod.org>
 <CAE+aGtVDXtPbZxC-OJvQ0R+dOk0S=_gx+0wfyJ+wbA_xn=NLMg@mail.gmail.com>
 <75e183e9-f253-60f3-c7bd-a064b8887ca1@kaod.org>
In-Reply-To: <75e183e9-f253-60f3-c7bd-a064b8887ca1@kaod.org>
From: Sittisak Sinprem <ssinprem@celestica.com>
Date: Thu, 29 Jun 2023 09:57:17 +0700
Message-ID: <CAE+aGtVs33sbcQJrW88H7E6ot72cBnJC=OPZYO0saEo3i6Mr4Q@mail.gmail.com>
Subject: Re: [PATCH qemu] aspeed add montblanc bmc reference from fuji
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, srikanth@celestica.com, ssumet@celestica.com, 
 thangavelu.v@celestica.com, kgengan@celestica.com, anandaramanv@celestica.com, 
 Joel Stanley <joel@jms.id.au>
Content-Type: multipart/alternative; boundary="00000000000040ab1e05ff3bdda8"
X-CLS-Gapps: True
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: celesticainc,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ssinprem@celestica.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000040ab1e05ff3bdda8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi C=C3=A9dric,

I had fixed the function name to support in current branch,
but facing about below error while starting

./build/qemu-system-arm -machine montblanc-bmc  -drive
> file=3D~/flash-montblanc,format=3Draw,if=3Dmtd -nographic -netdev
> tap,id=3Dnetdev0,script=3Dno,downscript=3Dno,ifname=3Dtap0 -net
> nic,netdev=3Dnetdev0,model=3Dftgmac100
>


qemu-system-arm: device requires 134217728 bytes, block backend provides
> 27726336 bytes




On Wed, Jun 28, 2023 at 11:34=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:

> On 6/28/23 12:07, Sittisak Sinprem wrote:
> > Got it Cedric, I just know for it,
> >
> > I am fixing, and will re-send the patch as V2.
>
> Could you please use the patch below and send in your series ?
>
> Thanks,
>
> C.
>
>
>  From cfbc865ffe8a4dffe4ac764eb10416aa906a7170 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D <clg@kaod.org>
> Date: Wed, 28 Jun 2023 18:32:20 +0200
> Subject: [PATCH] aspeed: Introduce ASPEED_RAM_SIZE helper for 32-bit host=
s
>   limitation
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the
> default ram size of machines (AST2600 SoC) that can have 2 GB.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index eefd2e275015..0ae252232597 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -49,6 +49,13 @@ struct AspeedMachineState {
>       uint32_t hw_strap1;
>   };
>
> +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> +#if HOST_LONG_BITS =3D=3D 32
> +#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
> +#else
> +#define ASPEED_RAM_SIZE(sz) (sz)
> +#endif
> +
>   /* Palmetto hardware value: 0x120CE416 */
>   #define PALMETTO_BMC_HW_STRAP1 (                                       =
 \
>           SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |              =
 \
> @@ -1504,12 +1511,7 @@ static void
> aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
>       aspeed_machine_ast2600_class_init(oc, data);
>   };
>
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS =3D=3D 32
> -#define FUJI_BMC_RAM_SIZE (1 * GiB)
> -#else
> -#define FUJI_BMC_RAM_SIZE (2 * GiB)
> -#endif
> +#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>
>   static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>   {
> @@ -1533,12 +1535,7 @@ static void
> aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>       aspeed_machine_ast2600_class_init(oc, data);
>   };
>
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS =3D=3D 32
> -#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
> -#else
> -#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
> -#endif
> +#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>
>   static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void
> *data)
>   {
> --
> 2.41.0
>
>
>

--00000000000040ab1e05ff3bdda8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif;font-size:small;color:#134f5c">Hi C=C3=A9dric,<br><br>I had=
 fixed the function name to support in current branch,<br>but facing about =
below error while starting<br><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">./build/qemu-system-arm -machine montblanc-bmc =C2=A0-drive file=
=3D~/flash-montblanc,format=3Draw,if=3Dmtd -nographic -netdev tap,id=3Dnetd=
ev0,script=3Dno,downscript=3Dno,ifname=3Dtap0 -net nic,netdev=3Dnetdev0,mod=
el=3Dftgmac100<br></blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
qemu-system-arm: device requires 134217728 bytes, block backend provides 27=
726336 bytes</blockquote><br><br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 28, 2023 at 11:34=E2=80=
=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_=
blank">clg@kaod.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 6/28/23 12:07, Sittisak Sinprem wrote:<br>
&gt; Got it Cedric, I just know for it,<br>
&gt; <br>
&gt; I am fixing, and will re-send the patch as V2.<br>
<br>
Could you please use the patch below and send in your series ?<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
=C2=A0From cfbc865ffe8a4dffe4ac764eb10416aa906a7170 Mon Sep 17 00:00:00 200=
1<br>
From: =3D?UTF-8?q?C=3DC3=3DA9dric=3D20Le=3D20Goater?=3D &lt;<a href=3D"mail=
to:clg@kaod.org" target=3D"_blank">clg@kaod.org</a>&gt;<br>
Date: Wed, 28 Jun 2023 18:32:20 +0200<br>
Subject: [PATCH] aspeed: Introduce ASPEED_RAM_SIZE helper for 32-bit hosts<=
br>
=C2=A0 limitation<br>
MIME-Version: 1.0<br>
Content-Type: text/plain; charset=3DUTF-8<br>
Content-Transfer-Encoding: 8bit<br>
<br>
On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the<br>
default ram size of machines (AST2600 SoC) that can have 2 GB.<br>
<br>
Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" ta=
rget=3D"_blank">clg@kaod.org</a>&gt;<br>
---<br>
=C2=A0 hw/arm/aspeed.c | 21 +++++++++------------<br>
=C2=A0 1 file changed, 9 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
index eefd2e275015..0ae252232597 100644<br>
--- a/hw/arm/aspeed.c<br>
+++ b/hw/arm/aspeed.c<br>
@@ -49,6 +49,13 @@ struct AspeedMachineState {<br>
=C2=A0 =C2=A0 =C2=A0 uint32_t hw_strap1;<br>
=C2=A0 };<br>
<br>
+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */<br>
+#if HOST_LONG_BITS =3D=3D 32<br>
+#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)<br>
+#else<br>
+#define ASPEED_RAM_SIZE(sz) (sz)<br>
+#endif<br>
+<br>
=C2=A0 /* Palmetto hardware value: 0x120CE416 */<br>
=C2=A0 #define PALMETTO_BMC_HW_STRAP1 (=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE=
_256MB) |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -1504,12 +1511,7 @@ static void aspeed_machine_rainier_class_init(Object=
Class *oc, void *data)<br>
=C2=A0 =C2=A0 =C2=A0 aspeed_machine_ast2600_class_init(oc, data);<br>
=C2=A0 };<br>
<br>
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */<br>
-#if HOST_LONG_BITS =3D=3D 32<br>
-#define FUJI_BMC_RAM_SIZE (1 * GiB)<br>
-#else<br>
-#define FUJI_BMC_RAM_SIZE (2 * GiB)<br>
-#endif<br>
+#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
<br>
=C2=A0 static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *da=
ta)<br>
=C2=A0 {<br>
@@ -1533,12 +1535,7 @@ static void aspeed_machine_fuji_class_init(ObjectCla=
ss *oc, void *data)<br>
=C2=A0 =C2=A0 =C2=A0 aspeed_machine_ast2600_class_init(oc, data);<br>
=C2=A0 };<br>
<br>
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */<br>
-#if HOST_LONG_BITS =3D=3D 32<br>
-#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)<br>
-#else<br>
-#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)<br>
-#endif<br>
+#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
<br>
=C2=A0 static void aspeed_machine_bletchley_class_init(ObjectClass *oc, voi=
d *data)<br>
=C2=A0 {<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div>

--00000000000040ab1e05ff3bdda8--

