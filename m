Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 955067B6AF1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfsG-0002up-6u; Tue, 03 Oct 2023 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnfsD-0002uK-Ma
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:55:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnfsC-0000WR-7N
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:55:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso7260555ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696341338; x=1696946138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ij4tD99TZFpTIN7WGEB0MtquTrkX84gbeLr2YlBul3o=;
 b=I07wHYbxsMg0ZNvjbm6LLf0lEyNKh0GjWEHwykkNvMt/HTSnv+66Ta8/Qb1vl9LBlZ
 7PllYzckVJM50GVki7/Gb9zthbZCXq2kUDIDaM/2I8BmGpRUlDN/Y/vNZ25Z3B6yClEk
 XlowDbm+3T20OofqQnqB95EZ7m5mfNTBipFGUhhnpEUFEMRyq733BJKbmcOhCAPb9OCl
 wvGPwY1BfV0NeIrbc13Iak/y4iPAiZptVZth9KQol+UEt1ZS9O0SDjP0zfXHv4F4nMxV
 pxnzv1icN+7EmbvoxO8c+a2jIWYt42/UzpetHgrw+auybybI8/Psf0SM5AkElXwN4o4q
 gLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696341338; x=1696946138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ij4tD99TZFpTIN7WGEB0MtquTrkX84gbeLr2YlBul3o=;
 b=mOdDraEmyNBbzRMc53LL/C2xmOWOkq/6SPG6NAfqTMx1+r/pkaQiRhob+UYXxbnBQZ
 9h17kX/UhLl322UPsX4VHJTkB+QNt6W23/PwH/DfMgPhEZL99qcPcdlZefcONOKDvmXf
 VLwqFOzNF3ubKIULQgHx38gouvD6UV2rqMWHqOKYQx849OWDqwXszis8dE3HcILf3d5b
 fDHCRWvP/AnZ0kBl4t783MwCw4YAdODWVIo4Dbfv821sMyRXAI5juiJtxXRu37O5V7va
 ltOgcIhcqd+TZUj6xuAD566Xpr6tZM/VWYlVsVKryqbpzA9eWNUSQQuAT8aeUmm2Rksc
 f9vQ==
X-Gm-Message-State: AOJu0Yxg4q7ooijrRnYW0NB3t906yGhSk+PL8cnMKljUbBvTFB7FDyK1
 MjicfriycUZC85YaGCC9C5h2dQ==
X-Google-Smtp-Source: AGHT+IFC5nmSEhAfx9J1jSGj5OiU2eVZBUmtHd5SuiHKMdW9zt62MorSW1qi2QGMf4cWeqSftYbqyA==
X-Received: by 2002:a17:903:1250:b0:1c4:4462:f1bd with SMTP id
 u16-20020a170903125000b001c44462f1bdmr13427477plh.35.1696341338468; 
 Tue, 03 Oct 2023 06:55:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a170902ab9500b001c5fc11c085sm1547693plr.264.2023.10.03.06.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:55:37 -0700 (PDT)
Message-ID: <10ff2836-5938-5511-70d5-a5169eb1d97b@linaro.org>
Date: Tue, 3 Oct 2023 06:55:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] tests: Drop mentions of SoftMMU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20231002145104.52193-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231002145104.52193-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/2/23 07:51, Philippe Mathieu-Daudé wrote:
> We want to clarify when code depends on a software
> MMU, or when it depends on TCG system emulation.
> 
> This series replaces 'softmmu' by TCG when relevant,
> or simply remove it.
> 
> Philippe Mathieu-Daudé (2):
>    tests/vm/ubuntu.aarch64: Correct comment about TCG specific delay
>    tests/unit/test-seccomp: Remove mentions of softmmu in test names
> 
>   tests/unit/test-seccomp.c | 24 ++++++++++++------------
>   tests/vm/ubuntu.aarch64   |  2 +-
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

