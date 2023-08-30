Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8378D66C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLxs-00046U-ET; Wed, 30 Aug 2023 10:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLxf-0003iF-Fw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:14:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLxd-00083m-5Z
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:14:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a40cf952dso7398900a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693404858; x=1694009658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FagQ6s8ApjvkO7tshD1iasMoxlMgt/pWg0ZRmp0Y4V0=;
 b=d/BQNuqA4vQGG42d3kEvsS6HJNYDUiegNAKTnVI+i2zZZdtplLxuoi2ynnfhpJh4F0
 VxN/lNBgyLPjFCf4PN+WD8d9w9FT+Hak3H5gutyw8zkToylIym0enMrsOJ1u+9TflITc
 BBGGHs+XZf4rTH6SWg1TYyRhKK6SpxJRUy8WmRNDTz9lwKcai44PzKB8fTdfRFHUj1ul
 4EafPLqjD66vwSyW9AeNK9DfMmaPCQSUisaP3N0Dz9kQSekd40azlGix77HosvahUcB7
 FLp5HZ5FdQSCYtie7T7WCtEYEAmGe3DeuuaZ0BQvyEZt5Crs170t4TiGU0L0Pw2htUn1
 7yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693404858; x=1694009658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FagQ6s8ApjvkO7tshD1iasMoxlMgt/pWg0ZRmp0Y4V0=;
 b=gYRDG8uPLtTEMneHgIpVOsYssXrSfQ0ohO1JMb368R9vBaOt3eYSuBzvy1icodI9Ud
 c3JKMVMbwAyDbdJYh4H+73UV+CMS++uSoZcVn0HgeHSD2ZXnAUrouX+obildy0rQXVgd
 7ZmJQC8cWxqPQkTpNAGEPIyDK/dOraWIVI4OmN1/u/Vz+2XOx8jvPaMKFcGBmJqRe2/v
 Ol1hIjS5EevCCnuqLn6SPlDLtpVjVCPyi2dOyTj4dkYdqydYoH/LYexYa/Zpb5pmXT3C
 h5rxZc7ltz6/a8XRium8XzFSbNp81POgWIAm1tTaMjJT7b5jDCQVL8db7OFO1NckaZij
 v/gA==
X-Gm-Message-State: AOJu0YyS79h2B6SivmquQPGciN0aAWPNBi5bU3lA9+ZrzwsscU0tg5pI
 w4KDfnln/2Qt9okHuJoP+2ov6Q==
X-Google-Smtp-Source: AGHT+IHwWv+kIJ6//0/PovMLxyDTxtP01asiePYP+YwAiWLhwlJRRQLTSOCzHZqIPXtIYmuO0+9dPQ==
X-Received: by 2002:a17:906:5da5:b0:9a2:b89:f82b with SMTP id
 n5-20020a1709065da500b009a20b89f82bmr1579274ejv.1.1693404858188; 
 Wed, 30 Aug 2023 07:14:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a1709063e0b00b009a1a653770bsm7184291eji.87.2023.08.30.07.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:14:17 -0700 (PDT)
Message-ID: <641e7b8f-cb06-a6b8-9eb3-38a23d623ff1@linaro.org>
Date: Wed, 30 Aug 2023 16:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 19/20] linux-user/s390x: Rename __SIGNAL_FRAMESIZE to
 STACK_FRAME_OVERHEAD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829220228.928506-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 30/8/23 00:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/s390x/signal.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


