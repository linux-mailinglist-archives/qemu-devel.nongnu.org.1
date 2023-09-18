Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0337A46A7
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBAl-0000m7-8E; Mon, 18 Sep 2023 06:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBAb-0000hf-9D
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBAZ-0004rt-9Y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695031672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqdyCaGqdq68Y5hiYUY1JjchYt1t5blJbSSM5/absNg=;
 b=CWGmUMJZEUm9khQKLUyQUUuysDTtzUal1FAI+vd78H3srv1ySKv9idyAo0eqY8q8Z/tyfb
 DPGHoQwFtH474YyNYeFeFKVx5gKj9p/m9oD+1QYVcfSPflD/5kcr6q3NJtZqEGhuNNN2/j
 WpNOOJt/R43H6cUVd28F5CAs+CeUwtU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ZVyXe7eeMlqrk1GoND5ufw-1; Mon, 18 Sep 2023 06:07:51 -0400
X-MC-Unique: ZVyXe7eeMlqrk1GoND5ufw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c01d1d0fe4so2391431fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695031669; x=1695636469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqdyCaGqdq68Y5hiYUY1JjchYt1t5blJbSSM5/absNg=;
 b=WSNS0YbG74kTnwXiwsdfCwW9d1YUGZtJbyzb2gPOTA1iIDoAD23kD/wel9R0YbAjLy
 yXspU5jwmf3wBV/AEKIJJldVu9EwWWtGs39d+sbZS8t//qanAKr9kBiyvn2ggK0nyYD1
 hYX23qoZD9M2wwAlWP55GH4BIk7jjcYB6kXgkFyUTNCh6LXR/t4YBdS42fDq+RTvWy0F
 V1qXe26vRqCKmLacxcBz1VfswUespkXr1Vd38ZJ6F8SRiiS5rwhJrrPYOfX2gZRKOY/k
 IrhTWt5TCStP4x0rk9HTWVupmLir+0qBucwLXzystaNNNrgxPls7BcFRI4IYnhtvICEZ
 2CMg==
X-Gm-Message-State: AOJu0Ywfx9TbO5D5Z4hYKyyxABK+zdUMcGR56NslFxYuCErhgexBVpY/
 RATQDdKuaMdGLq/jEKUALdLPHJ0QqTmPBJUDGNe0XpNOGDktxx8tZnms7h6Njm4oFk9basayDbq
 5ZhHGTbP52gStWInAovlAPr2deFrtS1s=
X-Received: by 2002:a2e:9297:0:b0:2bc:fc2e:7671 with SMTP id
 d23-20020a2e9297000000b002bcfc2e7671mr6582137ljh.13.1695031669538; 
 Mon, 18 Sep 2023 03:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIcO75cZwqOsh80a3wf9Ov1DBqpMKFoEgxwXRDAEIUMhJbo4IsbYsEn+t4j23a9TZ28h5GWMzO0rrPsRcQDPM=
X-Received: by 2002:a2e:9297:0:b0:2bc:fc2e:7671 with SMTP id
 d23-20020a2e9297000000b002bcfc2e7671mr6582117ljh.13.1695031669198; Mon, 18
 Sep 2023 03:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
In-Reply-To: <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 15:37:35 +0530
Message-ID: <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000086a4b806059f502b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000086a4b806059f502b
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Sept, 2023, 3:03 pm David Hildenbrand, <david@redhat.com> wrote:

> >>
> >>>> /*
> >>>> * The 64bit pci hole starts after "above 4G RAM" and
> >>>> * potentially the space reserved for memory hotplug.
> >>>> */
> >>>>
> >>>> There is the
> >>>>    ROUND_UP(hole64_start, 1 * GiB);
> >>>> in there that is not really required for the !hole64 case. It
> >>>> shouldn't matter much in practice I think (besides an aligned value
> >>>> showing up in the error message).
> >>>>
> >>>> We could factor out most of that calculation into a
> >>>> separate function, skipping that alignment to make that
> >>>> clearer.
> >>> Yeah this whole memory segmentation is quite complicated and might
> benefit from a qemu doc or a refactoring.
> >>
> >> Absolutely. Do you have time to work on that (including the updated
> fix?).
> >
> > Other than the fix you proposed I am not sure if we need to fix anything
> else atm. Seems physical address space bound checks are already in place.
> > Re: doc, maybe. I will add it to my TODO list.
>
> Will you send a proper patch, ideally not using pc_pci_hole64_start()
> but instead the same logic without the final alignment to 1 GiB?
>

I'll send. No problem. Could you answer my other question please ?


> I can also do it, but might take a bit longer.
>
> --
> Cheers,
>
> David / dhildenb
>
>

--00000000000086a4b806059f502b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, 18 Sept, 2023, 3:03 pm David Hildenbrand, &lt;=
<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">&gt;&gt;<br>
&gt;&gt;&gt;&gt; /*<br>
&gt;&gt;&gt;&gt; * The 64bit pci hole starts after &quot;above 4G RAM&quot;=
 and<br>
&gt;&gt;&gt;&gt; * potentially the space reserved for memory hotplug.<br>
&gt;&gt;&gt;&gt; */<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; There is the<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 ROUND_UP(hole64_start, 1 * GiB);<br>
&gt;&gt;&gt;&gt; in there that is not really required for the !hole64 case.=
 It<br>
&gt;&gt;&gt;&gt; shouldn&#39;t matter much in practice I think (besides an =
aligned value<br>
&gt;&gt;&gt;&gt; showing up in the error message).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We could factor out most of that calculation into a<br>
&gt;&gt;&gt;&gt; separate function, skipping that alignment to make that<br=
>
&gt;&gt;&gt;&gt; clearer.<br>
&gt;&gt;&gt; Yeah this whole memory segmentation is quite complicated and m=
ight benefit from a qemu doc or a refactoring.<br>
&gt;&gt;<br>
&gt;&gt; Absolutely. Do you have time to work on that (including the update=
d fix?).<br>
&gt; <br>
&gt; Other than the fix you proposed I am not sure if we need to fix anythi=
ng else atm. Seems physical address space bound checks are already in place=
.<br>
&gt; Re: doc, maybe. I will add it to my TODO list.<br>
<br>
Will you send a proper patch, ideally not using pc_pci_hole64_start() <br>
but instead the same logic without the final alignment to 1 GiB?<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;ll se=
nd. No problem. Could you answer my other question please ?</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
I can also do it, but might take a bit longer.<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div></div>

--00000000000086a4b806059f502b--


