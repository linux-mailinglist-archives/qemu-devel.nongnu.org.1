Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515F578E338
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUa0-0005Dy-EP; Wed, 30 Aug 2023 19:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUZy-0005Cu-DI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:26:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUZw-0008Tr-9F
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:26:30 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so175926b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693437986; x=1694042786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7j9W2Vlh7xHCKMbpvocvnU3XoFrpgssLpK1K9T7mBZU=;
 b=w9BJm4R4o6wd2Lf5yJFzPX+zcnCzntwrubS503qQRELV/XuY1SXj24d0APNXrSpfII
 mPRi0AKzrD7BHlKA1/QpHpOd6yXiiosvEZsvOElcxM1PYFDj4UC95ezqxPs0ot6Oou5V
 ZNaGqMd3aq+WsDbf6FXJWc5izcXXZ712zNW8e6CTXBY+SQVuK81rTYs7maV76tMGhDGJ
 pa3wxPjsIrIdwLVj9WCRpTPTyoPyjx/TW0ZvwbYaTUehrCNTnjIK/doikPHFj9fxSQQe
 uDayNV+CPd5x+tG2F041rkbSxTIAAWZNce9xchhx8wHR4PremNFNq4JIj1/WHMN0gSA4
 U1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693437986; x=1694042786;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7j9W2Vlh7xHCKMbpvocvnU3XoFrpgssLpK1K9T7mBZU=;
 b=ju72B7HJg7hR9nXUJf5OwiKHcAYXj3cu6WRmUprQsrm++OXWwu9FZcg5Zy5NgEhBlj
 7OpTu1s5fSBUX43ddP8YvoQvI0tKe35leOMTPIOCfuyhA8KFbOadO1dd8mN9z72xhObr
 ogDhXuTqe5UUss1RTplXDKrnO6v+qwZdZPmPvNhi3sR6O4mcACqlfNcDflBGCg0k6ATY
 iFDOwriMcyNL76XdltoLPZHVJwc8/4WIHfczAOJJ8JufZUdIC9FHqhaJHFTpFti3zT98
 uu6gDPWHGjdZUcJCPey118w+rcteNHiVCBZMqH3EuN3p6UYKpg+mftieIRmb6qr0vCkx
 DYLQ==
X-Gm-Message-State: AOJu0YwCWsXOsEj4G9y8fJDT8BJU0ULYw6BwD6BfDMKTGAVa+efJbWO5
 71zEMioHXBAWyRdJw3XVDI1xtA==
X-Google-Smtp-Source: AGHT+IEKOVkVcSvpeIS3pcpeN2y7XUI8piHAhW7FdT4nur4ypgf6fDL0q0j5AcTwUQ0MRVf7ZFjLcg==
X-Received: by 2002:a05:6a21:788a:b0:13f:c40c:379 with SMTP id
 bf10-20020a056a21788a00b0013fc40c0379mr4450383pzc.13.1693437986686; 
 Wed, 30 Aug 2023 16:26:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 m13-20020aa78a0d000000b00682c864f35bsm111175pfa.140.2023.08.30.16.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:26:26 -0700 (PDT)
Message-ID: <76b574c7-6a4b-c0b5-20c8-d1d639c4329f@linaro.org>
Date: Wed, 30 Aug 2023 16:26:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 33/48] target/loongarch: Implement xvssrlrn xvssrarn
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-34-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-34-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
>   void HELPER(vssrarni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
>   {
> -    Int128 shft_res1, shft_res2, mask1, mask2, r1, r2;
> +    int i, j;
> +    Int128 shft_res[4], mask1, mask2, r[4];

Likewise for the arrays.


r~

