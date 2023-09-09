Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 965DE799A4E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 19:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf27o-0001vd-5I; Sat, 09 Sep 2023 13:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf27l-0001vE-Mt
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:52:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf27j-0007eb-8C
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 13:52:01 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26f57f02442so2372989a91.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694281917; x=1694886717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zxhBiDTj+L5BMIDxMpSufWM7Qh88Kgn1O5ezIoDl5n4=;
 b=bHxXZWz2UlpMmlQkaxKgRfd2ktCiuxmyDZxHoO9XJ8AhBtnMGuJLiB2K729Yn1WBiK
 kaEfqnqdwyQTg4klVqQs30dd4+k8MqEZkm27gFEHXHwN2eKk/r92UNdjdBdNu0sWp7yw
 7dM6caGWsQrRMpZcH3zhd1V39bkJSHxlcQmRo6PQDcsDiGfFtNVh0Zzd54By04G1MEdA
 G00gvADo++UdsDRW52amZd90+v+ndte/qzeF7WiBnf5JnhsPLqbxU6f4XrrEu+as8Noa
 dntmJuatk8vBUrhq6RDrTIGYxlQ6s5H+FeogRa+OqMcDzfFF7sntO5p+KCZnldXF/JbE
 lEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694281917; x=1694886717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxhBiDTj+L5BMIDxMpSufWM7Qh88Kgn1O5ezIoDl5n4=;
 b=qSQEKC8//+MQTcSF/p+jILvlUPfdWumTBvhBj34HybaA3UWp3J21+v0yDbaXhaXpQl
 whOOdZMUgix12HYQ7kRatG0jgp1+CaAMntJ92UP4kBKpnXQ2vTnSqZwD3ormXfxwhGLJ
 QkA8yEyE4Yw6AfJsavdVippsV+09O7ojBOhOLzDsBxVfAML5smQ+KyTnDArJwHpjOufY
 9nNN+RyxiH9SYoGcxA/8Wey69CrhIj/H6vMSLAAq0aPTMiRwt7h+Bw/pSEJ3MrCogKSf
 JQ3+L5zXy2tphWnzXNS8AxAzdOEoecW4SvwlTFc9MMCMHYh8X+MqUZaO71N8Z/UKBM5l
 4Nfw==
X-Gm-Message-State: AOJu0YwZgwte7eZn71oI5sJPmUnBs7dE2+oK/X5wMfQOxS5pm2o8K1sO
 cVDuuk21CZ68lacuLTewAbQHeA==
X-Google-Smtp-Source: AGHT+IHF2Kkyp6sRdw9hRNSfjM3CPTWXm1a2L65WIzJJnb0hIK8n4Ct4t2xyXaQFwZhQO0b4HH4UDw==
X-Received: by 2002:a17:902:e80f:b0:1c0:bcbc:d64 with SMTP id
 u15-20020a170902e80f00b001c0bcbc0d64mr5978817plg.51.1694281917524; 
 Sat, 09 Sep 2023 10:51:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a170902e5c100b001b88da737c6sm3554483plf.54.2023.09.09.10.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 10:51:56 -0700 (PDT)
Message-ID: <79876863-58bf-b21e-3aa3-8ab25724be35@linaro.org>
Date: Sat, 9 Sep 2023 10:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 20/22] Implement shmctl(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-21-kariem.taha2.7@gmail.com>
 <ec99a998-7793-1c01-e9e5-d84c3ada68ee@linaro.org> <875y4knm2k.fsf@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <875y4knm2k.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 9/8/23 18:59, Karim Taha wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
>> On 8/19/23 02:48, Karim Taha wrote:
>>> +    switch (cmd) {
>>> +    case IPC_STAT:
>>> +    case IPC_SET:
>>> +        if (target_to_host_shmid_ds(&dsarg, buff)) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        ret = get_errno(shmctl(shmid, cmd, &dsarg));
>>> +        if (host_to_target_shmid_ds(buff, &dsarg)) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        break;
>>
>> IPC_STAT treats buff as output, IPC_SET treats buff as input,
>> so these cases can't be combined.
>>
>>
>> r~
> 
> I think they can be combined:
> 1- we marshal the struct `buff` from target to host
> 2- call `shmctl`
> 3- marshal the results back.

No.  For IPC_SET, the target page need not be writable, as you assume here.


r~

