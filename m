Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E373F46F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE25c-00083e-PE; Tue, 27 Jun 2023 02:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE25a-00082t-6Y
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:22:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE25Y-0000kA-G6
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:22:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f9c88ac077so51702655e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687846926; x=1690438926;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5baFru8hDaVf14yxIvziq3JRQtQ9EubbkKBzQa2r4Rg=;
 b=avSPum5JMFLKwgRRACYzXMB+HB4FJE04XZ/kTA65VCBit2UlfbkeyKCPol9ffQa59G
 mqXpCQAaYD44AcY8v+uhV4dnJEuNiKhApft3aD/jpOaOFCORb7oZgGQoI6qVY9y6J66V
 4YX+BLd+7S3NiWPq97QjGoNgoouFSHxwV8s05IxjBJxenA05Pl/F0TZPMaHDIELSBRE8
 6fuwnOgBPC1W0BuxKDpvK8/Tl9CTng8C5hyBJhKbUjdNqNJKnpsQK9dj+A3LDgUOlZlV
 xfituZcm5Ps1lOyHBrEjUbIF0rqMQZW4KCRgdi2942K+CTdih7yQcrCqSloMPFyEmtJu
 LfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687846926; x=1690438926;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5baFru8hDaVf14yxIvziq3JRQtQ9EubbkKBzQa2r4Rg=;
 b=OHUut6ffL423/oCmKrdxXjx7ePxRUoaVowci8cBfxsIwYyHnamRcvE04cgB83pyPN+
 I20ta6CJIsS+c8k3bFw543A05pWRi6o3LMa9/RhAFzbtwIJBbBAQOciAjFoy9gQwQVGG
 7QP2FuLt4DyIDhUToPiTbBNKzmR0JWmRrzkbkHqmpDc+PQ5g/k8D68qOYLrJ9hhLlUvt
 cf8NiIdkOuU52OjTT/V3p++BPgWcwF/yv/Zk3+6/CZ7NVNZRy2pXAnY+L6oIXkseF/vi
 TlPGiiHWgwcti1sKMVT/WLWoQWY1y3QBbbO02ofZSrH3ZmZHumnhn67+o2EI/eX4iR8o
 W/bw==
X-Gm-Message-State: AC+VfDzHo/YDS8NBgxAoy7wTIZYlaSOK/FFe1aAIN1YKUJ8v4A3k5KTs
 l1sOGZb8HlCUZptZQRBNk5h1yg==
X-Google-Smtp-Source: ACHHUZ7cYGP2dO1jCgUqqK5tK2LHOgaAaddzPRvEzmmme02g6X1aXflb1ZPyfVMVdgT8Ym1c6Y9Z+g==
X-Received: by 2002:a1c:740e:0:b0:3fa:98c3:7db6 with SMTP id
 p14-20020a1c740e000000b003fa98c37db6mr3342191wmc.38.1687846926422; 
 Mon, 26 Jun 2023 23:22:06 -0700 (PDT)
Received: from [192.168.157.227] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a05600c0b5000b003fba6709c68sm473192wmr.47.2023.06.26.23.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 23:22:06 -0700 (PDT)
Message-ID: <acb6fd1e-8bd6-2152-ec70-a5996d3cfb41@linaro.org>
Date: Tue, 27 Jun 2023 08:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: which CPUs should call aarch64_add_{sve, pauth,
 sme}_properties() ?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-TNaJzMPGCMEN-erSc1bQ4myq6SyiRDHY7_7fKLdqyQg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-TNaJzMPGCMEN-erSc1bQ4myq6SyiRDHY7_7fKLdqyQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/26/23 18:54, Peter Maydell wrote:
> At the moment:
>   * aarch64_a64fx_initfn() calls aarch64_add_sve_properties()
>   * aarch64_max_tcg_initfn() calls all of
>     aarch64_add_pauth_properties(), aarch64_add_sve_properties(),
>     aarch64_add_sme_properties()
> 
> and it happens that (ignoring 'max') we only have a64fx implementing SVE
> and no CPUs implementing Pauth or SME yet.
> 
> Is the idea that all CPUs (both ones trying to match real hardware
> and ones which are QEMU-specific like 'max') should call these
> functions to set up the properties if they exist? Or is the idea
> that 'max' is special and match-real-hardware CPUs don't need the
> user-facing configurability?

Set up properties if they exist was the idea, I think.

> If the former, maybe it would be better to put these in
> arm_cpu_post_init() so they're automatically called if the CPU
> specific initfn set the ID register value that indicates the
> presence of pauth/sve/sme.

I thought there was some weirdness with kvm and -cpu host.

> I ask because Neoverse-V1 has both SVE and Pauth, and I'm not
> sure if its init fn should be calling these functions.

I would say so.


r~


