Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F10470B9FB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q12fl-0008Og-Ep; Mon, 22 May 2023 06:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q12ff-0008OS-FG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q12fc-0003jD-FX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684750893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZV84TyXClPNOF+1RqUQPrjW0xup1eehwRWWaDUPFZY=;
 b=Q1h85l3ozGriqOwyG8epPxqhIJQ/6/4zwY5JbUyv8Hx5QQlPSFrIQSh+G+ziY/YYr2Z/M8
 7PDXT8sG0s9jhytLfHN5V3DnDNrilbnA7C0cCmNBn1Axwf1kif/rdIYJPZSm2L+LZS5LQa
 qZZxHvPjH8pUUM7k0D4jhJXgjTW8RcM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-CMdszyG4OuO9m-XIxklHhg-1; Mon, 22 May 2023 06:21:31 -0400
X-MC-Unique: CMdszyG4OuO9m-XIxklHhg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-43940969f9aso235797137.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684750891; x=1687342891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZV84TyXClPNOF+1RqUQPrjW0xup1eehwRWWaDUPFZY=;
 b=komWRWnrdV+3lqDoDj/eEfP0tKukt1aFQJVWT9hFqbkBeJK9OT/sSNzImq+wlIRojB
 d/9MmDBh9PAzMIZTWODq6f1lvfA3JcSWCa1q1MahafO8aEV6yQyN3ryQgetVHi0zkGCu
 vifuMAtW9+IwD3EXpwlukXJc51/ZHbNm/Chm57hU62J3OYmOMt7RyYiq+gxa+b2psjMT
 P+C4Y2My811ETSDV82ua2V763tCHq2sOHnE7ix9Il1mPkWCVPrP9WUDdSeaRy1ScKBNY
 yHuWIJiTjfvxxcnmhvky0PYYiE03SO73iofUslm4fXfiRVxuSNQCi8UoaSdE6VrNN3sI
 3I+g==
X-Gm-Message-State: AC+VfDy12WsR+HUhftB6wK8lYaOsmgwZRh1fL5Gf7syLSmHMz1RD8tIP
 0K0ofCwN7UOSqmYZMTnd6lSQ7Wpkobrgm2VPLT7rZOsKieik/SiQZMOgVyFnhi0OtIBOXnW9CD8
 acGERVIyqXtIaf6kuFlsYCdxOd2MyBUM=
X-Received: by 2002:a67:e9cf:0:b0:437:d893:6cdd with SMTP id
 q15-20020a67e9cf000000b00437d8936cddmr2240496vso.2.1684750891018; 
 Mon, 22 May 2023 03:21:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WDhli8M7maBRSS+LlNkppV2b8K3Lgl1K5n1CING2FqLcEQriqXDdnZrlbrgsG0Lr1rGdMabxZ616NR4EgbtU=
X-Received: by 2002:a67:e9cf:0:b0:437:d893:6cdd with SMTP id
 q15-20020a67e9cf000000b00437d8936cddmr2240491vso.2.1684750890753; Mon, 22 May
 2023 03:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
 <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
 <20230518063559-mutt-send-email-mst@kernel.org>
 <d69e10b7-597d-913f-eb90-ed59b5b669f7@redhat.com>
 <CABgObfa3XqZOnSFkty8UqxibXKkqFGeQVT7Wad7YLan8zC2G=w@mail.gmail.com>
 <7D7609D5-FAE5-4110-8821-C62904585B9C@redhat.com>
 <CABgObfZb7L3-7xrayi2X1pUOHVmsyxj5D8fLg2nTh86Fef1YvQ@mail.gmail.com>
 <31DC243F-BA0D-48B8-9CC3-43982DDB9535@redhat.com>
In-Reply-To: <31DC243F-BA0D-48B8-9CC3-43982DDB9535@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 May 2023 12:21:19 +0200
Message-ID: <CABgObfbPRtUAewNA+uT-DHLLpeSNu4kJpTjR7DK7ymaD_rz4Ag@mail.gmail.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000060f17e05fc45a220"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000060f17e05fc45a220
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 20 mag 2023, 17:13 Ani Sinha <anisinha@redhat.com> ha scritto:

