Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7E7C9C9C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 01:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsAqG-0005nk-E9; Sun, 15 Oct 2023 19:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsAqB-0005k1-RO
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 19:48:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsAq9-0000e9-Cg
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 19:48:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso1472275ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413685; x=1698018485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYEjY7K5/vYv4HdUSQlfGuxtW2ilRfesVR+kLR4/oMM=;
 b=wpb9O4O0ZXkwEX5OkvA0hwPi8r7G3GGpArKbNMo6DzHpQ9ZcpYuerfykgZWfHxqgOD
 jfpMoRd7PGiKmIuY7LiIRk5doH+dmGG5KMsHrmxki+9+LLohqdoUQqRfwhq1D+SRS41m
 SLfxUcAqmo/I+N0U1tZj7GAg4oegOJbnKN1LHRCDpzztQTGFZjfXv5vJM0vDnKYpgQ7k
 3n4yaHIeFxoCTiZHzwcMCpKlz9vd/zTbL3CC7Rzh62uq/AeYdl9bukbuW3SJ1Y8zg6p+
 jwptpHY/8D3/pAfxgpV0ocree1RDd/o9Ew6+TM3F1/Mhji8kRihFZWQOlYX/NTkFNs5f
 ePqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413685; x=1698018485;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYEjY7K5/vYv4HdUSQlfGuxtW2ilRfesVR+kLR4/oMM=;
 b=Mx/fG7aUB9PSu6GUwzDiKh8iwNh+RcgunR2m1NXDesmmdI2gPbxKwFBbhmVlpCf7Fc
 sk13RUrZm54ZBs1/1WCnpbMR36rZ/tgEGUx/w0tZwz092FaJZlKWaMEy4LUR7HeS0EDC
 5CK0UI2uSocihrcgSWzWmwiAktaq1Q6imXESNwlAdk0g/M8+iKOzgi9Bj/tpAr/tvOs7
 HzkI7JNN2v6t239TLcAPlLKqtovNmHfXc5S6yoj5wlPs4MTfMAEhEwwbHQu6UtPhYUYa
 7/fcoF/pRnEAHHxFQ6CxdkE1OKjagqzrarHgJryIF+gXkVON/4gFY1Kn0fMaL6emBG3t
 /uSg==
X-Gm-Message-State: AOJu0YzJIPhJTZi4ZCnvwMqD2w6xLY40p3ZysUKjEbTe6Of53HjWOiRr
 1w2R9TCGhFGAGG/Jb4G5H0+xJLvVf8hU5+p9v4w=
X-Google-Smtp-Source: AGHT+IFNOQpOfIBkkcMZES6w5is7Tc7ZhjdbbrhvJV0u+Vsb5K1S2KziRoe3FDXsgz0wgmMy7kxpZg==
X-Received: by 2002:a17:902:f54b:b0:1c0:9d6f:9d28 with SMTP id
 h11-20020a170902f54b00b001c09d6f9d28mr31062786plf.11.1697413684814; 
 Sun, 15 Oct 2023 16:48:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a1709026b4b00b001c613091aeasm7193101plt.297.2023.10.15.16.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 16:48:04 -0700 (PDT)
Message-ID: <c7db8b9b-328d-47ab-b14e-53a1c1bed133@linaro.org>
Date: Sun, 15 Oct 2023 16:48:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/tricore: Add read and write semihosting calls
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20231015205913.264782-1-kbastian@mail.uni-paderborn.de>
 <20231015205913.264782-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231015205913.264782-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/15/23 13:59, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/tricore-semi.c | 52 +++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/target/tricore/tricore-semi.c b/target/tricore/tricore-semi.c
> index 27e1bdc59d..ccbeae4bc0 100644
> --- a/target/tricore/tricore-semi.c
> +++ b/target/tricore/tricore-semi.c
> @@ -164,6 +164,52 @@ static void tricore_vio_set_result(CPUTriCoreState *env, int retval,
>       env->gpr_d[12] = tricore_vio_errno_h2g(host_errno);
>   }
>   
> +static void tricore_vio_readwrite(CPUTriCoreState *env, bool is_write)
> +{
> +    CPUState *cs = env_cpu(env);
> +    hwaddr paddr, sz;
> +    uint32_t page_left, io_sz, vaddr;
> +    size_t count;
> +    ssize_t ret = 0;
> +
> +    int fd = env->gpr_d[4];
> +    vaddr  = env->gpr_a[4];
> +    count = env->gpr_d[5];
> +
> +    while (count > 0) {
> +        paddr = cpu_get_phys_page_debug(cs, vaddr);
> +        page_left = TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
> +        io_sz = page_left < count ? page_left : count;
> +        sz = io_sz;
> +        void *buf = cpu_physical_memory_map(paddr, &sz, true);
> +
> +        if (buf) {
> +            vaddr += io_sz;
> +            count -= io_sz;
> +            ret = is_write ?
> +                write(fd, buf, io_sz) :
> +                read(fd, buf, io_sz);

You should be able to use "semihosting/syscalls.h".
Compare m68k-semi.c.


r~

