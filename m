Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02657A46B9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:15:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBHh-00056H-SW; Mon, 18 Sep 2023 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBHf-000564-DJ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiBHd-0006JQ-FZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695032112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOZ/d0YXZkCelbbP2Z5YUGAkCpfz1Poa+kHnlkX3yU4=;
 b=KVHB0hLNzJqBufMxAOCm5qdqwQVaBA/xq/brRpp0kQ0DnvQGJb2wLMDrqiFPYQ6bgbfTDk
 XCjnJ9Nf12V37txICyC8RH4c/1m8j7XVv0dcQwbSw4EpSsm9I9CmKnPkGZuI6c1E66kFj3
 DwuMsqjtrn4v89H/x4vxvRGeMRYlaNE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-aqe5jctdPMWdsVTkbbm9wQ-1; Mon, 18 Sep 2023 06:15:11 -0400
X-MC-Unique: aqe5jctdPMWdsVTkbbm9wQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bff6dcbccaso16367691fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695032109; x=1695636909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MOZ/d0YXZkCelbbP2Z5YUGAkCpfz1Poa+kHnlkX3yU4=;
 b=X4RDVAub49OEBsLQ2ypL1PwspAmGGZlrrcZdkV2GihqzhcyLOgJWvsjkGNwD6RSQpD
 gLOLQzfUidn3rYpqnzzE1l6vHI225jG897SRE6bbQCcty9ee+gd2uauTU7jj5CPSMgsj
 7k0g5BYduV9bwjb9RKa18R2gos6b609AUfOuJJ2VZIcvhAR7xzGA1IMMY1EwB43lfmAt
 6xITizPpdpqSA52JTA3H8gKUluiQBPpkt1W563bIxCZGXIH4EuuFyoap5pHSgKo3f4yK
 lfZDeRXXdiGOX0qN55LFlZtViJ/OdzqCsKU1w7pUDBAk41nZNZ0TSM1dAm3fVqdpkI78
 XIXg==
X-Gm-Message-State: AOJu0YwR3Sarl2Z7DJBDiUkowmVSYbqUTscpUZIYyJjAyfnm8ggT3Uij
 IIZ2t/nuDrx1cY3hJykgtL/zjSiQxnX+lj/DRAp+mFOXlx3n29mGzkfUJj+aQDMpOFagD5rX0qs
 DEHHOya6+Rg2xfi7zvF8slFQ9Z+xLnRQ=
X-Received: by 2002:a2e:9846:0:b0:2bc:bf29:18d3 with SMTP id
 e6-20020a2e9846000000b002bcbf2918d3mr7055300ljj.31.1695032109475; 
 Mon, 18 Sep 2023 03:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXfGNKxHJticfYjF5f3OBLIzgaFRtS0mDOeTMJErVwrf3njvVKNbLEc3XS5B1p/FB1CWVSFXVhNulup4KBGcM=
X-Received: by 2002:a2e:9846:0:b0:2bc:bf29:18d3 with SMTP id
 e6-20020a2e9846000000b002bcbf2918d3mr7055283ljj.31.1695032109174; Mon, 18 Sep
 2023 03:15:09 -0700 (PDT)
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
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
 <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
 <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
In-Reply-To: <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 15:44:56 +0530
Message-ID: <CAK3XEhPK_x4ujK8whQF45f5xg6wFtMS=Y5=q5oWj9aHJ=mxnfQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000c02cf106059f6a41"
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

--000000000000c02cf106059f6a41
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Sept, 2023, 3:41 pm Ani Sinha, <anisinha@redhat.com> wrote:

