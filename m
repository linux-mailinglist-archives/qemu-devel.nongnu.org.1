Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8D70D67D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MwY-0003Gt-Lw; Tue, 23 May 2023 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1MwI-0003GC-Q2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:00:15 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1MwE-00012b-2n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:00:14 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-783f1443b70so2298829241.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684828809; x=1687420809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rgi5BNGeZTlSTTlXJsJz1hU1LXhIB/GE/+C9XJ/3yR0=;
 b=P8qbhTjtjUb489CpWYP+IngUOFmStTVphzJEbSbAlZgOsbaXH0/p04SsmcO9qtsXP7
 g/dIi0qFsQqtbn/QWgEprK1M3f6FSzEae+DRowDV6isa4WuM9baH+5PEBjT8ZkQNk8yQ
 6dqTw+qqUksfScUY9vmF8khOi9Gav/9PY9R499OHegdwBG+SQWbMxrLwm1nBjKk+gdsd
 kIYmFEsbvTGThh2uLaaqh7XnikgVwrNxtAcJNRTRIscLaFHky0vmeWx9KwFWwI/hJyi3
 2Nn5EbhFwQb1olEMss71oMHu5nau0tuamC8opBDT1Y3wnuJw7QuhqKUnQlDWAUFC4J78
 daxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684828809; x=1687420809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rgi5BNGeZTlSTTlXJsJz1hU1LXhIB/GE/+C9XJ/3yR0=;
 b=AwcIjwA+dLFhnm4OLIs/ciLDuR49TQYHeqTdJ6LqhetBM4sz/7VsDDj2AREvtE+F9k
 hy6lMxDR8wnmAjqp/HM9N7qxpTz+tJqyJD1uVP3OKYbHfyqq+v9dvuq0BGuWT5ii3/H2
 BUhjW+UnDO0UCPzQMdVqmQRd1CjjlbK1W2gLR81cg2Tg++XKfg589WQnolQfT3mk0VZT
 tExvmYVU9tgneOVtzurxefiXaYTpNRVBfjeRcwtGIifUOZnQ7PQZO0F/Q07t/QHv1BLb
 lZGKarA7iHpL3WDGchZZKukcKK0f4od23q95N6Rr5Jr0SyLVgt9hoM0dBYqK9JRxReHN
 gZ2A==
X-Gm-Message-State: AC+VfDyqg0cNZTd6VgOU6oqxCeABzbMS08duCGquMBOvFkDbWC2UZecK
 zCdnDq2rkjnY9DZS6hdvl5vujXzgGUS9U1+QfTRvDA==
X-Google-Smtp-Source: ACHHUZ4W8SEaWeWx9647c8gJ3u5tBNqxfv1/m3AOnkiJLrL7PLcmc+Auf5BHQ1fS3yD5u0lT1oyixG6TSuRFv7KrC4o=
X-Received: by 2002:a67:fbda:0:b0:437:db07:eb3a with SMTP id
 o26-20020a67fbda000000b00437db07eb3amr3504382vsr.22.1684828808719; Tue, 23
 May 2023 01:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221130015444.1459842-1-tommy.wu@sifive.com>
 <20221130015444.1459842-4-tommy.wu@sifive.com>
 <db28b205-4797-4bc0-09c9-53d54c0ce268@redhat.com>
In-Reply-To: <db28b205-4797-4bc0-09c9-53d54c0ce268@redhat.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Tue, 23 May 2023 15:59:59 +0800
Message-ID: <CANj3q_njMYYYpp4a46R17o8PiEZMpTL4BbB5NBjegHCKCp4wMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tests/qtest: sifive-e-aon-watchdog-test.c : Add
 QTest of watchdog of sifive_e
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, jim.shu@sifive.com, 
 frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="000000000000a6c6bb05fc57c6c0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=tommy.wu@sifive.com; helo=mail-ua1-x92a.google.com
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

--000000000000a6c6bb05fc57c6c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,
Sorry for the very late reply.
Thanks for the code review! I'll send patch v4 to fix these issues.

