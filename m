Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EA791FA4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 01:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdIgL-0005So-67; Mon, 04 Sep 2023 19:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdIgJ-0005Sg-50
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 19:08:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdIgG-0005Hi-Qd
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 19:08:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5694a117254so1275125a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693868906; x=1694473706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CPBCydmOjcsYCPCijtUBDvjXJZ+Yr5VDf5dNG67d6/Q=;
 b=YKRRZk3N0/UjpbvdrAg7k/BvZDp0yiUz06uKHGPq8mw6QOhoPZX72OojvyIxLFgfgh
 IW93vUeam2szdUR3dp7jodWia3kaPxEt9tTT0gcBIzgMsB5/V1qtSVgl4oVCGOCBDtGn
 4OESrggTkUUg7u2uDU6EJfWu06Puzs9x50VLJnUuZqsvuIo280Ki9X+qmQpe5E+z62pN
 7TP8EyC1mqqhSWRJi86V6S6T1qyo46n+fX1+PtYcfYA56sbD+28kt3VKP/pd8xo23f2I
 shnyWJIxc5GGaHIaD9UeD4k7WF2Lpt9ycGK1Zb9MhsYdLl/FkT0xryfm/2tB8NFBc9As
 yPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693868906; x=1694473706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CPBCydmOjcsYCPCijtUBDvjXJZ+Yr5VDf5dNG67d6/Q=;
 b=MgZH/ZcBzNyRZJvJLZeFfamMmJGuiwj5FKKHRNWlbGR50kKHnuiTIX5AN2SFRbpY85
 LpACjWPjA+kh552PYbyKEooinkDo2G/Ti7N05U7h4nWMI/GrqmUFfkPCFRucMYSwVnPw
 Zn/esZib8vLeHZnhCb5D3OFvJzhgqsIjcCLly14f0kVrE9U2D2zH6ES510eLT00mbbE6
 JLHIw0N3oyqdYSBuBej3AFqllzyREHLDLR9bTwqVmMbY2jQgVmXIN/g8nr7lCtFieWlg
 WcB6WN+Atde81o/0McnI/kaoCyBVcXaSlJxFY2umHiSDJkc/KXGBhCJE9Y2LtFntY209
 VrcA==
X-Gm-Message-State: AOJu0YyVVecKQUz8gjOn429BHou1KaUc9ClHdlMxI76TgVfty2vkw0ZC
 EsuDze/lDf7Z2u2hm/xY/lSYdw==
X-Google-Smtp-Source: AGHT+IGF/z2GiWn7V9K3aTHIkhuM6uoBostGhjsFJM8Xyzh+oMSeeRRB2v9Vqln9KdVEgaqc/2L04Q==
X-Received: by 2002:a17:90b:e94:b0:271:c314:a591 with SMTP id
 fv20-20020a17090b0e9400b00271c314a591mr10925383pjb.47.1693868906343; 
 Mon, 04 Sep 2023 16:08:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a17090a020f00b0026b3a86b0d5sm8550201pjc.33.2023.09.04.16.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 16:08:25 -0700 (PDT)
Message-ID: <f1284643-ac00-b40c-db93-c6699afe6893@linaro.org>
Date: Mon, 4 Sep 2023 16:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 01/20] tests/docker: Update docker-loongarch-cross
 toolchain
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-2-richard.henderson@linaro.org>
 <87wmx6hw9c.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87wmx6hw9c.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 9/4/23 07:02, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Update from clfs 5.0 to clfs 8.1, which includes updates
>> to binutils 2.41, gcc 13.2, and glibc 2.38.
>>
>> See https://github.com/loongson/build-tools
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Do you want this queued ahead of a vdso series?

Yes, please.


r~


