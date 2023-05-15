Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D8703463
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybLm-0002i4-9n; Mon, 15 May 2023 12:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybLf-0002fR-E6
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:47:00 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybLX-0002be-R2
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:46:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-965e93f915aso2317035766b.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1684169194; x=1686761194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCiITeThY5qOdBNaqTlvfU/HtErmHpIdqcIDur8UAME=;
 b=UTFO3P893kQRFkOxnvRJwxzX1Tw8ncF84joGIE5ReOTd6/zTnIL5zxWM1gYRkUy1tB
 ecVfDwRtPv1LcLRJqYlZGMtzDn9boPXShspjfLme/ATOfLQX0wcKPx7/T4imuic0dFvu
 SfEt2nwqt1JOw9YgJQLTPbIv+35FbZzLboiGaIIMEXGhO0OK/G1gDrlHr+e7J0VHBNZI
 BTvQgTRqbIGLWP58EKxWIufYCUj8tLLkliu35hSW4xUMs5bVYvv4ehghZzxF3BLgtAtq
 VmwYU/vdOCll2W9C1oRYsY5BOk2fO6u5EanqfjkIIMPS/kr4pJZbnlXL35Tfd6nN1wB/
 cWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169194; x=1686761194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCiITeThY5qOdBNaqTlvfU/HtErmHpIdqcIDur8UAME=;
 b=cE90Byln5RvJStMn+IPpGid0WrMfuw6H1FMBviZDo9H2i/ZOkLlbXH7IEBo0VibKnO
 ybVlSYRgYpodZVsn6wl3BwvAb2cFGvnBzkYuFPBzIcnBjalNPsoiuYTJ50ifgGgyOvLE
 8H1RoZ23cxY6u5J3AhAEGkrTeTL3lfILzc8AedgKaOYch9VuZ+CZnv3qtkWDnXqSPRt2
 LEq2bMqkqRXPiUpSaQsG+7mVKC+eQAErj0PECnGncLfkIkrHw+ikB5emlC/asL2AVFRk
 3uJEYiFm/z4uB0RxwgUHjEh3157SVbTG95HCpwV0+IDc8wCsEkgwZTqZBqUVOVAsGrdQ
 Rdbg==
X-Gm-Message-State: AC+VfDzOFyv9dl5rzcveXXx9lIVLPG43NkSgWx+A/sCB0VhwsO+RdLuk
 MyNZWdb1jcXNY5AJDt+SE9Vl82KaWh2IE4q2vZNj+A==
X-Google-Smtp-Source: ACHHUZ7cbmw40aQHFH7SqLduPrE6TV3CmSdFOO7646ng6073xiCQQpAQL4C99FQrbMmBtLN75X9d3c9RI4yTrM9xKMY=
X-Received: by 2002:a17:907:3f28:b0:889:5686:486a with SMTP id
 hq40-20020a1709073f2800b008895686486amr33845102ejc.30.1684169193933; Mon, 15
 May 2023 09:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230510143925.4094-1-quintela@redhat.com>
 <20230510143925.4094-2-quintela@redhat.com>
 <CANCZdfp0p6+o5E2CpqC+6BWdzeW4u2019UfHf+RmfQyV-O2mvw@mail.gmail.com>
In-Reply-To: <CANCZdfp0p6+o5E2CpqC+6BWdzeW4u2019UfHf+RmfQyV-O2mvw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 15 May 2023 10:46:22 -0600
Message-ID: <CANCZdfpuobM1+v7XWrk1eMBpYKWaRiu_OxOQ2fZwSVnOVSFvRw@mail.gmail.com>
Subject: Re: [RFC 1/3] ARM: Use normal types
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008be18c05fbbe3262"
Received-SPF: none client-ip=2a00:1450:4864:20::633;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--0000000000008be18c05fbbe3262
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 10:44=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote=
:

>
>
> On Wed, May 10, 2023 at 8:39=E2=80=AFAM Juan Quintela <quintela@redhat.co=
m> wrote:
>
>> Someone has a good reason why this is not a good idea?
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>
> Reviewed by:  Warner Losh <imp@bsdimp.com>
>
> This has been that way the bsd-user sources were reorganized in 2015. I
> can find
> no good reason in the FreeBSD sources to do this (we've been transitionin=
g
> from
> the pre-standardized BSD convention of u_intXX_t -> uintXX_t for 25 years
> now
> it seems). I don't see any old or ancient usage as far back as I looked
> why they'd
> be different. Up through FreeBSD 12.x, this was u_int32_t (for all of
> them), but
> they switched to __uint32_t in FreeBSD 13 to avoid namespace pollution.
>
> tl;dr: change good, all should match.
>

Though a better commit message would be good. With that, I'll queue it to
my branch.

Warner


> ---
>>  bsd-user/arm/target_arch_reg.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bsd-user/arm/target_arch_reg.h
>> b/bsd-user/arm/target_arch_reg.h
>> index 070fa24da1..5f1eea4291 100644
>> --- a/bsd-user/arm/target_arch_reg.h
>> +++ b/bsd-user/arm/target_arch_reg.h
>> @@ -32,7 +32,7 @@ typedef struct target_reg {
>>  typedef struct target_fp_reg {
>>      uint32_t        fp_exponent;
>>      uint32_t        fp_mantissa_hi;
>> -    u_int32_t       fp_mantissa_lo;
>> +    uint32_t       fp_mantissa_lo;
>>  } target_fp_reg_t;
>>
>>  typedef struct target_fpreg {
>> --
>> 2.40.1
>>
>>

--0000000000008be18c05fbbe3262
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 15, 2023 at 10:44=E2=80=
=AFAM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 8:39=E2=80=AFAM Ju=
an Quintela &lt;<a href=3D"mailto:quintela@redhat.com" target=3D"_blank">qu=
intela@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Someone has a good reason why this is not a good idea?<br>
<br>
Signed-off-by: Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com" tar=
get=3D"_blank">quintela@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed by:=C2=A0 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" ta=
rget=3D"_blank">imp@bsdimp.com</a>&gt;</div><div><br></div><div>This has be=
en that way the bsd-user sources were reorganized in 2015. I can find</div>=
<div>no good reason in the FreeBSD sources to do this (we&#39;ve been trans=
itioning from</div><div>the pre-standardized BSD convention of u_intXX_t -&=
gt; uintXX_t for 25 years now</div><div>it seems). I don&#39;t see any old =
or ancient usage as far back as I looked why they&#39;d</div><div>be differ=
ent. Up through FreeBSD 12.x, this was u_int32_t (for all of them), but</di=
v><div>they switched to __uint32_t in FreeBSD 13 to avoid namespace polluti=
on.</div><div><br></div><div>tl;dr: change good, all should match.</div></d=
iv></div></blockquote><div><br></div><div>Though a better commit message wo=
uld be good. With that, I&#39;ll queue it to my branch.</div><div><br></div=
><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/arm/target_arch_reg.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch_reg.=
h<br>
index 070fa24da1..5f1eea4291 100644<br>
--- a/bsd-user/arm/target_arch_reg.h<br>
+++ b/bsd-user/arm/target_arch_reg.h<br>
@@ -32,7 +32,7 @@ typedef struct target_reg {<br>
=C2=A0typedef struct target_fp_reg {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_exponent;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp_mantissa_hi;<br>
-=C2=A0 =C2=A0 u_int32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0fp_mantissa_lo;<br>
+=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0fp_mantissa_lo;<br>
=C2=A0} target_fp_reg_t;<br>
<br>
=C2=A0typedef struct target_fpreg {<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000008be18c05fbbe3262--

