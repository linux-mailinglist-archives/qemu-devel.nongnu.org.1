Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58511789CC2
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 11:42:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaCGA-00079S-HX; Sun, 27 Aug 2023 05:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCG7-00079C-2F
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:40:39 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaCG4-0000P6-R8
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 05:40:38 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bd0d135ca3so1866621fa.3
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693129234; x=1693734034;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO78ciDbmXUMxUm3P6rNfvJ03p0YLxRWnMpWPZooRt0=;
 b=dHFPmdkEf+3PIcHzIaY9h3AcbZaJYgok7n5w3SckNlvTY1X6UJNN8hotu5IP69qMyd
 JdhX+UrLTdhOJpPCbL+pDLtaNp5+u0g4KjB/oBVDgBKbHCdDqUesE0cauESWsO1S4J0h
 MEHxnDExf51U02FHDoYWf9NkLp699jjvFp4gWHh/LDuesPvcnQaJ8Hl8sZVT4lL1TNS9
 cfTmLf/z9B1HB+1KLPW2q3S9Z4OXgTvO6RBW6lvwwbGZYFp1x+aRjLIs+szhlSblHURi
 5gM/GZI3+lRw7nhbPdQJI6mm5JcXwOSolMwCE5GdLqhZGUfEg6EvDv97oStdqAIjwoh9
 WZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693129234; x=1693734034;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eO78ciDbmXUMxUm3P6rNfvJ03p0YLxRWnMpWPZooRt0=;
 b=c1Oy9Lvq0kOHg628zFuTsL9+38XAQRdcsfJwOPJrIOdPL433aITrqJh4UBpjipJ2rm
 LMs4YzAke704kJQYiP/oT6Gi54q+DpdQNFkLaie4wUEg7nB8oWE6vVGODUHdUUvhWnK6
 J3ehdv+f+p9wvEHmCxXt8iHapmViPx23TdmFivpgfC6ecWHqhRt3dr9QnCBJJeTFHXvI
 Betje5SeAvUDbxVxYv8JF472LXCFv3WEsEDeQ1FwbJtP/vq2wIPCr89uMQMTg7H3TQwG
 ivWZ9b01PZMQo813wpjQouC40c8eSRUGg8xeNf/+UBlGHw21RwMVhO3lmYAACJDTBgaK
 Y1Xw==
X-Gm-Message-State: AOJu0YyuSwTEl0ySapEMTG3H2UivIld5dRKE9bnIwAl8z0W8XkQm83ey
 NYoUgJt4d7eRLJgrkBQbSXe3Sg==
X-Google-Smtp-Source: AGHT+IEHInMdlQcKQsaDNro10VoWW8TohVP2XiUqk72Ty+nqymYoRBbWLF7aaJXKu/utBmmIMdKnLA==
X-Received: by 2002:a2e:9812:0:b0:2ba:cbb:47b7 with SMTP id
 a18-20020a2e9812000000b002ba0cbb47b7mr17470749ljj.21.1693129234251; 
 Sun, 27 Aug 2023 02:40:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003fee8502999sm10420483wmc.18.2023.08.27.02.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 02:40:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2658E1FFBB;
 Sun, 27 Aug 2023 10:40:33 +0100 (BST)
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.15; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/3] softmmu: Assert data in bounds in iotlb_to_section
Date: Sun, 27 Aug 2023 10:39:23 +0100
In-reply-to: <20230826232415.80233-2-richard.henderson@linaro.org>
Message-ID: <871qfo6cxb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  softmmu/physmem.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..7597dc1c39 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *cp=
u,
>      int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
>      CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
>      AddressSpaceDispatch *d =3D qatomic_rcu_read(&cpuas->memory_dispatch=
);
> -    MemoryRegionSection *sections =3D d->map.sections;
> +    int section_index =3D index & ~TARGET_PAGE_MASK;
> +    MemoryRegionSection *ret;

It might be worth a quick comment where section_index comes from because
I was confused initially expecting it to be address like.

>=20=20
> -    return &sections[index & ~TARGET_PAGE_MASK];
> +    assert(section_index < d->map.sections_nb);
> +    ret =3D d->map.sections + section_index;
> +    assert(ret->mr);
> +    assert(ret->mr->ops);
> +
> +    return ret;
>  }
>=20=20
>  static void io_mem_init(void)

Otherwise:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

