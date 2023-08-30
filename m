Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443878D678
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbM3k-0002um-Ry; Wed, 30 Aug 2023 10:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbM3j-0002rI-Fl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:20:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbM3g-000185-AP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:20:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so24254265ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693405235; x=1694010035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rt84GZR5Ctf50AaoeiIFW4q7OL0gBhY9G1b8FXHCBmE=;
 b=MT/nTFGho13rDdTq9NfKgElEDoU3+A6V9ph7yxssWzUFSrIr22jrYE/t+kHEWW5/4E
 pw5xfq0B6R7lpX2GkfeBcXu9C6EUg+P9adKP77Lr4fmYkBy3Ye/t4D9/FCADjviVIeCj
 9ExGXaYqqfTWiQsnE/QqiJk1nTCNHYXbRgsMW8ALlsYKCgSRBmHm1e3wBeUP/m32s7YP
 jjmfDfv3WHEWCRLdg9r++bmO9Pm/8cVtonrLlKvCmu5P3l8A0EFiPriWndbqFhRsi8hn
 VNekbVF0gaPy+zD05X+UgCpiLly62R/jFRh51q3Cya9zmMhOLlJnyzbZDRfL26EtBzJF
 zT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405235; x=1694010035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rt84GZR5Ctf50AaoeiIFW4q7OL0gBhY9G1b8FXHCBmE=;
 b=UAguv3lGddS/vOlrZGXTSsOwU76a2sxHSdbRC5X/O0nJoW2biA3BrXjt+9v7DsR4RW
 hEb//J4ER1paHcs2CVTT1EyVoaQjIR/IAZCBD3EJiXPMi8vhZE+y7JVJl4PxA99hp2MD
 GEeRDRnc5IbivJ0/t2LKFeenm4NmxEAB0RnNen9Eywq0ka6q5syKsTl2gxTDdlNlE/MJ
 iHHYM41nzl92/PD9FdvIDfpKSvD7FH9XpsasfukopbvhPoqBuNJPkHXtLFonRtRJIYV1
 PgAIfbEq8yZWUsBheEFV854ZaaIYCbiqeOFt9+u9SD/AdyyQeeIoCH0sAVY6tO22p3nC
 GJbQ==
X-Gm-Message-State: AOJu0Yz+mFHvadrF0ttuP53u4WENv5yNo8SJ7bvb8+ETkECnJ1tEl4YP
 cRnwcjcV/FtMo3wDTrbu60h4OLcWkXyKOwmNvLI=
X-Google-Smtp-Source: AGHT+IEDoojHtj8zw+RVtEGrB6g+9lNdzwa18iqPLg35unRfAsTVsgUL0PTMCB4+2rdCBpc5P+83zw==
X-Received: by 2002:a17:903:24e:b0:1b8:a3a0:d9b3 with SMTP id
 j14-20020a170903024e00b001b8a3a0d9b3mr2229259plh.47.1693405234612; 
 Wed, 30 Aug 2023 07:20:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902d90500b001bf846dd2ebsm11046752plz.303.2023.08.30.07.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:20:34 -0700 (PDT)
Message-ID: <72ad459a-b67e-2683-55a0-56d4dc51df7a@linaro.org>
Date: Wed, 30 Aug 2023 07:20:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/48] target/loongarch: Add avail_LASX to check LASX
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/translate.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

