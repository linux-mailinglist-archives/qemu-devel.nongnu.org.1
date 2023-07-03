Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD34745DC3
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJxG-0000Bc-7z; Mon, 03 Jul 2023 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJxD-00006D-7n; Mon, 03 Jul 2023 09:50:59 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJxB-0007RJ-JC; Mon, 03 Jul 2023 09:50:58 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1b07d97180dso4569987fac.3; 
 Mon, 03 Jul 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688392256; x=1690984256;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8amCMfw5SGjdr3k2RdJI/hp3IA5DiZIXm7nlnkGLAlE=;
 b=qKCRm2Aldq/qJ0TqCFDvx9NR24CUIow2lpOZdhR0YMPEsuXh4LX6Wh22pym+dioF2o
 iXYwD0hxMTO/2+kBNVT0Q6Yf433tzgraRr8NfHyiEY3Q02626Huwjwr/SFwY/JKXGqCg
 Zd1PV771h4KoRulEDVAJRNz6BjyTOuVssNqEu3vFz8Mv0pZmUM+BsmJ87D1TWBjYn4Ak
 BY84qYMIAGH8wmmuKyQSg88vQ98fMa7eJfeFgHoVVpN4CFS1nzER9S7Q7ZTFIz3GEQRA
 vW9x/0A9zLMpQiZPQOriQbgZ7FSCB8WPLNe3g6LG7x2F8KOrSBpC7jqNWxZ18Sh8BMIc
 eB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392256; x=1690984256;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8amCMfw5SGjdr3k2RdJI/hp3IA5DiZIXm7nlnkGLAlE=;
 b=S56Igpd8cgFLmp2SAblusVJU1ixRMfA9jAfNltLCIMHzgVtktaR7DBIlfD+LzvbuRe
 lKtnuWi5YxM4hBltkVegMkoE9bmyofl68fHddazQA7BZt3ATd51RdkjfX2Uj5j4n5Xns
 tfDa4QKZsenj1O1hwpjPIBn5ulpD/q4lFOZk3TJUw8b9JVxmJlcFHmuXWOxJrZEEORHQ
 eEEKjdTWIFcPLDYxuxJzctbikZZqRU99t+boXF+bCsOMi1GE4iOO1viz+k8k7q9TXGRV
 KJta7F3AXGyI3/yH/KVI05fFP4qWuG3DhvqZ7dRpav9zXi1AeDFhRzNySE1/QFw9rrQV
 Rhjg==
X-Gm-Message-State: ABy/qLa5HV958orol4balUvaUoFArQ3JUhHU7IfegaMKcXfcOYJ8c2jr
 MbTKCapoPO/q1n8bXNuyUBM=
X-Google-Smtp-Source: APBJJlFOeVuDy/I1sGuxLfR+gBmSDD1aeSrsrSaTzUlyXigSI4u/WA/4xvNQZJaJn7AOtAiHXPWUjA==
X-Received: by 2002:a05:6870:3d9b:b0:19f:1df3:ffce with SMTP id
 lm27-20020a0568703d9b00b0019f1df3ffcemr11972794oab.53.1688392255709; 
 Mon, 03 Jul 2023 06:50:55 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 ek14-20020a056870f60e00b001807f020a39sm12290537oab.12.2023.07.03.06.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:50:55 -0700 (PDT)
Message-ID: <aff81ef5-5be8-2ad6-d35e-f7cf4775cce4@gmail.com>
Date: Mon, 3 Jul 2023 10:50:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] Fix PSIHB interrupts init PQ state
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230703081215.55252-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230703081215.55252-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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

On 7/3/23 05:12, Frederic Barrat wrote:
> On P9 and 10, the real hardware defines the PQ state of the PSIHB
> interrupts to be 0b00. Qemu defaults to 0b01.
> 
> It doesn't matter to skiboot, which doesn't rely on it and explicitly
> masks the interrupts during intialization. But this patch fixes it,
> just in case some other hypervisor checks it.
> 
> Changelog:
> v2: rename property/struct member
>      rebase to Daniel's ppc-next branch
> 
> 
> Frederic Barrat (2):
>    pnv/xive: Add property on xive sources to define PQ state on reset
>    pnv/psi: Initialize the PSIHB interrupts to match hardware
> 
>   hw/intc/xive.c        | 8 ++++++--
>   hw/ppc/pnv_psi.c      | 2 ++
>   include/hw/ppc/xive.h | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 

