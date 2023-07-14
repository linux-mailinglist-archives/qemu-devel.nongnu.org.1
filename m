Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF5753DA6
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 16:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKJuG-0008Hc-KS; Fri, 14 Jul 2023 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKJuE-0008GS-3T
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:36:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKJuB-0003eE-Ta
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:36:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so2080794f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689345382; x=1691937382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5MAFPP3CPQuhIrr7QhKlJDUPZdFH6UcsW420s6L+m8E=;
 b=u/jFLY58VAqAGu4CIz0ZqiFXwbDZyCAnivc9DuebFN5UJ7EnvlHTTJTKV6zYS44K/V
 NzooLgEesHturhvEGwRHTvfr++M/W1M39ILjxWC43ZMrPQLAMVkXY+zfohHBC6fNULwV
 VDEI/BCUQ7hOPhilh7BwvP/RFI6oUwKj078tanaZCNkdW6uITlVsiKCS6e4aopnpxZ+9
 bI9qp4ryH9oqSauW42hCI++kAM48QOoOL977vNcAUxFXbmSDpRO02f3YSUfB10iWdjWJ
 rZV2ZaLX99lJwnGii+KXdhsi+HAn+UZrYswswkRHd94p4aSlUbrlddkb518J+P61pYpy
 bEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689345382; x=1691937382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MAFPP3CPQuhIrr7QhKlJDUPZdFH6UcsW420s6L+m8E=;
 b=Fk7vL20R9iUOjhwmRSQQwcH1Qq6IKqVgzkI3kccS0NBkyVAS1Cr3QuNpiZ/v0echjJ
 Ij417hDqVI78pi/zr+DMqnH3sG1vvaJDzZNj9bSe8bQ+6DajDHrcsjJ9szRDXjF3Jree
 ekaFf2t6x6KgPMDJAQyYDMkw3UbOkaS+WFdcOmQm+RPQ6f/jll4VABTXA+rP578qAMYc
 BGr1fglePHI3LywmLPH5ml/UwxTw5+OdTJ12T0D/XkFdkK4sTkjqXA9iG2iEMskf8uyW
 4+iMnwTl3SQ4EBLYSkt+t/K7CEmZtvYPkFEzpqDEdlj/JHH8OOFVi0T1V3XSAKG/0xe/
 w9lA==
X-Gm-Message-State: ABy/qLZCPS3JPUteb2LWw08BhRZ0tP4hFjutOxrBhh4nN2jZA+4tUINs
 FZPBO+POObxcWybHC+dVdS5nCg==
X-Google-Smtp-Source: APBJJlGNv0EFG8cC1vQacm/yBAsq9453Sk9wUkQvxor8R75aiZpWrDGQwLn+GqSSN1rj2RC3T72BBQ==
X-Received: by 2002:a5d:400e:0:b0:313:f38f:1f4e with SMTP id
 n14-20020a5d400e000000b00313f38f1f4emr3928672wrp.27.1689345381909; 
 Fri, 14 Jul 2023 07:36:21 -0700 (PDT)
Received: from [172.16.245.178] ([194.158.78.244])
 by smtp.gmail.com with ESMTPSA id
 z13-20020adfe54d000000b003143ac73fd0sm11159546wrm.1.2023.07.14.07.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 07:36:21 -0700 (PDT)
Message-ID: <f124ff80-f864-bfc7-e4ab-5696a1886ef9@linaro.org>
Date: Fri, 14 Jul 2023 16:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20230714104903.284845-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230714104903.284845-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/7/23 12:49, Thomas Huth wrote:
> It's possible to compile QEMU without the USB devices (e.g. when using
> "--without-default-devices" as option for the "configure" script).
> To be still able to run the loongson3-virt machine in default mode with
> such a QEMU binary, we have to check here for the availability of the
> OHCI controller first before instantiating the USB devices.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3: Back to runtime detection, but more simple this time compared to v1
>       (checking for OHCI should be enough, since this implies CONFIG_USB
>        which is the switch that usb-kbd and usb-tablet are depending on)
> 
>   hw/mips/loongson3_virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued to mips-fixes, thanks!

