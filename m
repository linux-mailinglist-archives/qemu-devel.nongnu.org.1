Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8987777B1
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4In-0005jQ-KE; Thu, 10 Aug 2023 07:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4Il-0005hh-7f
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:58:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4Ij-0000K8-N8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:58:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3176a439606so765358f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691668680; x=1692273480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WI4qJmH4MM3DDvI/+sT7SSTHxR37DyKdvXPFoMRYwAw=;
 b=ULQSkKOxrhZZJY7ADr3ZMALwfLFBRauEhkr0YIIBBugvLrdJLTBPGN3d0u6YSBrKb7
 A8T2nT4HUyRV85U1KYZS4oUacKeXcDn9/QtKRl+7OTf08vb+AjjaGYyS0pCWZ48ccPqj
 jwuoSHYCjAFV/dwJAvyPeTec4DVE4CoLjsRdG/WYRtszJBv/hvT+NKVyIrxp2nQ2cfHq
 iNgRKVIAKTfzKjK9lwkrdK5bFQLS/Qyut2Ke1acwk84iHWVt+UmR7Rz91i7AqiGH2sx2
 z/Pm9x+80kCObJY59o1k2K6vmP06voFbOTwKRqBlZI19ZDk0CmqPie4k9yStjXpJSq1x
 ylLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691668680; x=1692273480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WI4qJmH4MM3DDvI/+sT7SSTHxR37DyKdvXPFoMRYwAw=;
 b=EUj8jjpCORFeo4/s/ZuGDNFECMn46IkZouZcHc2p0ItT79/KECJB01AcV4wh+yzQHY
 UZLYHG2nTMIs/uPrO1/Kl9ucoKkswJWPmjP26FEDCNDVTX3FwYtrdarYHHM2e86iMHOX
 YnPWl2+cSx6vcaX9EpIKjxUcm6LAW1yMDL66weQOiQAgWv05doFUzwBuThVxR3/WivXg
 /0OTF+s4dt7+IbLco/p+ANuuUGcaaBWGagpDNQGgWT1+AtYshhHaRkkvV1bYCZIk0btD
 LWMsMCP8TdGB2HWguxe2DU3Fx28RgyyKMpHPAMEybji4azNADOMqwsnZ7nhKgPJ9AON0
 V/Fg==
X-Gm-Message-State: AOJu0YynWqBHaOlFR8kptDm3+E8mqLjQXMPYBmYxucfxAvW1AaZIB4KF
 QWw5/lV+y13KYvsdUujfqES/FaboX0Zbhj8fC54=
X-Google-Smtp-Source: AGHT+IHVrxRN/vkV6oZXPzEAC2iSkgWryrY0po8uwFq/uU0Kw6l6GXRSeMsm7PWmo7LX70k8NO3bjw==
X-Received: by 2002:adf:e905:0:b0:316:f25c:d0b3 with SMTP id
 f5-20020adfe905000000b00316f25cd0b3mr1881289wrm.22.1691668680142; 
 Thu, 10 Aug 2023 04:58:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 k17-20020adfe8d1000000b0031455482d1fsm1974671wrn.47.2023.08.10.04.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:57:59 -0700 (PDT)
Message-ID: <47cf1576-023c-a155-262a-72b5fb843e53@linaro.org>
Date: Thu, 10 Aug 2023 13:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] configure: fix and complete detection of tricore
 tools
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, alex.bennee@linaro.org
References: <20230809082946.747668-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230809082946.747668-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 9/8/23 10:29, Paolo Bonzini wrote:
> The tricore tools are not detected when they are installed in
> the host system, only if they are taken from an external
> container.  For this reason the build-tricore-softmmu job
> was not running the TCG tests.
> 
> In addition the container provides all tools, not just as/ld/gcc,
> so there is no need to special case tricore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


