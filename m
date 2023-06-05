Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40126722655
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69e6-0003C1-4v; Mon, 05 Jun 2023 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69dn-0002su-VB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:49:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69dl-0005ph-51
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:48:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f739ec88b2so10778935e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969331; x=1688561331;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xCzWi+Gj+JdNiZSqe5gpwxMCEPTAIg0nGB1NGGvbR0=;
 b=wTMyg2L2h2HXcwmFk0+/FTtRB4Xw/MAeunNBBS90N73EsITyVkSsrBx1+PQvgtn2Qq
 D1XAhVTsuaXA15PNt3O+nMTAlBuXFg1CnxwMX4KBumegUC/ioSabV7haA13sVAZIdxAY
 IZ4QgPqCc3cTSvgHDhpw+FnyF0egQhRmDTiW+1RyKohVKRr7dmKTyXEjvuFMR6R8yGIP
 rROMqGm3QlVTA37L9Zb1ScogSao2gagRH0WOTR2XLqLtDky36r2SD8sQEZn6JNX7nWMb
 jjs1/6zZsNrIgYER3nz1AVYJwW5dFBV2zIDasG2G1p78ErPF4ZORbzvjfLrDcf8ChtJR
 T5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969331; x=1688561331;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xCzWi+Gj+JdNiZSqe5gpwxMCEPTAIg0nGB1NGGvbR0=;
 b=aoqY4dHMMXhvarEGceJc1lHWM/zvVSnLjFKSskrxaD8VVjojtH+S+4kSFJaNTTbECD
 ab9aBteXhFupCVdT/S5LaopCFM/bGKf8AO0Ugmi5b36k1BaDZkkjvmy7POrAmL2Rm1vP
 RjaspfCnKEhJigtjS8WSrxPTJuU9iME3gDPSdMfcK9iMsMXh2HdzTnZ/Mp4pnaqR0uCi
 vHdTGsoPbSWPTnWnlcpLBY41NKmmpUspV+MwUJnKew4cBllvyNzrscyYV+UFad5SI/nQ
 8eB1CH3VHNNZWpA96So9Qg14IWmFRt5Mt9AdhHNi9gFAFDRz7YXg+AT6OsEgNhNgy3dD
 Ym4A==
X-Gm-Message-State: AC+VfDzJefNU/MYJ1kKijFHI1/NEg73XEMP6uh0Jas23y/mUf7wVDi02
 GIgR9MFEQEUegEAge99lcvRjwA==
X-Google-Smtp-Source: ACHHUZ4+x81WJ6dTx78FEMdxUM+SDPtV2mQahdzPkdQQh3c4RPVrs4UBJoJ6dUuGRilBVKrdqtKXZQ==
X-Received: by 2002:a05:600c:b43:b0:3f4:2365:e5ac with SMTP id
 k3-20020a05600c0b4300b003f42365e5acmr6841170wmr.13.1685969331492; 
 Mon, 05 Jun 2023 05:48:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a5d594c000000b0030ae16132besm9676455wri.12.2023.06.05.05.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:48:51 -0700 (PDT)
Message-ID: <23bdb920-a3ca-db00-3356-1c8959e86a67@linaro.org>
Date: Mon, 5 Jun 2023 14:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 10/23] q800: reimplement mac-io region aliasing using
 IO memory region
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> The current use of aliased memory regions causes us 2 problems: firstly the
> output of "info qom-tree" is absolutely huge and difficult to read, and
> secondly we have already reached the internal limit for memory regions as
> adding any new memory region into the mac-io region causes QEMU to assert
> with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
> failed".
> 
> Implement the mac-io region aliasing using a single IO memory region that
> applies IO_SLICE_MASK representing the maximum size of the aliased region and
> then forwarding the access to the existing mac-io memory region using the
> address space API.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
>   include/hw/m68k/q800.h |   1 +
>   2 files changed, 82 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


