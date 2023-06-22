Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D404739E07
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHEG-0002lx-UB; Thu, 22 Jun 2023 06:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHED-0002gT-5T
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:07:49 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHEB-0008Tc-3U
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:07:48 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b47742de92so67584071fa.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687428452; x=1690020452;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nfKvOgOrbkgkXViPw7vzimy09tR0n7wu6nRhHT0mqj0=;
 b=uCAvesJlEbiGITu28gkVfUlziLgIoX/sUBIeHW9iBPFjKPU+Mz84nExk9ru72YotqL
 JCyZ3SGVZRmpexJTYD0gmuNfMxngBk1T7t/yUGdj9c/BKDA0zVTqtO+tcjmtsgxqjVvF
 bTX72UWqvWOerz6IgNixqObN2YU6nkvlhLK0AXp7n3U6/FDiekr/bVtavYzY4VVl1Sp6
 6G4krcxyO3aAzu0bnC8hrlJFDv7/+MpOjdZR/YnCv6DMRzrwwKB8vwZUELjygVrcgtFB
 pte17ULNN6XTR3UdbiXwOGxQTPzv6kwMoHOd0UuaQ8f+xxcaO7ett2fnpLZ9tq0tT2Z0
 Juig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687428452; x=1690020452;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nfKvOgOrbkgkXViPw7vzimy09tR0n7wu6nRhHT0mqj0=;
 b=G9eQLP2pDo4qImCshwwop0MpiS0mpTIr+T2FYFROIeKS1HMfHMeF0/+/stZi6mY2Ar
 ZMwxdA9k9Cu1xwFiJfVoOsTm4SvCkam2gNRGzFGDQoAjMvp6lx3I9/AsM9U6YDQd1UqP
 yFUDuLv3t0eRzJq0Ta7m/KWcZB1nhBrmjMJVI3Jp8i6zmOSsyy3YiQkoKRuYSPcIG8Hu
 m84odeYzlp6kIdqaRoF7O2dcr1DJ78B6FGHBNLLhuyDTnDD0b2dwaGVwNApdkuovgtXV
 UEd64VgLrGv7hGpmhhfL6gsKrqkUNZn3Yml0BynXbVaBPBGHD4l905tlwoNDJnX1Sf14
 CO5w==
X-Gm-Message-State: AC+VfDyPjd3oKqdcB+7eMIN2Yhmp5/Q45wxiZ0K3vSLVPCeZ2JTsTPd6
 s/+SvC4gakII320QOdp07+6mtwlXXqmm6emV2jEpGw==
X-Google-Smtp-Source: ACHHUZ6CeEaQzusqYfZHzslq1oEa2jfJKMElEqh5WtAfXQttGmJi/HSmj+f4y1OTwr6ZgKw4jRmxIA==
X-Received: by 2002:a05:6512:3109:b0:4f8:6534:9a5f with SMTP id
 n9-20020a056512310900b004f865349a5fmr9000030lfb.36.1687428452096; 
 Thu, 22 Jun 2023 03:07:32 -0700 (PDT)
Received: from [192.168.122.175] (127.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.127]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d58e4000000b00311299df211sm6696332wrd.77.2023.06.22.03.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 03:07:31 -0700 (PDT)
Message-ID: <773ac3d3-a7a1-13eb-7434-67e0db9b64c9@linaro.org>
Date: Thu, 22 Jun 2023 12:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/24] q800: add support for booting MacOS Classic -
 part 1
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <0e8c4da9-2b33-dc24-77b0-cea5bdd905a3@linaro.org>
 <0da13e10-27d4-ff12-656d-291bff2e1b70@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0da13e10-27d4-ff12-656d-291bff2e1b70@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 16:06, Mark Cave-Ayland wrote:
> On 21/06/2023 10:42, Philippe Mathieu-Daudé wrote:
> 
>> On 21/6/23 10:53, Mark Cave-Ayland wrote:
>>> [MCA: the original series has now been split into 2 separate parts 
>>> based upon
>>> Phil's comments re: QOM parenting for objects in Q800MachineState. 
>>> Part 1
>>> consists of the Q800MachineState patches along with QOM parenting 
>>> fixes and
>>> the 2 mac_via RTC patches.]
>>>
>>> This series contains the remaining patches needed to allow QEMU's q800
>>> machine to boot MacOS Classic when used in conjunction with a real
>>> Quadra 800 ROM image. In fact with this series applied it is possible
>>> to boot all of the following OSs:
>>>
>>>    - MacOS 7.1 - 8.1, with or without virtual memory enabled
>>>    - A/UX 3.0.1
>>>    - NetBSD 9.3
>>>    - Linux (via EMILE)
>>>
>>> If you are ready to experience some 90s nostalgia then all you need is
>>> to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) 
>>> and a
>>> suitable install ISO as follows:
>>>
>>>    # Prepare a PRAM image
>>>    $ qemu-img create -f raw pram.img 256b
>>>
>>>    # Launch QEMU with blank disk and install CDROM
>>>    $ ./qemu-system-m68k \
>>>        -M q800 \
>>>        -m 128 \
>>>        -bios Quadra800.rom \
>>>        -drive file=pram.img,format=raw,if=mtd \
>>>        -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
>>>        -device scsi-hd,scsi-id=0,drive=hd \
>>>        -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
>>>        -device scsi-cd,scsi-id=3,drive=cd
>>>
>>> And off you go! For more in-depth information about the installation 
>>> process
>>> I highly recommend the installation guide over at emaculation.com [1].
>>> Compatibility is generally very good, and I'm pleased to report it is 
>>> possible
>>> to run one of the most popular productivity apps from the 90s [2].
>>
>> Could you add an Avocado test for this machine? See how the
>> MipsFuloong2e test (tests/avocado/machine_mips_fuloong2e.py)
>> handles the firmware (RESCUE_YL_PATH).
> 
> In theory it is possible to do this, but how do we handle booting 
> proprietary OS ISOs that are still within copyright?

Just provide the hash. You are not redistributing anything.

> Also this is only 
> part 1 of the required changes, you'll need part 2 applied in order to 
> achieve a successful boot :)
> 
> 
> ATB,
> 
> Mark.
> 


