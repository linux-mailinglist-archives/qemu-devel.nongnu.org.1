Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C62730EB5
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ffV-0002ki-24; Thu, 15 Jun 2023 01:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9ff6-0002hQ-Nm; Thu, 15 Jun 2023 01:36:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9ff1-0000b2-LZ; Thu, 15 Jun 2023 01:36:44 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-66654d019d4so311494b3a.0; 
 Wed, 14 Jun 2023 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686807401; x=1689399401;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aB0WYe/CbEE8zDc9XIrKGkaNWrDuX24pob4dWBP/4JI=;
 b=I6yUN3sRU34lm35dKWijAXLrt06Ggwa/bhtv4maXMpPtgjvDW2VSlalvAVQIu3KAZ/
 TjQZM2OuZZROiQPZ+Z14qlHEQdrGy/+2xp58VGsM2Ufd6EGpLJarQuR1eh5p16CfJNJa
 2HbKew94E6yCbrWXkf9dOxd8IpSymJnS5oa03W18Bub3EdBVVpCO94RlrFFP7ht3yPvO
 VwdfbmIlXlBK0T4EUkz2dO9IiuFwxjwkKvQqzdyjJl2Pdzv7sHdo+GgWkjWau/WLrBvn
 so7tNfWcb17cSLRXq7qXyG0rky6PSRJMl+j1/q+8Kvq8vxssWgc3W24+D2EbmmD8oGT0
 ekfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686807401; x=1689399401;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aB0WYe/CbEE8zDc9XIrKGkaNWrDuX24pob4dWBP/4JI=;
 b=fGXnyRHa8ogcrdAv9ihGnWewGIkGOFrXMngcj+R132BnqJ7Csi17l3ifB+T1eweaUj
 isdBmEtNYC4Var2CrvHJYcqJT2U0zn+Y8E+snUzOQAgtNbLEGOaIkGG02Wsn2SP1zjrs
 Jfq9Vu6/t7FGQz5Z4a1cByN9rcM9geGv/WPSz5k6wMYtC2DzLeoZKie6RUO+N2khfWtm
 KArKhriDMy2Y345wZNuERc26LrWkkS0SBPWfrSm+ApxISwi6OBVibqc+hW2Ok6CNfQMU
 5axvFGAFmCWB3CpSh//x/TzPws3zDTeWBuJjhbdY1ffXzzE89PkvvHz5Fimz5MwiB+la
 cfQw==
X-Gm-Message-State: AC+VfDze+UCG+KtCfDqbbPMe6XFlCNHnIniB+SZ189ghpJIk/TEU8/zz
 xBVce+tzxMIce+If/rghkYDc6GO4mZU=
X-Google-Smtp-Source: ACHHUZ4MF2+5rb3ouLzAhtXemhsKsh5uivCkd2iKw5uhyhkKyz/rj83528+WG2iud/ZrhlPekn/BPA==
X-Received: by 2002:a05:6a20:1589:b0:10b:aeff:aa00 with SMTP id
 h9-20020a056a20158900b0010baeffaa00mr4305655pzj.28.1686807401443; 
 Wed, 14 Jun 2023 22:36:41 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 i25-20020aa787d9000000b0064f51ee5b90sm979719pfo.62.2023.06.14.22.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 22:36:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 15:36:37 +1000
Message-Id: <CTCZBGI3FBF7.7FQGDAVNLTYL@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 2/4] ppc/spapr: Add a nested state struct
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-3-npiggin@gmail.com>
 <f350a17c-5164-93ed-446f-1925ced02f10@linux.ibm.com>
 <CTCCRNIC7LCM.383MVI3UNIDK4@wheely>
 <30b061d3-83e1-eb96-4404-ffb9559b3684@linux.ibm.com>
In-Reply-To: <30b061d3-83e1-eb96-4404-ffb9559b3684@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Thu Jun 15, 2023 at 2:51 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/14/23 17:26, Nicholas Piggin wrote:
> >>> @@ -1766,34 +1872,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int ex=
cp)
> >>>        address_space_unmap(CPU(cpu)->as, regs, len, len, true);
> >>>   =20
> >>>    out_restore_l1:
> >>> -    memcpy(env->gpr, spapr_cpu->nested_host_state->gpr, sizeof(env->=
gpr));
> >>> -    env->lr =3D spapr_cpu->nested_host_state->lr;
> >>> -    env->ctr =3D spapr_cpu->nested_host_state->ctr;
> >>> -    memcpy(env->crf, spapr_cpu->nested_host_state->crf, sizeof(env->=
crf));
> >>> -    env->cfar =3D spapr_cpu->nested_host_state->cfar;
> >>> -    env->xer =3D spapr_cpu->nested_host_state->xer;
> >>> -    env->so =3D spapr_cpu->nested_host_state->so;
> >>> -    env->ca =3D spapr_cpu->nested_host_state->ca;
> >>> -    env->ov =3D spapr_cpu->nested_host_state->ov;
> >>> -    env->ov32 =3D spapr_cpu->nested_host_state->ov32;
> >>> -    env->ca32 =3D spapr_cpu->nested_host_state->ca32;
> >>
> >> Above fields so, ca, ov, ov32, ca32 are not taken care in
> >> nested_load_state, ca being introduced in previous patch.
> >=20
> > They should be, by cpu_write_xer.
> >=20
> I see. In that case, do we really need the previous 1/4 patch?

Good question. This supersedes it, but it's good practice to do a
minimal fixes for bugs. Not just to make for easier backporting, but it
helps to understand bugs in the commit history.

>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks,
Nick

