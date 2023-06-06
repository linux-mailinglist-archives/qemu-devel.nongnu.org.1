Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77346724AC2
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6azI-000217-5A; Tue, 06 Jun 2023 14:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6az7-0001zv-9k
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:00:51 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6az5-0005gM-2k
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:00:44 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5584f8ec30cso4748961eaf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686074438; x=1688666438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkmWsUeQ3NeqOOEXMdw17W1sbDyxMp7hfVxIgZmM+dU=;
 b=o3mwICIfLws+jcwDsNpfIxx92VjPaUb9/a5z/SHauUvHO67t6AiTqEb2wymWKEHgbI
 XXo/GidAR5Ve1stX4cQklkuWSz/VUWOC8JzROflwiew80+hqWx+0C9KFpl7PxrB6Ln4O
 l6bumFcuYj8QpkLigfkOA7YqvGgIORxKmLKgq1f8Z1G+3ozPHbAlV9XPdpoSZeO/r0FV
 H2i0vLgYSE2IIOo2NWtRDVzSmnXPYFrazuxFFNyglCFdjTpj+Eedzq3n5jelfdfElYaN
 7JzDE97R2mrg00hGl5zl8ae4mgicgzZ+5B8cd3THQ14wo2F4rXbhChYfPJ/6OOvlpdl5
 N4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686074438; x=1688666438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkmWsUeQ3NeqOOEXMdw17W1sbDyxMp7hfVxIgZmM+dU=;
 b=GD+KaUxYWo3E/AMyeSatULBi3YR3R3kNfqbmUFhJ89N5J0as5HKC9dXBHZeyyGc4Pr
 f84+1Eo/1L2GR+2l2n5BxG66U4lDjOMcfs+PyPCCvxyNkm/Dvm22zhsh3NN9/HOBezTM
 uH8OvaJR8ZKR4jyU2CIwIp1dPG/7DtAmb7R7YEKZSSIbjCSl1fg78ElPyZ8l4pD/H7LR
 UQc3mzb7uyfwfmLqRfff42/xq/XXd2DBXuUutk77aPYzY32CACe/2JDfN/sc+S/ZezOP
 PcmbMzO+uhxQjgLrhXQJ1bahmVTa6/ZWyhFCPDxKfeAvM1pnHjtIEHxPWfJMAYo7CdkJ
 hQYQ==
X-Gm-Message-State: AC+VfDw+94k8xhz+zjtSQl0KiyHEprVVKFNj2AzoNZPnpOfPPOESPEMV
 CCa11KB2Bs+RHhJpTZk2F+URAA==
X-Google-Smtp-Source: ACHHUZ5fww69VSyE1Z7z5sKWe2gU6haAEEnK87S3bMijOfh0NOXcPSM6//xY2wXNq4Wcm34iiTnJtw==
X-Received: by 2002:a05:6358:c114:b0:123:57ad:62b6 with SMTP id
 fh20-20020a056358c11400b0012357ad62b6mr595071rwb.0.1686074438110; 
 Tue, 06 Jun 2023 11:00:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a17090a154200b0025621aa4c6bsm10370844pja.25.2023.06.06.11.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 11:00:37 -0700 (PDT)
Message-ID: <2cf9b45b-c2aa-c83e-706a-e3e51601b793@linaro.org>
Date: Tue, 6 Jun 2023 11:00:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/8] linux-user: Emulate /proc/self/smaps
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606132743.1386003-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 06:27, Ilya Leoshkevich wrote:
> /proc/self/smaps is an extension of /proc/self/maps: it provides the
> same lines, plus additional information about each range.
> 
> GDB uses /proc/self/smaps when available, which means that
> generate-core-file tries it first before falling back to
> /proc/self/maps. This, in turn, causes it to dump the host mappings,
> since /proc/self/smaps is not emulated and is just passed through.
> 
> Fix by emulating /proc/self/smaps. Provide true values only for
> Size, KernelPageSize, MMUPageSize and VmFlags. Leave all other values
> at 0, which is a valid conservative estimate.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 57 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +            if (smaps) {
> +                show_smaps(fd, max - min);
> +                dprintf(fd, "VmFlags:%s%s%s%s%s%s%s%s\n",
> +                        (flags & PAGE_READ) ? " rd" : "",
> +                        (flags & PAGE_WRITE_ORG) ? " wr" : "",
> +                        (flags & PAGE_EXEC) ? " ex" : "",
> +                        e->is_priv ? "" : " sh",
> +                        (flags & PAGE_READ) ? " mr" : "",
> +                        (flags & PAGE_WRITE_ORG) ? " mw" : "",
> +                        (flags & PAGE_EXEC) ? " me" : "",
> +                        e->is_priv ? "" : " ms");
> +            }

There are a couple of AArch64 specific bits here, which we emulate.
But this is good enough for now.


r~

