Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 480227ABB01
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 23:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjnZy-0001bG-Mu; Fri, 22 Sep 2023 17:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crauer@google.com>) id 1qjnZw-0001aZ-6R
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 17:20:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <crauer@google.com>) id 1qjnZt-0000rY-JH
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 17:20:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-690d9cda925so2579698b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695417643; x=1696022443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8tTiA2/3rErjRJAJbqEVAZaDi9MtkjTW8NXaO0a17vw=;
 b=uXLFrMopvIBipXlHTxcQM++90rfRwbVjinjS3kiZjXGVcXngu3W/pJGRmYmydY79SH
 JMv01s9eI9TDi64WZANdX2x10eTBIZ01guGxjjCw7R26bAXqqkAnW0fFJ8GdgQMMT1AO
 +GqmPj/04FGv4tsJqqIcwxp+QGQkeFFPmNslBu4A9UzvdtGguXAPJNvavOFDIwZghYy0
 KpbIfA9STKJXmeav601W4i5hJZ6BM1j8E6rc8PIda4vFkKAhDtTdk0G35vFkIvXbkoVY
 aGw2jrXpnM8oYqHAv44g4U176hGYFRKYKL1BqNzvvEsVHhOApYFKS8xPCr2nbPBEyTij
 zJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695417643; x=1696022443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tTiA2/3rErjRJAJbqEVAZaDi9MtkjTW8NXaO0a17vw=;
 b=BatpC09G8OluCuFNgI+Brw0gGYpJggbLjGxADzjWnJc3WVP4LRkM3n2DVJZ5qwq1lr
 WgNfWjYHwS5fdv29k2kXnIoRlgmXmjj/PTXSM5N6Ejfpq283Gi9HkPackt3JHcOdQ6e3
 uW6WSko5UuJarqhooqW0FXlApeSSpcVJKyudNhWV0lCK1HEM5KK+A1fbZYt9uCXnp0IE
 KqlxN8r+M8PH2t3tmuUp8UHU9rc1XPsVCm8+JdY87DUMG6DGqwzyTygAOzhJsvYTUXVp
 E4ro+M/la8Bd7WRODorzZ2T9STBW2JmHOiWQ7PngCWakgzQoBMSgy1lxntOo4TsITUfT
 t7fw==
X-Gm-Message-State: AOJu0YxXey5cV4PO91vuYQn7ePL6PgZMeE5thN6fynm4xRDFnjM46US5
 +DlA8tkVFO9+YtmKwMG0ObxNpGBRaf7ITxWNSxLQqA==
X-Google-Smtp-Source: AGHT+IEFFwSoD37AFO1oozVcau/BbZ/A8RVnYgQDwi0XiRaSeP0ztMHZ5X2AukC7V9h39ac4j8t2hOQOQqCosOI4smM=
X-Received: by 2002:a05:6a21:3d87:b0:154:e7e6:85c8 with SMTP id
 bj7-20020a056a213d8700b00154e7e685c8mr768214pzc.31.1695417643066; Fri, 22 Sep
 2023 14:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230922181411.2697135-1-crauer@google.com>
 <CAGcCb128kdfZTTBB808iGONtdM9cnJF5CGxXhd+aS+eg2U=3Gg@mail.gmail.com>
In-Reply-To: <CAGcCb128kdfZTTBB808iGONtdM9cnJF5CGxXhd+aS+eg2U=3Gg@mail.gmail.com>
From: Chris Rauer <crauer@google.com>
Date: Fri, 22 Sep 2023 14:20:31 -0700
Message-ID: <CAFtMCFXaS-TTPXbBiVWVxdgK9zFUVj1Ft119p5Hzi_wj+=bSKw@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/npcm7xx_timer: Prevent timer from counting down
 past zero
To: Hao Wu <wuhaotsh@google.com>
Cc: peter.maydell@linaro.org, kfting@nuvoton.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005d0fb80605f92e17"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=crauer@google.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000005d0fb80605f92e17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No.  This patch does not address that issue and is not related.  I was able
to reproduce it about 2/1000 iterations with and without this patch.  I
will look into that issue separately.

-Chris


On Fri, Sep 22, 2023 at 11:24=E2=80=AFAM Hao Wu <wuhaotsh@google.com> wrote=
:

> Is this related to this error?
>
> https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04903.html
>
> On Fri, Sep 22, 2023 at 11:14=E2=80=AFAM Chris Rauer <crauer@google.com> =
wrote:
>
>> The counter register is only 24-bits and counts down.  If the timer is
>> running but the qtimer to reset it hasn't fired off yet, there is a chan=
ce
>> the regster read can return an invalid result.
>>
>> Signed-off-by: Chris Rauer <crauer@google.com>
>> ---
>>  hw/timer/npcm7xx_timer.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
>> index 32f5e021f8..a8bd93aeb2 100644
>> --- a/hw/timer/npcm7xx_timer.c
>> +++ b/hw/timer/npcm7xx_timer.c
>> @@ -138,6 +138,9 @@ static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTime=
r
>> *t, uint32_t count)
>>  /* Convert a time interval in nanoseconds to a timer cycle count. */
>>  static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns)
>>  {
>> +    if (ns < 0) {
>> +        return 0;
>> +    }
>>      return clock_ns_to_ticks(t->ctrl->clock, ns) /
>>          npcm7xx_tcsr_prescaler(t->tcsr);
>>  }
>> --
>> 2.42.0.515.g380fc7ccd1-goog
>>
>>

--0000000000005d0fb80605f92e17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No.=C2=A0 This patch does not address that issue and is no=
t related.=C2=A0 I was able to reproduce it about=C2=A02/1000 iterations wi=
th and without this patch.=C2=A0 I will look into that issue separately.<di=
v><br></div><div>-Chris<br><div><br></div></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 22, 2023 at 11:=
24=E2=80=AFAM Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuhaotsh@go=
ogle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr">Is this related to this error?<br><br><a href=3D"h=
ttps://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04903.html" target=
=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg04903.=
html</a><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, Sep 22, 2023 at 11:14=E2=80=AFAM Chris Rauer &lt;<a hre=
f=3D"mailto:crauer@google.com" target=3D"_blank">crauer@google.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The count=
er register is only 24-bits and counts down.=C2=A0 If the timer is<br>
running but the qtimer to reset it hasn&#39;t fired off yet, there is a cha=
nce<br>
the regster read can return an invalid result.<br>
<br>
Signed-off-by: Chris Rauer &lt;<a href=3D"mailto:crauer@google.com" target=
=3D"_blank">crauer@google.com</a>&gt;<br>
---<br>
=C2=A0hw/timer/npcm7xx_timer.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c<br>
index 32f5e021f8..a8bd93aeb2 100644<br>
--- a/hw/timer/npcm7xx_timer.c<br>
+++ b/hw/timer/npcm7xx_timer.c<br>
@@ -138,6 +138,9 @@ static int64_t npcm7xx_timer_count_to_ns(NPCM7xxTimer *=
t, uint32_t count)<br>
=C2=A0/* Convert a time interval in nanoseconds to a timer cycle count. */<=
br>
=C2=A0static uint32_t npcm7xx_timer_ns_to_count(NPCM7xxTimer *t, int64_t ns=
)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 if (ns &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return clock_ns_to_ticks(t-&gt;ctrl-&gt;clock, ns) /<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0npcm7xx_tcsr_prescaler(t-&gt;tcsr);<br>
=C2=A0}<br>
-- <br>
2.42.0.515.g380fc7ccd1-goog<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000005d0fb80605f92e17--

