Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451481CBFF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 16:15:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGhDi-0006Vl-Rv; Fri, 22 Dec 2023 10:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rGhDf-0006VW-2n
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 10:13:47 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rGhDc-0000WP-Bh
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 10:13:46 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28bd85bda06so1173703a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703257900; x=1703862700;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2/RW4oWM0QAcyR+4M9wWIRn5CoNhaVjvj4AwIv0Wy0=;
 b=a72fFtV1qitIRDbZ7wigW/XbR2OzWiXnPAvzPmjaVxvZAepuk0Kb6CXqpZ8rayO0IY
 zpO+PGf38bedmUWL4jJRSieBZZ5hhGp8fc8ts5Qvsoe/ZTdNHvR6K4V8mVHfN8JgVT6L
 rBqdVLzv3EtwWOrMb6jQPUfgR8q9QbcsSo39WKcTDUf+ag/8Veqp8dU1nUB0+5XT4JkR
 5Nqj7a12k37ES+3KjPAmCTWIjpRUjxIBYzBSnEjWgJ6nasYhDYeXlhbI6MK5gexPBoMo
 vVVj3RoHUHUh1kbRIAmdTMpv2KAr6dZfG4pO/zqChfrYyMgFM/kdwYzeozG05vuHBsaq
 oGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703257900; x=1703862700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2/RW4oWM0QAcyR+4M9wWIRn5CoNhaVjvj4AwIv0Wy0=;
 b=M8ZtUeyeDScFz2oBCouhZPm8xJJkKAzkh1DEbb3HwVGEvebHgD7oMgZDeQF6oZg232
 aS1+K71OzqCHm/KmNA4vqzEqaNZQdebZ6Z2cdHirqplBWbCbxfTF1kQevGSDMGrgjM+U
 0eIv1+zTGBSFAJo6EHc4R6UETIMsWCMiUMuN8SYBo4l/dK+I1I93Cif/BbOKZ07vhgqU
 RzD8v3DS2475aPzdg+amvraWck86Qw71qxzLoqlhSwxXONO0LQuHPr85E27OvX3aYRed
 TUjs1hfayLT20Z1DWECMhzDGOEinzqVuANT8R8MpxbjCb9MKZToQT5EyBm9+CFM5Av/F
 Cl2w==
X-Gm-Message-State: AOJu0YyAB4y3/G52lq3QfhZBm+mlIfW2UJcjkArE91XDoZG/ythzEuD0
 RPotWQXrPKIwAnZ7d7WDDbI6HIplO4z3GiSqHdNU8c529JZJdA==
X-Google-Smtp-Source: AGHT+IGUBaJKa9SBJFGW07NyNmkAsH7puD2Coa2kP7B8K1f0Ypb9ClGRmwI9rQMUgkJkNtQIK2hmlCsIvgfoB9ZnXLI=
X-Received: by 2002:a17:90a:15d7:b0:28c:3a7:356e with SMTP id
 w23-20020a17090a15d700b0028c03a7356emr969222pjd.7.1703257897983; Fri, 22 Dec
 2023 07:11:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700319559.git.yong.huang@smartx.com>
 <3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com>
 <878r5mwoig.fsf@pond.sub.org>
In-Reply-To: <878r5mwoig.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 22 Dec 2023 23:11:21 +0800
Message-ID: <CAK9dgmbPJWtt774MVGHAwFbSgpVFXsdWT=NJM-Lkdizt6aLXsQ@mail.gmail.com>
Subject: Re: [v2 1/2] qapi/virtio: Add feature and status bits for
 x-query-virtio-status
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f87dc4060d1aa167"
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000f87dc4060d1aa167
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. of course. I'll do that next week. While v3 would be a single patch
that only contains the first commit.

Thanks,
Yong

On Fri, Dec 22, 2023 at 5:54=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > This patch allows to display feature and status bits in
> > virtio-status.
> >
> > Applications could find it helpful to compare status and features
> > that are numeric encoded. For example, an upper application could
> > use the features (encoded as a number) in the output of "ovs-vsctl
> > list interface" and the feature bits fields in the output of QMP
> > command "x-query-virtio-status" to compare directly when attempting
> > to ensure the correctness of the virtio negotiation between guest,
> > QEMU, and OVS-DPDK. Not applying any more encoding.
> >
> > This patch also serves as a preparation for the next one, which
> implements
> > a vhost-user test case about acked features of vhost-user protocol.
> >
> > Note that since the matching HMP command is typically used for human,
> > leave it unchanged.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>
> We discussed v1 some more since you posted this.  Do you intend to do a
> v3?
>
>

--=20
Best regards

--000000000000f87dc4060d1aa167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Sure. of course. I&#39;ll do=
 that next week. While v3 would be a single patch that only contains the fi=
rst commit.</div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif">Yong</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Dec 22, 2023 at 5:54=E2=80=AFPM Markus Armbruster &=
lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204=
,204);padding-left:1ex">Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx=
.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
<br>
&gt; This patch allows to display feature and status bits in<br>
&gt; virtio-status.<br>
&gt;<br>
&gt; Applications could find it helpful to compare status and features<br>
&gt; that are numeric encoded. For example, an upper application could<br>
&gt; use the features (encoded as a number) in the output of &quot;ovs-vsct=
l<br>
&gt; list interface&quot; and the feature bits fields in the output of QMP<=
br>
&gt; command &quot;x-query-virtio-status&quot; to compare directly when att=
empting<br>
&gt; to ensure the correctness of the virtio negotiation between guest,<br>
&gt; QEMU, and OVS-DPDK. Not applying any more encoding.<br>
&gt;<br>
&gt; This patch also serves as a preparation for the next one, which implem=
ents<br>
&gt; a vhost-user test case about acked features of vhost-user protocol.<br=
>
&gt;<br>
&gt; Note that since the matching HMP command is typically used for human,<=
br>
&gt; leave it unchanged.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
We discussed v1 some more since you posted this.=C2=A0 Do you intend to do =
a<br>
v3?<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000f87dc4060d1aa167--

