Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1557C99A1
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs2TD-0002rP-LL; Sun, 15 Oct 2023 10:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qs2TB-0002pc-Ah
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qs2T9-00077c-4k
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697381509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbWpb5HP6JPxg7yhsmVy+f3vOMRlOPU6+Twp/BV6P3g=;
 b=I4r5Q2hVeGrZbrRJej8RyFGa3Bvba0HW0sdEfGB7kAkEZSCd4HG/OqxvJlarZyFOHI5bRB
 I+eqlI7fJ9IEPm3VW6844qOhAPbKSK7i+ryJtuB0WtdgS3o/ZnanUrgRzXvcAMhY3PHGuJ
 GufE51TUzQsWYQB2kz4Norig2EePdhI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-CciabPl2Mj2cEf4NeFN2_w-1; Sun, 15 Oct 2023 10:51:37 -0400
X-MC-Unique: CciabPl2Mj2cEf4NeFN2_w-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-457e3fa6563so19840137.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697381497; x=1697986297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbWpb5HP6JPxg7yhsmVy+f3vOMRlOPU6+Twp/BV6P3g=;
 b=h2rjkacmzbSJP/svZAY6ymY6w80LsC1BJeH6rG+ZUumCvCRZo6W3OkOlP7CXqyXCCw
 diB3W0HXyVK8QaYL/OrcYJBMpV9QJS/jnRJEu+HUq8vWn9xNdBif3N9wveU1iWNgNXMO
 TgKO8pG0HaUsrHOZATLeNB2oBoNZcs39oReqfxpB4NavC504qtZigtVPLnvCssvI3IgF
 SKx2LubjEDGxYXzwHCfcm52mTEwV+BJBYdjQBiIirlYyghWYN99A7jfYzLGiDkckqn/t
 1YJ2z8V4BWV6h+B9RaffVppFW7DK2gTBpJ8uFRw+6nva4BNh7MS30yxUvIQ5W4rQ0GSn
 b5jw==
X-Gm-Message-State: AOJu0YxSsnZ/HU4AbPo6xml8vleTIcfqqgplo98QWJN3sGSmuvia4Eh+
 am4vv3eakUbiH6QmN9V9wrBVzLeTxwGalG3awPviUuj9Ktd5GdKq+/skbqscffL7w/UwV8zT0dY
 uGObjTx2KLt30wUpOFPaMBg7U1vCKu+A=
X-Received: by 2002:a67:f6c3:0:b0:452:9356:ab4e with SMTP id
 v3-20020a67f6c3000000b004529356ab4emr21242245vso.25.1697381497157; 
 Sun, 15 Oct 2023 07:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmiCmyAWZkqVVznzZKpLBZOFKR66jQ4zWTSv724u+3O5Gzygm5uHigdt3gh4Z1Xzrgt9p0SQ91++uOQg+ft2c=
X-Received: by 2002:a67:f6c3:0:b0:452:9356:ab4e with SMTP id
 v3-20020a67f6c3000000b004529356ab4emr21242241vso.25.1697381496891; Sun, 15
 Oct 2023 07:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-8-pbonzini@redhat.com>
 <47144c91-3c1d-430a-b917-fbe9bb7b193c@linaro.org>
In-Reply-To: <47144c91-3c1d-430a-b917-fbe9bb7b193c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 15 Oct 2023 16:51:26 +0200
Message-ID: <CABgObfa7TgQZzQWFfp9t+M+0YxrgiPY5ZC2YZbzmcFvjN57iVQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] target/i386: introduce flags writeback mechanism
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002bcb290607c26d06"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000002bcb290607c26d06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 6:06=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> On 10/14/23 03:01, Paolo Bonzini wrote:
> > +static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext
*s, CCOp op)
> > +{
> > +    decode->cc_dst =3D s->T0;
> > +    set_cc_op(s, op);
> > +}
>
> You must delay the set_cc_op() until the end too, for the same reason.
The function call
> will emit discard opcodes, which will kill cc_foo while still live via
the memory exception.

Right, that can affect previous instructions due to dead code elimination.
I even wrote part of that code. :)

Since I have to add decode->cc_op, I'll add CC_OP_DYNAMIC handling as well,
and
assert that everything is NULL if the gen_* function didn't touch
decode->cc_op.

Thanks!

Paolo

>
>
> r~
>

--0000000000002bcb290607c26d06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br>
<br>
On Sat, Oct 14, 2023 at 6:06=E2=80=AFPM Richard Henderson &lt;<a href=3D"ma=
ilto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferrer">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/14/23 03:01, Paolo Bonzini wrote:<br>
&gt; &gt; +static void prepare_update1_cc(X86DecodedInsn *decode, DisasCont=
ext *s, CCOp op)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 decode-&gt;cc_dst =3D s-&gt;T0;<br>
&gt; &gt; +=C2=A0 =C2=A0 set_cc_op(s, op);<br>
&gt; &gt; +}<br>
&gt;<br>
&gt; You must delay the set_cc_op() until the end too, for the same reason.=
=C2=A0 The function call<br>
&gt; will emit discard opcodes, which will kill cc_foo while still live via=
 the memory exception.<br>
<br>
Right, that can affect previous instructions due to dead code elimination.<=
br>
I even wrote part of that code. :)<br>
<br>
Since I have to add decode-&gt;cc_op, I&#39;ll add CC_OP_DYNAMIC handling a=
s well, and<br>
assert that everything is NULL if the gen_* function didn&#39;t touch decod=
e-&gt;cc_op.<br>
<br>
Thanks!<br>
<br>
Paolo<br>
<br>
&gt;<br>
&gt;<br>
&gt; r~<br>
&gt;<br></div>

--0000000000002bcb290607c26d06--