On Wed, Nov 30, 2022 at 7:29=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 30/11/2022 02.54, Tommy Wu wrote:
> > Add some simple tests of the watchdog timer in the always-on domain
> device
> > of HiFive 1 rev b.
> >
> > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > ---
> ...
> > diff --git a/tests/qtest/sifive-e-aon-watchdog-test.c
> b/tests/qtest/sifive-e-aon-watchdog-test.c
> > new file mode 100644
> > index 0000000000..1f454c266a
> > --- /dev/null
> > +++ b/tests/qtest/sifive-e-aon-watchdog-test.c
> > @@ -0,0 +1,650 @@
>
> I'd suggest to add at least add a SPDX identifier so that people know
> which
> license this file has. A short comment on what is being tested here would
> also be nice (though it is already quite obvious from the file name).
>
> > +#include "qemu/osdep.h"
> > +#include "qemu/timer.h"
> > +#include "qemu/bitops.h"
> > +#include "libqtest-single.h"
>
> Note that libqtest-single.h restricts your code to testing with one QEMU
> binary. If you want to write code that is a little bit more future-proof
> (e.g. if some of the functions should be used with migration testing late=
r
> etc.), I'd suggest to get along without libqtest-single.h and pass the
> QTestState around as a parameter of the functions.
>
> [...]
> > +static void test_wdogcfg(void)
> > +{
> > +    uint32_t tmp_cfg;
> > +
> > +    test_init();
> > +
> > +    tmp_cfg =3D readl(WDOG_BASE + WDOGCFG);
> > +    writel(WDOG_BASE + WDOGCFG, 0xFFFFFFFF);
> > +    g_assert(readl(WDOG_BASE + WDOGCFG) =3D=3D tmp_cfg);
> > +
> > +    writel(WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);
> > +    writel(WDOG_BASE + WDOGCFG, 0xFFFFFFFF);
> > +    g_assert(0xFFFFFFFF =3D=3D readl(WDOG_BASE + WDOGCFG));
> > +
> > +    tmp_cfg =3D readl(WDOG_BASE + WDOGCFG);
> > +    g_assert(15 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                        SCALE));
> > +    g_assert(1 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                         RSTEN));
> > +    g_assert(1 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                        ZEROCMP));
> > +    g_assert(1 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                        EN_ALWAYS));
> > +    g_assert(1 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                        EN_CORE_AWAKE));
> > +    g_assert(1 =3D=3D
> > +             FIELD_EX32(tmp_cfg,
> > +                        AON_WDT_WDOGCFG,
> > +                        IP0));
>
> Just a matter of taste, but at least I would prefer the statements on one
> line as long as they still fit into 80 columns.
>
>   Thomas
>
>

--000000000000a6c6bb05fc57c6c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Thomas,<div>Sorry for the very late reply.</div><div>Th=
anks for the code review! I&#39;ll send patch v4 to fix these issues.</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, Nov 30, 2022 at 7:29=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:t=
huth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 30/11/2022 02.54, Tommy Wu wrote:<br>
&gt; Add some simple tests of the watchdog timer in the always-on domain de=
vice<br>
&gt; of HiFive 1 rev b.<br>
&gt; <br>
&gt; Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" tar=
get=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
&gt; ---<br>
...<br>
&gt; diff --git a/tests/qtest/sifive-e-aon-watchdog-test.c b/tests/qtest/si=
five-e-aon-watchdog-test.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..1f454c266a<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qtest/sifive-e-aon-watchdog-test.c<br>
&gt; @@ -0,0 +1,650 @@<br>
<br>
I&#39;d suggest to add at least add a SPDX identifier so that people know w=
hich <br>
license this file has. A short comment on what is being tested here would <=
br>
also be nice (though it is already quite obvious from the file name).<br>
<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/timer.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;libqtest-single.h&quot;<br>
<br>
Note that libqtest-single.h restricts your code to testing with one QEMU <b=
r>
binary. If you want to write code that is a little bit more future-proof <b=
r>
(e.g. if some of the functions should be used with migration testing later =
<br>
etc.), I&#39;d suggest to get along without libqtest-single.h and pass the =
<br>
QTestState around as a parameter of the functions.<br>
<br>
[...]<br>
&gt; +static void test_wdogcfg(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t tmp_cfg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 test_init();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tmp_cfg =3D readl(WDOG_BASE + WDOGCFG);<br>
&gt; +=C2=A0 =C2=A0 writel(WDOG_BASE + WDOGCFG, 0xFFFFFFFF);<br>
&gt; +=C2=A0 =C2=A0 g_assert(readl(WDOG_BASE + WDOGCFG) =3D=3D tmp_cfg);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 writel(WDOG_BASE + WDOGKEY, SIFIVE_E_AON_WDOGKEY);<br>
&gt; +=C2=A0 =C2=A0 writel(WDOG_BASE + WDOGCFG, 0xFFFFFFFF);<br>
&gt; +=C2=A0 =C2=A0 g_assert(0xFFFFFFFF =3D=3D readl(WDOG_BASE + WDOGCFG));=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 tmp_cfg =3D readl(WDOG_BASE + WDOGCFG);<br>
&gt; +=C2=A0 =C2=A0 g_assert(15 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 SCALE));<br>
&gt; +=C2=A0 =C2=A0 g_assert(1 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0RSTEN));<br>
&gt; +=C2=A0 =C2=A0 g_assert(1 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ZEROCMP));<br>
&gt; +=C2=A0 =C2=A0 g_assert(1 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 EN_ALWAYS));<br>
&gt; +=C2=A0 =C2=A0 g_assert(1 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 EN_CORE_AWAKE));<br>
&gt; +=C2=A0 =C2=A0 g_assert(1 =3D=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_EX32(tmp_cfg,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 AON_WDT_WDOGCFG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 IP0));<br>
<br>
Just a matter of taste, but at least I would prefer the statements on one <=
br>
line as long as they still fit into 80 columns.<br>
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div>

--000000000000a6c6bb05fc57c6c0--

