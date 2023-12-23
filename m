Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23181D3D4
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Dec 2023 12:49:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rH0U3-0004yo-C1; Sat, 23 Dec 2023 06:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rH0U1-0004yD-Cl
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 06:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rH0Tz-0000Rz-JR
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 06:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703332073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVWkUmexxNVBKkpdzB5pSC/IF1T5lqT962/H9PdL338=;
 b=Dj/RQglGwDh/hOFaKHODcSo3Cylano7YMUa82n6P/9vKj+j/RmJx8m4vzVTEjZ1eF0Osbm
 ZF6ZBziOVAMvv88reFG7TuRtWlrT8Zmt0eIcWK3qJsswoKO4pfV/HgrjhCzw7FvaBSthMn
 45iyGi8ta4aE3SGbDpWS9Kk7jYESU6Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-5U8NlKo9PA-ya3xd0eHlKw-1; Sat, 23 Dec 2023 06:47:50 -0500
X-MC-Unique: 5U8NlKo9PA-ya3xd0eHlKw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4277cd01468so42772031cf.3
 for <qemu-devel@nongnu.org>; Sat, 23 Dec 2023 03:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703332070; x=1703936870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVWkUmexxNVBKkpdzB5pSC/IF1T5lqT962/H9PdL338=;
 b=iu0KRUMoPeCHAXLPf/ycOU28JtO5Y0592jFAUs2LyaIl967VaUXi3RoQ74fpR5I2i9
 AwtfhhwtvOWtdtWM4PeGsX+ib+KbyFHGsvMyGJj8HLeiXSCxrdyD4cx5Q2XVLSxC4H9+
 OADDdXNG7QrNzbS+dlwvKu5NOl7pr93cQ3R//gDLg09Ect9Ek2xnf7mS9T6EJi7nFETR
 G/7WTfl14X6JWWIR+l0UPkWf5UoLfgDNd2O8S53iBTFYX7DcsJDOn5J9aocY0XgYYP6z
 oVeb9950U9s80JhUygehJ4xNNEkrUR682UHanG+O4vL+1W4BqkCI7nelyRuScjLMpFUL
 0Hzw==
X-Gm-Message-State: AOJu0YwQsf53+6zmb3DRMrUFEspW+b9c0sp/r07YI0ZF3szuddW+A/rO
 ab/FOvclJS6kTFQGQyi13OxDVLHzNFAJFKrjs31pV6rjQfGQwUaUsZyUIIL4YkbDSkCZK6u8HfK
 /4a5FxpA52YGmqVg5osauWs0vykRGGz1hahHIKqU8IdR5Vuo=
X-Received: by 2002:ac8:5d41:0:b0:425:7990:34f with SMTP id
 g1-20020ac85d41000000b004257990034fmr4027347qtx.70.1703332069877; 
 Sat, 23 Dec 2023 03:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESQGNMQDqPOp9kPXi40NKjFqabyS4HKI0h9YrIvX3cVGxKCl+u82Bddgx9We3oSWfq1F6kC/BeLo1lw6ww8B8=
X-Received: by 2002:ac8:5d41:0:b0:425:7990:34f with SMTP id
 g1-20020ac85d41000000b004257990034fmr4027333qtx.70.1703332069553; Sat, 23 Dec
 2023 03:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20231222175951.172669-1-pbonzini@redhat.com>
 <20231222175951.172669-4-pbonzini@redhat.com>
 <0102018c963dbec6-062a7a68-53b9-4325-9137-8cee657053b2-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102018c963dbec6-062a7a68-53b9-4325-9137-8cee657053b2-000000@eu-west-1.amazonses.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 23 Dec 2023 12:47:38 +0100
Message-ID: <CABgObfbgVgQu5oYqtatVjA50FCWxvANtXAYHnV70iFOCu8DniQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/i386: Fix physical address truncation
To: Michael Brown <mcb30@ipxe.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f0cbe4060d2be6bd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--000000000000f0cbe4060d2be6bd
Content-Type: text/plain; charset="UTF-8"

