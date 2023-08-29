Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE078CA6C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:13:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Gr-0000BI-K1; Tue, 29 Aug 2023 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2Gp-000069-Mj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:12:51 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2Gn-0007RU-EH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:12:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-26b5e737191so2364386a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693329168; x=1693933968;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3QBZ/e6+o19HR1qWorKjxCAPCSWrLtWWRu5Fn6+x4xg=;
 b=fXsjYBdHlzTOY4xWT6Jx6qdl5pvSlquZ8jx1dG/aC7fPGlir1+W3pzyE+y88L5rwgL
 HvHohe3EMbk+cgCrpyb87It6qkYgEw97ht6ruYs+Jp0d1lCYXVWn/BVdEgWr9bYL2L4N
 csnva2+IqviMqLfs/YexQPQKYe5er1uE5/FBkuXmNI+rGzm2dQs8cEd19Uz1cbTrX2xD
 zn7Xk1rMfKBdmAXwUMpr5fz1Prs3g3LdsFSE+Wrs7s3Gjk7Qf15r/kwmgksMDio2tp3z
 /9g8kNBFoISmnTlYthbV5eqshChb8I1LoBIdsd29UDyywd+ICIsYJo5NI3I5bZK2AkD5
 a4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693329168; x=1693933968;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QBZ/e6+o19HR1qWorKjxCAPCSWrLtWWRu5Fn6+x4xg=;
 b=iKE953q34FFjONz36ihBIFwogGb29WRc2ex3xUZEZhs4ju7a8Eu9lOQsLkiBDMhGAV
 EMm3fe5qEaMWWaL7HtOD8RkDgCaHmxgZLcH4rEGrGASA0Spl/Kn/Q6Yh+XiIYU6yKN7C
 17r2yW0R9i2ze6O6g4uQIRycKafddrqj/xVyxTJM2qVDpHgTAMmY3T4cC3wGdsGWem53
 QZ6IDnwTFqW1Xi6snzNUXodyRLricNwQ10uEM2TOgeIutUJGhkfP4gYampzreNI8fA0o
 yDzOTnbOeCCmlzglrIu3i7B/s2GPG1cvMoTb+C3/2cNyz8xkMJplOFs7X1TBMewa3ovi
 ceHQ==
X-Gm-Message-State: AOJu0Yw7HCOOZKGKd9YhnhwA+AYyhsVcGujLinLewzwwt4QT7Rr5nSSf
 iZsN7dXdYhjMhTQ0wubH8ZUNoHIGOScx9D92YQM=
X-Google-Smtp-Source: AGHT+IFJB9rDRH5j61+JRjq2KeQb7NPuE5ZionjNIkETGdlXlCU5pozhgvFUdPNeoCgutbXgDGfWAA==
X-Received: by 2002:a17:90b:2348:b0:269:4645:80b9 with SMTP id
 ms8-20020a17090b234800b00269464580b9mr23651420pjb.2.1693329167811; 
 Tue, 29 Aug 2023 10:12:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a17090ac28d00b0026d533216e5sm10977094pjt.46.2023.08.29.10.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:12:47 -0700 (PDT)
Message-ID: <1f58c589-4c9a-35b8-d67d-5a4ae1151d6a@linaro.org>
Date: Tue, 29 Aug 2023 10:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux-user, bsd-user: disable on unsupported host
 architectures
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829084007.69019-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829084007.69019-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 8/29/23 01:40, Paolo Bonzini wrote:
> Safe signal handling around system calls is mandatory for user-mode
> emulation, and requires a small piece of handwritten assembly code.
> So refuse to compile unless the common-user/host subdirectory exists
> for the host architecture that was detected or selected with --cpu.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 40 +++++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It is better to error out during configure than fail later, eh?


r~

