Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F25796F24
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:03:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5HS-0001a8-0x; Wed, 06 Sep 2023 23:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe5HH-0001Tp-Ez; Wed, 06 Sep 2023 23:01:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe5HB-0006OQ-NA; Wed, 06 Sep 2023 23:01:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68bec3a9bdbso405017b3a.3; 
 Wed, 06 Sep 2023 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694055708; x=1694660508; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGS5PBTnJcJ4FQkQm30+H85OPQIdTQ1zl6oh4vfLmr0=;
 b=JLorEoL8hZInR2rLhOxZYZvG6XrCD9E5HLBMo18PhbXm7SaNKTBVe83G7gHsrsK6Mr
 bw70eQquGktp3R6Tk9A2wcpHycv1Rs0rbb6HyIlDJec47pxlv0LJQZgOPrZQwWgVjNw1
 t5fB3W5L5IXKS75oJFaWSPpvPE0iIl+x3tKSYh/GwRARz9JXUtUesdIQu/gTnjY5CiKs
 BxoPY/95Nss2KbGFNGrpgcyI91dnQjsQfvHrrH/65wdB3ZSZ/mxxkIAaRA+LQePatWcY
 0VeXRPRCkAwLqV2YB3eo3ueWMIsm06w/NN2dw/3XUgh9yro6ddqHGEYBT8Adppk19JXo
 6OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694055708; x=1694660508;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iGS5PBTnJcJ4FQkQm30+H85OPQIdTQ1zl6oh4vfLmr0=;
 b=KvV4hXpU+YWsX+dneUbL0oEyGbRQ7apDWlBgsgSeJex/cztQVB7L+Cnh9VIiY9hksg
 uRE5OoP2n7JHhdA1hVTetifC0TMiJ1Cgc/E78gHOKAw+7dCrFLcPg1/VfGgQ6K0xoD3Q
 T90WiWrxM3drR6R2UwDZq7Fs9BlktG54/XJC/0LGFERPTsHHgPosqtnGlHTfhRaLNHMI
 PDS9CUrgRawgOFQ7ieBdb8N2xnLUBvqFdl01VvoeaLOTmfRZSCJFpE9tka+plaT3VdQF
 xw5cSkfrLWmm9EINmgghFnTZj6CnxqqUeFGWVAKZQwQF6Li+SyqqS2ppZL8jxPRDK8m9
 Hyxw==
X-Gm-Message-State: AOJu0YxgkbZuLt/Pu1I66E18pWz5P4+PTNoj5YzTiQNtBQMRXcl5pYiG
 Az+9LgyO36GyDQr32e+1z8A=
X-Google-Smtp-Source: AGHT+IEwpLduc6L3kcEBEv83Lp1v4yV635Drn0Mnlr4cLTp9vVg+V97kkDjdgy68EK5fg+wU/qOoGg==
X-Received: by 2002:a62:f24c:0:b0:68e:30db:ee43 with SMTP id
 y12-20020a62f24c000000b0068e30dbee43mr3204670pfl.21.1694055707676; 
 Wed, 06 Sep 2023 20:01:47 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 25-20020aa79119000000b0062cf75a9e6bsm11369825pfh.131.2023.09.06.20.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 20:01:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 13:01:41 +1000
Message-Id: <CVCCMLRLPB9H.3T7JJ2S044E0I@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 10/15] ppc: spapr: Initialize the GSB Elements
 lookup table.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-11-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-11-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Might be good to add a common nested: prefix to all patches actually.

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> This is a first step towards enabling support for nested PAPR hcalls for
> providing the get/set of various Guest State Buffer (GSB) elements via
> h_guest_[g|s]et_state hcalls. This enables for identifying correct
> callbacks for get/set for each of the elements supported via
> h_guest_[g|s]et_state hcalls, support for which is added in next patch.

Changelog could use work.

>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  hw/ppc/spapr_hcall.c          |   1 +
>  hw/ppc/spapr_nested.c         | 487 ++++++++++++++++++++++++++++++++++
>  include/hw/ppc/ppc.h          |   2 +
>  include/hw/ppc/spapr_nested.h | 102 +++++++
>  4 files changed, 592 insertions(+)
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 9b1f225d4a..ca609cb5a4 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1580,6 +1580,7 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> =20
>      spapr_register_nested();
> +    init_nested();

This is for hcall registration, not general subsystem init I think.
Arguably not sure if it matters, it just looks odd for everything
else to be an hcall except this. I would just add a new init
function.

And actually now I look closer at this, I would not do your papr
hcall init in the cap apply function, if it is possible to do
inside spapr_register_nested(), then that function could look at
which caps are enabled and register the appropriate hcalls. Then
no change to move this into cap code.

>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index e7956685af..6fbb1bcb02 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c

[snip]

My eyes are going square, I'll review this later.

> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index e095c002dc..d7acc28d17 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -33,6 +33,8 @@ struct ppc_tb_t {
>      QEMUTimer *decr_timer;
>      /* Hypervisor decrementer management */
>      uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
> +    /* TB that HDEC should fire and return ctrl back to the Host partiti=
on */
> +    uint64_t hdecr_expiry_tb;

Why is this here?

>      QEMUTimer *hdecr_timer;
>      int64_t purr_offset;
>      void *opaque;
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.=
h
> index 2e8c6ba1ca..3c0d6a486e 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h

[snip]

> =20
> +struct guest_state_element_type {
> +    uint16_t id;
> +    int size;
> +#define GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE 0x1
> +#define GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY  0x2
> +   uint16_t flags;
> +    void *(*location)(SpaprMachineStateNestedGuest *, target_ulong);
> +    size_t offset;
> +    void (*copy)(void *, void *, bool);
> +    uint64_t mask;
> +};

I have to wonder whether this is the best way to go. Having
these indicrect function calls and array of "ops" like this
might be limiting the compiler. I wonder if it should just
be done in a switch table, which is how most interpreters
I've seen (which admittedly is not many) seem to do it.

Thanks,
Nick


