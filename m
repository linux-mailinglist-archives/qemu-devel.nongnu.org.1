Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6892776378
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkqy-000838-5u; Wed, 09 Aug 2023 11:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkqs-0007um-C5
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkqq-00086U-VT
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:11:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-26813cd7a8aso4882598a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691593915; x=1692198715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwgEZohiClVqY7sb5JjmpEu1lsClCbl8vTXWkINLb3U=;
 b=KFoP9orKDkGVehBk4oqIW5wJB/DNu/Z7CNTCQwaUO3Q2jtSXIqfL6FoLecCvhYn96+
 V1dGVEjLRWL3taKGFZ94PhlA60F7BNbH3CkMD02755yy5wwuK/oB7TDx2YMZdnWgD4HL
 fnZ2WNGtYJkzFtYKhje14yN1WLs5WOCFv4bIhCAaE+9m26ZqtLwoKOatoDTCtxclIQJ+
 d1AVwNVqNwApJzBTkrmtrepQLOp95oAtwykiAV/Zl98j/HYPwXfEG7tSP0MoHTWf27Bu
 +/lFYMFgG1nNLux+kfvf/MCbCCy6cbUDDb6WJGkkW7ZgNLJBoGyutSvQcF8Ulz0BA9fC
 Oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691593915; x=1692198715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwgEZohiClVqY7sb5JjmpEu1lsClCbl8vTXWkINLb3U=;
 b=RwlB7hRHaGLJkq6Ms5SbDA16tu+HToBi+C4EcYE1jm6XvFg2oW4bRxSrzNiSnBCFSG
 Hn/mO1IGGLGrYOdKeL8+0C8HxRV6qE/EP/lWCN0lHPj1ML0vK6CsSoGRaOWldaBt2ceN
 I2Nm9JB1PkDUtUkOWmfyxzpMUIh+Y5aCMLfK8g9i8Yl2emBOiUFPQ6lCldheuP7dL8AR
 +I/d1IsGK4QvWZ69JL4WsM2npB8oYOXlhYa+locPF3xGk0F1wccKzw7jYHKF0tioqx15
 PdePNC7/xJQyvfnAjuECTiOU2t3Y10o8dAQIZZCzO7jYefmkufB/wYxf85pGOgdi14sm
 wLWA==
X-Gm-Message-State: AOJu0YzUg1UxB+vcryq3Xbmh4XyHxzxpEvTM4HNj8mmech84gVQgh+y/
 4PldHblRijrEYjaa8r6j8kO21w==
X-Google-Smtp-Source: AGHT+IERKyxEFL+kM9ePg/i75rjfnhtQMDiu9vFubSpFatqyGa1gdmRBsSp/QWn67JywZQ328enpAA==
X-Received: by 2002:a17:90b:2242:b0:262:e84f:ad80 with SMTP id
 hk2-20020a17090b224200b00262e84fad80mr2505224pjb.9.1691593915731; 
 Wed, 09 Aug 2023 08:11:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a17090a284c00b00262ca945cecsm1661726pjf.54.2023.08.09.08.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:11:55 -0700 (PDT)
Message-ID: <c105f343-7899-42df-8aaf-b1cf09ab4629@linaro.org>
Date: Wed, 9 Aug 2023 08:11:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/11] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-12-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809083258.1787464-12-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 01:26, Jiajie Chen wrote:
> Add la132 as a loongarch32 cpu type and allow virt machine to be used
> with la132 instead of la464.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic loongarch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   hw/loongarch/virt.c    |  5 -----
>   target/loongarch/cpu.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+), 5 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

