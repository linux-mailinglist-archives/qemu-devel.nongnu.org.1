Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C007DC437
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:17:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxeIM-0008LX-Ed; Mon, 30 Oct 2023 22:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qxeII-0008LE-Qu; Mon, 30 Oct 2023 22:15:50 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qxeI8-0002dl-BF; Mon, 30 Oct 2023 22:15:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9e072472bso36449425ad.2; 
 Mon, 30 Oct 2023 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698718538; x=1699323338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e1JvKf8hEVdxPwWKTl+gtzbPVC6CZv82gIivlP5wkio=;
 b=EMLOPmOQ7NxINj4wD6eqdipmzN9vygwk2M6yef6OGUd2uLqoSha3EjXaqaHv1T282F
 tmG3D8jH4jtJLMbzfUeCxlGzKtD/tiWDMqmmotYhOa1qzlZY9l23I3l+VoDkVoA9Xf3Q
 9yThkjW08XOxdhpuAESrHETJtgzcoBraC6V4hUqMQLFhkd0xaVG4F3K1SwF4CxkYBBOL
 Ht+IPdwGEE7LlqILCplgJHX10IzGl9M7uFyU36MUeEOxkxc6j48Joi5BbWKX+31NZleW
 lAGbO74LRwLWzGaSJ4slXyTss1QLlcxj0NI2oDDUaxk7j3wGyS5uB1rynI0VpClf54k2
 Q2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698718538; x=1699323338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e1JvKf8hEVdxPwWKTl+gtzbPVC6CZv82gIivlP5wkio=;
 b=o4ekRJ7ikLfpu6OCaDVArgJOb3q1BGTO7B1tkReihfyZevJd50fU+5aN0iGxcBF1vL
 4yvFi8t1P86MOHvzSHR772BnldBhxH0HOy6z694RUdkF3Rco2hucNof4vPYMRnkWIMap
 AqdwbwrnrPzC2UobZcrDLCGPUtfBMQkw7ptIuG7qRJXNuF231+VAdObwLy/srNTOkqT/
 YCcGB6N4IAwDWvNtLqeN6l+ZplYYrHfxaqymRIOCVijnmC4AixohpTrrVrTml9jzUrMg
 MImp0mveJbSNrLJ73xtofVxwX7tBw3iuRLMu558EuJh28BYEPiPlSkWHPNH2kHX8ey+Z
 NBTw==
X-Gm-Message-State: AOJu0Yzm+rSoOxIUd584sLTBf4vk4X4IE7lFKsWDrjg2CJWGETaMsniH
 DD+bn/xEXoGtE7L3/EsJOpw=
X-Google-Smtp-Source: AGHT+IEyyS6XDlv+Q6CUBMfFUzNP0qekTCrrWsQL4n+rpdjJzGUVx+3vJ0G01I0efYp1BTY5PXECxA==
X-Received: by 2002:a17:902:d502:b0:1cc:924:e0b5 with SMTP id
 b2-20020a170902d50200b001cc0924e0b5mr10505259plg.50.1698718538411; 
 Mon, 30 Oct 2023 19:15:38 -0700 (PDT)
Received: from [192.168.0.19] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b001c60c3f9508sm161463plx.230.2023.10.30.19.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 19:15:38 -0700 (PDT)
Message-ID: <d33de324-dc12-41e5-96eb-4a7b8c85d439@gmail.com>
Date: Tue, 31 Oct 2023 02:15:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Modify lu.c to share codes with SCSI subsystem
Content-Language: ko
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
References: <9fd0dc1f55724fa79011be231cc27bf4aab11157.1697764912.git.jeuk20.kim@samsung.com>
 <53a87de9-6586-5a66-de53-152dc4cb4d1d@linaro.org>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <53a87de9-6586-5a66-de53-152dc4cb4d1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 10/30/2023 1:11 PM, Philippe Mathieu-Daudé wrote:
> Hi Jeuk,
>
> On 20/10/23 03:51, Jeuk Kim wrote:
>> This patch removes the code that ufs-lu was duplicating from
>> scsi-hd and allows them to share code.
>>
>> It makes ufs-lu have a virtual scsi-bus and scsi-hd internally.
>> This allows scsi related commands to be passed thorugh to the scsi-hd.
>> The query request and nop command work the same as the existing logic.
>>
>> Well-known lus do not have a virtual scsi-bus and scsi-hd, and
>> handle the necessary scsi commands by emulating them directly.
>>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   hw/ufs/lu.c            | 1473 +++++++---------------------------------
>
> I liked this patch intent, but almost 1500 lines changed in a single
> patch make it impossible to review. Ideally each patch shouldn't modify
> more than 100 lines, otherwise reviewers are either exhausted or can't
> be careful enough and miss possible bugs or design issues.
>
> Regards,
>
> Phil.
>
Hi Phil,

Thanks for the comment.
I thought that since most of the code fixes were code removals and
were functionally bundled together, it was right to submit them as a 
single patch.

However, I agree that it was inconsiderate of the reviewers, and I 
apologize for that.

Next time, I'll size the patch appropriately as you suggest.

Thanks,
Jeuk

