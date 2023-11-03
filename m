Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5887B7E000B
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqb9-0001jf-Cj; Fri, 03 Nov 2023 05:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyqb7-0001jC-8X
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:36:13 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyqb1-0006Jt-Bg
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:36:13 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c514cbbe7eso26362611fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699004164; x=1699608964;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/pJepHZ88QkJoUsmv2+9NEU3TfxTCxoj37klCYMhTXo=;
 b=G1Yg9jgM7YBfFUwbmIyMZCI4vtxfH6iGpLXx9FTjYOkglVDIkM3ncOHy302SfzfAJm
 c0AKutPzxGTpwtBMWdk5QaZ/AMBbpB5CCevAPOUtOGPLRmJiIFKG33JwsEenpamweSc+
 le8fBqk2VYXMJ2o8dTxW8MNagB1NtbGphpcti/6n25fllSTWMjnMo3EpW01N9eRxSL+2
 kU31Oumw09G+MTg7p9J/UCQMkUeM2HS/KalbtP40zTsJoV/4bqULpshW5s3Pzi6mKNnN
 WZ2XNKYQadsXCofLX/zTVtCvTHwI3gpE6ge2nStK7MQDvkidrPoyndaaNrmcr2ANLiF+
 EcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699004164; x=1699608964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pJepHZ88QkJoUsmv2+9NEU3TfxTCxoj37klCYMhTXo=;
 b=lyFRpZv5G1cSNE6VyyQvKNxP6+Nv1qwLZtxK60pCv62rvGg62sw9011b96ADg7cAbi
 TBiQznuE5IPNglWkA+Vky1P8pjnjSGOBvnGwxGBGy3IQ+cOiPah+87Chh4RUQxuvzfDr
 u3fCb5vFsp71lzr/6jX+LaYAlEQnvV3lyidLQQieuJy+bq3gaGPt4VTQ4AaH/iJBEZ9X
 lgoCm7ozgpuUjIjlw7jzI4IfaenZNfou/6TGqChQeLaJ6pnuRJW0Hp8aubg7NgO+9oRB
 m4JS3zqaoL/rZIgN8saDKNzpsQQHTfxqPWdFTJxgFMr4ldovNXNJpbYT6yHuHDMgv12w
 lt9g==
X-Gm-Message-State: AOJu0YxiEkBWRJppjaYd7akNKuTUG0NpAzLqMZvud08zwcd8S/yzWLbP
 tKv7SQLLUSWZMU9tEfYbuof60G4YwvMDwTm24fmEMA==
X-Google-Smtp-Source: AGHT+IH6oZUDzy0JzOWixXak5WQQSan9UcDV+DRdbAkV229l0paVONEZHDPhXR5pWmNomeGU3p2b1EWQijnl+lk2ahQ=
X-Received: by 2002:a2e:9f16:0:b0:2c5:3492:5d96 with SMTP id
 u22-20020a2e9f16000000b002c534925d96mr16142759ljk.12.1699004164515; Fri, 03
 Nov 2023 02:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
In-Reply-To: <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 3 Nov 2023 11:35:53 +0200
Message-ID: <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000b2bdd006093c3bc5"
Received-SPF: none client-ip=2a00:1450:4864:20::233;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000b2bdd006093c3bc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 4:56=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com>
wrote:

> On 2023/11/02 19:20, Yuri Benditovich wrote:
> >
> >
> > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com
> > <mailto:mst@redhat.com>> wrote:
> >
> >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
> >      > Probably we mix two different patches in this discussion.
> >      > Focusing on the patch in the e-mail header:
> >      >
> >      > IMO it is not acceptable to fail QEMU run for one feature that w=
e
> >     can't make
> >      > active when we silently drop all other features in such a case.
> >
> >     If the feature is off by default then it seems more reasonable
> >     and silent masking can be seen as a bug.
> >     Most virtio features are on by default this is why it's
> >     reasonable to mask them.
> >
> >
> > If we are talking about RSS: setting it initially off is the developmen=
t
> > time decision.
> > When it will be completely stable there is no reason to keep it off by
> > default, so this is more a question of time and of a readiness of
> libvirt.
>
> It is not ok to make "on" the default; that will enable RSS even when
> eBPF steering support is not present and can result in performance
> degradation.
>

Exactly as it is today - with vhost=3Don the host does not suggest RSS
without  eBPF.
I do not understand what you call "performance degradation", can you
describe the scenario?


>
> We will need OnOffAuto instead of a simple boolean value if we are going
> to enable RSS when eBPF steering support is available; "auto" will be
> the default and will enable RSS if and only if eBPF steering support is
> available. "on" will not be default so it's better to validate if RSS is
> available when the user explicitly specified "on" for the "rss" property.
>

--000000000000b2bdd006093c3bc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 2, 2023 at 4:56=E2=80=AFP=
M Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.oda=
ki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 2023/11/02 19:20, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@red=
hat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Probably we mix two different patches in this=
 discussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Focusing on the patch in the e-mail header:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; IMO it is not acceptable to fail QEMU run for=
 one feature that we<br>
&gt;=C2=A0 =C2=A0 =C2=A0can&#39;t make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; active when we silently drop all other featur=
es in such a case.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If the feature is off by default then it seems more=
 reasonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0and silent masking can be seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Most virtio features are on by default this is why =
it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0reasonable to mask them.<br>
&gt; <br>
&gt; <br>
&gt; If we are talking about RSS: setting it initially off is the developme=
nt <br>
&gt; time decision.<br>
&gt; When it will be completely stable there is no reason to keep it off by=
 <br>
&gt; default, so this is more a question of time and of a readiness of libv=
irt.<br>
<br>
It is not ok to make &quot;on&quot; the default; that will enable RSS even =
when <br>
eBPF steering support is not present and can result in performance <br>
degradation.<br></blockquote><div><br></div><div>Exactly as it is today - w=
ith vhost=3Don the host does not suggest RSS without=C2=A0 eBPF.</div><div>=
I do not understand what you call &quot;performance degradation&quot;, can =
you describe the scenario?</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
We will need OnOffAuto instead of a simple boolean value if we are going <b=
r>
to enable RSS when eBPF steering support is available; &quot;auto&quot; wil=
l be <br>
the default and will enable RSS if and only if eBPF steering support is <br=
>
available. &quot;on&quot; will not be default so it&#39;s better to validat=
e if RSS is <br>
available when the user explicitly specified &quot;on&quot; for the &quot;r=
ss&quot; property.<br>
</blockquote></div></div>

--000000000000b2bdd006093c3bc5--

