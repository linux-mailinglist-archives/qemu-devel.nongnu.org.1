Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6D7B56CB
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnL0v-0003D2-2a; Mon, 02 Oct 2023 11:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL0s-0003Cm-Js; Mon, 02 Oct 2023 11:39:14 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnL0r-00039B-51; Mon, 02 Oct 2023 11:39:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-578d0d94986so12187485a12.2; 
 Mon, 02 Oct 2023 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261151; x=1696865951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BmTQpU6VpGtnvhhNosAcWdPaUQvNkJKoESNX+bRhR1k=;
 b=GuvoRXnwHXWr8evlEYjR8n6zIHfR6dpYZtgpnyKcbk6WrCLFgmrkHKBoCd8d3kCgEE
 mYd2T7vH5ks3zSMmxsAMXksgKKY57aIe/lz6RG1b5dBYXyS97DKFCedIFGPQqV34fiHx
 gzbqj1+x+xubAGp3FgOHNDGdYmTl5UhRWqnZPqsoM9lR+HNgRQsmKJfjKqIW8B7lIqCW
 5srblwixYurvmTAqFEj9WQD+2MUAcv/c7ef+wHeMq9uVeUVtRNnas2o8QFfb8G6RdnfD
 Ngl3J6DkoZWMJvY3qhsriyWVY/8E9WMDvmUYFWwvmYSRmT7IVCRhXFTdHwcoIwuz6pKS
 hblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261151; x=1696865951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BmTQpU6VpGtnvhhNosAcWdPaUQvNkJKoESNX+bRhR1k=;
 b=kZzzcK+rHYaiTy868NbT3K69b+8vmdasV0WWM+0tHPQCKYmws0NfedHhoxZBfO8wHW
 7s7LcK/IZ6LzMqa9oL5ColJ5WjGorPwK89qXoiANhTDaWo4qz3xxVXuzBoUx0KNISl0B
 re+BZb5ZhgO9CGdUQnbasJV7hMQcSxLW5J9+VfGkgs28McFqVfjwo+jNqSHKjyKH/HlS
 8nXE57EPNR2ikONjl9w7hS69raKOhuBAKenFZ8CIcpbQcHWlv7z+TQ0vEs+JUwkIPNJ2
 9BFtkbBL1tg+yiWvD/QDhb8TFekb9f+HlqDk48BfBSs2qB0fuQ5gklh7tkoTNQkbWdP+
 UWog==
X-Gm-Message-State: AOJu0YzeG2f7ggn420hvIGQnPrlXiXXvxHFduoDiiwqmbP2H4EzS5Dw6
 bxG5mAO/JGlc+Nj1ZSjsyps=
X-Google-Smtp-Source: AGHT+IFRvZTuhhpR9oq0S+lApp1UYB5qMRJW3rTElkbi3tV/0CL2lIfxp8eys6GQ7ndVMTJgEsVCVg==
X-Received: by 2002:a05:6a21:3388:b0:14c:3218:c1bd with SMTP id
 yy8-20020a056a21338800b0014c3218c1bdmr16091577pzb.11.1696261151350; 
 Mon, 02 Oct 2023 08:39:11 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 ff10-20020a056a002f4a00b0068a0c403636sm4414439pfb.192.2023.10.02.08.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:39:11 -0700 (PDT)
Message-ID: <1f2e6825-6691-48b4-2623-77e4511c7052@gmail.com>
Date: Mon, 2 Oct 2023 12:39:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/8] MAINTAINERS: Adjust file list for PPC 4xx CPUs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-4-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=danielhb413@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f90264203cc..2bf7af9bd150 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1960,7 +1960,9 @@ F: docs/specs/acpi_hest_ghes.rst
>   ppc4xx
>   L: qemu-ppc@nongnu.org
>   S: Orphan
> -F: hw/ppc/ppc4*.c
> +F: hw/ppc/ppc4xx*.c
> +F: hw/ppc/ppc440_uc.c
> +F: hw/ppc/ppc440.h
>   F: hw/i2c/ppc4xx_i2c.c
>   F: include/hw/ppc/ppc4xx.h
>   F: include/hw/i2c/ppc4xx_i2c.h

