Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA51270F81E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oxz-0000Bg-8K; Wed, 24 May 2023 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1oxx-0000BY-3m
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:55:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1oxv-0006yy-6v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:55:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so829508f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684936545; x=1687528545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a6fSjh319S26h/k2r8NwOY8AqMPdFpMMQgUCsjr6qGQ=;
 b=t4pmhfIJq51DKdtCvnaRPyGi39bsLHIIVh7bcExrJD2g9KThRsRzHkerApyDvzwsfN
 thgr/OFEkr5AqUjA+KfDVP8gsAuvq9v7DkX3O8jrhfbobIH6t9krewod7H3kGogfRj1a
 f1+uQEmvjhwXCSMjzCBkO7k9KVKzUK99OVUTNFdAE+CHw24iSnOtu9gEJixiow6JshMt
 sSTYyXUsWXSpavuOmPJlFONZqd2cBihaZXQiPyMz/E2BxTISqJ0xOAro+/qWMC9qj6lH
 LlxTnF4aB9fIYAK4vNPJ9fHRoSkJmXj6ygY8F2wTb5Q7HIaIn5Ng57q7gCS7kbv7m5k1
 5jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684936545; x=1687528545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6fSjh319S26h/k2r8NwOY8AqMPdFpMMQgUCsjr6qGQ=;
 b=eVa5+ujnFgaGxFGqD0WM9uhg60aJx3JDcWb2wDwz0Zenron0cVrEf2fHDr1gZKPOc3
 +Ek25vg/D794TOUtQsXLSrOsY2ev5wqw3MFQN34O/HI3v2bRlyX26T5lf0xhSZEGSonU
 bURkTUUhdipv8zWQqb5a59bWPlcjP28SFQ4R8vndmqTlpLaiAAD9atsoXOU140V5JtEI
 Hg7f/s2dsWL++8ak4xYy1K8I5QWgf20JslIdQ5mCbnRSjjJfcG7MyIxYB4VacONx3s92
 2pbdZecuBSnx8BlQD8SMYhXqS1GrLZ2raVLo5wcGC5onIySUb8z+8A1rrvWMneTtdvtO
 05gQ==
X-Gm-Message-State: AC+VfDzj99dVprqaAcitVRXa9E85VNOKUD0uqxXoPvyavVF2PxLQGmfF
 wtRqapMOPhsDbinLDyPivurTOQ==
X-Google-Smtp-Source: ACHHUZ5iN8lxxi/XI3IVDp4DH/yHcrpMqW0nfZCoyIllPU/M24darlm7HvYsMsZiVyoC4cV2bseAdA==
X-Received: by 2002:adf:ee49:0:b0:306:3b78:fe33 with SMTP id
 w9-20020adfee49000000b003063b78fe33mr13563036wro.32.1684936545256; 
 Wed, 24 May 2023 06:55:45 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr.
 [176.184.31.193]) by smtp.gmail.com with ESMTPSA id
 o9-20020adfeac9000000b0030633152664sm14639606wrn.87.2023.05.24.06.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 06:55:44 -0700 (PDT)
Message-ID: <a6f38498-8717-46ea-6aeb-9d85e6be9c1e@linaro.org>
Date: Wed, 24 May 2023 15:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Use MachineClass->default_nic in more machines
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523110435.1375774-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 23/5/23 13:04, Thomas Huth wrote:
> These patches are required for running more tests with "make check"
> on builds that use "--without-default-devices". By marking the
> default NIC in the generic MachineClass, the main code can decide
> whether the NIC is available in the binary or not, so the instantiation
> can be skipped if it has not been compiled in.
> 
> See https://lore.kernel.org/qemu-devel/20230512124033.502654-5-thuth@redhat.com/
> and the other patches in that series for more information.
> 
> Thomas Huth (5):
>    hw/hppa: Use MachineClass->default_nic in the hppa machine
>    hw/alpha: Use MachineClass->default_nic in the alpha machine
>    hw/arm: Use MachineClass->default_nic in the virt machine
>    hw/loongarch64: Use MachineClass->default_nic in the virt machine
>    hw/xtensa: Use MachineClass->default_nic in the virt machine

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


