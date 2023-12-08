Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C480AB5C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 18:56:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBf3h-0003tL-Qg; Fri, 08 Dec 2023 12:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf3Y-0003sm-KZ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:54:32 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBf3W-0004yi-FA
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 12:54:32 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d098b87eeeso21647755ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702058069; x=1702662869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1oFjTkTxwWRXiDAa1bd7NwDieJKmCj1wNxx5ocJgnHM=;
 b=B1/JmUVHuJYU4PKV0mKiII8O+dkxL0lxNokw++v3bLA/Cb63KOYmwuvI1vV1MFh+s/
 Tjw2vQPWwM1Qjmw/AsfpL+lvFgIa6Im0Hh5vg/bfOIRc+Yo7P4fyouCV9jefj1HA4srG
 hw5h6j5b7hWbGLO2/yCxCT8tsBEF6Jo970s3OLdtJLwpqhIKz0bnYAKpT5T3xEp+RQRO
 nR16SLx3ylG7CFYHYZg4DVc/hW55r2I/0V9gfbpucXwZ8AxD2n/qOIOVyzKz5P+nqrqj
 DjDiPZtk8G7Bx60vzXrnd0zSUVSklOjo8XusV+Xi1Z2X0rrgpx4WyinwUj7Vfy8dmgi3
 11zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702058069; x=1702662869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oFjTkTxwWRXiDAa1bd7NwDieJKmCj1wNxx5ocJgnHM=;
 b=rQCbPMELZGARS0Hgez2iBXJ9vpDamuE8FFJ0iNaybMSH3c5sXw3Qap0Cyi/nfTlOOF
 RblhxoOcAyVg59YnAfxxK8yWcBfKxvWts0H7cx0OTeQDhN+ZfYLhgVONfUKJACWQKwRq
 CKduWzSvJTBga/Med4cS66mHaZk+FWJQ8/+D1UmPfhQ/aO00X7cKhEDGV19Ps1bVFqgE
 p2SYaZVxN/ZKoBTcZsQcQh2CjnZNfhHKERb2TJRK13q9itoJh+jHZncW3Zqt+HOFH7Ez
 aD7KelWfwHhbGx1z0DhbHmSJXBhfY9yjwVrTkIG3HkW6XmPtIagzCHUq7E4S4rfGaMe1
 baew==
X-Gm-Message-State: AOJu0YwhpbgAYSOg5+nA4V8z278IGaKXOSicSM9BoQ4xN+QCir665bfs
 FboSWAdrFQH1K5GdCiYxhV1HgA==
X-Google-Smtp-Source: AGHT+IG4MeMNJ5oPB5Sm9mwOtZ7zIPK+JzKgxP7tpwJz4djNcGykD4iYY++7DYCow7KgSrwog2Ml/g==
X-Received: by 2002:a17:902:d482:b0:1d0:7d0b:5571 with SMTP id
 c2-20020a170902d48200b001d07d0b5571mr435946plg.109.1702058068944; 
 Fri, 08 Dec 2023 09:54:28 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ja19-20020a170902efd300b001d0b0334a9asm1988324plb.155.2023.12.08.09.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 09:54:28 -0800 (PST)
Message-ID: <78b637eb-f3cd-4b8d-a3be-758a25b3691d@linaro.org>
Date: Fri, 8 Dec 2023 09:54:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] sysemu/cpu-timers: Have icount_configure() return
 a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
 <20231208113529.74067-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231208113529.74067-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/8/23 03:35, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have icount_configure()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/sysemu/cpu-timers.h | 10 ++++++++--
>   accel/tcg/icount-common.c   | 16 +++++++++-------
>   stubs/icount.c              |  4 +++-
>   system/vl.c                 |  3 +--
>   4 files changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

