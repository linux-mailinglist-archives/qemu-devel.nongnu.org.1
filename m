Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE717E205B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:51:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy6D-0007nV-G6; Mon, 06 Nov 2023 06:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy69-0007fh-C4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:48:53 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy67-0005Yl-Q2
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:48:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so2260854f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271330; x=1699876130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBGTGX02jhQOKGxROPSlWdbV/6HszDTwcl/KIC2ZBgE=;
 b=eJqDUZIaoui3a78kz1Cb5GGO+zL0OHbpf2JLgyBsRX9uDFZC6n0k5YpBmBdgFkiRn6
 I6eCrg8Q8Wv1XLvxe0aIIoKANVfM+xy13fMMiMipTjsseqKoA1WiMUdRbpYBsrj1ajMp
 te+NuatdDdfIkcA+9MnL1TNY1uRTixwcJxTM3kS4vvA9VDgW7Fh1bw+QCOsX+GNPbiWv
 WffjgBRHEzBnW2eYRFD8wAB9kMIqarUSwOT17Uj75rcXFrzOLc0SP4IC9Q+g/hhPtlcw
 pviNqTT2ICZj94BNVu1wXRmuKoZHRNUfSNh8q4pul8zlVDHiSDQuBOw0GjU0mx3MPSM4
 uQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271330; x=1699876130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBGTGX02jhQOKGxROPSlWdbV/6HszDTwcl/KIC2ZBgE=;
 b=G/iJXCpBZGSNQx1f2AWkDIsDhkErvJgTTovfRFJ/HFghvrrCL9XM+kvTB2WE0vEI2M
 D0IHCF/8fvkF8knkgLSgG2jBjc0khgoQmN+3hH591iJN8Q9IJjVBM85kE9nJflDE3ANr
 yf6n7FsKppc8qASTnBTqxtasBJpDhguzchMBMlpkMQRMGvLz013iWaW6okBfzV2X9+jo
 moW7pVAOenG+f+8FRd7e9NknQkECJO+63xdgG3pLKn3CQwBYvrxyoW3TXMIHbZhUVGZp
 T+2qnDiMLvbjOTzz4K10xLU0JohrcW/hquYI/SxtDcWuY7ocwb5t4ggEwx9g4I1hvIvT
 mMqg==
X-Gm-Message-State: AOJu0YwXtDDwS7KRNA5Za7dRgeF0a8DVZevCQnVQx3XeI8dw4N58dah9
 uk0OcVNzr6iZSZy9g/5IFd32qw==
X-Google-Smtp-Source: AGHT+IGHvxTZDDs9OAT8zAdw2GCM9ufnPvaAKH4Vpiny5o3RyG74lqWyr+eDW1q45VYWkYp6YdEIQw==
X-Received: by 2002:a5d:5e0a:0:b0:32f:dcce:bf38 with SMTP id
 ce10-20020a5d5e0a000000b0032fdccebf38mr78112wrb.62.1699271330359; 
 Mon, 06 Nov 2023 03:48:50 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 m1-20020a056000180100b0031980783d78sm9230335wrh.54.2023.11.06.03.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:48:50 -0800 (PST)
Message-ID: <1507130a-006a-8adc-3acf-359e3f7c0998@linaro.org>
Date: Mon, 6 Nov 2023 12:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/71] migration: Make VMStateDescription.subsections const
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Allow the array of pointers to itself be const.
> Propagate this through the copies of this field.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/migration/vmstate.h |  2 +-
>   migration/savevm.c          | 12 ++++++------
>   migration/vmstate.c         | 15 +++++++++------
>   3 files changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


