Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EE7B3BD2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKlG-0005M0-SL; Fri, 29 Sep 2023 17:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKl9-0005K3-Ay
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:10:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKl7-00027V-Pc
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:10:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c5bbb205e3so132043745ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021848; x=1696626648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Rmh87IUWdCa6CgCgal/3ll46ZP/M5RNLJHZXZYHh6c=;
 b=Q+mi8NZzswGwz53gFo0SlTBjrE5mHTsjXwQ2uAH4SUuSis6X5NVcsWECO/Xf39PQzm
 0gUTkONyFpD9NnqQEujTprnZLxRLkrhCI34EqSu7xe/0m+sGwk2lka8P3T9uYw+CWYrY
 2kzzknWyRb9KjTQK2q6RwjK1Bqlw84z5NUwM+ubUd147qDGR1bQxCxtTM2COK92IRRmo
 LqcfNhJccFFUe7HgwJSa+cPQr4+Dg8ZXmn3LcQaSIiPYBmL+iJ4iTZBnV0O81Hmt5HP+
 1vKMSlCxEUim6fh8BzVqzw6IULx6ezfewhrBGKCvZerWDZk91KkFLMz0byx3Gwa7kpVg
 qt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021848; x=1696626648;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Rmh87IUWdCa6CgCgal/3ll46ZP/M5RNLJHZXZYHh6c=;
 b=ah6LsRGVty4iXxMXmnVPP9HtPD4F2epny5FVaxrEydJV07bJ/FdO00CyIkJM6Vtt/x
 X1Z4eOOkNKCtER+NoMGPsXCevD/lYzGLzu7kbdyIAhHR72ohI4TKnOJXXj4nuKjBAE3l
 BdoLiVK8vKhNTEpiSh4XDegOlxzd641Zjfh/xG+BQIbatVLWNoCV8m3z4o1MvkAlYfx+
 EQgr/hTcv7n7xR31UPBzgej27BLr+o3pRfRBGdYfFLo5j639bSNIe1PEqAGNkZVOGJZK
 jwq8a8pFoHj0ZO5gHaWl0N6eyYZzDeaiRtkmjprhP4UzdWfqoOdxWaE6KItsqHngSb3R
 7eEA==
X-Gm-Message-State: AOJu0YybSSkhhMEjs1rRRYj80cTsSV9EXD7NoRvcVLYDKHnYOzX55zZJ
 QToIyFhIip+aw/LhS5kB1NOp1+kViF21IXkUKFk=
X-Google-Smtp-Source: AGHT+IG94JB29aeYtzCcDIbJhZOhKqauipqGr75KRIrI7K/zjuIQjZvCo2yUhF0tSHk5KiDj7Y9MFA==
X-Received: by 2002:a17:90b:360e:b0:268:4485:c868 with SMTP id
 ml14-20020a17090b360e00b002684485c868mr4523368pjb.49.1696021848505; 
 Fri, 29 Sep 2023 14:10:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 rm10-20020a17090b3eca00b0027732eb24bbsm1917863pjb.4.2023.09.29.14.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:10:47 -0700 (PDT)
Message-ID: <f7ebc99d-ccc4-09d9-8a20-e726ad12a959@linaro.org>
Date: Fri, 29 Sep 2023 14:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/22] exec/cpu: RFC Destroy vCPU address spaces in
 cpu_common_unrealize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> +++ b/hw/core/cpu-common.c
> @@ -224,6 +224,11 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>   
>       /* Destroy vCPU thread */
>       cpu_remove_sync(cpu);
> +
> +    /* Destroy CPU address space */
> +    for (unsigned idx = 0; idx < cpu->num_ases; idx++) {
> +        cpu_address_space_destroy(cpu, idx);
> +    }


Merged with the previous patch, with the single call.


r~

