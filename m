Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F3743CFC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFETf-0005Hc-W3; Fri, 30 Jun 2023 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFETd-0005HH-OW; Fri, 30 Jun 2023 09:47:57 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFETb-0006eN-6j; Fri, 30 Jun 2023 09:47:57 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1a1fa977667so1673987fac.1; 
 Fri, 30 Jun 2023 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688132848; x=1690724848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pl5i4oxx/vuNCkI+/p7lG4tsKXsJkTAS+tnwmcDGPz8=;
 b=d/+pqkJakpkUlGhpOA8kxlZ5ESrmgsGJCSv2Jtvp/2fOlJ6/+MWM0AH7fn4NWs2rxa
 tn8biJmlMRjU896fP9F1zK1G3FZ0JIngntbRyYdH6ETwJpgzp/4nqORJcI2oZ9a5Z7bz
 xAlSgo1quQrReYsdiGsPCsXvsJYYzK1cjeZt5UNfUYXI1K3l9MYEKhHnYDkGY5rfXzpv
 7cCAM5K+shuzoK5Otti07lD/5NDu59pZwcDLOdA8yzld2bYzVtWFOXEevfdk3c77M3Ky
 8axoJQklPxCq5Ah0Hghl/os5B6GA7FIq3WA1EDL9fmSJrncr8aX4D5+p92/++FQWkT0t
 VPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688132848; x=1690724848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pl5i4oxx/vuNCkI+/p7lG4tsKXsJkTAS+tnwmcDGPz8=;
 b=VimvBRqacfbia52tTJKKpThCO3NfpkrU/O8jDvaVwYhJ4S1mdRqNTT5nZ5MYn9+PUl
 33uh+tnsrstb9SsqNHJoxnGHILTLYRqNGG02AU/AP9beciLnnSirKLphNqGix+Y2ogXf
 h7f9PZAQFTxFvZ8gSza9iYEFTuJ4TlEuQa/p4p/6Zb5dk2IBW6wSw5sXoroltdokoFHf
 KUNkwYUxbdSJHEz4agWF3m3g/pQsIjV7Wcmd2a/a4S7NiYUJsroKzOvVO+Tl4XyITezY
 OOrqbpKZnBOR7zPZqc8I7n359t2FSY0eJDOqsakXG71HjT6//R10g2OpJshuRxIXmoSn
 Fi8g==
X-Gm-Message-State: AC+VfDy08/KrouQ5ZovUrWyT3BRVgez160Tfj/WntzJw4WaBkX8Tl2AL
 e5ZMaTwoE1ypwC4LDp0TcD8=
X-Google-Smtp-Source: ACHHUZ5PCZPOu5Erx/c2MVp4+YlgwH9SIHnDs8OQsQ4e3XaN2xDhCINnojzqUfeuudH2/uR4A8RzsQ==
X-Received: by 2002:a05:6870:7808:b0:1b0:3043:cb4a with SMTP id
 hb8-20020a056870780800b001b03043cb4amr3925075oab.0.1688132847827; 
 Fri, 30 Jun 2023 06:47:27 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 el35-20020a056870f6a300b001962e45f0d4sm8907245oab.24.2023.06.30.06.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:47:27 -0700 (PDT)
Message-ID: <6b9af219-d909-4843-7a6d-d62c7b83db88@gmail.com>
Date: Fri, 30 Jun 2023 10:47:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] ppc/pnv: Add P10 quad ops
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-4-joel@jms.id.au>
 <da80494b-0626-62f5-65b7-1e4b0901ee27@linux.ibm.com>
 <CACPK8Xdyp_buQ4A=h8aJB1A_Q2kUpAGRHY1mm0Gn3jB3vk9a3Q@mail.gmail.com>
 <bcf6dff6-45e8-738a-3600-d2f2369283b4@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <bcf6dff6-45e8-738a-3600-d2f2369283b4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/30/23 04:44, Cédric Le Goater wrote:
> On 6/30/23 09:35, Joel Stanley wrote:
>> On Fri, 30 Jun 2023 at 07:30, Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>>>
>>>
>>>
>>> On 30/06/2023 05:55, Joel Stanley wrote:
>>>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>>>> index b9a57463aec4..7fff2fd9e298 100644
>>>> --- a/hw/ppc/pnv_core.c
>>>> +++ b/hw/ppc/pnv_core.c
>>>
>>>> +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>>> ...
>>>> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
>>>
>>>                                            ^^^ reading
>>>
>>> I'm guessing we'll need to flush out that function pretty soon, so not
>>> worth resending.
>>
>> Thanks, good catch. It's incorrect in the p9 callback too.
>>
>> I had it fixed locally along with a re-wording to make it clear the
>> message was for unimplemented operations, but decided not to send
>> that.
> 
> 
> There is still time for a v2 ! Please keep the R-b.

Since you're sending a v2 please fix the 80+ char line in patch 4 to make
checkpatch.pl happy:


-static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr, uint64_t val,
-                                         unsigned int width)
+static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)


I'll not queue the series for now.


Daniel

> 
> Thanks,
> 
> C.
> 

