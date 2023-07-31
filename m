Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD5769AA0
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUd5-0002nW-B7; Mon, 31 Jul 2023 11:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUd2-0002n2-EN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:16:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUcx-0003IV-MC
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:16:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso3257503b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690816565; x=1691421365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZa2g5LcB9ShxVAbbKF2yjP62FnZCjkpuV9gQxAh/mc=;
 b=XdOFesFcnBlIuUaMgU36lcCGL/l8byeL3yk3tDluIKVZN+cnvCU5FBwfBONP/uO8A0
 jqTbxbvVIWYiQDpJqJptuFIVPEx46ouav0PgzgPlQNFZOwiqzCgz0z+9ha4Mm2WuoLOG
 bVuXpgsd9M3OnfqDjJAZfP/Cla41NM7L+0lsHfcERQwW4SXvOPV2RewWXMOOqD7f7LeL
 U2uOV07QwvAANAHBDZWRW6+iyy7d/6Zu2nfb1BK1RFnSg49iyNq4WkMc2oso36ua7u7R
 7KTyc8/ROeBN1C+IqREKfJaMNT+Th61oiN+MY3tXlmsX2RbnGVRvKxTdQZWhxIb0yJG2
 bpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690816565; x=1691421365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZa2g5LcB9ShxVAbbKF2yjP62FnZCjkpuV9gQxAh/mc=;
 b=EEJuJ9hy40BtU9RlHch7AobkKU5GkHT3+x2ogjuTdP4RqoSd/Yxowj3Rr34pZsNl0+
 kXW1KtDLlIg4zsrGyUoavykhJ/Vlj5x68fK5NqnLmls9jiYotDOyZN0J72QWwHPsrd9P
 sWeHjpblNX6OQRlxdC+cVpn0+MrkLb64XUfeIpf2nS/rWxMy6x2JuG7Y0uA5Z8BrTH+L
 qco+AMP8H6eEEtNJU8wkOtrZotWfkuSZiHFROB1bmxpkaXESOKbp/0WPypu7aRuipKCW
 REoCpBF4dP5H7jggL30ZX485yjsq0agfnvJfTAJcR6o9BesKgWeVApxK6e8EtmkGOXiZ
 y65w==
X-Gm-Message-State: ABy/qLaGV6ax7znS7KbFt7gvdweFa7a71Uu/Wy9OPxf2JyZqGNs6jEkf
 eoR31eOfPWoW+7Ye9AtUjYYTRg==
X-Google-Smtp-Source: APBJJlE2dT0HVcfhwMadgorMNBdeRrk0jh7WixlDy4FWv1zW0HjkwRH6e7e4wMi+KvU6YCbHPmTntA==
X-Received: by 2002:a05:6a00:1991:b0:66a:4a45:e017 with SMTP id
 d17-20020a056a00199100b0066a4a45e017mr11972987pfl.20.1690816564722; 
 Mon, 31 Jul 2023 08:16:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 m3-20020aa78a03000000b00686e8b00a50sm5998569pfa.104.2023.07.31.08.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 08:16:04 -0700 (PDT)
Message-ID: <db4d8cd1-a214-5991-0169-a66147816f72@linaro.org>
Date: Mon, 31 Jul 2023 08:16:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/riscv: Use existing lookup tables for MixColumns
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Zewen Ye <lustrew@foxmail.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
References: <20230731084043.1791984-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230731084043.1791984-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 01:40, Ard Biesheuvel wrote:
> The AES MixColumns and InvMixColumns operations are relatively
> expensive 4x4 matrix multiplications in GF(2^8), which is why C
> implementations usually rely on precomputed lookup tables rather than
> performing the calculations on demand.
> 
> Given that we already carry those tables in QEMU, we can just grab the
> right value in the implementation of the RISC-V AES32 instructions. Note
> that the tables in question are permuted according to the respective
> Sbox, so we can omit the Sbox lookup as well in this case.
> 
> Cc: Richard Henderson<richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé<philmd@linaro.org>
> Cc: Zewen Ye<lustrew@foxmail.com>
> Cc: Weiwei Li<liweiwei@iscas.ac.cn>
> Cc: Junqiang Wang<wangjunqiang@iscas.ac.cn>
> Signed-off-by: Ard Biesheuvel<ardb@kernel.org>
> ---
> v2:
> - ignore host endianness and use be32_to_cpu() unconditionally

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

