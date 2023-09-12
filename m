Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70B79D8E1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8Mb-0000Fe-Al; Tue, 12 Sep 2023 14:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8MZ-0000FF-En
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:43:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8MX-0004SU-8G
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:43:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fdcc37827so109017b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694544228; x=1695149028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T020SFV1r5pnx2Y8EBEIr/930/3kMf/sIb7O/9786rc=;
 b=kxeQNDecFTX50Iyti1Bk1QkkZX9YOwuKoG/E4/5FkQ3goexs+HiKcukxZXGbswjL76
 UjRjv+vZhIdPalH2ey1Cgq+1M5R1m/4JxaQlYgba6YFbl2X6EyLQQJmdCPzK1tOTEtLj
 fuLuDZvOxCztRECx7sqJgmu/BYjtH/LlVP+C2OlWhrYGQEN3syItczLWKyYbihtiQyZw
 Budw5BlGxE71IShhRDB/Up1rMMRZKV9C98XdGb3Bgg3VLXVOkfvJnJNKIFcy8R9jgV4s
 U04k2U7MHgEl3NY8we1G3PuBXZGEMvaj3bBRNp+z6GvCN8iHECG2PvVUe8BcWJcwzjdt
 iv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694544228; x=1695149028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T020SFV1r5pnx2Y8EBEIr/930/3kMf/sIb7O/9786rc=;
 b=jF9hpYPTNccgEjqmYMUzBix9N5DltH7HKdBRpKBP34XbmpPPAt4JXafn+dlBkvjDHm
 1cGg8GV12nQZVbDgBaS2MpwemnF+oPsrKZGnqHEWXwlO09/62LpwRtM+IAmsKNON85Tf
 Pmbjj/Yew0szvv79aZK+s3ZrYKXZlyTK9O6l5J6S7m79E8mUKGn+vETWIS5kMJN4eo7O
 tuJ2ZPg9HYTKyObW4XsWtkb1j6F5BZlB/lrX7VoDIS8s0zGOmrVopgls0AzUrYKJQsGG
 /C4QwyhpsDvM2PoxFWM5uBsJmBlhnL8y/IP6G3bhM0vS814oMmq8tGgmFVdgHkyWzZfk
 RG4g==
X-Gm-Message-State: AOJu0YyVeQCtwTc84YLCUEVWOACZ8iAtCMWZoDGYeJ1+w8CMBzX0cgss
 OdQjXQFLklYLSWXUmmMwQwiX/gWlH8kluGNyGxs=
X-Google-Smtp-Source: AGHT+IF2BWQFFlYRbdu0gjB7GrxPZG6ioCRjcPgNftOhZFegZN0URXJg3cAfV9N13b+VU8e7MKIp1Q==
X-Received: by 2002:a05:6a21:9988:b0:13e:90aa:8c8b with SMTP id
 ve8-20020a056a21998800b0013e90aa8c8bmr624640pzb.4.1694544227864; 
 Tue, 12 Sep 2023 11:43:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a656459000000b00573db18bca2sm6667537pgv.33.2023.09.12.11.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 11:43:47 -0700 (PDT)
Message-ID: <c0049873-fb1c-571d-baf7-ff53b34c2f23@linaro.org>
Date: Tue, 12 Sep 2023 11:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/11] include: Introduce tlb_ptr field to CPUState
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-3-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912153428.17816-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/12/23 08:34, Anton Johansson wrote:
>       IcountDecr *icount_decr_ptr;
> +    struct CPUTLB *tlb_ptr;

These are both in CPUNegativeOffsetState.
We might as well use that pointer instead.


r~

