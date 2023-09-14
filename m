Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51679FBBB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfe9-0002Oe-5K; Thu, 14 Sep 2023 02:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfe4-0002NT-Fh
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:16:09 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfe0-0008FX-Qq
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:16:08 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bfc2b26437so8459111fa.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694672161; x=1695276961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rqmDsuaf11O3NLP/9dNiobtads68NprpAFgCZzqtrKs=;
 b=GOT1QLjGjeAZPFu+eBxrZKvWJbY1rT9FEcvqS27wZcHF3DeudPy4uNyJdwLKq7mXlT
 uaX0XvWx9L9ajR5P8Mcv40xTeAesBaBCM//U1EcBawLHKUphg5SnBFevVMhM2rKT/HnO
 P7upcQYJNHg6Oy6hQOv3hXHzUDR7FraN1tnKZs7KYUJOXLKa4aAi40w4lcPqxH8iaBaK
 nsKoY0qdhFs21vRWq09G5u1gfP7jhziPPG9LNR3s2kRMOBm9nE49yC2gjs7yBUc9fL0y
 YwnjyeDpzloWqvBkmtkcoeWFenLjLc72vfm+rM5xoGC64GZmEjweEHsAjm46sZ7D1vnM
 stWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672161; x=1695276961;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rqmDsuaf11O3NLP/9dNiobtads68NprpAFgCZzqtrKs=;
 b=J9YxTkqPYUraVhPEqaXaKxt3kXxUDiyrJy//JvQ3KM/rdSDYweQppEovVeBnVx2hOa
 lTu2mMUDLLqjcESdXhUpdt17MHVolKDA/AZ53BgK/4o9K1ikmi5dUYONCuGAYWQz/VB9
 zNBp6rUaqYctH6BvcpiESNX+zjiHkUgHjJEQeWstRjcbuOZdcycsIpQq4UsOYf4BJjvl
 zYU/OqklH8YaNrX5x1XWT7FgVoM2wQdZOcDN/GQIfFDE4DPMco6Mp8wRt64psa7jq2tF
 j358GM8/8uHKvm1oe+yVxbGuKe1xHcShDK29UZIajPwWMclgmCFKzyduo7fmQEpCFcUC
 U2Zg==
X-Gm-Message-State: AOJu0YwBRfbLoCQM9LXd4vjY+1WAeWrcPWRD0NCwI+1+Z1gjCgwpdSkA
 WsG7amfkK6QCAo94MtBsZEeR1YDM7z/Oc2WeKCA=
X-Google-Smtp-Source: AGHT+IHNYqNWlGaIB4gbrV+qtXfPxFXZc7YuVphm9bkb3iqGoAXiilM+0yK9nots3oDo1VXsdtQAsg==
X-Received: by 2002:a2e:a406:0:b0:2b9:e701:ac48 with SMTP id
 p6-20020a2ea406000000b002b9e701ac48mr4281208ljn.32.1694672161642; 
 Wed, 13 Sep 2023 23:16:01 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 lt10-20020a170906fa8a00b009737b8d47b6sm493266ejb.203.2023.09.13.23.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:16:01 -0700 (PDT)
Message-ID: <48360d07-33ab-2d6b-61cf-b700a6a96e61@linaro.org>
Date: Thu, 14 Sep 2023 08:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 18/24] accel/tcg: Modify probe_access_internal() to use
 CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> probe_access_internal() is changed to instead take the generic CPUState
> over CPUArchState, in order to lessen the target-specific coupling of
> cputlb.c. Note: probe_access*() also don't need the full CPUArchState,
> but aren't touched in this patch as they are target-facing.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-5-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Use cpu->neg.tlb instead of cpu_tlb()]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 46 +++++++++++++++++++++++-----------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


