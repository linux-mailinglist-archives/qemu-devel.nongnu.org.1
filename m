Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A5799B86
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:57:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5wP-00053V-7s; Sat, 09 Sep 2023 17:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5wN-00053N-Qg
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:56:31 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5wL-0000i9-OO
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:56:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-570a432468bso3047958a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694296588; x=1694901388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2um+TDoVFB1N5PmO+8NF5CYY5ADG50GTgnQh30pkUGI=;
 b=bJwKFhuernx79f5JQPDpxPC14jwLXUPhkMw/SBQiDaXMYQ6ZvVpq+jGkiLq8l7w3KY
 mjC46g7lz8Z8/snxUQCzG/0HdZlDNob49HQdhCUWCf27uPtoxlfgkfPJ2rbnVhOvdK1L
 gdwttp+GNMRxcLSm+HYoBdIKIam5nCNYDMLcJN4Sx78v5cmUIwXf3FHpDJKJrBod5rFh
 SXszzgVT8FElSvF5EoeNTrGaOK/mR6wmf7H1gYwtuBJ2rURjLOBIDRHK114VocrMQBYQ
 H5A5wcw4SqD+60SKvV57ZIAPt0aX7Jy/sh4UYPZVu9RcLTgGlraopItcbkAnjUrUsY4z
 I+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694296588; x=1694901388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2um+TDoVFB1N5PmO+8NF5CYY5ADG50GTgnQh30pkUGI=;
 b=GknEunjjGsMKvumTQE9at7S/r4rN5l3irU2E3BWqLLYWvuARNSI74R8m4hSoC1cEby
 pA/n9XPhAogJdMSBq7RWfiT4XGBLu4HoLGjRNEK+TFsr1l5TGwA3CiZIKaLM60HQCBr2
 D0e7OGiVido9o3cCfURe4DRshZd9MOWilJ7bFwuEe+y/yVdl0Rh4CibZcsqIXq5TEiDL
 4IVnZ5baakHSAHOGDAOLFRn7MKa4QcIBoF3JV/swWY4+/OONC4GkmdR9OOILDdxcWv1j
 pIbwx9uQ2loT9DVod2FQzFDRBmfgWjjmMxADxo+T/6j8KlHshCFb6PoUYP2gWPJJZNro
 kIMg==
X-Gm-Message-State: AOJu0YxbtIio/e0w6CkI9+vtDqL+/TDh1FJnSLzDJfPVtiYFT6xzJ372
 cV+/EC59rwFuwEIyf8DzJjQpgQ==
X-Google-Smtp-Source: AGHT+IHvl8GcZFISIqOjpSx86mwtxsh7ffgvT47hZCcbupKvb2AzNkf/PuE1q/VeJgFHX9NqJZ8b+w==
X-Received: by 2002:a17:90a:cf91:b0:26f:510b:b64e with SMTP id
 i17-20020a17090acf9100b0026f510bb64emr11773192pju.11.1694296588085; 
 Sat, 09 Sep 2023 14:56:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a17090a72c200b0025bd4db25f0sm3114902pjk.53.2023.09.09.14.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:56:27 -0700 (PDT)
Message-ID: <b28d7353-ff60-dd93-b473-5b1627eddb01@linaro.org>
Date: Sat, 9 Sep 2023 14:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 16/16] tcg/loongarch64: Implement 128-bit load & store
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230908022302.180442-1-c@jia.je>
 <20230908022302.180442-17-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908022302.180442-17-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/7/23 19:21, Jiajie Chen wrote:
> +static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi,
> +                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
> +{
> +    TCGLabelQemuLdst *ldst;
> +    HostAddress h;
> +
> +    ldst = prepare_host_addr(s, &h, addr_reg, oi, true);

Final argument here should be is_ld.

Since this is the only remaining error, I will fix while queuing.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