Il sab 23 dic 2023, 11:34 Michael Brown <mcb30@ipxe.org> ha scritto:

> I am confused by how BOUND can result in an access to a linear address
> outside of the address-size range.  I don't know the internals well
> enough, but I'm guessing it might be in the line in helper_boundl():
>
>      high = cpu_ldl_data_ra(env, a0 + 4, GETPC());
>
> where an address is calculated as (a0+4) using a 64-bit target_ulong
> type with no truncation to 32 bits applied.
>
> If so, then ought the truncation to be applied on this line instead (and
> the equivalent in helper_boundw())?  My understanding (which may well be
> incorrect) is that the linear address gets truncated to the instruction
> address size (16 or 32 bits) before any conversion to a physical address
> takes place.
>

The linear address is the one that has the segment base added, and it is
not truncated to 16 bits (otherwise the whole A20 thing would not exist).
The same should be true of e.g. an FSAVE instruction; it would allow access
slightly beyond the usual 1M+64K limit that is possible in real mode with
286 and later processors.

In big real mode with 32-bit addresses, it should not be possible to go
beyond 4G physical address by adding the segment base, it should wrap
around and that's what I implemented. However you're probably right that
this patch has a hole for accesses made from 32-bit code segments with
paging enabled. I think LMA was the wrong bit to test all the time, and I
am not even sure if the masking must be applied even before the call to
mmu_translate(). I will ponder it a bit and possibly send a revised version.

Paolo


> Regardless: this updated patch (in isolation) definitely fixes the issue
> that I observed, so I'm happy for an added
>
> Tested-by: Michael Brown <mcb30@ipxe.org>
>
> Thanks,
>
> Michael
>
>

--000000000000f0cbe4060d2be6bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 23 dic 2023, 11:34 Michael Brown &lt;<a href=3D=
"mailto:mcb30@ipxe.org">mcb30@ipxe.org</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">I am confused by how BOUND can result in an access =
to a linear address <br>
outside of the address-size range.=C2=A0 I don&#39;t know the internals wel=
l <br>
enough, but I&#39;m guessing it might be in the line in helper_boundl():<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0high =3D cpu_ldl_data_ra(env, a0 + 4, GETPC());<br>
<br>
where an address is calculated as (a0+4) using a 64-bit target_ulong <br>
type with no truncation to 32 bits applied.<br>
<br>
If so, then ought the truncation to be applied on this line instead (and <b=
r>
the equivalent in helper_boundw())?=C2=A0 My understanding (which may well =
be <br>
incorrect) is that the linear address gets truncated to the instruction <br=
>
address size (16 or 32 bits) before any conversion to a physical address <b=
r>
takes place.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">The linear address is the one that has the segment base added, =
and it is not truncated to 16 bits (otherwise the whole A20 thing would not=
 exist). The same should be true of e.g. an FSAVE instruction; it would all=
ow access slightly beyond the usual 1M+64K limit that is possible in real m=
ode with 286 and later processors.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">In big real mode with 32-bit addresses, it should not be possibl=
e to go beyond 4G physical address by adding the segment base, it should wr=
ap around and that&#39;s what I implemented. However you&#39;re probably ri=
ght that this patch has a hole for accesses made from 32-bit code segments =
with paging enabled. I think LMA was the wrong bit to test all the time, an=
d I am not even sure if the masking must be applied even before the call to=
 mmu_translate(). I will ponder it a bit and possibly send a revised versio=
n.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
Regardless: this updated patch (in isolation) definitely fixes the issue <b=
r>
that I observed, so I&#39;m happy for an added<br>
<br>
Tested-by: Michael Brown &lt;<a href=3D"mailto:mcb30@ipxe.org" target=3D"_b=
lank" rel=3D"noreferrer">mcb30@ipxe.org</a>&gt;<br>
<br>
Thanks,<br>
<br>
Michael<br>
<br>
</blockquote></div></div></div>

--000000000000f0cbe4060d2be6bd--


