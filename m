Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF9775EE7E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrMR-0005cZ-15; Mon, 24 Jul 2023 04:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrLP-0004yz-HG
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:55:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrLN-0000wx-H4
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:55:07 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso3743252f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188901; x=1690793701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bBG+xPb+o3DQOL6IZ10MUUt+FeXDEGimdn9UVYEtuQ=;
 b=B5dR4y2jmLrFLHh5kzPFw6QhbVvyAhVKCDRrBTCtC6t6RtjSSCycaDlCZk5zOzzcS1
 A7+08ZlqPDOiP5gijM8zCvIFjMsejr9/sKbP1Doi/W/+nh7P+y9t8iDfgplD2aPV+r7V
 hVkIUP2c7FfqGDu8QLD+WF7gK6oXOlY/TNH2O0Dlo/5lpDzu51Ga8PjAu/N6WN5dDK8l
 wX4ATiVDNm6VuX8fQTNcyjtM3Us+n1Yqm45+dtgxRa/rrCRhwdeLmaIQvFSExxfdckSe
 LJ90rybhm6M60yok7qI1i2ffSQiC4mzsB4JN8CHfgzbWI0YzPD1T0IUUgPUQf/K/wkPx
 Ufxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188901; x=1690793701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bBG+xPb+o3DQOL6IZ10MUUt+FeXDEGimdn9UVYEtuQ=;
 b=ftKOsSOE0laMSo0PXEykqIlpzBQNLOQknaoOeTn6t0ON/gLOsiw72jXfln08fITinh
 zfXSqOermOtXBoYF/KEBmFH+1GjJ67xMabkPCNYvcmqeK73Ty2Qv6i3NNj3zqgxoCkZ8
 fcCZ/THNEgc9XhBqyU8edz+4h0kK3Em+TsBf4sf+fU/5zVmmH8HStsdF2VwCbs4Jg5e1
 DDBLNOcd4s4WxtJYFJvf1ymqoI/N7s7wbRfH2thkJVCIQvvPUFgGF3Wo2fnp3ppz/TxS
 5br8dKJH73KHSIvdIqo/xqufCsOxlyFDQOX4Dbav5RQmac8odSCbYWR1Ux7j5h5Pi3WD
 y9cw==
X-Gm-Message-State: ABy/qLaX/GLR8jrJ6S4bPiMAdBXYPUP1uMkCq6UJHeEM7oLkYP8eNsl6
 zGmMiZc4SjTBFEUZbiPQBN5pzg==
X-Google-Smtp-Source: APBJJlGdOwE68idDquz/Shwgnbfg5L38o3cn6OolVING+0SPrc7aRJm2/3DZtppqfe+V+XqH8g5Sqg==
X-Received: by 2002:adf:e608:0:b0:317:6175:95fd with SMTP id
 p8-20020adfe608000000b00317617595fdmr1044692wrm.43.1690188900977; 
 Mon, 24 Jul 2023 01:55:00 -0700 (PDT)
Received: from [192.168.224.227] ([62.252.144.58])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a5d58d4000000b0031433443265sm12244914wrf.53.2023.07.24.01.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 01:55:00 -0700 (PDT)
Message-ID: <f40545af-4c99-d1ac-834b-f05ed315e5d2@linaro.org>
Date: Mon, 24 Jul 2023 09:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/14] target/s390x: Make CKSM raise an exception if R2
 is odd
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230724082032.66864-1-iii@linux.ibm.com>
 <20230724082032.66864-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230724082032.66864-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/24/23 09:15, Ilya Leoshkevich wrote:
> R2 designates an even-odd register pair; the instruction should raise
> a specification exception when R2 is not even.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   target/s390x/tcg/translate.c     | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

