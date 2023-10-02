Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608287B4B64
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCIe-0003YP-Ry; Mon, 02 Oct 2023 02:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCIZ-0003Y9-At
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:20:55 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCIX-0006SM-IS
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:20:55 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c1854bebf5so87820561fa.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696227649; x=1696832449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rcj/V/bYhUolwtBnilzCz0kRLow2hQa0NKkSotaABI=;
 b=mbwf5EktNsPJr/rZv3EXJPPJ4UjrplEkQeJiH6/M8FOFhVYmphYn90L1eZhyuUW21S
 luPaJNZVJO6xzQS+8n+RaqTnosNT4QrxfbBZr8u2k4ZHapOFjOAdAzlbZQCw/lJ3QWYz
 gFYZkQfiW7qwFPSERitqhC0/N22T423OHCtVGcSaFOXHQCQDxdnCMuWvuiiNVmToUryf
 buT18lYziSww7b3csqiqJPHPOXJNASkDEWZX4O9efyAmsqa8KXNbGm+f3vxrxAL1+FWe
 vPycEjLUgUCiDR4iYscd4Xres4EUNLPIUqVIoJILbPeE49CgOqyoeFwekg4ER2thmYb0
 5WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696227649; x=1696832449;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rcj/V/bYhUolwtBnilzCz0kRLow2hQa0NKkSotaABI=;
 b=lpBwAc8j6G5L8cI++ZVjwdWwSBm7dAhXmosdsUjkY3ItV+65FcO+iHTp+4eLFhEVlY
 iux/lamWB/HkfpzxC12qRsrHRJSAyfn2Oe8LmpNlVSfQcZLpri2i7WcMpN3KEHKyxnSp
 mOiu0jrqg/eOJrjIM1bvpD6mbdlpbAIpTYZIXK/3i2dmiOElCy+2juFZWjJk0cES/oh5
 zEeKqQ9Whcr7bgZ9qjnqSBaAZeUO+Tg56oqVy3/h4NX/O2AheP1DT5F81W5H2DlfjGNH
 TANpyUY0L2Ho/+4XXcfVMxV00CMYNuClAOCyg3Jj8ol0cDIIwp+Ubju5RPbARmEOIFSH
 XdoQ==
X-Gm-Message-State: AOJu0YxPEztgtu1BhEtLsQIFjZ33NwQzl6tcbkFLIPUYineh0ENDogWb
 Qg8fe3CkEkiYYjv3qGHaaysOeA==
X-Google-Smtp-Source: AGHT+IF8xHzWwFUs2p0JLxBjXNeh5cHh8zIpmsvZDAzK41t2MOMvETp/+/wojKfTPEVBD4MZFOgZcw==
X-Received: by 2002:a19:f511:0:b0:503:264b:efc9 with SMTP id
 j17-20020a19f511000000b00503264befc9mr8061639lfb.18.1696227649271; 
 Sun, 01 Oct 2023 23:20:49 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 v29-20020adfa1dd000000b003247f732c07sm10619158wrv.12.2023.10.01.23.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:20:48 -0700 (PDT)
Message-ID: <1b36bc2a-3bba-d876-5ea7-f3e37d9ec464@linaro.org>
Date: Mon, 2 Oct 2023 08:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lecp6w7x.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87lecp6w7x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 29/9/23 13:43, Markus Armbruster wrote:
> Back in 2014 (time flies), I posted
> 
>      Subject: MAINTAINERS leaves too many files uncovered
>      Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
>      https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/
> 
> I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
> (at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.
> 
> Unsurprisingly, the number of files in the tree
> 
>      $ git-ls-files | wc -l
> 
> grows over time:
> 
>      year  2014  2015  2016  2018  2023
>      #     3746  4387  4921  6461  9788
> 
> Looks exponential to me, doubling every seven years or so.
> 
> The number of .c files has grown more slowly:
> 
>      year  2014  2015  2016  2018  2023
>      #     1836  1945  2132  2633  3588
> 
> The number of .c files not covered by MAINTAINERS
> 
>      $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
>      $ grep -c '\.c$' unmaintained-files
> 
> went down a lot after my first post, but has since flatlined:
> 
>      year  2014  2015  2016  2018  2023
>      #     1066   461   402   259   246
> 
> It looks like we've pretty much stopped adding more unmaintained .c
> files, i.e. cherry-picking the kernel's 13f1937ef33 (checkpatch: emit a
> warning on file add/move/delete) as commit 4be6131e329 worked.
> 
> On the other hand, we're not making progress on the remaining old ones
> anymore.

How many new files without maintainers?
Shouldn't we turn this warning into an error, so new files must have
maintainers?

