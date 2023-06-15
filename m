Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402F730D5A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 04:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9d5D-00037u-6v; Wed, 14 Jun 2023 22:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9d57-00037I-Pf; Wed, 14 Jun 2023 22:51:29 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9d56-00034w-A9; Wed, 14 Jun 2023 22:51:29 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-762092e1fb7so124326085a.1; 
 Wed, 14 Jun 2023 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686797483; x=1689389483;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=483N0eGSwd7mtHeI6tPr01SaCebSA8BFPvAXSW6CXyM=;
 b=G73pn8T7iEHxIGaP4+eO+Qe2UG1pOMpz6Qbq2Dsh2j410s2Mv6CE4QG4l/uksIsV3W
 56ari/Effeq4sOgvINiJr4nhLBOV/A0QC1tscwRLjQS7a47m/+HzHl5nUaB3KSEXX2u9
 dm/HVnGQcQSaTGi/5ArWUXC/NqE5bYHU9uz+1xZkvuXrWkretIc+GzdSlG8Oew53YIAU
 a/M/FDZX7OEq7ocxiZRbhOFNLKj581rLEIKIW3Eq0SNw4ha6StR+2ZIOTeRMNClstBmo
 eCAfB8das/KjLTC+l2j7M07St+dFQfvHnpetXtGCFnhJb/v/J2aaIVIa3ezd7Y1zMlfD
 iwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686797483; x=1689389483;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=483N0eGSwd7mtHeI6tPr01SaCebSA8BFPvAXSW6CXyM=;
 b=GisxYmWz2PGQMcZLjmfYYVQGv1uMcCl/eMsJka4QeoVPBzaBRJ+efre04qsOXHmU/m
 1TiqYxXL+RyMIjfhSa1ZhAYQ2BTfTuwT7AYJm3VX0Iw/xHN1tVzQem7HF2gBNHVcRCcL
 zOw1I9pL744Kvdpr+TdC2yLYyTQN8CwFwFzQ3pmA8BCLWWX+jt2X5f3zrtB2yJwO9aXF
 UenW8V9/R7NOFSnDyWHnggO336yBzNtA34gnYBNTyj2fd1ZoYI3WbZbhkIDI5Gvn6y5+
 eby9YqsB2dkSjXGSc+F7nT4TjL9Yxr/BrKV8uUcqDsgijUlK15N+HYlbDpfzxkRwP43k
 Llow==
X-Gm-Message-State: AC+VfDwnY46mwULKFOnmhaxbRpoBG7duASt1kFNbtALUKQTEycGmM+rg
 cQK1CH4+vFNEYUS7ZCvOByA=
X-Google-Smtp-Source: ACHHUZ7JWjeru8XpuHTaMtF7xH0oqkjTWkux7qbeL4pPquo1NasVO+xdz4JiHA3ddGOYF+CaWQfRBg==
X-Received: by 2002:a37:64d7:0:b0:760:7209:55e7 with SMTP id
 y206-20020a3764d7000000b00760720955e7mr12342309qkb.27.1686797482809; 
 Wed, 14 Jun 2023 19:51:22 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a631111000000b0054ff36967f7sm376546pgl.54.2023.06.14.19.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 19:51:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 12:51:17 +1000
Message-Id: <CTCVSVIX21N6.3V2JEPOBPPX3Q@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 1/6] target/ppc: Fix instruction loading endianness
 in alignment interrupt
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Anushree Mathur" <anushree.mathur@linux.vnet.ibm.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230530132543.385138-2-npiggin@gmail.com>
 <0bbbffa7-d66c-66f2-f660-321e4f8aa026@linux.vnet.ibm.com>
In-Reply-To: <0bbbffa7-d66c-66f2-f660-321e4f8aa026@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=npiggin@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed Jun 14, 2023 at 3:51 PM AEST, Anushree Mathur wrote:
>
> On 5/30/23 18:55, Nicholas Piggin wrote:
> > powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> > after cpu_ldl_code(). This corrects DSISR bits in alignment
> > interrupts when running in little endian mode.
> >
> > Reviewed-by: Fabiano Rosas<farosas@suse.de>
> > Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> > ---
> >   target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index c13f2afa04..0274617b4a 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
> >                     env->nip);
> >   }
> >  =20
> > +#ifdef CONFIG_TCG
> > +/* Return true iff byteswap is needed in a scalar memop */
> > +static inline bool need_byteswap(CPUArchState *env)
> > +{
> > +    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is =
set */
> > +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> > +}
> > +
> > +static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
>
> This hunk fails to compile with configure --disable-tcg

I don't see how since it's inside CONFIG_TCG. Seems to work here.
You don't have an old version of the patch applied?

What configure options exactly?

Thanks,
Nick

