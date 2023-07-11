Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687A74F5A3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGLy-0007Ik-Rm; Tue, 11 Jul 2023 12:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJGLx-0007I9-0y
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:36:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJGLv-0003BJ-IY
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:36:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso6810556f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093397; x=1691685397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zaZyB+gGPCiBOtS5jBYwWmvnGFyFk7ZMSKSdT+Oem+E=;
 b=DmGJ5nL4JsOwEFJcH3z0oEt3ULFunqGh92BwmzducgX9bAS3jWcJjNaHfljXYfrmFg
 Radd/3QjzV82mfcDtlp5TGUWzf7Pg8kaOoIBdcHfV2hXTvyFdBamiHxi5shuCBdQL3aW
 mOrBlR8gpfdvmxyd+coQs7MettAAkg+OFMZwf54rQJExS15kNzY+4Nve/DRwTo3A8gYn
 Cfo9VmxHjMHgUX4jzo08ThkKVbfE0QoWguGb4liwKlAzKW/7/vV8JAKktPE9Be0D/zZN
 5sw1r6och8DOomYEXnHGzLUegLHG7kCuJLeT8emBve/K93phUpVLu5QRLulsf1hgVpJC
 bsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093397; x=1691685397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaZyB+gGPCiBOtS5jBYwWmvnGFyFk7ZMSKSdT+Oem+E=;
 b=PC5lPUMOaz+UlEXd88juzz59+EbxDL3R6k7x254mQIPkOla4qvvRDU0wbJ7CNaioUu
 dhuGHY9k8pIFcC8EK0W7AgGKRJq8asEUR+2167hVn6akZSMUmbJMtVUUlNO54Wn7xyGy
 nsGA5dIK2RCO+2TUbId4lM5hr/yk8ECAUOj1UZk/eZ5LIKIMnwmI5CLi0jQULwJPFG+/
 a0ICDzUERnIVp3MFUVR0XOs9zVi/5sLuRP12v9PnPQ8RAw+7oPii3NKGsnx9Lez8yWO1
 tk1T5fPXOiuNvsf0fw29UriovLLGY0ZAUtYANo65xRbvfByC2QpM3SHb3XHwXSs11iZD
 2GVQ==
X-Gm-Message-State: ABy/qLbzSghRXjTb4g2KMcIoT8LLwxFKIIl7th/Xwx/UYDgyhB8RbnBn
 YxAXkAzgKZZN7PDdKGiklhTNaQ==
X-Google-Smtp-Source: APBJJlGhbl0P9wKxGSjjz5wb6s0JEkJGVzTtVeA0BquCel7Bu1nNSHwXMMM4cHYytMQh1OOM0tmfbA==
X-Received: by 2002:a5d:4404:0:b0:314:46cb:880a with SMTP id
 z4-20020a5d4404000000b0031446cb880amr19880908wrq.28.1689093397453; 
 Tue, 11 Jul 2023 09:36:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 i17-20020adff311000000b003143853590csm2655663wro.104.2023.07.11.09.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 09:36:37 -0700 (PDT)
Message-ID: <c4a48824-ad33-29ce-26d0-fc1cd92b7a7b@linaro.org>
Date: Tue, 11 Jul 2023 18:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] s390x: Fix QEMU abort by selecting S390_FLIC_KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230711151440.716822-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711151440.716822-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/7/23 17:14, Cédric Le Goater wrote:
> If QEMU is built with --without-default-devices, the s390-flic-kvm
> device is missing and QEMU aborts when started with the KVM accelerator.
> Make sure it's available by selecting S390_FLIC_KVM in Kconfig.
> 
> Consequently, this also fixes an abort in tests/qtest/migration-test.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/intc/Kconfig  | 1 -
>   hw/s390x/Kconfig | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


