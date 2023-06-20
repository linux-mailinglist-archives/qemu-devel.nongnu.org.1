Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68C737213
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeXt-0002BL-VS; Tue, 20 Jun 2023 12:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeXs-00025f-9l
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:49:32 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBeXp-0004Te-DJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:49:32 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b466073e19so51876121fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687279767; x=1689871767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XFnkXXRA1u93BwS7oiFDUqZ7KPxRD/eOJHkxHJI42KM=;
 b=WZ16hjh+D5PX81su31mDdUJe0g4pFOSRs6fINwvIHCAzZpy4nzilpdf03l3kp5ij9p
 6OL5xQ10NAC8WlQWfv2fwaD+7XIUHkX0lkBDc6nHDy379E52OkR/uaP1c5pMfTDP36nW
 ogYwDpSshDgMRsrKBhnsM6f+BRdLdPfJYciLbfXh3B51d28U2ZRVl/YTSvsu5YCSExl7
 cohIZp70KDps+mD9xinCllUg+wCioGpDi6vEjvJgUj6jDZsPr59F9hLDKQnC8+DuF9nK
 XY7ibM8uwyc2FjHfRPMcd8bm4FyiEW8SGNYukg1FqnZRXoEdKWPCne4W+dKSJHiqg7Jj
 /m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687279767; x=1689871767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFnkXXRA1u93BwS7oiFDUqZ7KPxRD/eOJHkxHJI42KM=;
 b=Tr4xqJOewU//0v9M0cT0ZjOIZ87vpMrXLCTBXGqjR8ssgDiHcG5Hp01On3W0eNz7Nr
 t7gmQyS3TmqwfA/3lGt8aj9INCNggYbJFhV8wdvoXzJiJhDfDOsY6Gm2MEWDGu4fhG/J
 Cs8g3kNoIjmzfSZoDfGbOQHTZbuxQY/qXm3xl+qKsaL+R6j0S+stcuYMlDlGaxTMLpKo
 czwYJwXlp6yXOM0tX+QTjYvc3aKWIuFevKyZJa2VxrICwHmlhcC4P30OJz/rgAEWHrRM
 ogIJNfQD8ROjz2xDW2VJH0BSqZrgm3QY+Ctw77yRhk7Y5gD3L2G4+bd+80pc5j0NOen/
 /8Jw==
X-Gm-Message-State: AC+VfDxPLwyTuwSSlrAHnZ+dtCvMggGI4yXChEIIls3QKU5h3VXulcXQ
 sChMmXPmTXcznacwht3LETrjsw==
X-Google-Smtp-Source: ACHHUZ4GVhMOymHTxZtmuYjbwCDJgmzmX9jZb8EmFJOU1c5XvBWAeFwT6elKdYnIfF6lTahAfIRoHA==
X-Received: by 2002:a2e:6e07:0:b0:2b4:4a68:a95 with SMTP id
 j7-20020a2e6e07000000b002b44a680a95mr8711689ljc.8.1687279767580; 
 Tue, 20 Jun 2023 09:49:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm1696213ejb.126.2023.06.20.09.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:49:27 -0700 (PDT)
Message-ID: <a97f13d5-9f40-8109-3182-c359a08435ec@linaro.org>
Date: Tue, 20 Jun 2023 18:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] configs: Enable MTTCG for sparc, sparc64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20230620164040.912490-1-richard.henderson@linaro.org>
 <20230620164040.912490-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230620164040.912490-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 20/6/23 18:40, Richard Henderson wrote:
> This will be of small comfort to sparc64, because both
> sun4u and sun4v board models force max_cpus = 1.
> But it does enable actual smp for sparc32 sun4m.

Yay \o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configs/targets/sparc-softmmu.mak   | 1 +
>   configs/targets/sparc64-softmmu.mak | 1 +
>   2 files changed, 2 insertions(+)


