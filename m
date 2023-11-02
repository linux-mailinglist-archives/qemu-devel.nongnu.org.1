Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292BD7DEC0F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 05:59:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPlz-0002Q4-Kt; Thu, 02 Nov 2023 00:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPlx-0002Pd-Ia
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:57:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPlv-0001jR-QT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:57:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso4427935ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698901054; x=1699505854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tVMN87Vbxw/oAf0073ldPqNd9mQM9WENYeJXn07CA6M=;
 b=Q0QXV2OMdgbND0GZT31bnOzqxTXJ2tBB4jYM1hv5DzhWcZTMz0ha0Wtp6XKYBbSack
 Dc4V+NRe1iC75ZdzxL7cLBCajSqrd+ZA8RdOTmk4fX0MLhz0zT/pRZZxM0AjrufZYiER
 iAynGwi63ZIFjg7pe45r3lIRTkX66eEIHus591Cs2krnSwJKbj1fh4tmJYFZ8T1dHntb
 DOf3KAUHUum9gaO9SHRAiUSaDhCqEiEaofNeUpogVTl2X0ucH8/iOUU+UyPXNfOgBzrF
 xC0cc/ndwwgTgv6L4KpqCcTUpr4cMSNDiC+mPCE4MF+iaibIbNZaE26Dp8VDSMAB85nU
 gSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698901054; x=1699505854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tVMN87Vbxw/oAf0073ldPqNd9mQM9WENYeJXn07CA6M=;
 b=q19wdaw+OX37VhOwNndHMExERuvR9qLEpzxV/l1gPmjL4i5mSzTojOrscwUjKdTP4x
 8J51H8fiHc5T2bqvqsP1X7+V/4BQREGbfqs5LIYU+8fh9EqfhR4QqFdOnz+gn0fT/9ZG
 yD1SvJ/tBKP9FEKBSbgExIXc+3c7CAIEEDZxvwWLfLmr606tZ3trhv8bItvbZkswxzQu
 N0DaPGRSyHU+9to7YI07R0ApXaj4hYqfUkuTpiVGpikuttEidl8eISm7J3veI00nNkTM
 JbEFz9s3ysC5RAFq0+xBbK/vFfQIRiGe8Di7ER0U00bcVYoLPQ5avZW4qOR55pl4XiJp
 GQVA==
X-Gm-Message-State: AOJu0YzVRqDRzfBmJj6voVxvadIc/15TlBwuMywoyNx1zDpMvscuPfz7
 V4OvmQfVYrt5EAFedWdLwD2Vql2ygx6dfFmPSiQ=
X-Google-Smtp-Source: AGHT+IGVASDKLNSYjPWwKmuNKMTxNMa8SU9ms3dDVVxUHAphqLSF0S5/l+whwpmRTK0MOFUu+0hnAQ==
X-Received: by 2002:a17:902:e5c2:b0:1cc:3fc9:7d09 with SMTP id
 u2-20020a170902e5c200b001cc3fc97d09mr13459790plf.15.1698901053891; 
 Wed, 01 Nov 2023 21:57:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jw13-20020a170903278d00b001b03f208323sm2100805plb.64.2023.11.01.21.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 21:57:33 -0700 (PDT)
Message-ID: <4579e4ce-ad21-4901-9ecd-8ef6eace2616@linaro.org>
Date: Wed, 1 Nov 2023 21:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-27-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-27-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 11/1/23 17:24, Gavin Shan wrote:
> QEMU will be terminated if the specified CPU type isn't supported
> in machine_run_board_init(). The list of supported CPU type names
> is tracked by mc->valid_cpu_types.
> 
> The error handling can be used to propagate error messages, to be
> consistent how the errors are handled for other situations in the
> same function.
> 
> No functional change intended.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 50edaab737..1c17a0d5bf 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1393,6 +1393,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    Error *local_err = NULL;


This...

>   
>       /* This checkpoint is required by replay to separate prior clock
>          reading from the other reads, because timer polling functions query
> @@ -1465,15 +1466,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>   
>           if (!machine_class->valid_cpu_types[i]) {
>               /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> -                         machine_class->valid_cpu_types[0]);
> +            error_setg(&local_err, "Invalid CPU type: %s", machine->cpu_type);

... could go in this block.

Though I don't see why you can't write to errp directly?


r~

