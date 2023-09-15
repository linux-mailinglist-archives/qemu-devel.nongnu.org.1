Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839E7A12DF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 03:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgxWD-0005sK-La; Thu, 14 Sep 2023 21:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxW6-0005s2-QS; Thu, 14 Sep 2023 21:21:07 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgxW0-0000ow-DV; Thu, 14 Sep 2023 21:21:06 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5731fe1d2bfso915357eaf.3; 
 Thu, 14 Sep 2023 18:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694740858; x=1695345658; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDJOEB59coJCMpMAiDGT07EGBmulG2Bnl8XuBpKvcvc=;
 b=JGcXOY14EgNx/lrR51ynLR6hzZE+mI8CA5KY6Xa2knaimRula+Gd9jEA9q0NwrW6LM
 etNlF8OLP6+i8T1YKCaSn0uhrPTFvz7SK/gO9piDhM60ZarBbAs3D0UVcDJEZllogUiZ
 qnnvwuDOInnVxq2RKKvHWsauinAe2N+DtPQMpx9QhR1C3mLu8Lcb2I18lo2LdE7Yztyh
 kYLvPBmdlxMp8fOL62M8LidlogrHfNm/85ah+VwHppFgIYiNrhLHtP2WyzeypSdLu97y
 nCoAYJsycuVIo6c344AvTk2BcGrT2sIZD0ej/yds0yrVrAOXLA92UQz3EiY2R+gYkt3M
 HRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694740858; x=1695345658;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gDJOEB59coJCMpMAiDGT07EGBmulG2Bnl8XuBpKvcvc=;
 b=hZjC3xLSEY1SVLXY/y46aq7SoVr62XdqdqM5LfKtWErQC6PcoNf4KJEd/YHKwaLYqj
 8Vi0BQ8xN99AV84Gc6/Wtn2HAiTVONqTV40wtcVAt6+7ETWu6wsrTBPNUpw2XuFGDvTR
 kWybu+tz5MNYrdi7CGB665eUfhqjqdOPjPR6usGwxBbk7L9XBhNk+w4VtFoaQobVbEPo
 MHbz0uHqNfL7aQ+9iVAZs3nHxevxcDVi1YquXP6gFfpqeXoEYjnVhab0zgbYygNtRqjd
 uVci0oXVDjUf4m9w0vLqgRvpwoyTXrZPdGWkkiazyXVKVUrzTWc8sKKa8T791OxT45zg
 CQ3g==
X-Gm-Message-State: AOJu0YwDrnd2I1cOamFtiLf/pBVAX9eXMYm45zrpoe3AkAcr/0rFhhoX
 xLd9FZ8AIuqWNLzJ7tLTW5k=
X-Google-Smtp-Source: AGHT+IHgrGStFajlnrjBxzum6yLl78krdWhGODg5hzUXsOXBMArcH3huOJEW6sGLRMxPyy8obnhNuQ==
X-Received: by 2002:a05:6358:52d4:b0:13c:dd43:f741 with SMTP id
 z20-20020a05635852d400b0013cdd43f741mr490882rwz.24.1694740858565; 
 Thu, 14 Sep 2023 18:20:58 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 x4-20020a656aa4000000b0056428865aadsm1511350pgu.82.2023.09.14.18.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 18:20:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Sep 2023 11:20:52 +1000
Message-Id: <CVJ3HRR2EADR.15F9G78LN7PKL@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 4/4] target/ppc: Add migration support for BHRB
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202514.3382619-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230912202514.3382619-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed Sep 13, 2023 at 6:25 AM AEST, Glenn Miles wrote:
> Adds migration support for Branch History Rolling
> Buffer (BHRB) internal state.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  target/ppc/machine.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index b195fb4dc8..89146969c8 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -314,6 +314,7 @@ static int cpu_post_load(void *opaque, int version_id=
)
> =20
>      if (tcg_enabled()) {
>          pmu_mmcr01a_updated(env);
> +        hreg_bhrb_filter_update(env);
>      }
> =20
>      return 0;
> @@ -670,6 +671,27 @@ static const VMStateDescription vmstate_compat =3D {
>      }
>  };
> =20
> +#ifdef TARGET_PPC64
> +static bool bhrb_needed(void *opaque)
> +{
> +    PowerPCCPU *cpu =3D opaque;
> +    return (cpu->env.flags & POWERPC_FLAG_BHRB) !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_bhrb =3D {
> +    .name =3D "cpu/bhrb",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D bhrb_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINTTL(env.bhrb_num_entries, PowerPCCPU),

Maybe don't need bhrb_num_entries since target machine should have the
same?

> +        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES)=
,

Is it possible to migrate only bhrb_num_entries items? Wants a VARRAY
AFAIKS but there is no VARRAY_UINT64?

Since all sizes are the same 32 now, would it be possible to turn it
into a VARRAY sometime later if supposing a new CPU changed to a
different size, and would the wire format for the VARRAY still be
compatible with this fixed size array, or does a VARRAY look different
I wonder?

Thanks,
Nick