> > On 20-May-2023, at 3:06 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >
> >
> > Il sab 20 mag 2023, 09:25 Ani Sinha <anisinha@redhat.com> ha scritto:
> > 40c909f534e3f3cd2 from what I can see. It requires a full QEMU build in
> order to turn on CONFIG_IASL in bios-tables-test. At some point in the
> past, we could just install iasl and rerun the test and it would discover
> iasl in the path if CONFIG_IASL was not defined.
> >
> > So you want CONFIG_IASL to *not* have the full path if you configure
> with --iasl=3Diasl?
>
> Iasl is *not* a mandatory tool to run that test. So we do not want any
> configure option at all. It is absolutely not needed and makes the entire
> workflow more burdensome.
>

Configure is the default place where people look for an option to customize
binaries. A magic environment variable is hard to discover.

What you want is:

- default is iasl
- default can be overridden with --iasl

Implemented as:

iasl =3D find_program(get_option('iasl'), required: false)
if iasl.found()
  config_host_data.set_quoted('CONFIG_IASL', iasl.full_path()
ending

- IASL environment variable wins

- if neither the preprocessor macro nor the environment variable is
present, the test is skipped

Paolo


>
> > Paolo
> >
> >
> > I have proposed a patch with the title "acpi/tests/bios-tables-test:
> pass iasl path through environment variable=E2=80=9D.
> > I have tested possible scenarios and it would satisfy my uneasiness. On=
e
> thing I could not find is how to discover OS environment variable from
> meson.build. From what I could gather, currently it is not supported.
> Hence, when both CONFIG_IASL is passed from the command line and meson
> discovers one of its own, the meson one would be enforced and not the one
> developer passed.
> >
> >
>
>

--00000000000060f17e05fc45a220
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 20 mag 2023, 17:13 Ani Sinha &lt;<a href=3D"mai=
lto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; ha scritto:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">&gt; On 20-May-2023, at 3:06 PM, Paolo Bonzin=
i &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noref=
errer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Il sab 20 mag 2023, 09:25 Ani Sinha &lt;<a href=3D"mailto:anisinha@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt; h=
a scritto:<br>
&gt; 40c909f534e3f3cd2 from what I can see. It requires a full QEMU build i=
n order to turn on CONFIG_IASL in bios-tables-test. At some point in the pa=
st, we could just install iasl and rerun the test and it would discover ias=
l in the path if CONFIG_IASL was not defined.<br>
&gt; <br>
&gt; So you want CONFIG_IASL to *not* have the full path if you configure w=
ith --iasl=3Diasl?<br>
<br>
Iasl is *not* a mandatory tool to run that test. So we do not want any conf=
igure option at all. It is absolutely not needed and makes the entire workf=
low more burdensome.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Configure is the default place where people look for an=
 option to customize binaries. A magic environment variable is hard to disc=
over.</div><div dir=3D"auto"><br></div><div dir=3D"auto">What you want is:<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">- default is iasl</div><=
div dir=3D"auto">- default can be overridden with --iasl</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Implemented as:</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">iasl =3D find_program(get_option(&#39;iasl&#39;), =
required: false)</div><div dir=3D"auto">if iasl.found()</div><div dir=3D"au=
to">=C2=A0 config_host_data.set_quoted(&#39;CONFIG_IASL&#39;, iasl.full_pat=
h()</div><div dir=3D"auto">ending</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">- IASL environment variable wins</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">- if neither the preprocessor macro nor the environment =
variable is present, the test is skipped</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt; <br>
&gt; I have proposed a patch with the title &quot;acpi/tests/bios-tables-te=
st: pass iasl path through environment variable=E2=80=9D.<br>
&gt; I have tested possible scenarios and it would satisfy my uneasiness. O=
ne thing I could not find is how to discover OS environment variable from m=
eson.build. From what I could gather, currently it is not supported. Hence,=
 when both CONFIG_IASL is passed from the command line and meson discovers =
one of its own, the meson one would be enforced and not the one developer p=
assed.<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000060f17e05fc45a220--


