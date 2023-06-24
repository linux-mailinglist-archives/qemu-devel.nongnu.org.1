Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8EA73CC0D
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD75B-0002ie-2F; Sat, 24 Jun 2023 13:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qD758-0002iD-SN
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:29:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1qD757-0001XY-7g
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:29:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3113306a595so2083455f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687627790; x=1690219790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rhzf7EDWr9fqwBth9dhsRvteXNCs+QW5NagkgthVGzQ=;
 b=VNs6DEoKh/s7/4rjdeoetIW25o/v2lGI//LAE+ZAdTkllPa6YtgvYgIoOHJU+NZjPK
 hSE9F4OxNa90KZwtdwDrK6Ep4Z2oNgwcpyyvQpPZacQ4IPSRt7japWpbpRyyEgMCS877
 OZXUTAVyH6RHpC8uP6ZFWK0qNmhIgMKk6WRg162HIelHrs3PEZRg+sLJdwpThNWXpww6
 m2q0g1MvAUEwqJ5b739OM7BOjClUZ/ECAwgvrrlPeoEQ5pD/U/RO+t0s+6FNFMaVygcs
 Xy/TDNqz6llyPSjrLLC8pzZ5o7eQjL2G0jplvvBCtbNDZrRqJm4pKsVKXdCwQQmmdUEA
 sP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687627790; x=1690219790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rhzf7EDWr9fqwBth9dhsRvteXNCs+QW5NagkgthVGzQ=;
 b=NyZZYuCM+YmSYuKuqs9YkK5YQjFlxBMzNN5Mncni1xS5lOksrwcThiZn8SJXGCuE9Q
 AOtnGHfGw4HSHqhG9Az0DDQn4dSZf/iireMyv5SCzbTx/46yWhVyt5AN3gP0di7aDVvW
 cBvru/Cf6qujlCY5X8ru48Q2QkMTCzxBBrCSC7FbOYOLSoZd9eaFMobX5PBDVlPfku0Z
 RWiNKkPBOLPIDLqoYGOqmmDhKg3yw/QORQuD6jDbvU5Fd+XXn8HhCMfAcIZXIh6qiy+h
 +TMma/Pga/q598+/cghZ76ylid5Ew4Q5fQJ5FfY8xUXvdret4KsEONY9oheV6Oego9MA
 uWbQ==
X-Gm-Message-State: AC+VfDzsIqmw2bZKDOmJ5BM9K1nSYNnY8BiBBTyHnT5S3PDyHXdstLT9
 YhlPJ1HRhm809YuRfNH3XJHPsj+v+6zzaBqwmwU=
X-Google-Smtp-Source: ACHHUZ4Q5TRTmAxE6aEpXo95aWgiyLQWQetD0huxfSVBXexMMHs+UpOaDhD5XfMBeknyikVRYhUKAI10g21qCzDP5aA=
X-Received: by 2002:adf:ec01:0:b0:313:e267:319c with SMTP id
 x1-20020adfec01000000b00313e267319cmr1527603wrn.37.1687627789950; Sat, 24 Jun
 2023 10:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230619142333.429028-1-richard.henderson@linaro.org>
 <20230619142333.429028-2-richard.henderson@linaro.org>
In-Reply-To: <20230619142333.429028-2-richard.henderson@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Sat, 24 Jun 2023 19:29:38 +0200
Message-ID: <CAJy5ezo9ypVe1w6RosXw20=Hu9C9CM8013-eQujaCsH1nDe7aA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] target/microblaze: Define TCG_GUEST_DEFAULT_MO
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000eee59905fee37618"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000eee59905fee37618
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 4:23=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The microblaze architecture does not reorder instructions.
> While there is an MBAR wait-for-data-access instruction,
> this concerns synchronizing with DMA.
>
> This should have been defined when enabling MTTCG.


Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>

There might be MicroBlaze systems that allow reordering of load vs store
streams but it doesn't seem to be documented and I'm not 100% certain so
this change LGTM!

Thanks,
Edgar



>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 88324d0bc1..b474abcc2a 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -24,6 +24,9 @@
>  #include "exec/cpu-defs.h"
>  #include "qemu/cpu-float.h"
>
> +/* MicroBlaze is always in-order. */
> +#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
> +
>  typedef struct CPUArchState CPUMBState;
>  #if !defined(CONFIG_USER_ONLY)
>  #include "mmu.h"
> --
> 2.34.1
>
>

--000000000000eee59905fee37618
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 19, 2023 at 4:23=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">The microblaze architecture does not reorder instruct=
ions.<br>
While there is an MBAR wait-for-data-access instruction,<br>
this concerns synchronizing with DMA.<br>
<br>
This should have been defined when enabling MTTCG.</blockquote><div><br></d=
iv><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar@zeroasic=
.com">edgar@zeroasic.com</a>&gt;<br></div><div><br></div><div>There might b=
e MicroBlaze systems that allow reordering of load vs store streams but it =
doesn&#39;t seem to be documented and I&#39;m not 100% certain so this=C2=
=A0change LGTM!</div><div><br></div><div>Thanks,</div><div>Edgar</div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Cc: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" target=
=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
Cc: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" targe=
t=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
Fixes: d449561b130 (&quot;configure: microblaze: Enable mttcg&quot;)<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/microblaze/cpu.h | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h<br>
index 88324d0bc1..b474abcc2a 100644<br>
--- a/target/microblaze/cpu.h<br>
+++ b/target/microblaze/cpu.h<br>
@@ -24,6 +24,9 @@<br>
=C2=A0#include &quot;exec/cpu-defs.h&quot;<br>
=C2=A0#include &quot;qemu/cpu-float.h&quot;<br>
<br>
+/* MicroBlaze is always in-order. */<br>
+#define TCG_GUEST_DEFAULT_MO=C2=A0 TCG_MO_ALL<br>
+<br>
=C2=A0typedef struct CPUArchState CPUMBState;<br>
=C2=A0#if !defined(CONFIG_USER_ONLY)<br>
=C2=A0#include &quot;mmu.h&quot;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000eee59905fee37618--

