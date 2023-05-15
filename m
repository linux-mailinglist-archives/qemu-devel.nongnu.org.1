Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F46703420
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybJe-0001Cy-3c; Mon, 15 May 2023 12:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybJc-0001Bt-81
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:44:52 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1pybJZ-00020b-90
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:44:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-96aae59bbd6so736021366b.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1684169087; x=1686761087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m6jivdEPIgJj/t98nvgqG/KAAhAmoF6cw6AkU/c7JEs=;
 b=LmfHgUBhKrt9s0rWLIT2V049VrzcdqUwYwa/9l8R+ko9VFhy3KWPqrFViSfcmO3Un/
 dFlYPvOpScbNndu26aho+bbcLUkvT3XASpiCzrc28xccyeRPy6XENwZoU5bKOmeOkOcm
 kHgtXIFtlvSqi+cGFNxIF7lAxMcafGMm74IhswwBl0k3qxiztUwqVRB78aPIg3olIOrP
 Z2BG4NEqx7D+1XarZQn4C0ZrLxgshneFgorKMnXkBZd6dt/gMmMhRnLW+I4gbiU9O0R4
 Tn9yeDGKXNDRtYpDM0kpuLnyO4eZEV6/0Qm9G+rZ6fJGfooouqzUo74E3BGQRM2aDcS/
 QpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169087; x=1686761087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6jivdEPIgJj/t98nvgqG/KAAhAmoF6cw6AkU/c7JEs=;
 b=EIK8XFIGkb3sbywqZUzSNQCfUF2oRYnZWxXBRXcDMwtre5SoK9ZHpX0+fNSb/C3nNG
 E2JSqnMCzX4tAiCKXaiP1KoIlU7XINTAnUgfBlvYu+nCMAmKCnq6eRv41w2Oee+nvDXZ
 OK51EcTvjaIlpeTYoE+JEhhQsBRG04ss6sxRIa0Y7m18UfUU2eW1nkI8ZRQAeyD88xJ+
 VhGTSmV+uLO9g77IX9Zdo7AxbsBGyVV8yQWq/BAMHaz6JzqYrH0jVaaYqTn8ae1zQlC7
 Nr7/NQEHHYDz/gZay32+Kr+jtoreb3yg7s1dQbSGtfUn26j0JfF8+k0pRQfMdJ8OfkMt
 BG4g==
X-Gm-Message-State: AC+VfDystcOt1kVJ6WkVpH8LUgGrDYowt1Ijfa9ZmPParuRsWoFgIlKN
 en3bQnB14ipTLaaHp3PWb5u0zWQMMg+L5OaBBbwLQA==
X-Google-Smtp-Source: ACHHUZ67n6gj54JzCSSDaoxgo0HRi93Av65XBYy0FGHw6GnV9j8t1M+u+Q8o9qGI20j0RU57I0ztrt1jikwzZzjYS6c=
X-Received: by 2002:a17:906:730e:b0:96a:f09b:373e with SMTP id
 di14-20020a170906730e00b0096af09b373emr6973442ejc.15.1684169087538; Mon, 15
 May 2023 09:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230510143925.4094-1-quintela@redhat.com>
 <20230510143925.4094-2-quintela@redhat.com>
In-Reply-To: <20230510143925.4094-2-quintela@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 15 May 2023 10:44:36 -0600
Message-ID: <CANCZdfp0p6+o5E2CpqC+6BWdzeW4u2019UfHf+RmfQyV-O2mvw@mail.gmail.com>
Subject: Re: [RFC 1/3] ARM: Use normal types
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000346c5105fbbe2cb4"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--000000000000346c5105fbbe2cb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 8:39=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:

> Someone has a good reason why this is not a good idea?
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>

Reviewed by:  Warner Losh <imp@bsdimp.com>

This has been that way the bsd-user sources were reorganized in 2015. I can
find
no good reason in the FreeBSD sources to do this (we've been transitioning
from
the pre-standardized BSD convention of u_intXX_t -> uintXX_t for 25 years
now
it seems). I don't see any old or ancient usage as far back as I looked why
they'd
be different. Up through FreeBSD 12.x, this was u_int32_t (for all of
them), but
they switched to __uint32_t in FreeBSD 13 to avoid namespace pollution.

tl;dr: change good, all should match.


> ---
>  bsd-user/arm/target_arch_reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bsd-user/arm/target_arch_reg.h
> b/bsd-user/arm/target_arch_reg.h
> index 070fa24da1..5f1eea4291 100644
> --- a/bsd-user/arm/target_arch_reg.h
> +++ b/bsd-user/arm/target_arch_reg.h
> @@ -32,7 +32,7 @@ typedef struct target_reg {
>  typedef struct target_fp_reg {
>      uint32_t        fp_exponent;
>      uint32_t        fp_mantissa_hi;
> -    u_int32_t       fp_mantissa_lo;
> +    uint32_t       fp_mantissa_lo;
>  } target_fp_reg_t;
>
>  typedef struct target_fpreg {
> --
> 2.40.1
>
>

--000000000000346c5105fbbe2cb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 8:39=E2=80=AF=
AM Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com">quintela@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Someone has a good reason why this is not a good idea?<br>
<br>
Signed-off-by: Juan Quintela &lt;<a href=3D"mailto:quintela@redhat.com" tar=
get=3D"_blank">quintela@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed by:=C2=A0 Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">im=
p@bsdimp.com</a>&gt;</div><div><br></div><div>This has been that way the bs=
d-user sources were reorganized in 2015. I can find</div><div>no good reaso=
n in the FreeBSD sources to do this (we&#39;ve been transitioning from</div=
><div>the pre-standardized BSD convention of u_intXX_t -&gt; uintXX_t for 2=
5 years now</div><div>it seems). I don&#39;t see any old or ancient usage a=
s far back as I looked why they&#39;d</div><div>be different. Up through Fr=
eeBSD 12.x, this was u_int32_t (for all of them), but</div><div>they switch=
ed to __uint32_t in FreeBSD 13 to avoid namespace pollution.</div><div><br>=
</div><div>tl;dr: change good, all should match.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
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

--000000000000346c5105fbbe2cb4--

