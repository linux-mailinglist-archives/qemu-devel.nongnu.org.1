Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DE7715AF
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 16:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSeww-00082A-9t; Sun, 06 Aug 2023 10:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSewu-00081v-Lb
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:41:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSews-00031e-Nz
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 10:41:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so2438278b3a.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691332897; x=1691937697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T+0O69Ci6r8kxsB+4DOghZXaog4XZB6uAxv+uMSnHSY=;
 b=wLuCKlIR87UfPIg1Rud9K8pQD6ptt8IYNvGgqbnANGe5jUccfmbb32V2zzYMZ6SHG7
 oKHl5Cmlu60vcYTbxBG3WPkFXOXdMY9VGT7JjWu54hYaavB6amq55OyHaMgbeqxKSviX
 m6dFgZRhAsqrO/DngEb67s5pBHH/JlzfUx4+27/o1nQYlIPJSr5XVrb4i5BAdYh6MEnY
 fdEgr8jBWKUt3sZcbpkjDJRiCQCTAYXtC7p6qauq1cVWI7V7utM5CptJDCPWfyUNgtll
 KobG+1rNtmygNPf5Rf4WZUIBAN4R9B8LoGtGvq0BYFV+Z+2ESJjLQHC4Xgu388j5wn/c
 pkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691332897; x=1691937697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T+0O69Ci6r8kxsB+4DOghZXaog4XZB6uAxv+uMSnHSY=;
 b=eeTskwGjVZ7jA0k/WTWydJOLIKDX4zMMC14iZboXpxgt/JOyD+sScJsEKdBjt4xz+P
 Y/xw+SUI5iNtzIqY/M0PUb8DAhZ7h3aMXh6YfGZp+qohpv2G2nldh/BP75HByR/kG7Bz
 LZD0T7Aa2ltX+7+4E2rVKK3wfLH4yhs/69ijAwkRksGBmIc755a3GGVTldvPh2BOdYWy
 QwfRmz480jc/GMp79mAELtbanzsQYRyASuMbJtTJlwbtLmzBt0FAH+Dmn8UsCqwiLvbt
 6O5r+4HySYAh9LN2q+fKvxrvjN9/h8U5zTW4s+jh9s58eI3yZLSiI0gkLN2Zh4PvDzc3
 Zklw==
X-Gm-Message-State: AOJu0YzOPapZw8VNEMcdXaqId4VbjxtoCUjGDHIc13yztXJbAFNL0cdI
 LwJSO+P46AoGlGwScNfGXBreJNAisCc9WSXkFlQ=
X-Google-Smtp-Source: AGHT+IHLIrdEMgSEYlqDiHzeX0idh0ouEAkmN8R95YCh9o2fd2yf7CXUNLeQKoiTyz4TQb21gMqnEA==
X-Received: by 2002:a05:6a00:c87:b0:687:2f80:86d5 with SMTP id
 a7-20020a056a000c8700b006872f8086d5mr6757818pfv.13.1691332897283; 
 Sun, 06 Aug 2023 07:41:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e72:57bd:c5e4:990c?
 ([2602:47:d490:6901:e72:57bd:c5e4:990c])
 by smtp.gmail.com with ESMTPSA id
 bn10-20020a056a00324a00b00687a4b66697sm2698737pfb.16.2023.08.06.07.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 07:41:36 -0700 (PDT)
Message-ID: <c5c5f247-6b2d-36e1-c144-53c4a99ad5cc@linaro.org>
Date: Sun, 6 Aug 2023 07:41:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] target/loongarch: Introduce loongarch32-softmmu target
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230806141357.1756714-1-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230806141357.1756714-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/6/23 07:13, Jiajie Chen wrote:
> This commit introduces new loongarch32-softmmu target. Compared to
> loongarch64-softmmu, the new target is different at least in:
> 
> - GPRs and CSRs are 32-bits wide, but FPRs are still 64-bits wide
> - LA32 lacks some 64-bit-only instructions
> - CSR.DMW0-3 introduces PSEG

Let us not create a new executable if we can avoid it.
We can run 32-bit cpus from qemu-system-{x86_64,ppc64,aarch64}.

In any case, the patch is much too large and must be split.


r~

