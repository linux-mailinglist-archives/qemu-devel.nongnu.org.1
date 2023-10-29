Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8787DAEAB
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:58:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxDmK-0001bg-1p; Sun, 29 Oct 2023 17:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxDmB-0001bO-6t
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:56:55 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qxDm9-00066m-7n
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:56:54 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5087d19a6so54315561fa.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698616610; x=1699221410;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sTWtuMtt0BKofbrC+1iYdZpjD1qL9KCwiQYhqn2slxg=;
 b=DVuKtuALZpHRidGU+NxdFQgvYbos4Fqt1IH4wbcpirUX1opEteIB+pSdaDsgqtGATA
 Kq8CbtAt/dupTA0TXnGQMYFp+d2in+d1vr9lAIU7aoFuzdlERVi5m2Q4V8jROLBCGjXn
 ndbaTfYUSKloFvJnGgq6GH7AmXZJEYPa7JjKSrgl5xzLUHmNaRSG6pgQAkZ1O2VC9Amn
 dgFJBry+L0FusLLjjD6lSgFMNUkksPtBY0UAo6wJgRwT5S8Umep84RE/rg7QHkgi8/eY
 peKRnWmqp3Wi6Zt/0ZEnA2Lcofn52lkjQ0Tvk02UArvggU8w+zBSbm/sdPFB7CvVIITD
 GxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698616610; x=1699221410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sTWtuMtt0BKofbrC+1iYdZpjD1qL9KCwiQYhqn2slxg=;
 b=c2WBoXPUtptZrVxtx5G9I9yt3YCMOgYDVmRomsnhbqzTU7WqH4td9vG7KU3f8LgETu
 p4Piutg7o+E+8dLkGZgy8/TbzeN/SjeYvBXhm5nsXfw8PwK7demIipBP8EtqOKsHqBwB
 8BtyW9PvUClpKCn1r+bNMgIMWOCiDxpo+hCMIBxs737SuG0AIkD4AzAVpXVB0UHrNtJJ
 8dFP9CtLjECSl/wqcq1rwmTk3D/t4/5ftPNqST/5dFYEGn9jREDHey5OcgfKm5B7L25e
 GTfmR8TtFWQbOYxKxJY8nXFA5QtGKz5G27efee3kPhC/qyVuhj6xrGDK6kqonSKfpmJo
 yzVA==
X-Gm-Message-State: AOJu0Yw3b2z5RDkF1P9BsS0sYs4TKDxQeRt5EE1Lmg6nfYggncLgFhlD
 T14ppR2R3WgYQzWCfHQlY6/zyQ58sHul7YDJqJT2Pw==
X-Google-Smtp-Source: AGHT+IEb27deocJnKOqzBocxG7CrfoBY/swuiJzGyFDtYud4sB13cewMx/o6o91PJGPp8Ogztkhs/HQtM6MZH9oqRwA=
X-Received: by 2002:a05:651c:32a:b0:2c5:2cd7:62e8 with SMTP id
 b10-20020a05651c032a00b002c52cd762e8mr6296293ljp.12.1698616609507; Sun, 29
 Oct 2023 14:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-16-akihiko.odaki@daynix.com>
 <CACGkMEuA5azGUQzyCe=4xq+YfV60PuiOajhJ=1HOXoG9Gege5g@mail.gmail.com>
 <8247b828-fc57-4f40-8320-a1e2c494f216@daynix.com>
In-Reply-To: <8247b828-fc57-4f40-8320-a1e2c494f216@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Sun, 29 Oct 2023 23:56:37 +0200
Message-ID: <CAOEp5OfYZ3W867iXXEu70Za_UnxdW8UBW4qV-FjBZ=R5nFNUeg@mail.gmail.com>
Subject: Re: [PATCH v5 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009e9f730608e1ff0b"
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000009e9f730608e1ff0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch allows  VIRTIO_NET_F_HASH_REPORT feature to the adapter whose
backend does not have a virtio header and does not have offload features
that depend on it.
The migration between such different systems is very problematic even if it
seems successful, such setups are not performance-oriented and especially
supporting the hash delivery for them is (IMHO) redundant, it just requires
more testing and does not bring any advantage.


On Fri, Oct 27, 2023 at 11:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com>
wrote:

> On 2023/10/27 16:14, Jason Wang wrote:
> > On Tue, Oct 17, 2023 at 12:14=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com>
> wrote:
> >>
> >> virtio-net can report hash values even if the peer does not have a
> >> virtio-net header.
> >
> > Do we need a compat flag for this?
>
> I don't think so. This change actually fixes the migration from a system
> with tap devices that support virtio-net headers to a system with tap
> devices that do not support virtio-net headers. Such a compatibility
> flag will revert the fix.
>
> Regards,
> Akihiko Odaki
>

--0000000000009e9f730608e1ff0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch allows=C2=A0 VIRTIO_NET_F_HASH_REPORT feature t=
o the adapter whose backend does not have a virtio header and does not have=
 offload features that depend on it.<div>The migration between such differe=
nt systems is very problematic even if it seems=C2=A0successful, such setup=
s are not performance-oriented and especially supporting the hash delivery =
for them is (IMHO) redundant, it just requires more testing and does not br=
ing any advantage.</div><div><br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 27, 2023 at 11:07=E2=80=
=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko=
.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 2023/10/27 16:14, Jason Wang wrote:<br>
&gt; On Tue, Oct 17, 2023 at 12:14=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"=
mailto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com=
</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; virtio-net can report hash values even if the peer does not have a=
<br>
&gt;&gt; virtio-net header.<br>
&gt; <br>
&gt; Do we need a compat flag for this?<br>
<br>
I don&#39;t think so. This change actually fixes the migration from a syste=
m <br>
with tap devices that support virtio-net headers to a system with tap <br>
devices that do not support virtio-net headers. Such a compatibility <br>
flag will revert the fix.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
</blockquote></div>

--0000000000009e9f730608e1ff0b--

