Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55597722374
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67T3-0000Ev-5Z; Mon, 05 Jun 2023 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q67Sp-0000Av-3u; Mon, 05 Jun 2023 06:29:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q67Sn-00050l-CB; Mon, 05 Jun 2023 06:29:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b038064d97so43021025ad.0; 
 Mon, 05 Jun 2023 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685960963; x=1688552963;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fznKQ6DvinOnKzhIaVnN2mewHYIIvPlSLlKY6/cYSrc=;
 b=mYZE7eGplHQET3HeME3g+fq1AXR/2XcjyRqoVf512oIoznlJjWOr1eRv7n+bjqeCZT
 9xO8eOxGYrDbQW99D8oR9qzXfT7w2yRiC9fUZgeyDE5gnMJeUGlyxgSpBgNqanwoSy3U
 AVGVRUTr75jrdhXMEmKTcEquWWbUPoYIPXvQ+Yz3QfjGvzm8Pwb/1v0lpI0OJi8yyPUv
 478DCtfXFcHks1M7h7u3IOv9rra/FRZtHhMjfQ9RSB4+b1pdQlm8TNuVVTpy2Q0GKKUU
 Lk1Cz/5/LMjAit+A285FLIdU6+gP+hk0lLqXMnGdghX3H5iG+AM8HCi+6Hdk9lmxz7H1
 riyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960963; x=1688552963;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fznKQ6DvinOnKzhIaVnN2mewHYIIvPlSLlKY6/cYSrc=;
 b=XG22EP/6B9JlVF25ReXXjmOrmC6MIdIDa7F4A4XvTYb7GmSOxl/bI3RSgI6JgBDa4g
 04nbbTtEAdvEABNq3YJIwBGH1AzOzQbVxmDJxNY11KFKUJ/pxZFCgEVMhbowGS/Ex7c4
 T0XincbRDxTCE4Y7klJlUXvk7MooiF6HOjwQ2Y/a0zVkRIq2+Cl31+NpXJoHSfx2OpTp
 vdDmU1Z/L4c2exwFYCFnzSQUVQ277pv9E6d/g9uIOyQbkO745c1uw2DGF00pSZVMQNWJ
 WTZi5ahw9LYoH1odFN3dltptrANpVlw3EN5EoyHDs8cxOPDhcMlMmJLLCm9s7V3znNm6
 3HYQ==
X-Gm-Message-State: AC+VfDxcuOY6v2Exlnxqzt1OQWK9RNf2EcSW+qJdIrs+3ApOeXWnam/y
 o0OO9zT2vwFEtEJx76W1KkU=
X-Google-Smtp-Source: ACHHUZ48KNisX1Gr5OgQp7s8hlJu3G3TyOxyws2+ByMtYrQlbSvDTneCdG2Dqq4mOH79M1u1VAV7hw==
X-Received: by 2002:a17:902:e748:b0:1a9:6a10:70e9 with SMTP id
 p8-20020a170902e74800b001a96a1070e9mr7466782plf.33.1685960963492; 
 Mon, 05 Jun 2023 03:29:23 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ea8400b001a2104d706fsm6220077plb.225.2023.06.05.03.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:29:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jun 2023 20:29:18 +1000
Message-Id: <CT4NA3UVZF4D.1R1A17JVLDKQZ@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [RFC PATCH 5/5] spapr: Allow up to 8 threads SMT configuration
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-6-npiggin@gmail.com>
 <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
In-Reply-To: <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Thu Jun 1, 2023 at 5:20 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/31/23 03:23, Nicholas Piggin wrote:
> > @@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> >       kvmppc_set_papr(cpu);
>
> so, spapr_create_vcpu() set cs->cpu_index :
>      cs->cpu_index =3D cc->core_id + i;
>
> and spapr_realize_vcpu :
>    =20
> > +    env->spr_cb[SPR_PIR].default_value =3D cs->cpu_index;
> > +    env->spr_cb[SPR_TIR].default_value =3D thread_nr;
> > +
> it would be cleaner to do the SPR assignment in one place.

Problem is we can't do it in create because the SPRs have not been
registered yet, and can't move cpu_index to realize because it's needed
earlier.

A nice way to do this might be to have a cpu_index and a thread_index
(or require that it is cpu_index % nr_threads), and use those values as
the default when registering PIR and TIR SPRs. But I haven't quite
looked into it far enough yet. pnv sets PIR in the realize function
already so maybe it's okay this way for now and it can be tidied up.

Thanks,
Nick

