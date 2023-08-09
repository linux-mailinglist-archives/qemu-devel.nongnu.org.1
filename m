Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074D7763A0
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTl1t-0002xg-9R; Wed, 09 Aug 2023 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTl1q-0002xJ-Lf
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:23:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTl1p-0001yF-3n
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:23:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686fc0d3c92so4749261b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691594595; x=1692199395;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5amRLnCuKsBT8DRgge9hKljBAtuBaOud/g7b4FC7oA=;
 b=L8LtZAvAR98jsWd423kWxYz35Mmz3ti9DSs+nqDgABHqBYPjZE8FOx74oKN1V2hNbi
 EgZcUk1XARhxyHmc+Oc/OhuQ7k0LeURVtuaYAzb6ULlZ+uyUtrtlqWZ1/UhRp/w/Q1E+
 CWmmMrevQzq3fLUDSV0DZ6jon2ZKYZ2wMoSmgaov0OaFwy/uwJvP583QZUX9TMBGZXGg
 tEBuPYWcMO70ILpN2R6EBSXv9o2tcHq8Zf9i12yr8WgaEQzBzUdx73aqGFLmWeaJxO6G
 zj9cltH23//sFRDoQAtlwGytriYvtymLm6v+WT5/ykREVVgpq+0mY90cM/0w/mvaxZRI
 8xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691594595; x=1692199395;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V5amRLnCuKsBT8DRgge9hKljBAtuBaOud/g7b4FC7oA=;
 b=OgMPEko/YCw/lzHV676M6RDGtMlMSckwO+YUEtw+6UluelNfqfW8l7Ro5j0hM71FeS
 k7XSWRx+hT0ZUj33QdJLsUFwMIN30H08HYnpQkbDwsd2Uv12zt9/tq1sPZxzvJ4Kh6Vh
 eb6BV2kM32FEqB3wyM3mDIUnpBF1O5lfd9M/4wY5IXDpuZtXYosx0n3gkw/8Dk14MDa1
 Bdr1fTGEI+Y6FH8z/Lon43v2Wd93bfCFGyJU7DjayQfH4YFrFC293WRxali2SB3s8gK/
 IFjU+3zjOK/88xhVBa5Cf1nKEC+2Ar9XvanB5dIZf+cwnfyUMJwNLFw8KUYjv4e5n62J
 HnEg==
X-Gm-Message-State: AOJu0Yzkg+SpJ/u8AqtQGIG38ehqvIhvF9LN8SoJ2pVEu9CVyMfG1PkG
 WvCdmQqphHtzU04l4CHibaovHg==
X-Google-Smtp-Source: AGHT+IFlTx8/COS5skSvoPLb/aCKJ0yL/g/PxUpV7xDFzQ+BdU+sjW43LeXF3V3KxpdJbNPll3yWpA==
X-Received: by 2002:a05:6a20:12ca:b0:11f:4707:7365 with SMTP id
 v10-20020a056a2012ca00b0011f47077365mr3341539pzg.38.1691594595251; 
 Wed, 09 Aug 2023 08:23:15 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a63fe49000000b0053051d50a48sm8331921pgj.79.2023.08.09.08.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:23:14 -0700 (PDT)
Message-ID: <9251069c-95e5-aff5-9ee9-de7a493b23bf@linaro.org>
Date: Wed, 9 Aug 2023 08:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fix interval_tree_iter_first() to check root node value
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org> <ZNOsq6Z7t/eyIG/9@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZNOsq6Z7t/eyIG/9@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 08:11, Helge Deller wrote:
> Fix a crash in qemu-user when running
> 
>      cat /proc/self/maps
> 
> in a chroot, where /proc isn't mounted.
> 
> The problem was introduced by commit 3ce3dd8ca965 ("util/selfmap:
> Rewrite using qemu/interval-tree.h") where in open_self_maps_1() the
> function read_self_maps() is called and which returns NULL if it can't
> read the hosts /proc/self/maps file. Afterwards that NULL is fed into
> interval_tree_iter_first() which doesn't check if the root node is NULL.
> 
> Fix it by adding a check if root is NULL and return NULL in that case.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 3ce3dd8ca965 ("util/selfmap: Rewrite using qemu/interval-tree.h")
> 
> diff --git a/util/interval-tree.c b/util/interval-tree.c
> index f2866aa7d3..53465182e6 100644
> --- a/util/interval-tree.c
> +++ b/util/interval-tree.c
> @@ -797,7 +797,7 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
>   {
>       IntervalTreeNode *node, *leftmost;
> 
> -    if (!root->rb_root.rb_node) {
> +    if (!root || !root->rb_root.rb_node) {


I guess this is good enough for 8.1.  Before the conversion to interval-tree we would also 
emit nothing.

I've already done a rewrite for 8.2, and I noticed this problem.  There I emit what 
mapping information that I have, which is everything except for the device+path data.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

