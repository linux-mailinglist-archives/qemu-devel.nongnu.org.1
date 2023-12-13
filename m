Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F83811E73
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 20:15:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDUfv-0005RG-P1; Wed, 13 Dec 2023 14:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUfu-0005R7-7Z
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:13:42 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDUfs-0002IA-Kf
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 14:13:41 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso10198902a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702494818; x=1703099618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i4/jHHl+lbTAM9uhvp49twqWZWtQndlbTIq/tBatWIw=;
 b=K0BM/w4fPGsDoSr+aiWuOaDRdy7KGYMW7Dhyqw5lXybspfngNvDOuYpjpY+Yg/O7V1
 Z07RZUlALGl3SQ0jORDdcjcSqQnXzDlQH+dv2K/IFKas9guu0MJZv5qODY5PoPlUYYRv
 kaazxtDysd+5dWq4d/iMLBzMSzeIivuQtkb1fgh8Ii50NOjzbkBdnyqTux3Hwd7S3A+m
 FlN5wnwWSYX+fzCc3J9YaCw48+RCtFWVfR6sNmVql+k0/+RczVu6+/Jkr0EtPl1T1l0Q
 ii5jkAqVTfxW+TIB9zXjho11j07+lSsFmtURRRg4hHqZCeE2evYJf9XINX6rcLCdKgWc
 fqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702494818; x=1703099618;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4/jHHl+lbTAM9uhvp49twqWZWtQndlbTIq/tBatWIw=;
 b=qavp3bR6ZWIY9sMo5VypeGnOmKStznjKea2vQ2WKGZEPSMdT83qkQR6Z3Ahgfu5Znm
 S2Ta6Ea5FpyD9WugLIbYKoai5lrO2BCTvkODwbVt/0Mkkr90D51SMuDOVV1Bv1QMGNtt
 m4ux0fC1AaFpCXAFg30WPMmPOgptZFlwGuh/Y7duDYjlqJPg+3nVHqm4qKVfmLuB3FTL
 F6OtTlzGMPc3AkCQGiUDoLJNiCBSu2H7uznX/8NdqRmon+Xy+k3hohUxFrfvwvhO2c3g
 EdiFoVDxDoMrUOrgwRLic7qBP6jY/jztzfw8difr2Zp038RPBno3mKPZ1MrJlCvxeLUd
 X5RQ==
X-Gm-Message-State: AOJu0Yyixk0QSqz9MJ+y7yZJmibIXHl0d5A8aKI2sJ0FZl1WkKr/nVdI
 T8Et7WU/sVR4FTmYa2aT26NhUg==
X-Google-Smtp-Source: AGHT+IENHKKpAQ45bAde430aSwU4PuRVZbTfBtTDHhrfV+1PbPEDFHYNla2gyKmDXrCifMDglbZaLg==
X-Received: by 2002:a50:8d8a:0:b0:54c:e28c:2086 with SMTP id
 r10-20020a508d8a000000b0054ce28c2086mr5010253edh.38.1702494818646; 
 Wed, 13 Dec 2023 11:13:38 -0800 (PST)
Received: from [192.168.1.120] (tmo-066-178.customers.d1-online.com.
 [80.187.66.178]) by smtp.gmail.com with ESMTPSA id
 n8-20020a50cc48000000b0054c9df4317dsm5985262edi.7.2023.12.13.11.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 11:13:38 -0800 (PST)
Message-ID: <9078f5a2-648b-4f83-b2e9-8c9b16b8e0ad@linaro.org>
Date: Wed, 13 Dec 2023 20:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about clocks emulation
Content-Language: en-US
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org
References: <1001572703.6422667.1702386300513.JavaMail.zimbra@enst.fr>
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1001572703.6422667.1702386300513.JavaMail.zimbra@enst.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi Arnaud,

(Cc'ing Peter and Luc)

On 12/12/23 14:05, Arnaud Minier wrote:
> Hi all,
> 
> I tried to implement the RCC (Reset and Clock Control) for the STM32L4x5_SoC but ran into some problems regarding clock emulation in Qemu.
> In this SoC, it is possible to change the source of several clocks used for devices like the CPU, the USART, and approximately every other device on the SoC.
> This change can be made at runtime by writing into a specific register.
> I tried to model this by using the clocks in hw/core/clock.c by I noticed that it is not possible to change a clock's source once it has been assigned (see clock_set_source()).

Ouch.

I thought this was what connect_mux_sources() what doing (see
hw/misc/bcm2835_cprman.c) but it is only called (along the
clock_set_source() calls) from the realize() handler.

> It prevents me from implementing a clock tree similar to the one on the hardware.
> 
> Is this limitation there for some reason or has it simply not been implemented?

There is a /* changing clock source is not supported */ comment in
clock_set_source(), so likely not implemented :)

IIUC the only issue is how to update the src->children qlist.

> Thanks,
> Arnaud Minier
> 


