Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843577F27A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 10:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYji-0001Jp-1d; Thu, 17 Aug 2023 04:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYjg-0001JO-9P
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 04:52:08 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYje-00008h-1v
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 04:52:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so1008913566b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692262324; x=1692867124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQ55TtZvjqa1V89w9cig7DFAZBWwwDe6SiZ2vdDo8u4=;
 b=Aq9ZfSIvvktYXZ/fkkZeykHWxWierLHcTYKgd24mZPHaMrdl4VGciewMXXGoo182Oe
 b50eoeC/z7At6L0MqXj3ah/tffkHS48vE6GN7NN4WAklwCMdJ+iTM/yqdY8t/Hi1tJwi
 ZEU0NaIyzMHdoG++yXmpNE9wDLuPi4SsTdYMMh2knQ5tEY+Qu61sWjxt68Xad65L/7vJ
 oMwb9qBSNVpm1tOau1eZO51nqikd1fcWRvJp7t83ohZZgMpPa2kLCwEsPucXN11UUZ4m
 Vcw+LXkwEjRESNDVJZ28Q9vv7iAFgPDg0LMykJWYlGyMQfSXnz+btEGY+aNFX3wgoiPK
 EbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692262324; x=1692867124;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQ55TtZvjqa1V89w9cig7DFAZBWwwDe6SiZ2vdDo8u4=;
 b=HlfILMC7T21qbmnsdj8POqnbcaTgALfJOCxaV08nqTkw2ErIpoMgKC0UmcqvTojU0E
 bEMuGHoig3122L34EMXVv4WIOmTfDo030j6dGrhvvXFim4so1MnUxeF+Z4kqiiP1Kcv4
 FwuahfmS0z7NJuylFn5GcGCHquSLhkgYvWybZMwuX5npaKXjSL4QfLHFGV9bWpLWYGBY
 IEbs2oFtQNdk3hQyjk726B5xYsU0iZCt/nru5xsZP4c5WvviRvgyE9bYo5ectTHeHZm5
 NWCeMsOB6ruc2SwFdTLN98yoXzYvsk2/M7G7uEfJ8eCwRLsieL7/RKWIiqFuzZ+a05cz
 UevA==
X-Gm-Message-State: AOJu0Yz0A4ageyEpU9LHNg+BnPzR66IgKsLNG6a16sj3k0nWLOky4vFq
 dRDtloICVMnM4+P9zgY5C+/cRg==
X-Google-Smtp-Source: AGHT+IHlONnUFco7TLwY+8Ir6ivBsN657JZ9EjEeMUrqwF17njL9BelyznxGEqm05VRVfAVC7W0kqA==
X-Received: by 2002:a17:907:7799:b0:99e:23a:d01b with SMTP id
 ky25-20020a170907779900b0099e023ad01bmr1258871ejc.19.1692262324477; 
 Thu, 17 Aug 2023 01:52:04 -0700 (PDT)
Received: from [192.168.69.115] (mek33-h02-176-184-23-56.dsl.sta.abo.bbox.fr.
 [176.184.23.56]) by smtp.gmail.com with ESMTPSA id
 l7-20020a1709060e0700b0099ccee57ac2sm9837541eji.194.2023.08.17.01.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 01:52:03 -0700 (PDT)
Message-ID: <5546b08c-eb6d-f863-3355-59925edabfbd@linaro.org>
Date: Thu, 17 Aug 2023 10:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] util/selfmap: Use dev_t and ino_t in MapInfo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816181437.572997-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 20:14, Richard Henderson wrote:
> Use dev_t instead of a string, and ino_t instead of uint64_t.
> The latter is likely to be identical on modern systems but is
> more type-correct for usage.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/selfmap.h |  4 ++--
>   linux-user/syscall.c   |  6 ++++--
>   util/selfmap.c         | 12 +++++++-----
>   3 files changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


