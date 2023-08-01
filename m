Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B79DC76BEE9
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQwUP-0003xa-HH; Tue, 01 Aug 2023 17:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQwUK-0003xK-8V
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:01:04 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQwUI-00061R-Il
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:01:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bf8e5ab39so610984466b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690923661; x=1691528461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HJtXdT7hIp3lXx7+QiAylX8LbLwsVXxGwQjohTc1MAI=;
 b=FJGmaQ2/Cg3WolJuI8X4oCEikfgZpGqpeNerXf3nOdpU4RLVbg/JVVRl8eIOj/0fra
 y/UylDUB5mzNZAg73fB/bJwXTKMw1R+z1e1jC6kLGM6xrG0jzU7Kj1Vl8XayS5gXSjdj
 3pfe2cVq5YRk943VrqlrT+ZFCjbZV1GgiFrnmbZlNGm0VvRHZuScRsulQ9RWMjOE16t8
 U9N2vk09WCV2Yk1nBVONIXg+EHR2loHqTJi7XP7/heeETVFjMl8vWDg7d8Aq0utSvgFH
 QeMqDhijDLAEb/UhiGG97u4GktH8Uuvr6qfFZ7CBAsJ+vQVyTnQnqjh7Xg77l7fhant9
 eyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690923661; x=1691528461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJtXdT7hIp3lXx7+QiAylX8LbLwsVXxGwQjohTc1MAI=;
 b=Q2h6Z8qSHCWpzRDXdT3+eahY+dQnzUU5ujdMJgjLtp6xFQZb+CAbgdX6jOUV+kFlJU
 SSzuk8Zq9lrrwRhF3swikY3lMOEMZdcj4h6fWh6IKVvEgVF2B9MD3CStKxtqz7yv9BbO
 wN/B9jI0Q0UlOYN+knOURYWQkKvM2wb2JbQ6e3tXoPQcPSwfF8afFqSgmfrG/0SImqBh
 RLRPZOG8cryHZ0NWNKD2nHvdNHO415O52PM2zWCQ00oKuu1MRopj6S4PzTh+/qOhEj+t
 Hn+7BUK1EjrER7DpoOIfrzz/V4H0GjxfCenCwBFpCcFBjghcxlYREa7yDARVcH69AyEq
 lVfA==
X-Gm-Message-State: ABy/qLaXM29bewCRaIBGsRtJofYkfXSEk71UrCikCdx4Y22Zioc+CMgo
 1lQrOpXjyjuw6D5nbYh4JDKSfigQnID3Ay2AeY8=
X-Google-Smtp-Source: APBJJlEzw5DBymxQY0l8U7rEukzHquxzmlQf8JCC7IyvINz7VoyKzSd0MWApqTP2IpXAlXLwrT0tO3Zop/7XY4HYLWs=
X-Received: by 2002:a17:907:a073:b0:978:928:3b99 with SMTP id
 ia19-20020a170907a07300b0097809283b99mr3357777ejc.46.1690923660581; Tue, 01
 Aug 2023 14:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-4-dinahbaum123@gmail.com> <87tttix39v.fsf@pond.sub.org>
In-Reply-To: <87tttix39v.fsf@pond.sub.org>
From: Dinah B <dinahbaum123@gmail.com>
Date: Tue, 1 Aug 2023 17:00:49 -0400
Message-ID: <CAH50XRepiYcR9_e0AtuwTk1Nn34TXvZ87F5VVWg3aSx8BRJHPg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cpu, softmmu/vl.c: Change parsing of -cpu argument
 to allow -cpu cpu,
 help to print options for the CPU type similar to how the
 '-device' option works.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000219d990601e2d84f"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=dinahbaum123@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000219d990601e2d84f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I will fix this. I somehow didn't catch that you had replied to the
old one.

-Dinah

On Tue, Aug 1, 2023 at 10:10=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Dinah Baum <dinahbaum123@gmail.com> writes:
>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1480
> > Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
> >
> > Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
>
> Looks basically the same as v2, which means my review still applies.
>
> Message-ID: <878rdbfww1.fsf@pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg06699.html
>
> If you need further assistance, just ask.
>
>

--000000000000219d990601e2d84f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, I will fix this. I somehow didn&#39;t catch t=
hat you had replied to the old one.<br></div><div><br></div><div>-Dinah</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Aug 1, 2023 at 10:10=E2=80=AFAM Markus Armbruster &lt;<a href=3D"=
mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Dinah Baum &lt;<a href=3D"mailto=
:dinahbaum123@gmail.com" target=3D"_blank">dinahbaum123@gmail.com</a>&gt; w=
rites:<br>
<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/148=
0" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/1480</a><br>
&gt; Signed-off-by: Dinah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com=
" target=3D"_blank">dinahbaum123@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Dinah Baum &lt;<a href=3D"mailto:dinahbaum123@gmail.com=
" target=3D"_blank">dinahbaum123@gmail.com</a>&gt;<br>
<br>
Looks basically the same as v2, which means my review still applies.<br>
<br>
Message-ID: &lt;<a href=3D"mailto:878rdbfww1.fsf@pond.sub.org" target=3D"_b=
lank">878rdbfww1.fsf@pond.sub.org</a>&gt;<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg0669=
9.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2023-05/msg06699.html</a><br>
<br>
If you need further assistance, just ask.<br>
<br>
</blockquote></div>

--000000000000219d990601e2d84f--

