Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D245707961
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:58:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzViU-0008IY-Lc; Thu, 18 May 2023 00:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzViS-0008Ht-So
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzViR-0001YW-4p
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684385894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnyFSz+wq7s+MQcGM0EpafMe12bS1eZBXo3KtPXIaJc=;
 b=LQnp0ws+QZxJZAUW5Fl+F07/a+8M/a47SxAgI7gvpGPemcC4MbJ+GOpOdSMrISEK42K6u7
 1eveeHq4Yz1K1z9rYAN1DtESKpkmYfSL/pT4yi/RNW/ouwltz/bQ3D6AgEIFROhdl2po3h
 3YTHGozNDwW824PNlJ3AJgSoIdXenmA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Uw3gtV22Nhap-TMEesLqYA-1; Thu, 18 May 2023 00:58:12 -0400
X-MC-Unique: Uw3gtV22Nhap-TMEesLqYA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-780c9094f63so497609241.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684385891; x=1686977891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xnyFSz+wq7s+MQcGM0EpafMe12bS1eZBXo3KtPXIaJc=;
 b=OGYjJ/4BSNwq5biBNEKsU2BHwTpAXxaaWfchaNF+ioW6SYcZVrB5THIF12aoLTyDdb
 uo7ButvXlDLyZ+38mD7yZgI5h+DQ629U2fgaoqlSi6FdoRpksOJVSKYWqUtKuVq02FH4
 IT6Cjd7582mtX0uJV37xxBiqpS3YIT3KFl61egt7G1V5pn+DEMvK4+77PbUz4/vVgBGJ
 hkD9H7Q9huA7ZBEKzmS4VFz/R2TSqFtzvez6hSKqfUW2aZaCzoWOWCzaK+nTizPE9VfT
 axgpEC+W57dsfWu0LIwpx3AxVGRzAwMAT+46g/N2y/Aj5y44o+BPxp5S0TLBDVqWSCbP
 hzzw==
X-Gm-Message-State: AC+VfDwCq66XFvdnXC3vUkG9gRxUzL3S3qM7NpQeo7zyXe+w+GCuiQpv
 wA5Z1X6FlszVCu/qWdRDuOXYP18ytUF/ip9utVcKTBabFkOQdrlo5iPm/T02GzQhxfz7cGiZVXZ
 7btsJzJ5GQx4q8WMOJlSA4AE7Du9boP+IIxjUX7c=
X-Received: by 2002:a67:f50e:0:b0:437:e14e:a98e with SMTP id
 u14-20020a67f50e000000b00437e14ea98emr118061vsn.19.1684385891463; 
 Wed, 17 May 2023 21:58:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59jk81BtvYWCYXOPuD+hS7AaauAH2QB5EjGIzz3XCcw+1b0K9WXSfWxyYI2npZy64ui6Q7TC/ZSEijjuLw6cE=
X-Received: by 2002:a67:f50e:0:b0:437:e14e:a98e with SMTP id
 u14-20020a67f50e000000b00437e14ea98emr118058vsn.19.1684385891242; Wed, 17 May
 2023 21:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <20230517174520.887405-64-pbonzini@redhat.com>
 <CAFEAcA8851_6Ye_sQ-wA85HSzwRTQvMw_Ahmh9E5XafyOwwq_g@mail.gmail.com>
In-Reply-To: <CAFEAcA8851_6Ye_sQ-wA85HSzwRTQvMw_Ahmh9E5XafyOwwq_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 May 2023 06:57:59 +0200
Message-ID: <CABgObfYcWRPLrVeYPRcRcuPeg41QckH9UMbsu0=n7WBLf5UrYA@mail.gmail.com>
Subject: Re: [PULL 63/68] configure: remove compiler sanity check
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b6689a05fbf0a639"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--000000000000b6689a05fbf0a639
Content-Type: text/plain; charset="UTF-8"

Il mer 17 mag 2023, 20:48 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Wed, 17 May 2023 at 18:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The comment is not correct anymore, in that the usability test for
> > the compiler and linker are done after probing $cpu, and Meson will
> > redo them anyway.
>
> The other thing this check is useful for, though, is
> providing a helpful error message rather than using
> a busted compiler for the other compile checks that
> configure does and then producing a confusing error message
> when some required-item test fails. (I think traditionally
> this was the GLIB_SIZEOF_SIZE_T check, but we may have put
> some other tests before that in the meantime.)
>

Yes but Meson does both the sanity check and the sizeof test now.

Paolo


> -- PMM
>
>

--000000000000b6689a05fbf0a639
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 17 mag 2023, 20:48 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Wed, 17 May 2023 at 18:50, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The comment is not correct anymore, in that the usability test for<br>
&gt; the compiler and linker are done after probing $cpu, and Meson will<br=
>
&gt; redo them anyway.<br>
<br>
The other thing this check is useful for, though, is<br>
providing a helpful error message rather than using<br>
a busted compiler for the other compile checks that<br>
configure does and then producing a confusing error message<br>
when some required-item test fails. (I think traditionally<br>
this was the GLIB_SIZEOF_SIZE_T check, but we may have put<br>
some other tests before that in the meantime.)<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Yes but Meson does both the s=
anity check and the sizeof test now.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000b6689a05fbf0a639--


