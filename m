Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027E7489D2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 19:05:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5vJ-0006cU-HJ; Wed, 05 Jul 2023 13:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vH-0006c0-Gq; Wed, 05 Jul 2023 13:04:11 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qH5vF-0000VO-6j; Wed, 05 Jul 2023 13:04:11 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1b38121a011so3574452fac.2; 
 Wed, 05 Jul 2023 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688576647; x=1691168647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBFFbXAj0D1rsUoFLcUZE8Sq0BVb8co5EbLKvNkn2vw=;
 b=LKxbwWlQIuz1zyYr21KwsNWUbLWTCkpsQutuDdLYRHUJaB4kbX2vhjkvDtGM9qoMsg
 SEgjU511BOKeHTn+6veKLClO5A9gpeHR9EXSJUufVqw6dGNumD1BKwE0/BQ+pXjcN2k9
 w0Uo3lnfgJujuH2aDFsY75PmoIVV6yGB6ObXkyVI5TH4nOXRiYTbIEr8yLuuMIXW5J6s
 HMWocI8yu26pNOzUi1WmP/zQLCFqnHoUkGLSQ/FUYW6fEcWH/pU5r5iYrNOkhhZ7wE8U
 TdV5Gmsy2OFn5xsiwuCQA/rIaVLQ5UqXdvm5zp2UgzQe2iMRKKBeKWR2UzPnV3m/EXZw
 sI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688576647; x=1691168647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBFFbXAj0D1rsUoFLcUZE8Sq0BVb8co5EbLKvNkn2vw=;
 b=JA3tjk18siqUF9mZAEFNpiXegT2kilj6mSvJfbMAS6/AcqDnq7tRbly+j/Cwk17wEt
 HDXk1L1iSmXY833ULiXPrqeVlg3n3bfqYB5yrZXNMk0dkxCNb62M1O+0wZq52WIuEKrR
 y87hLaUK4MP8S+s9wWCG22iDE8050s8LB2choTCWvYYlo8y4qm7SWQUJVlHmPHdmKwxI
 EwTXcgXyePP1b/bWQG+rI8gxoBEUD+Gvzwl/Zhk1+qIFncSBFx1YHun3Dwrq+FBKAxPL
 uJjIcPHt4BEfv0ujEEqh0dqVQS/qzmLz9gaDaWOIC6Skvee01hB7k4UZQoyBR8TRHWgV
 aTVA==
X-Gm-Message-State: ABy/qLZ+EdM0ntWE6E0M0q1XjemyqGl0LxBWdGRQPd0JYhH49hRqzxbi
 y4nfvMZPPNYnkv34ODrXXlc=
X-Google-Smtp-Source: APBJJlG8Dfv2EVVCNPJCY6gfXAklIt495zCabTppaPnHhezo/luTSXzSoVkHnwfUYSFiF42fMPq/fg==
X-Received: by 2002:a05:6871:520c:b0:1ad:3647:1fd0 with SMTP id
 ht12-20020a056871520c00b001ad36471fd0mr17611818oac.22.1688576647095; 
 Wed, 05 Jul 2023 10:04:07 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 dw22-20020a056870771600b001b3f0afda0fsm702443oab.30.2023.07.05.10.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 10:04:06 -0700 (PDT)
Message-ID: <6e54457b-face-25fe-1df8-f70c0a962610@gmail.com>
Date: Wed, 5 Jul 2023 14:04:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/4] ppc/pnv: SMT support for powernv
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230705120631.27670-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230705120631.27670-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.089,
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 7/5/23 09:06, Nicholas Piggin wrote:
> These patches implement enough to install a distro, boot, run SMP KVM
> guests with libvirt with good performance using MTTCG (as reported by
> Cedric).
> 
> There are a few more SPRs that need to be done, and per-LPAR SPRs are
> mostly not annotated yet so it can't run in 1 LPAR mode. But those can
> be added in time, it will take a bit of time to get everything exactly
> as hardware does so I consider this good enough to run common
> software usefully.
> 
> Since RFC:
> - Rebased against ppc-next (no conflicts vs upstream anyway).
> - Add patch 4 avocado boot test with SMT, as was added with pseries SMT.
> - Renamed POWERPC_FLAG_1LPAR to POWERPC_FLAG_SMT_1LPAR since it implies
>    SMT.
> - Fixed typos, patch 1, 3 changelogs improvement (hopefully).
> 
> Since v1:
> - Fix clang compile bug
> - Fix LPAR-per-thread bug in CTRL/DPDES/msgsndp in patch 1
> - Add 2-socket test case to powernv Linux boot avocado test
> - Remove SMT caveat from docs/system/ppc/powernv.rst
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    target/ppc: Add LPAR-per-core vs per-thread mode flag
>    target/ppc: SMT support for the HID SPR
>    ppc/pnv: SMT support for powernv
>    tests/avocado: Add powernv machine test script
> 
>   docs/system/ppc/powernv.rst  |  5 ---
>   hw/ppc/pnv.c                 | 12 +++++
>   hw/ppc/pnv_core.c            | 13 +++---
>   hw/ppc/spapr_cpu_core.c      |  2 +
>   target/ppc/cpu.h             |  3 ++
>   target/ppc/cpu_init.c        | 14 +++++-
>   target/ppc/excp_helper.c     |  4 ++
>   target/ppc/helper.h          |  1 +
>   target/ppc/misc_helper.c     | 29 ++++++++++++
>   target/ppc/spr_common.h      |  1 +
>   target/ppc/translate.c       | 27 ++++++++---
>   tests/avocado/ppc_powernv.py | 87 ++++++++++++++++++++++++++++++++++++
>   12 files changed, 179 insertions(+), 19 deletions(-)
>   create mode 100644 tests/avocado/ppc_powernv.py
> 

