Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535147069BF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:24:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzH7q-0005GF-FL; Wed, 17 May 2023 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzH7o-0005G1-5i
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:23:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzH7m-00023I-Cs
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:23:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64384c6797eso580000b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684329805; x=1686921805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RF+64XcycpR5msXryKRl0Qf1ShQrSFqyBNCtrMkrpyk=;
 b=QFpYkTiPNgWbzUFQNI6Zg+CehCcmyDidF8c44lbE9buiW3+J2j4bf5PAZy0ISQoPbd
 RNzR7Pei8Vtk/c/Rx0bxBTQl3NdNodHf/D6h7R5rs9SG/DJJWnRY6OjEPmnLWMOWfuZb
 bBphy8uhQaKwCrF3jxOjaiOi8N345x3TbZTqch9e42dYol7adabu3/NbrJ41AN5y4QpS
 xmcRC7T3yb7chSc41Sa/XRQ4dxjAv73+2fJuvXIYz4c5aSyDZYHFDag9fcW8ZH0S5vS7
 n7Y+KLnNDutYrDnHvOSGUocgeyLlKE5+5UGyDk8tzR2QM+A/1HpHJ3yzpW8v9kE9Sr2V
 4l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684329805; x=1686921805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RF+64XcycpR5msXryKRl0Qf1ShQrSFqyBNCtrMkrpyk=;
 b=Uf7XTj6fZ9f9JIT6s6DvylRKoVzAHaET8xKBv/EAKopIi7UxX/xnvHt7jj9CZekvuK
 20ctcT6rPWMbG589de/VOPFTQ5unJOQYEbhRE93qPDdmZiJ9CxjyYQaVuCdfVjMoU3Yo
 I04ronXf6vf0F9E+eWoLK6bZ2u4T6pO9Gl4XssUUEAOCBaXjLIUkMz2ukfYCMGR69IJN
 /92KnRigCUjiNUxWH/tGu+9I4Nwi9SXL5z1wl2dk5IVl44jn3+CtQKahbCbWLsePCQo8
 OUa7CIFXilVa91SvBkJ+kBjuij9kCzxlIDGyTpFWRVhJ87RoO7jn0pivJUL5wRnC5WE2
 6QHA==
X-Gm-Message-State: AC+VfDyxjJC+nEOMg8DnK7NdpfyOzxSnQkbseK16A/ZBIdJp48IkUb9d
 lg6XCKWPKv+VmE6DWWR3ewHPGg==
X-Google-Smtp-Source: ACHHUZ5T7CF/KJGl8DIQnLdjLa8Cv+t9zfnzHFRFMx9JXcxmiJQgXilzRGHpfd4ti4kfH0ArGQdbPA==
X-Received: by 2002:a17:902:d488:b0:1aa:e5cd:6478 with SMTP id
 c8-20020a170902d48800b001aae5cd6478mr55100628plg.58.1684329804952; 
 Wed, 17 May 2023 06:23:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 q68-20020a17090a1b4a00b002310ed024adsm118654pjq.12.2023.05.17.06.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 06:23:24 -0700 (PDT)
Message-ID: <5804cff8-472f-3ddb-eb4f-d6fe2566de57@linaro.org>
Date: Wed, 17 May 2023 06:23:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] softmmu: Move ioport.c into the target-independent
 source set
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Burton <mburton@qti.qualcomm.com>
References: <20230517074222.766683-1-thuth@redhat.com>
 <20230517074222.766683-3-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517074222.766683-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 00:42, Thomas Huth wrote:
> Now that the st*_p and ld*_p functions can be used from common code,
> too, we can move ioport.c from specific_ss into softmmu_ss to avoid
> that we have to compile it multiple times.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   softmmu/ioport.c    | 2 +-
>   softmmu/meson.build | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

