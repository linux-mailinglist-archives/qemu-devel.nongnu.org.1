Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E874ABBE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHflT-0004gC-4v; Fri, 07 Jul 2023 03:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHflM-0004Zr-P0; Fri, 07 Jul 2023 03:20:24 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHflK-0008Dc-Iy; Fri, 07 Jul 2023 03:20:19 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5636426c1b3so1101985eaf.1; 
 Fri, 07 Jul 2023 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688714417; x=1691306417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WtaATV2Cd32wXbns9M50SQNgsVaLOzcgrEdKa7M4whg=;
 b=A9FV0aMPz5kS3GOmrZjyZ8b9kR38nk8pzr1P8b2xqd2fWsmb6UbeTtA+GiUq2v5K3U
 au36drEUjK13N2yD2v2LxrPzc1Hw3+RrMyvzN0iqm+f3eukyfz3h27/acVAEoUXqPTZW
 4Wo+tQzcaaUbCZYgB0i7FDUPx/UpLFdADrFyskKqfRAzE3KA2gzmwYIEdhLEt9oDVktE
 p8uW9rMgFu6xy2vqJnfyP5iTIM3Hiw2VJs+SqcfGn1GRihGBddSPiV3LNTXpinR47f0s
 B4CR4HCxn2VHVsFGPqGnkJJWT0FfTzHjVQDn9Ev+r+PvkthIL/9X8XKeQ8kLQHb7Wnfq
 iswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688714417; x=1691306417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WtaATV2Cd32wXbns9M50SQNgsVaLOzcgrEdKa7M4whg=;
 b=AZAcRqJrF0k+/nMxJxWpmA8ymWKLpGrdfC3gL4RAimJh4Nd1hS27RPw2cLlo/3R4bs
 l1sUmqbLmRKryNikeXqRrWwhyruBoUxF+T2ij3qFomDKqNYLMzcHiy74X9hUaiFQHMb4
 Vb1hBB1DH05NbY73NcnSDNkfV7mcyurPXqyl4D1Xv64RFlPGzHjAD3h7HXYeIkTsYiPd
 MrLyQhWCpL/UAC0ExwluTHl+8clSiFdhFIE8MFF/se52uKvGRY9vdYxm7jLURoLChXE3
 HDk1jK2IPF4aDkz0jgobVBoMpT7XP7K7cpILBl8DBksrtHsPrsuf920NjHuVZF6K2kJH
 z0ew==
X-Gm-Message-State: ABy/qLYLuUq/CkD83sYFfz+HWp0UNI2nqngyNxXuB+K578cZU1TK+QCL
 BgIHyJwQn+QyJalOTltccfo=
X-Google-Smtp-Source: APBJJlHj1988T2tI4rv8NzYIm0w9M3GKluX3SGnLmPqjWT0RUAVqZ0dQfzocoRxU4l3Xq14rejI62g==
X-Received: by 2002:a05:6808:14d3:b0:3a1:dd99:8158 with SMTP id
 f19-20020a05680814d300b003a1dd998158mr4669975oiw.6.1688714416920; 
 Fri, 07 Jul 2023 00:20:16 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 s4-20020a0568080b0400b003a1ed9482d4sm1425685oij.4.2023.07.07.00.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:20:16 -0700 (PDT)
Message-ID: <e16f68a3-4d8f-4200-b9ef-131bcdd13db1@gmail.com>
Date: Fri, 7 Jul 2023 04:20:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] ppc/pnv: Set P10 core xscom region size to match
 hardware
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230706053923.115003-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230706053923.115003-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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

On 7/6/23 02:39, Nicholas Piggin wrote:
> Sorry about the paper bag bug in the first version of the patch -
> I broke powernv8 and 9.
> 
> This adds a xsom_size core class field to change the P10 size without
> changing the others.
> 
> Also added a P10 xscom test, and passes make check.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (2):
>    ppc/pnv: Set P10 core xscom region size to match hardware
>    tests/qtest: Add xscom tests for powernv10 machine
> 
>   hw/ppc/pnv_core.c            |  6 +++--
>   include/hw/ppc/pnv_core.h    |  1 +
>   include/hw/ppc/pnv_xscom.h   |  2 +-
>   tests/qtest/pnv-xscom-test.c | 44 ++++++++++++++++++++++++++++--------
>   4 files changed, 41 insertions(+), 12 deletions(-)
> 

