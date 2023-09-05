Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA079228E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV4j-0003sR-Aq; Tue, 05 Sep 2023 08:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV4Q-0003WU-8z
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:22:16 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV4M-0000t8-Tu
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:22:13 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso37284691fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916529; x=1694521329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mr+5ZH3u0P7meL1erw8CVa+r7WQNyOC0HPVh5GzsMyI=;
 b=ZaZjCyOXFQz+5zQm/YYcyPlJXHfsJwkTlVdzPU9Zo83ltWS/ZhiHidLyDcIzzG/uZY
 TyL1rbkYHDG74KfLHU+Ci7GyKTCRHUCeTy9FCNKPG5qOiWHFwvniqwV5WKY1NPJx3ffn
 OUxgkDxfCvPq8nwSVT58A/S3gqqRxCVIX5fRluA4V/psSaUTdRsVqATvLAMEgX5w6GeQ
 kFfvd623ly6vBuNf9hwUEUlqiyLsdFs9z9U9k1erW83+N1HUAXSDWfK1gTIKZUAfzToj
 cyzOdC2YTZHi7T0zLy8yaeK2A7SfUrFasg4+mtUDECo69lyU11hpW4bl57Mu7gbj1oTZ
 nyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916529; x=1694521329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mr+5ZH3u0P7meL1erw8CVa+r7WQNyOC0HPVh5GzsMyI=;
 b=K5pka2TF+sPmSFbs1JON9M0shIO1pbtPXUtBJVaR6JsIij8vLe7Zhkdp8jq9yJwC52
 S445XCRa+EHHuEmcy28cWktlUgUX6Lkqr/N+L12EGccGCbPqihzO64zpn3lhJaRPJaY5
 h1zUCic0qnDT7qgXk6KddjvNMzcRtfZCyK02iNV9TBsgUY6XxDEyPf2FIhNom9ZS1PF7
 ZCF01nsvDQI672uW7LgKTgMr7PFwn8DFxnWE9mvXCj/AXa7kMnuPBF9AINNhaGGbHki0
 I25HVbW3yh5rnuAIeGjs8oOqw65C/coldGhCbFUDvztyxZh/LnXlriUW7uEBj2QKoqsY
 SE4Q==
X-Gm-Message-State: AOJu0Yz+Y/I2QKXsaViuovJtcze1C/vfF/3iwVivFYOBOog1O29xmfEF
 hZDNbg88LWMfWpuNwM3Qnmrs53vwEPN9Ebedlxs=
X-Google-Smtp-Source: AGHT+IE7HDyJrQysj8lLFxucXBzfwzRVMvTQ/15XtAR24Yz+30WKWUxDpf4WkHmXZ2rT25oZ7Mr2+g==
X-Received: by 2002:a2e:9c90:0:b0:2bd:16ed:517f with SMTP id
 x16-20020a2e9c90000000b002bd16ed517fmr9368897lji.4.1693916529093; 
 Tue, 05 Sep 2023 05:22:09 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fedcd02e2asm16736177wmg.35.2023.09.05.05.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 05:22:08 -0700 (PDT)
Message-ID: <3621d12e-67ab-4286-b319-fac2cc77a763@linaro.org>
Date: Tue, 5 Sep 2023 14:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 0/3] sysemu/accel: Simplify sysemu/xen.h
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Anthony Perard
 <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>
References: <20230905122100.5787-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905122100.5787-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 5/9/23 14:20, Philippe Mathieu-Daudé wrote:
> Trivial cleanups which simplify "sysemu/xen.h".
> 
> Philippe Mathieu-Daudé (3):
>    sysemu/xen: Remove unuseful CONFIG_USER_ONLY header guard
>    sysemu/xen: Remove unreachable xen_ram_alloc() code
>    sysemu/xen: Allow elision of xen_hvm_modified_memory()
> 
>   include/exec/ram_addr.h |  8 ++++++--
>   include/sysemu/xen.h    | 24 +++---------------------
>   2 files changed, 9 insertions(+), 23 deletions(-)

Oops, this isn't v4. v1 coming...


