Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2C797259
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:33:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeECV-0005rn-0N; Thu, 07 Sep 2023 08:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeECQ-0005hr-LO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:33:30 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeECO-000253-Ec
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:33:30 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so1184238a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694090006; x=1694694806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5Zv2w57Pu5zvBv+RmRMWxTLLDD5033YVrG2FGo/z5Y=;
 b=LcMceTxzu9NQfLe0J6Nb3rL1RA5vIhWqviY6bmTtPkjx7IcZ+2Difc0YJotFr8baqk
 3iFU9yYTB+La75JVYU70+Mv3COwRSsFL3JImMh9yWO4zv2qyDL/PVp34D73DkBBOy0Lu
 GcFhIi80lQsgLEdOrpKLbdsqyMmtHW6W/6LS8VVXm4lXDanji41khWOijm0i3U/a5oOY
 O5lq20YEu+rPXOvI5Rzum80rEKy17nTeTVE0a3W80zczdPJb0Uzp8zUoNe9AmzeAPG78
 VZGEIU9tjh/Lax6HpHK1b9Vr/8Q+wuCjhgnm6Baw8LxSskxEfqaiQm5q2pqPvs8Y07R2
 Y86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694090006; x=1694694806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5Zv2w57Pu5zvBv+RmRMWxTLLDD5033YVrG2FGo/z5Y=;
 b=jO4Kx8IhMSh8Jh94ljZBZbHf3Bbd9WigQtgzafgzZUPXLFZsYwxE2oBLFTsHSO6ISr
 kv171jY84rlaHBRI9GiM3g+oR9yEEUL8Hy3pvcGTahlKOrYY4OSo2FOj3NhBHld3Szac
 GsfKzx5E6t3PQ+eoE9ncDq5f32HpG6DXvJjUL9deR0xvdHujqyPBe+fN79+EEyJfC3jG
 zlbBpYFRJbLigiVY8gVlItfj37zSrQ6rXy+BzcSIH6p6yhpiEcZe1IMyl+9SkLZEf3ka
 EuVfbGOr67xGEQvmuKgcaKV3dRHdRCDSAZM1rELjpd/MbqnrjaAqPAsHuuvBQ4Z4dh12
 klkw==
X-Gm-Message-State: AOJu0YxtB62BIjnh4InT+RDm7kWNljEqdytcbnliOXdrstQ//wo9x4NO
 aoknKaxpgLOYTZtnr9EX2DBbyg==
X-Google-Smtp-Source: AGHT+IFiyeAxv+PcElS78SKV3hRLxkrNfqZ4f3aObhMItsMGt+ctJOtd8El6PUpyXS64y9sUPU6UFQ==
X-Received: by 2002:aa7:c485:0:b0:525:7f37:e87a with SMTP id
 m5-20020aa7c485000000b005257f37e87amr4585262edq.16.1694090006446; 
 Thu, 07 Sep 2023 05:33:26 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 w13-20020aa7dccd000000b005256e0797acsm9717904edu.37.2023.09.07.05.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:33:26 -0700 (PDT)
Message-ID: <760a2e78-9e8e-8c98-4c58-3e2c560bdd44@linaro.org>
Date: Thu, 7 Sep 2023 14:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/3] hw/cxl: Push cxl_decoder_count_enc() and
 cxl_decode_ig() into .c
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-2-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 7/9/23 13:35, Jonathan Cameron wrote:
> There is no strong justification for keeping these in the header
> so push them down into the associated cxl-component-utils.c file.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h | 18 ++----------------
>   hw/cxl/cxl-component-utils.c   | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


