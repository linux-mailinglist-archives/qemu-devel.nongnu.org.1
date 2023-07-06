Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D887498F3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLqA-0000vS-J7; Thu, 06 Jul 2023 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLq8-0000ut-I9
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:03:56 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHLq5-0008N1-Rq
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:03:56 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fb94b1423eso617050e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688637832; x=1691229832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYjWj/1a6y9A6d3F1DFRMrQHLg9CzgX8+fuE9Xq2eTA=;
 b=fojw2j7Ki1BnAZ7jwtaPiaprXt51n4+abAvpmcenuCl1N3hOTpbG4PmgykpTmDuRER
 S2ODyylQ5T1blhghxYaG3nKVtIJgo4EuqqSPpklcrGpk6abJlaEV2wDD/8zs3ElN3Qbw
 KRwcjpUdCuznycHyVHsZPeRhCGhx+R6koTXDzIr0C3o8GojnrDcYLgqJ86tF06UKKjWc
 8DjZFrNPaCztke1KFfZwLt6u7WRAPHd+LCK6MZNqCoz54DNfdgNpInlfUJnxZ/tF8UjD
 iejW3Xt1rPMW/MMq5OrB9hVawdcL0j5EtIsZg1F+/2HX006fkyXzrseMsLHPJWJDh9dC
 4uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688637832; x=1691229832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYjWj/1a6y9A6d3F1DFRMrQHLg9CzgX8+fuE9Xq2eTA=;
 b=Yg1DSWZbzsI4qIILyOO/Ib/ERjmqEiwHRAhlp8t9HG1+DTnGM+MZnFFLjJ/kKm52kh
 Z0Szt9YRe4dl0EI9gxwwhjBrlXgh04XuLPqfNKizdEFO4Wuy7PH/TRCCK3LOUf3TulcU
 QdjSvSs2B8GaLHIYNbuI/2S6X8ETnGdqFRUNtACq2S9lGN9uuWFmGac9I8iPMfY0zOef
 CDcKEOYz9ZPhy4hzjIV+7OzFPnrXisx0J2TgnquVq8eeMYiq5ykRnZIHRLdfFtnxLXyN
 NkFixS8V6JSzj+24kfXzC22IMn7/s2pq3qfmeTPzmha5XNpWPukeqs4PA7euUkDt3oDt
 Bpzw==
X-Gm-Message-State: ABy/qLbbL9yad7vakToCngDBctWAyG0rWBQDAADM3ug+XEp3OcllozdP
 +GOeMzI0VMhgE6b00CgvINBSTQ==
X-Google-Smtp-Source: APBJJlGBXAMKjpUK7EuKuYtohrhovzkdJsVrny9uQ3NpIeVVTRpAKrv450YTKYrtx8GxGAGqQ9JGfg==
X-Received: by 2002:a05:6512:3e24:b0:4fb:97e8:ed8c with SMTP id
 i36-20020a0565123e2400b004fb97e8ed8cmr1344761lfv.4.1688637831923; 
 Thu, 06 Jul 2023 03:03:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 v19-20020aa7d9d3000000b0051e069ebee3sm575022eds.14.2023.07.06.03.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 03:03:51 -0700 (PDT)
Message-ID: <8ada3ba0-1b09-93aa-a5fb-55ca08c8ef33@linaro.org>
Date: Thu, 6 Jul 2023 12:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230705152301.2850086-1-clg@redhat.com>
 <f45b0555-0808-0e99-24cb-fbf24bc2277e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f45b0555-0808-0e99-24cb-fbf24bc2277e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/7/23 11:38, Paolo Bonzini wrote:
> On 7/5/23 17:23, Cédric Le Goater wrote:
>> +    imply E1000E_PCI_EXPRESS
>> +    imply IGB_PCI_EXPRESS
>> +    imply USB_XHCI_PCI
> 
> "imply" should only be used whenever the device can be created with the 
> front-end/back-end combo command line options, and as far as I can see 
> this is not the case here.
> 
> You could set CONFIG_PCIE_DEVICES=y in s390-softmmu.mak and make these 
> three devices "default y if PCI_DEVICES || PCIE_DEVICES".

"default y if PCIE_DEVICES" for *_PCI_EXPRESS.