>
>
> On Mon, 18 Sept, 2023, 3:39 pm David Hildenbrand, <david@redhat.com>
> wrote:
>
>> On 18.09.23 12:07, Ani Sinha wrote:
>> >
>> >
>> > On Mon, 18 Sept, 2023, 3:03 pm David Hildenbrand, <david@redhat.com
>> > <mailto:david@redhat.com>> wrote:
>> >
>> >      >>
>> >      >>>> /*
>> >      >>>> * The 64bit pci hole starts after "above 4G RAM" and
>> >      >>>> * potentially the space reserved for memory hotplug.
>> >      >>>> */
>> >      >>>>
>> >      >>>> There is the
>> >      >>>>    ROUND_UP(hole64_start, 1 * GiB);
>> >      >>>> in there that is not really required for the !hole64 case. It
>> >      >>>> shouldn't matter much in practice I think (besides an aligned
>> >     value
>> >      >>>> showing up in the error message).
>> >      >>>>
>> >      >>>> We could factor out most of that calculation into a
>> >      >>>> separate function, skipping that alignment to make that
>> >      >>>> clearer.
>> >      >>> Yeah this whole memory segmentation is quite complicated and
>> >     might benefit from a qemu doc or a refactoring.
>> >      >>
>> >      >> Absolutely. Do you have time to work on that (including the
>> >     updated fix?).
>> >      >
>> >      > Other than the fix you proposed I am not sure if we need to fix
>> >     anything else atm. Seems physical address space bound checks are
>> >     already in place.
>> >      > Re: doc, maybe. I will add it to my TODO list.
>> >
>> >     Will you send a proper patch, ideally not using
>> pc_pci_hole64_start()
>> >     but instead the same logic without the final alignment to 1 GiB?
>> >
>> >
>> > I'll send. No problem. Could you answer my other question please ?
>>
>> Sorry, which one did I miss
>
>

Ok hopefully my last question. I am still confused on something. Does the
above mean that the hole64 will actually start from an address that is
beyond maxram? Like basically if you added all of ram_below_4G,
ram_above_4G, hot plug_mem and pci_hole64 then can it exceed maxram? I
think it will. Does this not an issue?



>>

--000000000000c02cf106059f6a41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 18 Sept, 2023, 3:41 pm Ani Sinha, &lt=
;<a href=3D"mailto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div><br><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 18 Sep=
t, 2023, 3:39 pm David Hildenbrand, &lt;<a href=3D"mailto:david@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">david@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On 18.09.23 12:07, Ani Sinha wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Mon, 18 Sept, 2023, 3:03 pm David Hildenbrand, &lt;<a href=3D"mailt=
o:david@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">david@r=
edhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:david@redhat.com" rel=3D"noreferrer noref=
errer" target=3D"_blank">david@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; * The 64bit pci hole starts after=
 &quot;above 4G RAM&quot; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; * potentially the space reserved =
for memory hotplug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; There is the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 ROUND_UP(hole64_star=
t, 1 * GiB);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; in there that is not really requi=
red for the !hole64 case. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; shouldn&#39;t matter much in prac=
tice I think (besides an aligned<br>
&gt;=C2=A0 =C2=A0 =C2=A0value<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; showing up in the error message).=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; We could factor out most of that =
calculation into a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; separate function, skipping that =
alignment to make that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;&gt; clearer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Yeah this whole memory segmentation i=
s quite complicated and<br>
&gt;=C2=A0 =C2=A0 =C2=A0might benefit from a qemu doc or a refactoring.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Absolutely. Do you have time to work on t=
hat (including the<br>
&gt;=C2=A0 =C2=A0 =C2=A0updated fix?).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Other than the fix you proposed I am not sure=
 if we need to fix<br>
&gt;=C2=A0 =C2=A0 =C2=A0anything else atm. Seems physical address space bou=
nd checks are<br>
&gt;=C2=A0 =C2=A0 =C2=A0already in place.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Re: doc, maybe. I will add it to my TODO list=
.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Will you send a proper patch, ideally not using pc_=
pci_hole64_start()<br>
&gt;=C2=A0 =C2=A0 =C2=A0but instead the same logic without the final alignm=
ent to 1 GiB?<br>
&gt; <br>
&gt; <br>
&gt; I&#39;ll send. No problem. Could you answer my other question please ?=
<br>
<br>
Sorry, which one did I miss</blockquote></div></div></div></blockquote></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><span style=3D"font-size:12.8px">Ok hopefully my last question. I am still=
 confused on something. Does the above mean that the hole64 will actually s=
tart from an address that is beyond maxram? Like basically if you added all=
 of ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can it exc=
eed maxram? I think it will. Does this not an issue?</span><br></div><div d=
ir=3D"auto"><span style=3D"font-size:12.8px"><br></span></div><div dir=3D"a=
uto"><span style=3D"font-size:12.8px"><br></span></div><div class=3D"gmail_=
quote" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><=
/div></div></div>
</blockquote></div></div>

--000000000000c02cf106059f6a41--


