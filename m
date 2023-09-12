Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2379B90B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqxm-0006fw-It; Mon, 11 Sep 2023 20:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqxi-0006f8-4i
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:09:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqxX-0003xr-Ok
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:09:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so4424547b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694477330; x=1695082130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mdAbQVk3u6dHUgpW/VGu3f1FA+J0QHIdcy6TGoXHp5w=;
 b=GvM0Is1xjB8tKsVs2PLfa4N8SZgClnCP8/F8DNUtGDDazdbWLOy3TyMbUdbhMCt2Q+
 /M9vl1SNQxr2GOwCE5RNXYg7Sn9lJAbHdfgOwYVfsQ0ditkvPIw4ppnv2+pJxZhWTNda
 MLH+XJ2+5zOmg/VmY+OPdajrPore0dvi3ndyFr/hjZx6vjRqnm/50HfvU2JyM0GNtWz2
 pLgmZqkHqBOjq+o9A9VpKFjoqmJi8ga+ZugdZGzrfrmUo6aTnUS9SkvfQu3yQY7Gar6Z
 Jqi3v4jGJjtJqmexD6RxBG/8swJjlqMTF31Bm6i0JoBeNRxntoKR75y1VoFou+U4uPu0
 htuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694477330; x=1695082130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mdAbQVk3u6dHUgpW/VGu3f1FA+J0QHIdcy6TGoXHp5w=;
 b=aJYsYov+P8KqR5i5fETzmY9imfaPAa/TKfOzsQFSlUvxxkz+MKeV8X3LfFceso98pa
 fT7MIcFQn+g7H1ZXLJxWCX0+NIbb7xa5kwxH7LxOoDlIFB6EQBeaKUf1lXG09dxLo0UY
 ktHSlgaY6a86oNMDNI2It9DPNa2iAANKQU2kNZ3ju5AtG+NuO6cYM7ZFOlfZaP4AarcW
 92nZ4n9R+jsM0Qhx9a9KJfEGmJ7ercePy3uiobjw310SqLuJDrOMcGygdSPLt4CzgT/L
 V2Gwdt3ViwhP9RBIcqU32XB5J733gm9m5XkmF87nsatjmX0xxz3UIe+jSFSfbpvzl8Bs
 eShw==
X-Gm-Message-State: AOJu0YwLOjlSQDXb5g9zd8qXPOvOartyJNAT0VvytrOwDFvqplEE60O+
 +yCa5IjHMG8VBIT3uFgrOMLfVw==
X-Google-Smtp-Source: AGHT+IGL7cUiL63rDwMwfoNyyuggoLtTTAVCpz8r1rP/6JeI+c/CPbU57dH/vr9mJVVLxGN+TMjo2Q==
X-Received: by 2002:a05:6a20:1448:b0:14c:f16a:2b78 with SMTP id
 a8-20020a056a20144800b0014cf16a2b78mr13392428pzi.45.1694477330174; 
 Mon, 11 Sep 2023 17:08:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c3-20020aa78803000000b00686bef8e55csm6143220pfo.39.2023.09.11.17.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:08:49 -0700 (PDT)
Message-ID: <0bdcfe70-58ac-4ed0-4f75-33d30653a9c2@linaro.org>
Date: Mon, 11 Sep 2023 17:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-23-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-23-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/9/23 12:37, Karim Taha wrote:
> +static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
> +{
> +    int i;
> +
> +    for (i = 0; i < N_BSD_SHM_REGIONS; ++i) {
> +        if (bsd_shm_regions[i].start == shmaddr) {
> +            bsd_shm_regions[i].start = 0;
> +            page_set_flags(shmaddr,
> +                shmaddr + bsd_shm_regions[i].size, 0);
> +            break;
> +        }
> +    }
> +
> +    return get_errno(shmdt(g2h_untagged(shmaddr)));
> +}

On success, this needs to mmap_reserve the region for reserved_va.


r~

