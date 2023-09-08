Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE1798729
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaiu-0003Zu-KB; Fri, 08 Sep 2023 08:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeais-0003Xt-GM
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:36:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaip-0002VM-S1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:36:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1827413f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694176586; x=1694781386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYf6mBkdML4msyU5d74DdDm3ybRNBr58noFQPx8fVrw=;
 b=bg0OmANunKaYNRLO9YhqMLHLL5VOUPAiTX5b+QcueNqur8g7G+uV6nfSoytwpJLIMn
 5M0Pkinp8zBcuKBLq1KPSdVeVqFd9yhcBHtHIKSDCTjtkynkJ6/f2aO6UGt6BM59fhXw
 JnMncxWW+eTQY+yipRw3NWiUjgnCTkoPwnE9sLhb8RlTC6GxEukPKv+qkapCttdIIb8L
 y+eNdwTvw4iVSXacuUcfgmia4dWo8U3JnrJNO5YzM5UcqJX6i9V67m2UYKsI6R3g/JD8
 3rAOVCBGXqRsO8i1VSKdsRtaYIVG9feYKJH/CBeDyQWGB1pP1HTJ9DBUjaGB/ZJ+7cBb
 cTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694176586; x=1694781386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYf6mBkdML4msyU5d74DdDm3ybRNBr58noFQPx8fVrw=;
 b=rhkBatkd2avbG9DymKxF1Rs5k/BzCSkF7kIn9ylbcNRUEqXyCzEOYAJq6BRYj0cOCV
 H/wFPcj/elzmf1frGG/V6yr2WOuugoBftw9a+T7fDwleKR82pKa74Nvh6zI2/3zgD4PF
 orgTmRhyfRmH2PBMFUd2r9MmzJFAhZOaBz3g+MykMcxedOoJBQ5CsT2fqDmCf1+ZzNxG
 StPFb1PUCCzY2qBe6AqVJGtV41HO79Af7D3cZMdwCx5wTWOZsNCkrxDhkFtju9FoDpAF
 yAEvD5PQ0Pl45p6KOW7EYQuBc51q9WTWpcBqPfuwGXHr1kRueM2SJxynN+FM7bKzbYu4
 pqjQ==
X-Gm-Message-State: AOJu0YzFxMeoV8i6/NhxWjYpCgWNMTw226KnQMtF4RbewEYmoBuVLH6X
 YtnmTu+sKWWD/gulngU+lhY7bxU84VcyHanbMe6PSQ==
X-Google-Smtp-Source: AGHT+IFcNmx2eIKfHhmHXyyDzlJCfhDlTsOHTKpPPY+4296MDZAFMNQQe260Bu7BLeJpiONHAnjSf5WrouwTr6XOWV4=
X-Received: by 2002:adf:a3ca:0:b0:31f:84cd:90c5 with SMTP id
 m10-20020adfa3ca000000b0031f84cd90c5mr270056wrb.10.1694176586206; Fri, 08 Sep
 2023 05:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-19-philmd@linaro.org>
In-Reply-To: <20230904161235.84651-19-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:36:15 +0100
Message-ID: <CAFEAcA-rV+VtS=2nVPDuh=bhdoy3LKdzfXOtX_2Shb58i3fS6g@mail.gmail.com>
Subject: Re: [PATCH v2 18/22] semihosting/arm-compat: Clean up local variable
 shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 4 Sept 2023 at 17:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   semihosting/arm-compat-semi.c: In function =E2=80=98do_common_semihosti=
ng=E2=80=99:
>   semihosting/arm-compat-semi.c:379:13: warning: declaration of =E2=80=98=
ret=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
>     379 |         int ret, err =3D 0;
>         |             ^~~
>   semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is her=
e
>     370 |     uint32_t ret;
>         |              ^~~
>   semihosting/arm-compat-semi.c:682:27: warning: declaration of =E2=80=98=
ret=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
>     682 |                 abi_ulong ret;
>         |                           ^~~
>   semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
>     370 |     int ret;
>         |         ^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  semihosting/arm-compat-semi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

If I'm reading the code correctly, the top level 'ret' variable
is only used by the SYS_EXIT case currently. So rather than
changing the type of it I think it would be better to remove
it and have a variable at tighter scope for SYS_EXIT. I
think that's easier to read than this kind of "single variable
used for multiple purposes at different places within a
long function".

> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.=
c
> index 564fe17f75..85852a15b8 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -367,7 +367,7 @@ void do_common_semihosting(CPUState *cs)
>      target_ulong ul_ret;
>      char * s;
>      int nr;
> -    uint32_t ret;
> +    int ret;
>      int64_t elapsed;
>
>      nr =3D common_semi_arg(cs, 0) & 0xffffffffU;
> @@ -376,7 +376,7 @@ void do_common_semihosting(CPUState *cs)
>      switch (nr) {
>      case TARGET_SYS_OPEN:
>      {
> -        int ret, err =3D 0;
> +        int err =3D 0;
>          int hostfd;
>
>          GET_ARG(0);
> @@ -679,14 +679,11 @@ void do_common_semihosting(CPUState *cs)
>               * allocate it using sbrk.
>               */
>              if (!ts->heap_limit) {
> -                abi_ulong ret;
> -
>                  ts->heap_base =3D do_brk(0);
>                  limit =3D ts->heap_base + COMMON_SEMI_HEAP_SIZE;
>                  /* Try a big heap, and reduce the size if that fails.  *=
/
>                  for (;;) {
> -                    ret =3D do_brk(limit);
> -                    if (ret >=3D limit) {
> +                    if (do_brk(limit) >=3D limit) {
>                          break;
>                      }
>                      limit =3D (ts->heap_base >> 1) + (limit >> 1);
> -

thanks
-- PMM

