Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE57923D1
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXj6-0004YX-09; Tue, 05 Sep 2023 11:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXj4-0004YN-8j
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:12:22 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXj1-0000bM-QC
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:12:22 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so42995531fa.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693926738; x=1694531538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h39soRfdAayIxxTx5C264UCtstamu32pHt1DXWWWyng=;
 b=KNufGV5KVhGGeSCzjChnLmLgzTEx/5hicN2wzEIgPDSGwLD/tfoh+6FKnwEHQX6eeR
 W2gIk5yd+Lb9Zqra96mHoPmpVY92vD3mfJ8zrc849oLfa5PJ4ifwbKUk1D9cQareOTln
 leIoqBPEFLe6CNoh/Xf5gs1xqwuJ1bF9lJrjILgKKw8j1QRexf83/KNJQNs8P1w6/0ml
 nK9GEzFS+SixmVi9QJUvy7QTH6RxsFg6uNhMsQyRkwGF9FlfTysJD+J1INlyqN4pAF+I
 PFYWZm3wcU4xCxPRTGUKNQ121P5yBHNd5t9tj+q3C4NMynT5j3UCl3oN+43gFsRIC4IQ
 K2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693926738; x=1694531538;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h39soRfdAayIxxTx5C264UCtstamu32pHt1DXWWWyng=;
 b=OS4WqkuSlpcUkVg6gp6csrBPAYwQWxfabfnaVopzxFl/qUiWLvrZ0RCNmJWQ1uyp/B
 FxrAJ67g1ZQbJQ39v/uYmWx2cLLiEm8KIa4qhN+3xj/5W/hfu3D/jWDfX4Wl7FSfXpf/
 1VDTqa/gffVUY/g5OKR/pABw+Bp/bNHwXmKwLmqZYavUXSWYWHoKQ/fs37WPUPEW/c0n
 2TeG4cNjM2TjPaJ5d60mabBhPJt3Aajhd48N8ODdeARO0GZ7dK+DkwvdfatlbGrb2fy+
 wZjaJ1CuzZgNIPoJBO+Ly5rz+XBnhX2nuUvWUXntvbwLNa1+Q5E/4V5H5ZDSAO56rKRO
 9a5Q==
X-Gm-Message-State: AOJu0Ywxbl7V/V2M+4VsyoyqKTWyg+dtSVLX91t3Q3JebpSP5Wcd9tvs
 xoFM0QUKRpxDCwOxl5Bu7YUfmGKYqTRp7nrydYY=
X-Google-Smtp-Source: AGHT+IEzYrHeqLtUk6g5z/hKgzv2MgiHYaTDG0q8+MvMTL7LYuU0KMcX94lzB11Im0uQW0CiHdvGDQ==
X-Received: by 2002:a2e:b0e7:0:b0:2bc:c557:84a0 with SMTP id
 h7-20020a2eb0e7000000b002bcc55784a0mr36507ljl.30.1693926737830; 
 Tue, 05 Sep 2023 08:12:17 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c214c00b003fbe791a0e8sm17273292wml.0.2023.09.05.08.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 08:12:17 -0700 (PDT)
Message-ID: <d35f5c16-e75c-fc7f-57cb-c6f7a5e696fc@linaro.org>
Date: Tue, 5 Sep 2023 17:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: mips system emulation failure with virtio
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Hi Richard,

On 5/9/23 16:50, Richard Purdie wrote:
> On Tue, 2023-09-05 at 14:59 +0100, Alex Bennée wrote:
>> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>>
>>> With qemu 8.1.0 we see boot hangs fox x86-64 targets.
>>>
>>> These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
>>> Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
>>> mips64 break, hanging at boot unable to find a rootfs.

Are you testing mipsel / mips64el?

>>> We use virtio for network and disk and both of those change in the
>>> bootlog from messages like:
>>>
>>> [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>> [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>> [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>> ...
>>> [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>> [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical
>>>
>>> to:
>>>
>>> [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>> [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>> [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>> ...
>>> [    1.894852] virtio_rng: probe of virtio1 failed with error -28
>>> ...
>>> [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>> [    2.064260] virtio_blk: probe of virtio2 failed with error -28
>>> [    2.069080] virtio_net: probe of virtio0 failed with error -28
>>>
>>>
>>> i.e. the virtio drivers no longer work.
>>
>> Interesting, as you say this seems to be VirtIO specific as the baseline
>> tests (using IDE) work fine:
>>
>>    ➜  ./tests/venv/bin/avocado run ./tests/avocado/tuxrun_baselines.py:test_mips64
>>    JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
>>    JOB LOG    : /home/alex/avocado/job-results/job-2023-09-05T15.01-71f3e3b/job.log
>>     (1/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64: PASS (12.19 s)
>>     (2/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64el: PASS (11.78 s)
>>    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>    JOB TIME   : 24.79 s
>>
>>> I tested with current qemu master
>>> (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
>>> there.


