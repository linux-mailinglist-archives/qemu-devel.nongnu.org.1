Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5482DD05
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:09:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPVN-0000Ib-1i; Mon, 15 Jan 2024 11:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPPVG-0000GX-Jx
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:07:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPPVE-00027l-TQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:07:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-336788cb261so7353836f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705334875; x=1705939675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94wDR4ldIJI8HYVo/IGKSIe6kSA+1K7c34dxjwR7B+w=;
 b=n18ZUOeeOxfqj+kMLfWHXmtwiOri5mhV8RVTq7tujz19FzjVhd4Tx01NTUBwtqyq9Q
 JBLwyh+ZF4ce9Ntds2Ulqg69+YE2yJDcsRMnjmihpjOFHsLEkgP8O3JGMp1j2zmEnFrs
 XkebKwyc/YBqYVDKwxQWzjYqAonBYFkMD/LEcM52cq7UpOkpEv1C8D4o1aU3TuK1ER5J
 F0YheRFE8nYSD86JugAzid87IrrcdF0pYr3+Kruae4QLpKu4RvS6VfKcmvNKPfQT102c
 TSY34FImxQYfxyApjgPEvKXiAoAEmymJgwFMXRBEGRhDhUqF0yMOEdURlI0mwtttFMsz
 4gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705334875; x=1705939675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94wDR4ldIJI8HYVo/IGKSIe6kSA+1K7c34dxjwR7B+w=;
 b=bVePyUqTA+cW1qSn/NN/o3MVwUWXaKQEwOYGDslAVNWumZWsSFQv1YhVI3+oCWHJIH
 do+lpP8MZNjwwrpRYazstRDmjoBJdQH9vNyNrNMP1BNPX3PFwGEDO3qhcSs9GFZLSJoJ
 kZa32SQdEe7QoN6eBcZpIu4P9o/Uc9bX7ww7523NxjjKTmKtelz+l8vhWT1P2Arv+KVd
 aHW/xNjIlsbM9NcHijrL5CCR1oOHPxEu+ZJJfCEwM/+8S4b9HmTRIoYWUgPlYDS/puI6
 onI+WxSnFpKC08svGnQJbEW3jkKL/9Qkadm3gyrvSlE/jE8lFC9nDtQxKrrZXG5c2x+7
 YG8g==
X-Gm-Message-State: AOJu0YyjVyuyi0CAGUeMVieD0hs1Mj7nNUKbifFGBjM3OIEXVJJvsydD
 FD13qCYQja0KJGAprtGu8Bstvpk1x+xAZg==
X-Google-Smtp-Source: AGHT+IEZDtY1kHVjVm/nF+7DIGONa+RTcGTWgo2NdP0icdawcNTK+DFUsNKemZqMHkdVpspiBD/nDA==
X-Received: by 2002:a05:600c:22cf:b0:40e:6193:b1a5 with SMTP id
 15-20020a05600c22cf00b0040e6193b1a5mr2919594wmg.39.1705334875039; 
 Mon, 15 Jan 2024 08:07:55 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm16421901wmn.35.2024.01.15.08.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 08:07:54 -0800 (PST)
Message-ID: <06d4179f-76b8-42f0-b147-f4bc2d1f06bd@linaro.org>
Date: Mon, 15 Jan 2024 17:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
 cpu-common.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
 <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
 <CAFEAcA91+EV7_iHvp2Kd8zgXAx2zg3odepQgg=vPpPLv8ETRKw@mail.gmail.com>
 <ZaVFDhNiptuyzhjX@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZaVFDhNiptuyzhjX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/1/24 15:45, Zhao Liu wrote:
> Hi Peter,
> 
> On Mon, Jan 15, 2024 at 10:41:48AM +0000, Peter Maydell wrote:
>> Date: Mon, 15 Jan 2024 10:41:48 +0000
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Subject: Re: [PATCH 02/11] hw/core: Cleanup unused included headers in
>>   cpu-common.c
>>
>> On Mon, 15 Jan 2024 at 09:37, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
>>>
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Remove unused headers in cpu-common.c:
>>> * qemu/notify.h
>>> * qemu/log.h
>>> * qemu/main-loop.h
>>> * exec/cpu-common.h
>>> * qemu/error-report.h
>>> * qemu/qemu-print.h
>>>
>>> Though hw/core/cpu.h has been included by sysemu/hw_accel.h, to keep
>>> the dependency clear, still directly include hw/core/cpu.h in this file.
>>>
>>> Tested by "./configure" and then "make".
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>   hw/core/cpu-common.c | 7 +------
>>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> Something seems to be wrong with your analysis of what
>> includes it is OK to drop. For instance, this file uses
>> the function qemu_log(), which is why it includes
>> qemu/log.h.
>>
> 
> I'm not sure about this, since qemu/log.h has been included by exec/log.h,
> so could we just include exec/log.h and omit qemu/log.h in this file?

We try to avoid implicit header inclusions, because if "exec/log.h" is
reworked and "qemu/log.h" removed, then files using declarations
implicitly declared start to fail building, and we need to clean
unrelated files.

> It seems enough for the compilation to omit qemu/log.h and only include
> exec/log.h.
> 
> Regards,
> Zhao
> 


