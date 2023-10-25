Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087A7D67D2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvakd-0004ht-B8; Wed, 25 Oct 2023 06:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvakN-0004gO-4M
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:04:19 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvakL-0000QO-Ay
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:04:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so8236399a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698228255; x=1698833055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E07m1KQ+cVLKozsbMNvcTmo++/R0dnqEoi53XpCZ9dw=;
 b=qL9PYoiRNGlVn3MBRjH7Q6gCkOD0zpfPvD6gT55ovXt7tDUdEeKLiPy72sYXgkXXRg
 R0f9JofdE3tn5n5L09e8/PqoB8dQ+DRNLSHpnYqcJWoHAa72ktdn0u7zd7BNceV8Q/yu
 /qI3RIeAFfXtaHEf5wsVLAtGnLPeJH4p/MV8iTFbbBP2rXaE7+TZItzmOc+HMs84Q7Nx
 M/TezwMh+wD4QEyoOgKOkxhd+G9kWZUpNmroMwYLH2e7Gxf6JFjD+2hC5w0bonX2m3MH
 D0qzhx9ySniS8ijE4bEpmsTfLLZ/JhepVJsr9LPc8Dbwi4JBfdCCndfvJH56LGCj63i0
 LSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698228255; x=1698833055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E07m1KQ+cVLKozsbMNvcTmo++/R0dnqEoi53XpCZ9dw=;
 b=vJNNVOygStSTUxzkogcJ5cX8zUbQx68Ngxbp+CgQk8dpXP3vgkhM2STpm4nTIs/ezx
 djNQSIcRIxy5VARVRv+Q5simKi+aQ/XVMIo644gZUK9lb9Ji99l1x+MS1OG9UB7QLYZl
 M3q0v3kr7jLCEjpL8l/95L+OKef0iRV0HqU4llea2SuhaxsJN/nUmPtPl76HppiEhiEL
 9LLSHsRWWB+3g8Wx3n0tYcHrIKukPYwIuBhqETKQf2ycBFxnP0gWK5Q5jjNr0JHX7qWI
 6Y4p05dGZIDXD3FCtOShAptWjG1S80LH7hNVzY2oPmmGYY7dyOTGGdcIkjTyslicHvJ1
 Ja9A==
X-Gm-Message-State: AOJu0YwOW2p+lFOppCLULCazeua5/KJPLyXcAJ7lcbKJrWfdt6JD6gRB
 I3Hoi9o+OmETMajKjBGVffJmqg==
X-Google-Smtp-Source: AGHT+IFu4C4nJoDUS1cCKnTbVEqLEqleij3crCqPhRsgLwmGJyiWZWJpkv2dayHVAyIrh8+vGTvqvA==
X-Received: by 2002:a50:9e24:0:b0:53b:9948:cc1f with SMTP id
 z33-20020a509e24000000b0053b9948cc1fmr9452686ede.12.1698228255381; 
 Wed, 25 Oct 2023 03:04:15 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 u17-20020a509511000000b0053e163a1ca0sm9497669eda.1.2023.10.25.03.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 03:04:14 -0700 (PDT)
Message-ID: <9a8e0ab9-48cf-777b-92ac-cd515eec0cf9@linaro.org>
Date: Wed, 25 Oct 2023 12:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 00/20] Support smp.clusters for x86 in QEMU
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Zhao,

On 24/10/23 11:03, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is the our v5 patch series, rebased on the master branch at the
> commit 384dbdda94c0 ("Merge tag 'migration-20231020-pull-request' of
> https://gitlab.com/juan.quintela/qemu into staging").

Since the 4 first patches are not x86-specific (and are Acked
by Michael), I'll queue them to shorten your series. I'll let
Paolo look at the rest.

Regards,

Phil.

