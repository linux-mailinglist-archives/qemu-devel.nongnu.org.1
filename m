Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE2740969
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOYx-00008A-BF; Wed, 28 Jun 2023 02:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOYg-00006g-R0
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:21:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOYd-00068r-Iq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:21:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbaa534dd4so13435615e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687933296; x=1690525296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITA7xeeMbyFYyrG44CjGH1g3rAgN+J4GBUH7rEwmHK8=;
 b=wac3UTjbLPaPNW2rTDlNS87Rps8SIQeUwpadm1VC7JGMgC7T8IpWMDm2u5UQ+OGspJ
 OaxBgP6OHDos1B55aNwkbit1pav2u/gRwHCLAYbaS5fBvjEWnhAtaIAULB5lcWdC2b4j
 0pNFFtWgNTT+U8Dg+Di/UzvhHX+0tuPHpMyRziYc/O3bHqk7E6FU9JSN69mBZu2Qu09O
 kK/S+aC1E20XXmReyT11iLKZN3mujPo8x1EMTng/Srp4t8Dnb22nOOFTHXUbi7x0GmbO
 e0QQAfsvZpYF48xla0NBli3Ab2uEssqgRIrO8vrwra/rMgFhMxGhiYifoyVahxkj+S2C
 mBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687933297; x=1690525297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITA7xeeMbyFYyrG44CjGH1g3rAgN+J4GBUH7rEwmHK8=;
 b=k4t7oWqeW8DKvFlDnECdpll8NZrMX47L29xib/RjvGn9av5kNrl4uuNuJ8TP5+kAJS
 J6czGsFTTGPbeNspGHrYo4cR43psvjkBUddWMdatCxCoBBm6SmuBVtc2ioe81Vyllhsa
 wKIrjM78Dt/mg68UirKUdQt74/oDsgvM3oY4J4vguado00JoD2hVFLfWzxKC8pGAW0/f
 eDPliuH39HDwiWKBjZFNatKDURc4qgQhmNmib3BmO8UXPeKNOSKjwJVHWl+RaOaeONTo
 C7gRzsxIlaC2+BwIUD6nS1REjdzrFRL5bqGJ6Z2xF5SsI2nNbCI38iTJQ0UyjZHzqhvs
 XQZA==
X-Gm-Message-State: AC+VfDzG7Nc/p5593A0nNwg//zltNohd1/MMBBHrkOz/opAFkGnMKhwR
 ieZc7u2QYxzYWvgvSEfDu5i1og==
X-Google-Smtp-Source: ACHHUZ4tReJN45Zj/XQvmFOPCR8/I5GNQNNaz3W6EOfmA/b8RfgSbIYiXmrpZR3Njvx8Tht7JJaNNQ==
X-Received: by 2002:a5d:484e:0:b0:314:145:2d47 with SMTP id
 n14-20020a5d484e000000b0031401452d47mr3779172wrs.19.1687933296669; 
 Tue, 27 Jun 2023 23:21:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b003f90067880esm15700689wmk.47.2023.06.27.23.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:21:36 -0700 (PDT)
Message-ID: <91de0bfc-9150-ae82-1067-83946eb963e8@linaro.org>
Date: Wed, 28 Jun 2023 08:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/17] tests: Rename test-x86-cpuid.c to test-x86-topo.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
 <20230529123101.411267-3-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230529123101.411267-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 29/5/23 14:30, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In fact, this unit tests APIC ID other than CPUID.
> Rename to test-x86-topo.c to make its name more in line with its
> actual content.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v1:
>   * Rename test-x86-apicid.c to test-x86-topo.c. (Yanan)
> ---
>   MAINTAINERS                                      | 2 +-
>   tests/unit/meson.build                           | 4 ++--
>   tests/unit/{test-x86-cpuid.c => test-x86-topo.c} | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>   rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (99%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


