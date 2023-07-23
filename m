Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ADC75E3F3
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNcMx-0001TC-3F; Sun, 23 Jul 2023 12:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNcMv-0001Sx-2m
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:55:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNcMt-00009w-Hg
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:55:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fd0f000f1cso21182895e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690131338; x=1690736138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E04E0aNkqoJPaTDFzdMBncgKQYDZlx03JabLSYommCc=;
 b=M91clZnXRPqK3h5wW8fS1fLEBSS6CB/BoEId/8bzDo8eGKnt5HpHuczh/6wCzYb+sf
 L+FZAE5rZIw1+tK7eGeWzSu0c6aOe+L2la6WA1E05n8fwIO4J0xFjhEN01rIITvz9B11
 OqyyTRzAnQ8J/cO6VSYF9bqmacHnX82RgW+aA77hX2cZahdQj5bD3yYfDcw3au0aAOes
 GdWMWJ0OSqbc0hWQD7F6817j1Idyh9Owrvd+4FMEkqtnr4v8wKd/i4PbtH7R43u2IrXT
 pcSZktUVpOjyzDm6gSfunB4CoVTxQqjQmrCPetW7yW+VnA6+Lq3eFv2hz5tC/nHk8d3F
 cRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690131338; x=1690736138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E04E0aNkqoJPaTDFzdMBncgKQYDZlx03JabLSYommCc=;
 b=Se6FSKyeoYjpcVmtRQB/DmkNqRh8sblNkWu30W+uZuqfKXVi1zxRi4r017G/dJFKcW
 f2nqSB+UBD1sDQHEdyK21KTLIZraAMWWfugr+lJbtTKDgg0dKgoNzqzz0cf0C7TxKEQj
 vt8qNLdCORRzrlrFcXtHLmzciJlogNF+ttKwTgtoMkcTJmbjyVgqeWaWA5mn1/yNFEat
 pApVGGs0KmiHYMoBGkdMwIWxIQrYnjgv3aRhtGQ8dQm5p5QSugAjTvwc6DD3kfEnnKcM
 TNe5SLuef41epqh0+qH1uRkdfHO05pyTCCtAxQ59vMRZ0/jcWsl+8e6ufSR4fGi10KnP
 4b3g==
X-Gm-Message-State: ABy/qLZDMDsdgfWbR1wC77ytm4uRSELsZFbW/dm5UuigV7WGt9rGzl2z
 rGrIhly3oH4+abVLr07M20a07Q==
X-Google-Smtp-Source: APBJJlEpmYBYB7RwyylE7mgpqrbDG2ZBwx4vvs5SYPHrrQWt0H7055ryCiJ/0wvKyOdgDFovu6EjJw==
X-Received: by 2002:a05:600c:5386:b0:3fa:821e:1fb5 with SMTP id
 hg6-20020a05600c538600b003fa821e1fb5mr12129248wmb.5.1690131337685; 
 Sun, 23 Jul 2023 09:55:37 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d6748000000b003143cb109d5sm10127407wrw.14.2023.07.23.09.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:55:37 -0700 (PDT)
Message-ID: <09509900-7cdd-35d8-72c8-9d7ac2952a64@linaro.org>
Date: Sun, 23 Jul 2023 17:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.0] tcg/sparc64: Disable direct linking for goto_tb
Content-Language: en-US
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org
References: <20230404150435.1571646-1-richard.henderson@linaro.org>
 <d9644b89-6ddf-8569-3ff8-b0c0b4f9dbe3@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d9644b89-6ddf-8569-3ff8-b0c0b4f9dbe3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 02:03, Jordan Niethe wrote:
> 
> 
> On 5/4/23 1:04 am, Richard Henderson wrote:
>> Something is wrong with this code, and also wrong with gdb on the
>> sparc systems to which I have access, so I cannot debug it either.
>> Disable for now, so the release is not broken.
> 
> I'm not sure if it is the entire problem but it looks like the broken code had the same 
> race as on ppc [1] between loading TCG_REG_TB and patching and executing the direct branch.
> 
> [1] https://lore.kernel.org/qemu-devel/20230717093001.13167-1-jniethe5@gmail.com/#t

Probably, yes.  Thanks for the reminder.


r~

