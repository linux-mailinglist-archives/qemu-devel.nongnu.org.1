Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D178E260
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTnj-0002xy-AX; Wed, 30 Aug 2023 18:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTnf-0002xV-L9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:36:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTnc-0007mU-IH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:36:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so1134155ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693434991; x=1694039791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heU8Q1KE1ZUjXv/fJCldyVnBb0HSCdVueRKDe27zQhQ=;
 b=GnirZvcq0EQ+SHckVCRW41pkkMrJWnKPwA84ex6Kcnq4t8NT/aXMcuusriRp8PIlea
 9Yke7wymDUOaiNEwqdfevlVvnFkAl2jrzMZv+2jfSBridq8t38KMoqD7bs9KepKocbje
 oGpLrMlyeN0GbeIvzZlHmtFoeVFOJln9We85Qapio68kzwB+WrIqg/bWlqkz270f5zK5
 JGv1DP/oJR+BInLZTXi23H7rdJ5jhaVcr8PvW8LwvjjmyoooopoD9ZU5BOUA+Oxhskut
 zV2af5SvC9nP5IP5R+Wh+dAUNof0XJOGO+EDkMet2NvpPWjuKmoQu5pSNHHXNl1D1+hM
 XWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693434991; x=1694039791;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=heU8Q1KE1ZUjXv/fJCldyVnBb0HSCdVueRKDe27zQhQ=;
 b=CigoU/LsfVmmgQXRetZ37uz28jcmSp2PXHZGhWGaz9R4Vq4Kj6EVQ0zd07s/BW/H7W
 x+tbBMvP29dfaSLiDqgd25V4z9UWxZoyziEcOWlVN6RFAmP1xRI/H5wj9oeLTbtgZvJf
 b6BpxXT3YlEap4qct3QMIjIpMs0um+ek9hyQwkAjdpBK79l03YugEQvKoJScq8s94yu0
 gW05Nbc7nC+vvBIzxMSFQIdSshDMC1znDl8SkYbELOCZrOsVqPLYvJltEU2ADy+gG2ue
 aAeORutoK9xUYFIjPEVPH6n9R9cQoT6QUtV1MJWsBiI4zgEfrFVxPVUzv+kEOV7tTvmQ
 8nOA==
X-Gm-Message-State: AOJu0YwFVaCPqxsfQUcczNMmrEisAipcKqKUH4qI/fiNURpzQ3JQ03Cq
 JP5q8h0VnQmmKYwBxebwpboj4avnCqV8xSmYupI=
X-Google-Smtp-Source: AGHT+IFmSTZZ/duq3ohl+r/KnYYe/pAMugi0q06CoU0r/7P+z5A6xSBLBG9wlVqaBECjlblu0iRsgg==
X-Received: by 2002:a17:902:d492:b0:1bc:56c3:ebb6 with SMTP id
 c18-20020a170902d49200b001bc56c3ebb6mr1364798plg.8.1693434991157; 
 Wed, 30 Aug 2023 15:36:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a1709027c8b00b00198d7b52eefsm3845pll.257.2023.08.30.15.36.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:36:30 -0700 (PDT)
Message-ID: <ecd3b04e-98e8-ee12-d173-c3cade26041f@linaro.org>
Date: Wed, 30 Aug 2023 15:36:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 22/48] target/loongarch: Implement vext2xv
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-23-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-23-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> This patch includes:
> - VEXT2XV.{H/W/D}.B, VEXT2XV.{HU/WU/DU}.BU;
> - VEXT2XV.{W/D}.B, VEXT2XV.{WU/DU}.HU;
> - VEXT2XV.D.W, VEXT2XV.DU.WU.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                    | 13 +++++++++
>   target/loongarch/insns.decode                | 13 +++++++++
>   target/loongarch/disas.c                     | 13 +++++++++
>   target/loongarch/vec_helper.c                | 28 ++++++++++++++++++++
>   target/loongarch/insn_trans/trans_lasx.c.inc | 13 +++++++++
>   5 files changed, 80 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

