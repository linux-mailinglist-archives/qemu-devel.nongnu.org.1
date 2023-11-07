Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C587E4632
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:39:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0P5O-0007EP-TX; Tue, 07 Nov 2023 11:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0P51-0007Dq-Mr
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:37:31 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0P41-00015p-5A
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 11:37:31 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso190599066b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 08:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699374987; x=1699979787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKIIiU5w+MRAAZQ/pV4NWcinTgJ93jPHmJQB+a9jmcE=;
 b=L9r4GsuuK41thcA4I6iMyD1Pg/32yaA/n72SqGVebpXGRYZH5hMxAu+twjs2/4M7bW
 tj/AmuQMRZtsM9mGAhbEeGj4w1P2AT/3CdBsfB00+S6LC9CBw2uZuOR+pNaDoWM1cjnE
 Jm9A7lEBONd1uM1fibEFwLNDSp8uyWUPWwJNtgoeEOPPTTtu4lPzSbeWXMP/RPD106is
 1+sU1Tll9RbmPNxkKAvxxHgnEz52a0VE0gVjJmV/HnzgeREPISkNoXZe5zOKgbshDQ+n
 pd2rd3Xi6AznhUR5tl1mXVwyJL37E3KeVVDciE6YLntMOSk1QIN8vf5yWvyB2uDsy/ua
 GUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699374987; x=1699979787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKIIiU5w+MRAAZQ/pV4NWcinTgJ93jPHmJQB+a9jmcE=;
 b=g+rGczAHxoMdhpEUq+846juJvrz9NLOT4Gz60dMkTN3iAhSIgPBm2SRWIqs7bFz2fZ
 64ZFUrP1sn+IyrxiFhoWPA2SzXQnYq03fg1l4IXMBkO2TA8NHCRVX4xojQG5RmzQvQxe
 OinFN+vWfgd9SZV3OXomv1bEpuk13KSCtWxkL42uSn7TMrFSOJD1cC5CR8ZpSPfHlMLF
 hOAoIyZkN/CaTbuihjgD3UoXR+YGHFZ3cAH+KSOr82Z8qKX9FBk4n3QiooEmGpn6+4/k
 Ax5vCtL36HyUFMH87rhD3vDSUAUMsa2RO1ocAJhhrGOjOhwpLIw9U2GWi7XVOU0kPB8Y
 XzOg==
X-Gm-Message-State: AOJu0Yz/uHZmeJuqHxb6p8ISvpbxmq4z7TBxHJCWcCS5dNUXng/niV6c
 WheOTY0YT8XftnQzr7C/yM1Azg/y4xz55mEaWE0=
X-Google-Smtp-Source: AGHT+IFOfx9V+xrPPDIwpIDSO90bH73OjOtAw5DCSE1TAitoY9cMm6aRLv1UwPrB6WBZS5uInzRNQg==
X-Received: by 2002:a17:907:7e84:b0:9dd:cc3d:7ba7 with SMTP id
 qb4-20020a1709077e8400b009ddcc3d7ba7mr9323454ejc.29.1699374987489; 
 Tue, 07 Nov 2023 08:36:27 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a170906504e00b00992b2c55c67sm1223733ejk.156.2023.11.07.08.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 08:36:27 -0800 (PST)
Message-ID: <e31dd548-b11d-47cb-a996-4473503b0aa7@linaro.org>
Date: Tue, 7 Nov 2023 17:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips: LOONGSON3V depends on UNIMP device
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231107140615.3034763-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107140615.3034763-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 7/11/23 15:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Cc: qemu-stable@nongnu.org
Fixes: c76b409fef ("hw/mips: Add Loongson-3 machine support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 66ec536e06..505381a0bb 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -46,6 +46,7 @@ config LOONGSON3V
>       select PCI_EXPRESS_GENERIC_BRIDGE
>       select MSI_NONBROKEN
>       select FW_CFG_MIPS
> +    select UNIMP
>   
>   config MIPS_CPS
>       bool


