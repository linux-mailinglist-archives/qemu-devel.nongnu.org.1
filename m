Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D27DEBB4
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 05:16:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyP6K-00020x-3X; Thu, 02 Nov 2023 00:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyP6F-00020b-R7
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:14:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyP6D-0006Rc-By
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:14:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so4242695ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698898468; x=1699503268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B67XhsM6szQCsiwbo0t/UrspcEy05/rlvNMPecuSUok=;
 b=ThfYVIYTtYU1v8AXfPljnlbSbO60pSmdTDqboskGg3WfNkZdEVgSK8vM/zvZoWFMOh
 2fVvTffSgUylK5GeIfU9JgZGBJCogo1dFRiJRmeku0fBmSGBq6aVsVX7A7P/SoRVtoj6
 C4Hpl7+wFbgh7rkg9okghLGzIujODvxqYuEu1qHv2vKCgdqH5474V4VdFnGC8dfcruiz
 pBFWyrnOjginXu7543feA1yg7TzJYydBBF8ldB6qJG79tTdpa6Dw8kCD7DB2q0JiNQx1
 9UmvUdrDoORjY35WnZDLiLLctuRpGizJOM8XbQh9MMNZb0dCuQc7V8UCbcb/g1ZKun0w
 kFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698898468; x=1699503268;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B67XhsM6szQCsiwbo0t/UrspcEy05/rlvNMPecuSUok=;
 b=wycD/Tuy0j8NwDpVuAf/HRBiCMZMF1TXp7IA5HVJTTKgS4LQSbCjbowilPrD70J0Wx
 KR7GGvyClAD+MPuryu1vO9iDQ6FUVZzWVHn/7uXxb6mE9L4mv8HKwnl01kmuLTy1mvfQ
 +Rx2PsLrZW+VKhJW9oqUm164ZLaLI7I8Nv458jM6EJu54UmPbA6Xs+7YSytDtLAPgb93
 sYlMCil/jIfhyTvbzAkybH4hfb4Hwguh8btb6gbU8+W4wbHWShMHp9GwT3VgV7L1Y5vn
 3r+XjkqOQ2jhMFGhKygSQKJcSrk+fKC1mhGZ1nIp2j9t0v1a8kvMw2jrQghD9UO39H5R
 wVyg==
X-Gm-Message-State: AOJu0Yyuw5EbrJaOTGA0lgUylsYLFGaSKWJfU+ABlKpXYrFnLnZUhKdv
 aYiEh3AY4wJ3jEZuIlTWuLxIUg==
X-Google-Smtp-Source: AGHT+IG7Xmj8VcSBnFHt6oXXJeJBWrMAihEvgQMNr8V78hrpILTP6A/1A2TrUd8fQyYoaPL/d3QExg==
X-Received: by 2002:a17:902:e0c5:b0:1c8:8f5f:b610 with SMTP id
 e5-20020a170902e0c500b001c88f5fb610mr15095258pla.13.1698898467852; 
 Wed, 01 Nov 2023 21:14:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jk5-20020a170903330500b001c61e628e9dsm2029348plb.77.2023.11.01.21.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 21:14:27 -0700 (PDT)
Message-ID: <3ee2adaa-3ea3-4ce0-ba77-32bbf64a4a33@linaro.org>
Date: Wed, 1 Nov 2023 21:14:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/33] machine: Constify
 MachineClass::valid_cpu_types[i]
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-26-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-26-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/1/23 17:24, Gavin Shan wrote:
> Constify MachineClass::valid_cpu_types[i], as suggested by Richard
> Henderson.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c      | 2 +-
>   include/hw/boards.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

