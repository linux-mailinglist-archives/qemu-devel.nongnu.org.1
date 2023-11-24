Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1C7F7436
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:49:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Vat-0004J8-Ki; Fri, 24 Nov 2023 07:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Var-0004AZ-1f
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:47:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Vao-0005cI-Qm
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:47:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b2ad4953cso16825895e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700830052; x=1701434852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2xSlMOjhRTHcGlZQri8H/KgmcTvXC+4xuXicKM3J4A=;
 b=WNgR+KIPFuC7HGpcSarrP00ouVI3OTUSu69keP5PwEwZo+jseM8oDEvmrlOM0dHTKD
 S/Ng2FY6MQR7zlB+x95yOq8v05V0ZF9nP3FIo9C04OP8Bven+9gfHvMmnuJMYhlQ/p+I
 huhb5g1UE7ttUBnhxzVvi4CQUl5Vs0GG245r/Anq2EM60m9KcsQWYb6kiY67pZa3DN30
 1GCjWHke8eAWPhyXAmZfstszWUDg+WdzQLzq7geftGScriJDdVlOJzUUZdwwruAOedVo
 pdH3ix7ATGNUJPvIvY26ZU3aZ2mAhjCj5XjUfroC41OhLJzn2BJhnd5//KotL18tX9WD
 hEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700830052; x=1701434852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2xSlMOjhRTHcGlZQri8H/KgmcTvXC+4xuXicKM3J4A=;
 b=GAn4eJ/9t+d6c+c/iFEfKM8snoAZvmxxpYJdTff2LdmgE5AzpN688r/yrRbvRP+TiB
 YQO/8W12CRZUr5OH6u+x3nD3dhGIvfsdjz87TK3VYgDEZvYATN8/1zNo4vudDR64JtI5
 84xSMTCF1aPW92KfX5HWYf8ZMU9sLSFMarDdlerIoRTV1efiXq4QmoO0pVbrqT+tN02E
 PPjSsFIt58V4yOI3oXoSlpr5OtwsR1FaKr+1PuOXHjq4LKrHwS/5Kal3/gGgMJUKqAs9
 uaQx7csxP7A4jTNo9g4tEAVZK/Mx6T05/kGGiZbHgDmyxOrUpej3+PA+iUZuBGdilYIB
 vv5w==
X-Gm-Message-State: AOJu0YxmC21nUjUkd9U3nYhFh7R1JFpu4Epe7xa2BOKqRtBxqbBwfwTv
 TlMBnehFpfbhNdAxf4tddLG6wA==
X-Google-Smtp-Source: AGHT+IHBHw0DQlH8XOCUX9Mv/un6JTCKpVtZHx+hVgc8VfuNytdkotwkBQIhImrphwzQCL1OemPYXA==
X-Received: by 2002:a05:600c:350f:b0:40b:37f2:95bc with SMTP id
 h15-20020a05600c350f00b0040b37f295bcmr2500711wmq.6.1700830052182; 
 Fri, 24 Nov 2023 04:47:32 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 v19-20020adfd053000000b0032f9688ea48sm4165581wrh.10.2023.11.24.04.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:47:31 -0800 (PST)
Message-ID: <bc15ee84-9ef5-4558-a978-88c0d5b06978@linaro.org>
Date: Fri, 24 Nov 2023 13:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 10/10] hw/char/pl011: Implement TX FIFO
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-11-philmd@linaro.org>
 <CAJ+F1CKFFU_VEA4nhgWw9RLDgc_gD0h-FPfvSP4LaFC1j4pP6Q@mail.gmail.com>
 <ZV3aMYohaUsg5gWx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZV3aMYohaUsg5gWx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22/11/23 11:38, Daniel P. Berrangé wrote:
> On Wed, Nov 22, 2023 at 02:31:29PM +0400, Marc-André Lureau wrote:
>> Hi
>>
>> On Thu, Nov 9, 2023 at 11:30 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> If the UART back-end chardev doesn't drain data as fast as stdout
>>> does or blocks, buffer in the TX FIFO to try again later.
>>>
>>> This avoids having the IO-thread busy waiting on chardev back-ends,
>>> reported recently when testing the Trusted Reference Stack and
>>> using the socket backend:
>>> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=149574
>>>
>>> Implement registering a front-end 'watch' callback on back-end
>>> events, so we can resume transmitting when the back-end is writable
>>> again, not blocking the main loop.
>>
>> I do not have access to that Jira issue.
>>
>> In general, chardev backends should have some buffering already
>> (socket, files etc).
>>
>> If we want more, or extra control over buffering, maybe this should be
>> implemented at the chardev level, rather than each frontend implement
>> its own extra buffering logic...
>>
>> Regardless, I think frontends should have an option to "drop" data
>> when the chardev/buffer is full, rather than hanging.
> 
> Does anyone really want data to be dropped by QEMU ? Every time I've seen
> a scenario where data has been dropped or lost, it has been considered
> a bug to be solved.

A kind of counter example is the RX UART model, which is used in
embedded world and respects the baudrate timing. I guess some scripts
were working with the QEMU UART chardev, but them the same script
failed when using HW UART, so realistic HW baudrate was emulated using
the timer API. See the chardev frontend handlers:

static int can_receive(void *opaque)
{
     RSCIState *sci = RSCI(opaque);
     if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
         return 0;
     } else {
         return FIELD_EX8(sci->scr, SCR, RE);
     }
}

The TX path also use a timer:

static void send_byte(RSCIState *sci)
{
     if (qemu_chr_fe_backend_connected(&sci->chr)) {
         qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
     }
     timer_mod(&sci->timer,
              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);

The more complex 16550A UART model also use timer in FIFO mode.

> Sure, we don't want QEMU to block on chardev writes, but we want that
> more than throwing away data.
> 
> What's the use case for capturing data from the serial port, but throwing
> it away if the other end of a socket doesn't read quickly enough ?
> 
> If someone does want lossy serial ports, they could configure the UDP
> charedev backend already.
> 
> With regards,
> Daniel


