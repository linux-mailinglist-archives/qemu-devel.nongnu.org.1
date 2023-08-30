Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77378D7F0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPgO-0003zw-Lg; Wed, 30 Aug 2023 14:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPgK-0003zi-O9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:12:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPgH-00059B-Cr
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:12:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3e943762so5045599b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693419159; x=1694023959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kUhT8+FcDDjYE/xifINNt7RTAFK63Gb/pawP8S+o4aU=;
 b=iD51OOwFA+UvMDXduTgYsNqFXtwdRox1BeZaqfMBraMi9f43MzhEO9F3lzIFl6z9SQ
 6F8PFHGGtxiTMjrZj/EPuCctXuexchJj+i9pfHsM1PXHqoHiT4R641MIZGxLixq0r1Yc
 Aq81ztA7ZmdtAgU5kC1SSK8SDYx3zrYW8O2fIECRKtuXLaDda8QzGSSdQATy1bmHwjlz
 n11FInFjtST4Jof4nbMYFCENEtgICSzEpNys/Ej2g3Hy/2QCAzWBRjpZ5egcLP6bE5iL
 77ApfIy9UD3rN6efFcOAEIkOQi5sf7QSYoRdbThIbuWdwG6D/qrkVlO4niBY8CgulmYW
 illQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693419159; x=1694023959;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kUhT8+FcDDjYE/xifINNt7RTAFK63Gb/pawP8S+o4aU=;
 b=Y11/lKwioGb057zSfIkQrr7nZeffLWvQe6zONnsBhLu/inEalmb0Juycz4eq7Xe5gI
 y/BuklTFEJvhVR122fxFeEE1VyboefbgYC05+qjJBOthj8Ka7w+5283u2dOSxmGs1wPo
 uaBYOgY1EvyxUQgy3Y0kR0sTu8FAQFw8/VXDEymEWo5Jdua8EzxsxRYKkW9QweMbrY0Z
 6dv1GDdAG+557vNG2+Qb1oG0urDyHIeWwkvzzXsBxlZCwQwnlO57g+yaiadX1X0lWhup
 wqqO9UdaCF9extQ5hghdpG0rqZ41a2ThqFzwYnipJ8LZKbuSKOcH/IOdU/f4Rdx6PWNt
 k44g==
X-Gm-Message-State: AOJu0YwZkKVlCYsafU/0i8N6F2PDTNc3q2wGW4V31/JXXPys8EX/uaQs
 HaU/sUusAAIXpGn4k0GFIpYjDA==
X-Google-Smtp-Source: AGHT+IHmB4sABggBy4EcvdqShyefMglllWmDvTegz+9+2ldb76UryOg2iB/Y4HGJDFAy1yv/adhLAw==
X-Received: by 2002:a05:6a20:c901:b0:14c:def1:984c with SMTP id
 gx1-20020a056a20c90100b0014cdef1984cmr2950316pzb.19.1693419159496; 
 Wed, 30 Aug 2023 11:12:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a056a00198c00b0066a4e561beesm4207403pfl.173.2023.08.30.11.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 11:12:38 -0700 (PDT)
Message-ID: <93b90f31-d33d-2c37-0ab8-166d9c28bb6a@linaro.org>
Date: Wed, 30 Aug 2023 11:12:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 11/48] target/loongarch: Implement xvhaddw/xvhsubw
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-12-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> --- a/target/loongarch/vec.h
> +++ b/target/loongarch/vec.h
> @@ -47,4 +47,7 @@
>   #define Q(x)  Q[x]
>   #endif /* HOST_BIG_ENDIAN */
>   
> +#define DO_ADD(a, b)  (a + b)
> +#define DO_SUB(a, b)  (a - b)
> +

Why are these moved?


r~

