Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854771F3DD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:31:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4owS-00087e-Fh; Thu, 01 Jun 2023 16:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4owQ-000875-ED; Thu, 01 Jun 2023 16:30:38 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q4owO-0001pb-AS; Thu, 01 Jun 2023 16:30:38 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1a28de15c8aso492744fac.2; 
 Thu, 01 Jun 2023 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685651433; x=1688243433;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUoKXebAHe5+LAXTa/3VCTV1QrPY2WThTKXU/bHHczQ=;
 b=fq5jGZV2OT9gPW/H9SIQ7JkkOcnNr5AvYEKbQQSU2/gX1Qm9p6N7n3m9EuFMRALiPP
 sbVCGfCv7UvPvQCM5olU6whMxN4wVi0+uZjHHYyhxEfU3YUU77dUt36OgLnQ69bk49gj
 xSuvqPnjm/CAhJgtvcGy0qznKJLX0jpNb/J0lEy3VxgmUtnMpPFSqaCej49OJwrEyV1n
 VXdSMw6ydn9MvYi9iqWcucevtcTf3lMAWCpzQ4x9IrvjK922DGpy+R52KRDgeYMgzPml
 bJD8mRS2L1oNcH4dQiULsWNt1gRi1Ij8Qh/pMUQYT/z5Bw4uZiI/z04XXer84RIQJvqo
 aOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685651433; x=1688243433;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUoKXebAHe5+LAXTa/3VCTV1QrPY2WThTKXU/bHHczQ=;
 b=MYF4Ggztr3seJTDmXpzrINsIgX3iv1tiVm/g4IuaoalHPnWcnv7j5cEfvQehnmPn4M
 GersUilcLMjHv7fk6AepspgIGmD+SxYXVxzCpOF8NhW+g3xHNcoR1yMQcuwXYEKkE0fZ
 U7aS+vyr4kaI+sgMwZ6v6qiVUT/ojLEWiv/JQYWRvXTcgx03NjWFCncwCfmYwsnoiL1I
 eEUM3lsN2oa5JcM6IkqL0yBdcWXkwLloRfZhxt1BEDTf2PlkA1Im24Qihgp8ZsBGQaQK
 Qg9+Yuih8jPIfynig80ZqEpqxegNpOZB2qVf/UC4/RVwj8AFwj44wIifPrREGof7stjm
 wdBw==
X-Gm-Message-State: AC+VfDxyUzr8IVoWVRi0KL5whdRVyoLc0AvFeylLPKgzh43MGS0XilEn
 KpNRBIdG9rezu91gePqjnYk=
X-Google-Smtp-Source: ACHHUZ4qqIvCHCqE8FQmQI1HnPTRa8V3FCOs/1CZ/YKNQXULQs5XyA6Z1MRtFZz9LZY6eF7h+rqYpQ==
X-Received: by 2002:a05:6870:e602:b0:1a2:7432:c78d with SMTP id
 q2-20020a056870e60200b001a27432c78dmr278033oag.34.1685651433090; 
 Thu, 01 Jun 2023 13:30:33 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a4adb8e000000b00545442d89b3sm7596727oou.23.2023.06.01.13.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 13:30:32 -0700 (PDT)
Message-ID: <0ae050d0-6f38-b15a-b3ac-c8169baf0d2b@gmail.com>
Date: Thu, 1 Jun 2023 17:30:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/5] Various xive fixes
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, clg@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230601121331.487207-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.1,
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

On 6/1/23 09:13, Frederic Barrat wrote:
> A set of small fixes for the interrupt controller (xive2) on P10.
> 
> Change log:
> v2:
>    split last patch to do a bit of cleanup first
>    add Cedric's reviewed-by on the first 3 patches
> 
> Frederic Barrat (5):
>    pnv/xive2: Add definition for TCTXT Config register
>    pnv/xive2: Add definition for the ESB cache configuration register
>    pnv/xive2: Allow writes to the Physical Thread Enable registers
>    pnv/xive2: Introduce macros to manipulate TIMA addresses
>    pnv/xive2: Handle TIMA access through all ports
> 
>   hw/intc/pnv_xive2.c        | 20 +++++++++++++++++++-
>   hw/intc/pnv_xive2_regs.h   |  8 ++++++++
>   hw/intc/xive.c             | 16 ++++++++--------
>   include/hw/ppc/xive_regs.h | 16 ++++++++++++++++
>   4 files changed, 51 insertions(+), 9 deletions(-)
> 

