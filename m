Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6A747A48
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 01:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGpBv-0005KW-H1; Tue, 04 Jul 2023 19:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGpBt-0005IV-A8; Tue, 04 Jul 2023 19:12:13 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGpBr-000670-L4; Tue, 04 Jul 2023 19:12:13 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b07d97180dso6169693fac.3; 
 Tue, 04 Jul 2023 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688512330; x=1691104330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMe/hF31yharNKOpKtOCe4MThj7hgDYjmW3iKcktcvA=;
 b=keqLD5P9t/9gfvYFAugyDj5MZT+rsa0WWiuSnx7BV65aCcYgEZ6BitVet3B1MHm/2m
 MIWIg8m8GCxiGL/XLt4YxFIw+iUWWHTxvxTWdzzszzu5j8VrG0khKL9bd1hpH3WTRuCE
 FWC7xpzuv4j1Kvy48mCv6/0i0c+wYXVvqa0F2DHdKCHkJm0aizNZF8TsUXSM3ho54Gjj
 HAnxVNwOd4fwKsgVuuECPJ92s2CsrtnypaRA+qeScRFsTIE7Hb2lJexBABGVSjfpGlMJ
 b+aHZmIdF0dcBtXDdWRA7z89dAd8BZHqY8UqP1FJTdrohutWkx/kgKxeRqTgBUSsCah+
 cFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688512330; x=1691104330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMe/hF31yharNKOpKtOCe4MThj7hgDYjmW3iKcktcvA=;
 b=EykScSUng8ehcPR5o1+kjsJXJF4UzuQdMddJW8Y9g9voGvohI20Cpsiq9BfLAYtl5b
 4xb1UDX/BFGTyZgH+sG0vM+gxJ1zvBnzcvFw2AHn9eCOqQEDCDRRfzOKz2qp+Zqsx/LB
 q42FmK+49EbEi5P2BwbAL3GHloalebVDhOyQZySL7oePbPmJkPT7UK/bR0QFqfci8EWN
 LtpHXdarFuGy126CeqqLQeZIT7tPs5K0relZc/h3uHyiECBfSxhkdtNdc8LRLTni18Hq
 g3JP3VmLUAow61FtCBsdzkoI+LMOnk+v6fdvGWMTWQxNE4pNgvb8Efz0WuliuyZqdIX2
 4irQ==
X-Gm-Message-State: AC+VfDzG647vgB4rsyR9uX/if5TXbebSfUf1DhDNby8IVQjk7PB5heGW
 +SMmdmct+9+u0sMWUQYwjJM=
X-Google-Smtp-Source: APBJJlFEoETmQTh1WzeMteGhx4HkVgFggreQlGPFm4DORaZ7bsNf9lO2mzYi0j6B+GyqHGCZ+X+bpg==
X-Received: by 2002:a05:6871:89c8:b0:1b0:19ee:88f2 with SMTP id
 tk8-20020a05687189c800b001b019ee88f2mr14357780oab.36.1688512329836; 
 Tue, 04 Jul 2023 16:12:09 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 m2-20020a0568301e6200b006b8c505d8aesm2817363otr.34.2023.07.04.16.12.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 16:12:09 -0700 (PDT)
Message-ID: <0183acc5-5f48-2b85-b55d-503cab6b81ac@gmail.com>
Date: Tue, 4 Jul 2023 20:12:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] ppc/pnv: Extend "quad" model for p10
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
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

On 7/4/23 02:41, Joel Stanley wrote:
> The quad model implements the EC xscoms for the p9 machine, reusing the
> same model for p10 which isn't quite correct. This series adds a PnvQuad
> class and subclasses it for P9 and P10.
> 
> I mistakenly thought we needed the quad model to implement the core
> thread state scom on p10, because the read was coming in to the address
> belonging to the quad. In fact the quad region was too large,
> overlapping with the core. This is fixed in v2, and the core thread is
> back where it should be in the core model. This should address Nick's
> feedback on the v1 cover letter.
> 
> v2 also adds Cedric's r-b, fixes the s/write/read/ mistakes, and is
> checkpatch clean.
> 
> v1: https://lore.kernel.org/qemu-devel/20230630035547.80329-1-joel@jms.id.au/
> 
> Joel Stanley (5):
>    ppc/pnv: quad xscom callbacks are P9 specific
>    ppc/pnv: Subclass quad xscom callbacks
>    ppc/pnv: Add P10 quad xscom model
>    ppc/pnv: Add P10 core xscom model
>    ppc/pnv: Return zero for core thread state xscom
> 
>   include/hw/ppc/pnv_core.h  |  13 ++-
>   include/hw/ppc/pnv_xscom.h |   2 +-
>   hw/ppc/pnv.c               |  11 ++-
>   hw/ppc/pnv_core.c          | 165 +++++++++++++++++++++++++++++++------
>   4 files changed, 162 insertions(+), 29 deletions(-)
> 

