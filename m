Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51631779425
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUo1-000782-WD; Fri, 11 Aug 2023 12:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUnz-000772-B8
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:16:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUnx-0002ag-JC
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:16:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso2052340b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691770560; x=1692375360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jhPC5kw45yfVaJKcXJ3pivo2nABfLSaN6eoBzGPs8wY=;
 b=OTYExDtmZK7OVEnzPut7p7P0Y9oIYU+KRV18kjj6d0TGvSrK+kX+5ffLldhDujxPbn
 AZmUBO3Y8jPeR9vS0Kbe1n9BNL33ZHefJAdfm+SHTFjMqKyK9nnLhH6l2SJxginUP28L
 sm4wMxCfYG8gYbfAf/ZUReOjuHUwrAVRGr0B0rnQEauyoTyn4qkvrQRkh3IsbPNLydbI
 SHWXmfQVSCr39z//k60cSO3tOtLD/EFUsbnfK5kQflLFBPqFtx6dUL9/GlnaUIswg7pl
 IfNu15dAfHWT73A0GwqHrYRF0BLvqQGfLUKYAhwSFfdNqmn6HyUPZDGOEhHiIG1a96hO
 Fkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770560; x=1692375360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jhPC5kw45yfVaJKcXJ3pivo2nABfLSaN6eoBzGPs8wY=;
 b=BQftIYmHIJPcoilSY8Q8dxfgFM9NDTj041J4DYvQxroF+X+y+defOuBM7SomA/jMni
 BTbJJ5I4nceKXn0xyax8yVWY/5FNfsHu0LcjSJ+EyBSdGrLrDTY3m94209jY7nVi1dS3
 PGVm18BX/4B4A1SugpHlpG3OoLXpdjtbuKLqM19p/gesWwypW49yHgrixjfN3lol0yLl
 /m99MKvyLVgLrueSKBFJ9oS/AEcYA71nJ9trurc/fsy+suqCGbJ0ucciv4D54858jobX
 4CAcDydv+7mJm1cSWgn918tU26BlMTw0fdEglG5xpPnW9uh/fbkG0Pfy1HW8tfWGj+nt
 F+HQ==
X-Gm-Message-State: AOJu0YwTRP6tEhX8pyxgdQffEdwVU5MJckRmdY1lrb5wXNmyG7njjJnq
 KBJBFbk/CdTtxvVgQiMERjiwkg==
X-Google-Smtp-Source: AGHT+IGoDBPbgm+yfKEjL660W5Y4gSbFu0xTInlOvWfEJ9+D+aHCNE+CN7DGRSxXA+iockmO2mnGxg==
X-Received: by 2002:a05:6a20:4402:b0:13d:3b4d:e4b4 with SMTP id
 ce2-20020a056a20440200b0013d3b4de4b4mr3592246pzb.9.1691770560090; 
 Fri, 11 Aug 2023 09:16:00 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a056a00270e00b0068790e58edfsm3480695pfv.56.2023.08.11.09.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:15:59 -0700 (PDT)
Message-ID: <1f8fbbaf-3d50-5207-0ac0-c393d462f281@linaro.org>
Date: Fri, 11 Aug 2023 09:15:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 7/8] target/loongarch: Add avail_LSX to check LSX
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-8-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-8-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 03:02, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_lsx.c.inc | 1482 ++++++++++---------
>   target/loongarch/translate.h                |    2 +
>   2 files changed, 823 insertions(+), 661 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

