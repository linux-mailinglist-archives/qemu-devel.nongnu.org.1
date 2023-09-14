Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A447A0C02
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqW9-0007TO-Lw; Thu, 14 Sep 2023 13:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqVx-0007J7-0h
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:52:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqVi-0000D9-AI
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:52:15 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso778681a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713932; x=1695318732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/CS8ZV0DJKRIhRiJAX15OjE0c8op9UEHE7Pm8cfxso=;
 b=E8HSiroLovTASjhEUCxazcdX5ytefFrbl8J4+VCdz3HrfRB90Wbj0D96sApSKrDwTd
 oMHcLwKda3EQPWxMlGTIrCcm2HRcIOa8w5Clg5qktx5IkugcBx8pLZcW3io5ZmyMjL5K
 HtjzXfBIVzwPQPJ6MBuOqlhguR1hTr6M0HLv2Z1WdaILT0samqZLTXr+w6DYEJ3SJ0Bt
 AasCUb/FFu5vND1gU2dlFmL705ElRchs3aMGaF+mb8PTRb5+MwMlAg0xdEqM5H2SErm4
 h7ScNZ/mW5mRQnmpBsxGaU150DGiUyW6e9WvyVvy2OB2itMrqujpiTkWKprcQfGEbOwy
 Dpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713932; x=1695318732;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/CS8ZV0DJKRIhRiJAX15OjE0c8op9UEHE7Pm8cfxso=;
 b=Fa3vjynCOgJ5s3cIwc/KuqhRvummQNV1OZMBU85smCT7Iyt3onHK7nghG8DIX1Qz5f
 85XyQ7tG69we4ayMo0gbPOycnrA7FTIYIpLbGvvGVYwNaHcutAd2oZgLLO/MJAaa/h0F
 5r1is3OmJ5rqHgsBdYU0WLDCquaJ+vX9T787P5DY2tILtD1H5JnOfoIOacmk3SuTU078
 BQu6404Zh/8NxvzKyY+dF4mXDTHg67cAkaC2Amh64JcvmcdWSfM/wXPvJAxTDLnSCkkY
 NVnK/2Z2Qvw+nr0nunP7b6yV1PN64A9ciasDXYxFaOueMYBKVycPrSVcaX0IdQgTk2sU
 AqXw==
X-Gm-Message-State: AOJu0YyE+Tw65ILT/pjeD9suzko0uFlPEjndBTu+kZZQnTOW8bfJ60LI
 3dt3pdGlCK/Y8og4TfaK3+fxMQ==
X-Google-Smtp-Source: AGHT+IH3+M+Y4LLtYxmNcYA/Nd4AzpVMxt1jLMOVpDbyc9ppsEkL21mI+vZHC01lFryO5T8CWEc0VQ==
X-Received: by 2002:a17:90a:8b0d:b0:269:621e:a673 with SMTP id
 y13-20020a17090a8b0d00b00269621ea673mr6097982pjn.1.1694713932277; 
 Thu, 14 Sep 2023 10:52:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 3-20020a17090a01c300b00274922d4b38sm113459pjd.27.2023.09.14.10.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 10:52:11 -0700 (PDT)
Message-ID: <92d2182c-a388-a5fd-04a6-4c85c070c24e@linaro.org>
Date: Thu, 14 Sep 2023 10:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-23-kariem.taha2.7@gmail.com>
 <0bdcfe70-58ac-4ed0-4f75-33d30653a9c2@linaro.org> <87jzss4ru2.fsf@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87jzss4ru2.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/14/23 09:55, Karim Taha wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
> Do I need to enclose `shmdt implmenetation` in a WITH_MMAP_LOCK_GUARD() block?
> 
> Mr.Warner forwared me a patch series ,that you sent on Sun 20 Aug,
> for the linux-user, which encloses the implementation in such a block.

Yes.  All changes to the guest address space must be done with the lock.


r~


