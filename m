Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC69370D9
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jul 2024 00:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZvs-0003l3-O5; Thu, 18 Jul 2024 18:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZvq-0003ec-Gf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:49:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZvn-00075F-W1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:49:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b702be5e4so242542b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342938; x=1721947738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnzifrkCVXQf33G/mSVcSBj6NOehU9lUzCZfzNGmSiI=;
 b=LWt85Anq0Dodp8GLHJkDuqK12C5VaFKwZ5z6uiyQMcL/622SzV1sw5ioD9o3Bmfmb6
 kbo3D4Ix2dMTf1j1J91Y1+0vbixo/43HlaLixxWg4rg1dAPVd3ebeunerGzi4ygfJO/V
 lBqrXlmzmDeLCB64hkB54d1Zwt/pN0wtFKjDaG558VU6WNBqilDxvnl4HxkHn/rdUZ6D
 ocrDU88GIRTgbIKdqoPaddJQynQO84b3AyR08SG6crDn0OuIeA64oInW6qb45YOme8YB
 lR93zpfMSIQolaBdda7QMQOBVSZLnLrh59xzNF+sw0s68P3t7lvFtbRyNtQJccVs/DmO
 CdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342938; x=1721947738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WnzifrkCVXQf33G/mSVcSBj6NOehU9lUzCZfzNGmSiI=;
 b=NjMfUITP8tt2ozF8p13/xRifNwRfdvQ6E2dmZ4CRGAnbm+HnWJNtPP9lImuqVdHoaP
 irpJh7YkQvfqHF+98oUVD8xoD5KnD2LytxG4ZYpu0OI2VtfR/eZ8OUMBmivSfzhEtFZk
 US1x9RpLHEoJ4qORxau3f8SgY4YlXKVvy7bMpYo3RwTS4x5TCL62IfHFVIksySrHJqTe
 C+uL+Q+GNQo3tt5XNbO0+ZRwFzGMFjrOZn6AjhAwC4RlKORJ+3sASAQBbg+5oMi2rgFm
 3Vo2cXNy4bxdmwiprKMcEdPkqvpSM8zI2JA0lkfATno4K793SvYGW6eyrr0Al+aR00S1
 U5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmWm3nLkZMYk1Ps/MBPNIZZ83XvNRGdtW46oXzDgMEgxS+nBLIqKujAfjX4emEU0t68v8O2x85t30gcIzu5iobjoryMig=
X-Gm-Message-State: AOJu0YzV8M690dqLvjyiz/NQAJ/pKuTnzQmFE+qH1jkgHSvYfNUL+gEk
 y5Tr4jyw0EI8d1Mu36LnKfd4DVDlHtUfbnjPAaCcU4G21pHwTkSeOoDp0iE4Nuo=
X-Google-Smtp-Source: AGHT+IHFAqL0F3ln4oVXcZhRK2Fi42KdUmyB5T8S3IlByKc5wBUEz825lQ0aPIHWUCGaFKMYnCOlWw==
X-Received: by 2002:a05:6a20:9187:b0:1c2:8c73:f35f with SMTP id
 adf61e73a8af0-1c3fddb3e27mr8202836637.39.1721342938477; 
 Thu, 18 Jul 2024 15:48:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff5fc3e8sm49581b3a.189.2024.07.18.15.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:48:58 -0700 (PDT)
Message-ID: <b12fabe2-9599-405c-a17e-0f0b9f08c23e@linaro.org>
Date: Fri, 19 Jul 2024 08:48:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] hw/intc/loongson_ipi: Remove unused headers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   hw/intc/loongson_ipi.c | 9 ---------
>   1 file changed, 9 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

