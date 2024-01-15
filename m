Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112F082E172
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 21:18:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPTOO-00086c-1U; Mon, 15 Jan 2024 15:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPTOJ-00085P-Lo
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 15:17:03 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPTOH-00081y-J6
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 15:17:03 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so7932590b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705349819; x=1705954619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orfheqfIjpc5QbZXYJ06+FmeezWWMsnM+s+VAsfR4xQ=;
 b=WopiEm9pTCjdEfwPphWL0bo+//u+EqFAK8SqzbuuRphMwzlMcBFJ8VhgltdyLya8sM
 4smgObRSEHZAY2u1oTFitGI5fiNHb5xkryqQXFoUFw5pGyjAN85g0jzBn6KvOlU1jZdb
 VKB6a1dayjthopBvkLo+lartox8dblZiH/csMnq4eEWY63tijCEFgabm7VWuC8Lsp0I9
 MrBN4tUhTOYDfE/NXRgQaoK4Qxq2/u1Ih9AMmnJByNUZqW5cirmOWQvUrFNBhoaGzwJP
 2VBsAdhbGXPo+89xU5bQP5taQmP/1BLzffie9WSB2tEB6VGcar6rGaONakmV/VxsrhgO
 Udgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705349819; x=1705954619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orfheqfIjpc5QbZXYJ06+FmeezWWMsnM+s+VAsfR4xQ=;
 b=vzO3/44XXxhAYn11pvWu4Y3SYYUTUCFm6dVVMklw4oSmznss7a26YkHnOlOqtxHQoY
 HxBLyLjuow2NoLELNOQx2gwFB2Ni9NDqOT/BElfnFj3hiTcg4ctcRCzsqVCr9AL7ZyFs
 JutTBr5vvcBXvyyhlEr6YV7wBcMs+Zl9PLepM3YcB0Cd1Ue29ac9QOHwX6+i9ndXWBGI
 NIIRdEfpdXJx+L5mOZApVENglmNJFDBy9Ct/d6vOLhfrycWecn0fU8xg5baOUS07bjh9
 G0K6KT2YrF2FP7O6/Lk2b4GOFXRx7QO1soeJHU+guwfYJ7aoGIGTadZDa4vdBe97eqsU
 ypzw==
X-Gm-Message-State: AOJu0YyN20+Omta7cjTF48DVfp/3j3X0J/YwrZYBpnEE2BHMhxX5ZWMv
 aGNp1Z+sD03BlfI98VK7Ktdh+YWMwDVPXQ==
X-Google-Smtp-Source: AGHT+IGlJKM1qGMPY1G/MdELffRUhAOAai97hEcpNcRoufSWHrIWEfBw4HXm8RtGZQw9UKwGwm82Vw==
X-Received: by 2002:a05:6a20:e606:b0:19a:e284:5b21 with SMTP id
 my6-20020a056a20e60600b0019ae2845b21mr3091791pzb.74.1705349819460; 
 Mon, 15 Jan 2024 12:16:59 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 ky16-20020a170902f99000b001d5af7fbda0sm5090942plb.122.2024.01.15.12.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 12:16:59 -0800 (PST)
Message-ID: <497a1756-c936-4681-98be-303cbffd6918@linaro.org>
Date: Tue, 16 Jan 2024 07:16:52 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] trans_rvv.c.inc: remove vlmax arg from
 vec_element_loadx()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
 <20240112213812.173521-12-dbarboza@ventanamicro.com>
 <32238550-8008-4771-9a1d-755be8c19384@linaro.org>
 <dbe10a18-163e-4457-92de-68e2f100217b@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dbe10a18-163e-4457-92de-68e2f100217b@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/16/24 04:57, Daniel Henrique Barboza wrote:
> I am now wondering if this is worth the trouble, and we should instead do:
> 
> +    int vlmax = cpu->cfg.vlenb >> (s->sew - s->lmul);
> 
> Like we're already doing in patch 9. Patch 12 would be a similar case.

This is more like what I expected to see.


r~


