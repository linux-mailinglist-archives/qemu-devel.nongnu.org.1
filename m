Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA496827AEB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 23:57:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyXm-0001bV-K9; Mon, 08 Jan 2024 17:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMyXg-0001bK-3A
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMyXe-0005KM-Hx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 17:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704754581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qu1Ps0Ku3RvGsZ9TDJ4irjyxcBVgusX7BtZqRjA1+Uk=;
 b=SdRMsAWnxaRH62wMJEO1bpFsgk+XLOPrGCX18AKn4Cjooy23xrt2+3jufFqBhrlQD2SkJO
 ZSK2DBqmmLKL3fRXbER2JZDHy/whxHIJpKz3J3+9KSO9hYIPdN0yp49AdzSzNyL7hE650W
 Gza48dLxad9FdnX94kmhrfJzq7pgDcg=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-2tp1qbcgMIeF18NX0A2_HQ-1; Mon, 08 Jan 2024 17:56:14 -0500
X-MC-Unique: 2tp1qbcgMIeF18NX0A2_HQ-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-467404eb0a6so369283137.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 14:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704754573; x=1705359373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qu1Ps0Ku3RvGsZ9TDJ4irjyxcBVgusX7BtZqRjA1+Uk=;
 b=DDZfrJ0gfClgcXbtg7QFzMcmzQirfX+/NW9ULtww3gYp7KSNMeADkwX7ApmkMOqONN
 fUPUoPz31VbetMjejKtdXYVes0lTairzuNt6zVK53vVaexacQZt5aDg78Fk+Kj/DJSX9
 VOMgUiom8dAaDTYE0AvtLu2xQEpivAQ5XWXbmCzVc/gD1EgE7K/t+rgOnmTAptRmDt6W
 wttjvihOmovlWgT/oGHY+dJCnnVMnzDlet4lgCqQ+4O9090Z6YftP1bOmCu8x6plbcCX
 3IiwRijYA0pE9g6NKDBWUy195SvzzYgouOCh542jF6jue2UlOemTgbuJmfpRxBIRrsX3
 esWQ==
X-Gm-Message-State: AOJu0Yx8YQoNCPFOpGUKYhlRe772UuFqB+QZmxNVioIGxbSp9M1V6n7Q
 qiLjJxaIhmPD69TIo+Qqz4r0HU8y+fDWwCHqrMip/T88HCvVJdQve7F3qNmiGsEANB7B5xCrsf6
 LGlcqFPOhuCxC9IJoDXCdLGhffI6dHcy8D4/MT+ScEhPxg3Y=
X-Received: by 2002:a05:6102:b16:b0:467:dfba:a28d with SMTP id
 b22-20020a0561020b1600b00467dfbaa28dmr1164157vst.33.1704754573443; 
 Mon, 08 Jan 2024 14:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcp96HnaN5aPEHbyAr+sc/5FViJj8uaMetltL05hNr4y+1rTOpSozwhqtXzIPKOGoc8Rg5JZDwms7LfKg1YC4=
X-Received: by 2002:a05:6102:b16:b0:467:dfba:a28d with SMTP id
 b22-20020a0561020b1600b00467dfbaa28dmr1164153vst.33.1704754573181; Mon, 08
 Jan 2024 14:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <CABgObfZme6gNZG=3ibXb8=+yAg=LHPeHYdncdx2LgN741bk_7A@mail.gmail.com>
 <6327ac54-6394-4648-b4b8-2294a37b1588@linaro.org>
In-Reply-To: <6327ac54-6394-4648-b4b8-2294a37b1588@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jan 2024 23:55:59 +0100
Message-ID: <CABgObfYE_L=oF0-bKESJVcPhNr_-R3Yw4Uoi7vtV3iW6Q5=26A@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c3a2b2060e771a15"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

--000000000000c3a2b2060e771a15
Content-Type: text/plain; charset="UTF-8"

Il lun 8 gen 2024, 22:45 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> > I was thinking: a lot of RISC targets simply do AND/ANDI
> > followed by the sequence used for TCG_COND_NE.  Would it make sense to
> > have a TCG_TARGET_SUPPORTS_TST bit and, if absent, lower TSTEQ/TSTNE
> > to AND+EQ/NE directly in the optimizer?
>
> Probably best, yes.
>

Ok, I will give it a shot.

> And for brcond2/setcond2,
> > always using AND/AND/OR may work just as well as any backend-specific
> > trick, and will give more freedom to the register allocator.
>
>    test   a,b
>    testeq c,e
>
> for Arm32.  So I'll leave it to the backends.
>

Nice. :)

Paolo


>
> r~
>
>

--000000000000c3a2b2060e771a15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 gen 2024, 22:45 Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; I was thinking:=
 a lot of RISC targets simply do AND/ANDI<br>
&gt; followed by the sequence used for TCG_COND_NE.=C2=A0 Would it make sen=
se to<br>
&gt; have a TCG_TARGET_SUPPORTS_TST bit and, if absent, lower TSTEQ/TSTNE<b=
r>
&gt; to AND+EQ/NE directly in the optimizer?<br>
<br>
Probably best, yes.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Ok, I will give it a shot.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
&gt; And for brcond2/setcond2,<br>
&gt; always using AND/AND/OR may work just as well as any backend-specific<=
br>
&gt; trick, and will give more freedom to the register allocator.<br>
<br>
=C2=A0 =C2=A0test=C2=A0 =C2=A0a,b<br>
=C2=A0 =C2=A0testeq c,e<br>
<br>
for Arm32.=C2=A0 So I&#39;ll leave it to the backends.<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">Nice. :)</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000c3a2b2060e771a15--


