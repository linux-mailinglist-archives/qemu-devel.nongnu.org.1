Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D142873ABE8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSJ0-0005Ot-5k; Thu, 22 Jun 2023 17:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCSIx-0005Mq-EG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCSIv-0002dS-RK
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687471045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IanzesFzr/B59GS9TWl7a6d+IPtEPLvAOlHijfBdEO4=;
 b=eAScE5PSSWwiwQbu0oRLNGP+eSljbdqAraqgG2bGQvPkXQ01izT/6FCGNgtZHgayacMhRm
 nxvKBkLxN+CTuzuupoududrRwFxxL3zANC9mbg0oJ2m3YxUUFszdNls6m9U1svXnewVbS9
 NCG2Pm4jJ7lwzkWiZoKiFbiFiTbOH3g=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-bSZBp-KKMLaz33qT3wB7AQ-1; Thu, 22 Jun 2023 17:57:21 -0400
X-MC-Unique: bSZBp-KKMLaz33qT3wB7AQ-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-43f5e2320a2so2407803137.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 14:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687471040; x=1690063040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IanzesFzr/B59GS9TWl7a6d+IPtEPLvAOlHijfBdEO4=;
 b=f9aveFxOZBxcnrJM6P5L/WAkwExomE4LseGEk/8U1s/est4nZ4E7KRpre+J8E7xOI0
 /cvvbkNhNQLPj5WyurXHDJ7PNRxiIdkoYQrCNmpRYhaxH/O73djEY2YGqFX4rpexf+ut
 dpsx0cn1Qc4sj2Xtc/M1f2K1VZcqm1S4Yq12sv0oh1BAu9DRU2L9kRAOn/vBJozppx9G
 +vHXweXIzE4ekQLmCT8hTBBspQeoJBgmqrujjCzHlNgZGAQl7MyyPxnkkoWu1hFsimn9
 gRLDBE2RDnvyrnYQhkBqBk2AEfgvbsvni3eLrDQZsGkNHey+wAFlXDPQU9GfP1yb4QzM
 TgfA==
X-Gm-Message-State: AC+VfDy6uUkxvvGOaDQejbCQMtMJKQVSiXdHjiA/yeqa2NApO+gf4VaY
 q+i0iTX00s+4oC+Axcw8O3DqD8VVSYt32ztFF9uEwkEjWPueZu6JP+8UouvzOD1g+jtGPfyij4Q
 srxlDN5aJhNncFciNCVEBjlIFBJGn/xA=
X-Received: by 2002:a05:6102:398:b0:440:a920:dcc4 with SMTP id
 m24-20020a056102039800b00440a920dcc4mr8468891vsq.22.1687471040689; 
 Thu, 22 Jun 2023 14:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4IYR+//Wn6J3WR4CIoe9QEdUk/uhh/Y+FzzoeSPzoUyiTvObQV3Ezbrtk1b1me3bQq7TXRDFRpTmQXxrXF+rs=
X-Received: by 2002:a05:6102:398:b0:440:a920:dcc4 with SMTP id
 m24-20020a056102039800b00440a920dcc4mr8468883vsq.22.1687471040448; Thu, 22
 Jun 2023 14:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
 <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
 <CAFn=p-a1Lz=FdrAYcB8Ua3AK=C5674Lyg5vRyxNjaybNXgvQ0w@mail.gmail.com>
 <CABgObfYo34ZOqAGdf9jEEQUtTztcwDUF+N9JGSsbBw8z1FOoWQ@mail.gmail.com>
 <CAFn=p-YnhA=FGPbPifY9vR=skpV=8dVvtmgdivJGw0cNjR6ouw@mail.gmail.com>
 <CABgObfbmjjB505_O4wg5sUKYkgVhcrdPnevV9Pv-uH+TCb=o-w@mail.gmail.com>
 <CAFn=p-YsWb2V-pjB82iDU4g_Z9kdq58QajzP_acDq8kfyja8=A@mail.gmail.com>
In-Reply-To: <CAFn=p-YsWb2V-pjB82iDU4g_Z9kdq58QajzP_acDq8kfyja8=A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jun 2023 23:57:10 +0200
Message-ID: <CABgObfY6mRs7hGm8HA17WZs-AoCv3AXezeUAsvXjSBVGJ70ang@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ef60b605febef792"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000ef60b605febef792
Content-Type: text/plain; charset="UTF-8"

Il gio 22 giu 2023, 23:18 John Snow <jsnow@redhat.com> ha scritto:

> Possibly I could teach mkvenv a new trick, like "mkvenv init iotests"
> and have the mkvenv script DTRT at that point, whatever that is --
> ideally exiting very quickly without doing anything.
>

Or maybe check itself should do the bootstrap if it's invoked from the
venv?!?

Paolo

>

--000000000000ef60b605febef792
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 22 giu 2023, 23:18 John Snow &lt;<a href=3D"mai=
lto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Possibly I could teach mkvenv a new trick, like &qu=
ot;mkvenv init iotests&quot;<br>
and have the mkvenv script DTRT at that point, whatever that is --<br>
ideally exiting very quickly without doing anything.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Or maybe check itself s=
hould do the bootstrap if it&#39;s invoked from the venv?!?</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000ef60b605febef792--


