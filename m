Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D06712079
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2RJG-0000CH-0X; Fri, 26 May 2023 02:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q2RJA-0000Bf-UN
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1q2RJ8-0005bn-8Z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685083932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JmpX5muG9Y8iZ7uFOFzWpWMuOz1nvQ1EXeyQoerH5Pw=;
 b=CXDBc0sT3lFj2tJaKsmD4SOC4s+tDl+YrR3lYc/zDlBUvH/ds7poq3qbTspN+PlQNbNDGR
 +stvIj4Wtcom9TwdbIJsvGX7H49jLSNGwdJbu2Fxro1+yG2DGQLH/XJS4l3X0lostAJbcN
 PK6KQiOelCJcAomIsVSOS35JLmHDvcg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-i6bnsudfP4mdgeU6YRZ4DQ-1; Fri, 26 May 2023 02:52:11 -0400
X-MC-Unique: i6bnsudfP4mdgeU6YRZ4DQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ad0812151so222145f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 23:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685083929; x=1687675929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmpX5muG9Y8iZ7uFOFzWpWMuOz1nvQ1EXeyQoerH5Pw=;
 b=AEsGcH0c36dm+MaraPveaK/10wwWGk7xMQgkpVr5HAeYgdSEoqey7ZhhKhNaFYjA1S
 MhuVCHnfUPrUsEtU2nOhbe1+Q3Ws9lNJ6atXlJl1BAh9VpE8asoScErej3dqSTNjzaDA
 Q1TOTHXzx655SGd65uMg3HCWDI514jH7rlCLUF3mzucAQC8QXVrkr3fEbjw1QXD7jm6M
 L8RgmXGDQpHhctEArdW0O1Ts9dCcdGMFV49wyxa/q9zOj23/KWKXt7PpLppnOQbdffJm
 kkzRA7Pk/K6HkyF11ay+MtSS0YOByJRT6Rz5j3zVbjbMt7GQCId3cLDgP+KIooFduNfH
 rQfQ==
X-Gm-Message-State: AC+VfDzmDLKW+2fPhvQJQtobWC5Rp5CNbBkptPeplOPsYRNMbMM19YJF
 j8kyTZROZrPCXfe/wYNNgYsuFJXM7Q0KChwe75kP55Dnc5Vc3bx6fFZcwyOtyYFGib3UiIkedQR
 p0NJ+JT6CH+4wwVx5VcaEIidhECPCbMzgs9dCH05+gQ==
X-Received: by 2002:a5d:43c7:0:b0:306:2c5b:9da6 with SMTP id
 v7-20020a5d43c7000000b003062c5b9da6mr598756wrr.56.1685083929278; 
 Thu, 25 May 2023 23:52:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6k0++Zps2sy5j/G6stiUqFg0XIIOO/HB7R2hS5RyYDzfEdR+vlEykcVOoG4Fqy7MELjMY8GZHJ67e82yBR9+k=
X-Received: by 2002:a5d:43c7:0:b0:306:2c5b:9da6 with SMTP id
 v7-20020a5d43c7000000b003062c5b9da6mr598740wrr.56.1685083929025; Thu, 25 May
 2023 23:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230522181021.403585-1-ppandit@redhat.com> <ZG9cc0yEAJ06N0XY@x1n>
In-Reply-To: <ZG9cc0yEAJ06N0XY@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 26 May 2023 12:24:07 +0530
Message-ID: <CAE8KmOyeV2HB-Fd5PsqVPh7NZBQ7KRH9CrP_7xOsHLac2dwFVA@mail.gmail.com>
Subject: Re: [PATCH] vhost: release memory objects in error path
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001aefc05fc932d6a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--00000000000001aefc05fc932d6a
Content-Type: text/plain; charset="UTF-8"

Hello Peter, all

On Thu, 25 May 2023 at 18:33, Peter Xu <peterx@redhat.com> wrote:

> IIRC this bug used to only reproduce on rt kernels, is it still the case?
>

* Yes, it's a same crash.


> Here besides doing correct unregister, does it also mean that even if
> event_notifier_init() failed there's totally no error message anywhere?
> Should we dump something when it fails?  And did you check why that failed?
>

* In the qemu logs we see following error

        VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
        goto fail_mem

After this execution likely did not reach the event_notifier_init() call,
because: goto fail_mem.

* But in case it fails, no error message gets logged. Do we want to add it
in this same patch?

Thank you.
---
  - Prasad

--00000000000001aefc05fc932d6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial narrow,sans-serif;font-size:small">Hello Peter, all<br></div=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Thu, 25 May 2023 at 18:33, Peter Xu &lt;<a href=3D"mailto:peterx@redhat=
.com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">IIRC this bug used to only reproduce on rt kernels, =
is it still the case?<br></blockquote><div><br></div><div style=3D"font-fam=
ily:arial narrow,sans-serif;font-size:small" class=3D"gmail_default">* Yes,=
 it&#39;s a same crash.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Here besides doing correct unregister, does it also mean that even if<br>
event_notifier_init() failed there&#39;s totally no error message anywhere?=
<br>
Should we dump something when it fails?=C2=A0 And did you check why that fa=
iled?<br></blockquote><div><br></div><div><div style=3D"font-family:arial n=
arrow,sans-serif;font-size:small" class=3D"gmail_default">* In the qemu log=
s we see following error</div><div style=3D"font-family:arial narrow,sans-s=
erif;font-size:small" class=3D"gmail_default"><br></div><div style=3D"font-=
family:arial narrow,sans-serif;font-size:small" class=3D"gmail_default">=C2=
=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 VHOST_OPS_DEBUG(r, &quot;vhost_set_mem_table =
failed&quot;);<br>=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 goto fail_mem</div><div =
style=3D"font-family:arial narrow,sans-serif;font-size:small" class=3D"gmai=
l_default"><br></div></div><div style=3D"font-family:arial narrow,sans-seri=
f;font-size:small" class=3D"gmail_default">After this execution likely did =
not reach the event_notifier_init() call, because: goto fail_mem.</div><div=
 style=3D"font-family:arial narrow,sans-serif;font-size:small" class=3D"gma=
il_default"><br></div><div style=3D"font-family:arial narrow,sans-serif;fon=
t-size:small" class=3D"gmail_default">* But in case it fails, no error mess=
age gets logged. Do we want to add it in this same patch?</div><div style=
=3D"font-family:arial narrow,sans-serif;font-size:small" class=3D"gmail_def=
ault"><br></div><div style=3D"font-family:arial narrow,sans-serif;font-size=
:small" class=3D"gmail_default">Thank you.</div><div style=3D"font-family:a=
rial narrow,sans-serif;font-size:small" class=3D"gmail_default">---</div><d=
iv style=3D"font-family:arial narrow,sans-serif;font-size:small" class=3D"g=
mail_default">=C2=A0 - Prasad<br></div></div></div>

--00000000000001aefc05fc932d6a--


