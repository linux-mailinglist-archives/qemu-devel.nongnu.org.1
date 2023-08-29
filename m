Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891678D07C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nt-0001bE-CN; Tue, 29 Aug 2023 19:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5UQ-0006ba-T6
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:39:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5UO-0005xX-RQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:39:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so38864115ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341543; x=1693946343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mefxhg3de8Ui+6QrHOEkuNFlQ0y0f8qrPVaQrlJaXC0=;
 b=BRgPuWhKO3Zv8KSSKiqOKAxAaBv7zEq/tEIg3I/1++2bdkmTgKjByVuLGs1vjfxz0e
 agWSHC4attTY7274EuTW+mwZE8rkqL00nA5RF/roJaKhlQnM6acJId1qdRVL5qA5dG1D
 jo74heejHhuFku++oNfN+yWAbeDncrRIArisLr9Vv2XRkBE8/CCFFFQKGTLjRzaiN7bm
 Svk9YXgeED/16EcevQqh28Mnyf3ZcUROMVNYksMf5jmjakWTkO1sbfyOXr3fL2jpNfPe
 cUbkxH/stJXMtk3E9wABlHOFMpIrHZzcwF6dGnutSiY7OIFFYEmdKxvZHPg+8R7eBcAr
 M2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341543; x=1693946343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mefxhg3de8Ui+6QrHOEkuNFlQ0y0f8qrPVaQrlJaXC0=;
 b=J/+0XVo2FP6okU2WVCeNA2TaYHgbGaoJYyoNHgogZGnCPCsjd7FfYgk5x9DuhLi1jC
 RQte+4vz9f9Q2A/Av2VmzBleCg3Xn4zpBv+TXljMpkPYKI6kM8O/fVcFQ3iM71/u09+a
 q7FTRFF5z+eFQBofdYX/zCiw/K2LzGfDdHuSWIdfrcvWDEt8zDryoaqFIm6C6nCVdqjM
 P1ZJ8UgshsTyIkYy+YamLGD6mhXgJFup5UihljTE9Q2qbaNHLhqI/wHA22FME9pdZcvN
 UkelkETmApWePdNSmB0f8Jfjv9o/VoFcgy4JYNNxLtlGDENTJyiCg+pO8tY+J1IyJlFj
 ukOA==
X-Gm-Message-State: AOJu0Yxm8PRxjV969NITWVUjFwkshX6fPkqAYffS+i4gmGgmVefMT5wE
 lHkSzgoqG+PtIEf5OoEDdE9u3iua5Q3C1+7eLaw=
X-Google-Smtp-Source: AGHT+IFeywAsyNH40uxNyBvFfluiNqMXBcrpuQGZcHVviR4QmhpVg4VJFpDRzLt5D4F6QGOiOUbiHQ==
X-Received: by 2002:a17:902:ec8f:b0:1bc:8748:8bc0 with SMTP id
 x15-20020a170902ec8f00b001bc87488bc0mr267057plg.33.1693341543208; 
 Tue, 29 Aug 2023 13:39:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a17090311ca00b001bdcc3a09c3sm9765352plh.256.2023.08.29.13.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:39:02 -0700 (PDT)
Message-ID: <4f5dad24-8bc2-b292-8523-f32ccf630407@linaro.org>
Date: Tue, 29 Aug 2023 13:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 30/32] bsd-user: Implement fork(2) and vfork(2) system
 calls.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-31-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-31-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 34 ++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++++++
>   2 files changed, 42 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

