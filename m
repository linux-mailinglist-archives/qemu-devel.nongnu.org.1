Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C0777E78
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8hD-0000i9-Pk; Thu, 10 Aug 2023 12:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8hC-0000hF-88
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:39:34 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8hA-0008BF-BE
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:39:33 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a5ad21a1f9so848918b6e.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685571; x=1692290371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+qEUf2bE9Ofo8iC6ayOBn8T5gSl9BVt6+eDpkSHkk4=;
 b=ou4x8pRSX2z5LRoJ7uZe9uD1dM6BI6lqTtBBxwfcqB9KLY0/HJvc+Y2slMyhScuwOp
 1qb1WmOGjF1mCWzKUf6Ye74dDTOa0DJG6jc/RvePwC8gyVQurwImbf+awD1wv6Dg1TFp
 0LdvGb6qgpTjcVkX+LLr3oZlc99ant+++5a6J2qwTQceeHgzUVNrhzudP9OkcEkBG8pu
 DFkUx5EFLHNATFSMkP6n6fAhvV1t5gwq+6pa1/NqbNK5pn10SzekKiYaJ7f/pXsdW+kZ
 d/XIw5RsBmR7KYjNQK+0glmLNPCtT37Sec8iFn5bS7IIb4ndbwKN5iR0Y2vbwrUa9Quf
 B45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685571; x=1692290371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+qEUf2bE9Ofo8iC6ayOBn8T5gSl9BVt6+eDpkSHkk4=;
 b=g9TNth7L9ycCILPLxnzAVOJg/hCb+lNqNv1FHT5+Wz/EZUsD8ER4E3h/DjvOTjfra0
 kyJZUk1xNBUQ4sJROp3e8Z/GSE5RsoAFjc48/b8XZhQeLGdMcbtw1lU9Z6omCezEah30
 ViNfcLVXifyxFTnUUdOZdcfrXuf0ge1ird62xtHPt7CWbFFVL7xyznP49IrZqbjvATW6
 wkIblmpgdy6mTkb2hOi122iJH07gtC1kBTNr3VMUmK4bqGBOv8ZksNNL1AP5rVGOKAeo
 ZuF0J/UZRfatpujenwK3x5sLIcKpKYvxFUpRVxFqZBFt69nkWRYaVOgj4BNlyrivOP9h
 E9tA==
X-Gm-Message-State: AOJu0YyXHTmYPCdIzoxMi3ymYPXCHyMX0F0aekgtbfMLDY00qgL8X7uO
 hy8II/+TYvi+I0gl00TvIBu92g==
X-Google-Smtp-Source: AGHT+IHChpclTKNXV2tg/PpTZvFnR6pvMlHlu9i6rz8VVfnvWQ8qd6hmVohXBIKlZJ+IJ1O6X6ywgA==
X-Received: by 2002:a05:6808:180e:b0:3a1:dfa0:7e18 with SMTP id
 bh14-20020a056808180e00b003a1dfa07e18mr4294659oib.25.1691685571039; 
 Thu, 10 Aug 2023 09:39:31 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a637556000000b005655811848asm1552881pgn.43.2023.08.10.09.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 09:39:30 -0700 (PDT)
Message-ID: <a2d08489-46ef-4a10-3c7d-842801331e44@linaro.org>
Date: Thu, 10 Aug 2023 09:39:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/24] tcg: Introduce negsetcond opcodes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-2-richard.henderson@linaro.org>
 <CAFEAcA93xKE8xaYEwED2Wwj0-3QiOfnfN7Zgvf=KMYgO1tnz-Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA93xKE8xaYEwED2Wwj0-3QiOfnfN7Zgvf=KMYgO1tnz-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 8/10/23 09:12, Peter Maydell wrote:
>> +    ctx->s_mask = -1;
> 
> Do we not also need to set z_mask to something here (presumably -1)?
> (I'm not very familiar with the optimizer internals.)

It is set to -1 by default before folding all operations.


r~

