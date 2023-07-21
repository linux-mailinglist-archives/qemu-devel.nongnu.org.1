Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2175C2D0
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmHN-000846-Kc; Fri, 21 Jul 2023 05:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmHL-00083k-IO
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:18:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMmHK-0008Hg-2r
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:18:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbfcc6daa9so13911385e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689931103; x=1690535903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dema8Xz8jryCDsFPSR71+BeBY5Jr1OifP866Zes038A=;
 b=fnPU0VgTOSVb3aI0szOd91VvIKStLK12/PbHdTudTlNswFa1M3ycDJHF2rRCxtsGUJ
 2jv2/s+sR4K92OOytGcnCToIQTHQdzZdAtUezLvflNmFZVMLo4RRcrl7Q/Hyh7E6wVH4
 TxtUqug2uuqTseUgGmz+pzBxA/+UQsWEnQ+GS7jsLvBBGl5rCsaqbhPi9YpRKP+/2ruJ
 4zfigbIPgdhBy2/qTDkZZXEYI7/Ay15UNtzuikdTeWadzxzWcKu7w5FhyuRRFRyDtJ2O
 NNCk7zDLVlH5j9md3/FWw7S8TY+nUtH8Xx1aGzMmzz5mA5DACGyTuBlyejphT8rn7I13
 jVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689931103; x=1690535903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dema8Xz8jryCDsFPSR71+BeBY5Jr1OifP866Zes038A=;
 b=c+Ba7FAbSLUfdEp9PROMIntWTZ9yndG0bd2/+quw4HHQZTxI1hU/rw/didDNz2KxTs
 /sJ/1SNNdDgQ9Imjg4Dn56TBYRkOLD4bb1Xs5fxshhhIpaO1kFcmbsWJG3qUwOc3nhdp
 SUcIplxZHwhn9YgMGorrAAOaQbjCb3SPb8vt80N5uyMYgVOSP3xfZMc/DyB9pCSmDe/0
 M3i9n9/oShshx7PtHWuM9chyi6XFIItAyhzORNOWNS1dwcE7OqQ0NGnefTnob+7APCnw
 JhVlm1XPeAevqtvB26OJE/FsIP4UrKXGvXEEVOD6TIaCuoBNDqtXMKRa+Rnt7TCiGaph
 EIAw==
X-Gm-Message-State: ABy/qLYoT6KLzhU4rG9ojA9AcaotYt54aTYRyBMTVTY0Jv40zvKa3A4y
 fTxhAwz5CLtjZK+iUnKqjmV8YA==
X-Google-Smtp-Source: APBJJlHmx0CPqyuVazTJdch3HTlBTwMr477QOCqHAqCQfgNxNZW/WmdUPj3vEG3g9Nrw7Aa1ZOyfZA==
X-Received: by 2002:a05:600c:446:b0:3fb:fda1:710c with SMTP id
 s6-20020a05600c044600b003fbfda1710cmr846014wmb.2.1689931103685; 
 Fri, 21 Jul 2023 02:18:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm2947299wml.39.2023.07.21.02.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:18:23 -0700 (PDT)
Message-ID: <e701b036-52fd-0746-d5f0-e2b858010824@linaro.org>
Date: Fri, 21 Jul 2023 11:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 4/4] rtc: Use time_t for passing and returning
 time offsets
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 17:59, Peter Maydell wrote:
> The functions qemu_get_timedate() and qemu_timedate_diff() take
> and return a time offset as an integer. Coverity points out that
> means that when an RTC device implementation holds an offset
> as a time_t, as the m48t59 does, the time_t will get truncated.
> (CID 1507157, 1517772).
> 
> The functions work with time_t internally, so make them use that type
> in their APIs.
> 
> Note that this won't help any Y2038 issues where either the device
> model itself is keeping the offset in a 32-bit integer, or where the
> hardware under emulation has Y2038 or other rollover problems.  If we
> missed any cases of the former then hopefully Coverity will warn us
> about them since after this patch we'd be truncating a time_t in
> assignments from qemu_timedate_diff().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/sysemu/rtc.h | 4 ++--
>   softmmu/rtc.c        | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


