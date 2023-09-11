Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B879B00C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqdR-0001Lv-6l; Mon, 11 Sep 2023 19:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqdP-0001Ln-Ki
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:48:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqdN-0007aO-Ej
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:48:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so6627735ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476080; x=1695080880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VaasfkHMgH4/aXp0Or9jRambNfVDxGMXPRAyn/zwAEY=;
 b=xhAMxG5TeAfcPI0jpCUQuQ86Ym8uZC53ehN9MRQhOsjB+D3NT7taBtalFtpLJwAnwL
 bz7X/fpwj4SIS3esbLvLMG9cu+6dzOqBZ6Yieh5f0iHX63/bHz99SG706afsh5Dds/fH
 QFueCoDg4ZtOFpaoYBglyfj7QqkyfyDFwP/m7qEWkkw7l+gOc6lQjtTMAsm+OFFPUO90
 84AGzFGA3n5jD7B6U53vxEp7h+oodnXoVktbV9NvW2tdejmqeFPX9yMur1iKkDszjv20
 mIZj8ZOSaRhPHDg8OyMgQQZUrdGIeCj4npTQJchXhfgNtCB4U8dkTAjS4lATlIll3sdZ
 6ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476080; x=1695080880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaasfkHMgH4/aXp0Or9jRambNfVDxGMXPRAyn/zwAEY=;
 b=YAm3nhiwXIU1BhOB0Tvn3rVqLhOfYAzvHvXKaWLBiuG4gJEoqeS8UQlnoQVWu36eKz
 BUtV3KLDkTRf70YElQdVpJjgXNUR4k1amWfbRWhlTuGw1qbg/QEYuUyi4NWqMFd+R84W
 mQ/L8CVIUa+Q6vDYqFq8FMXWsBm9H0I8+k+5NNFIEmM7AycaA9wR5KlOh7qDiPDjEbz0
 yOqfW8NsJ1o6VgiQpoDE2vCQXP5BmJIAvlrnbH55Rl3rWKrtgSzE9Puh/H9Mto+GQW5E
 KviBFfYG+KKtMjMvVzHs2G/RUDh7xZXPeaHFDe+NQXt6wZFn1ufqmwwnZBwc52Tt0P6p
 fAZg==
X-Gm-Message-State: AOJu0YyeFXdrnTwkeoBDCqxArrAxwXrXas+XQNDWPDZ4IxTG+sZ6hq/m
 +HDiY/dQ0rAXYjXtIdzN8O1N8Q5yl44GnkIUs14=
X-Google-Smtp-Source: AGHT+IHG+Uu3MrcBVtP3RbWJJurWdZSjrMK2R5pUS3PfPGqBQpK9mifVWG93aC6o60mJryLXUEQVqg==
X-Received: by 2002:a17:902:9a43:b0:1b0:6e16:b92c with SMTP id
 x3-20020a1709029a4300b001b06e16b92cmr9456421plv.54.1694476079900; 
 Mon, 11 Sep 2023 16:47:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 bg12-20020a1709028e8c00b001ac7f583f72sm6959563plb.209.2023.09.11.16.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:47:59 -0700 (PDT)
Message-ID: <d9579923-1aa4-ffe7-5d31-29d4dc6c7d33@linaro.org>
Date: Mon, 11 Sep 2023 16:47:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 55/57] target/loongarch: Implement xvld xvst
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-56-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-56-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> This patch includes:
> - XVLD[X], XVST[X];
> - XVLDREPL.{B/H/W/D};
> - XVSTELM.{B/H/W/D}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               |  18 +++
>   target/loongarch/disas.c                    |  24 ++++
>   target/loongarch/insn_trans/trans_vec.c.inc | 143 ++++++++++++++++++--
>   3 files changed, 175 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

