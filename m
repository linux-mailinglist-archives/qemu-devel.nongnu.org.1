Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B938A7A5E52
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXDn-0001vw-J3; Tue, 19 Sep 2023 05:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXDe-0001p3-Ec
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:40:34 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiXDc-00068Y-Vg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:40:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-532c66a105bso364029a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695116431; x=1695721231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJoKyKte8CTOgWqDtK5N0/FL7H85FT62yijw6mj3qfU=;
 b=tZy3EPEXkvVl10wHzHPVkQaci+3MwUySiYEZgZbf6kQRG/sWGEkU6xlErpPvMbc9lb
 J6KdntPS0GNlN/5FJLYkwYmpGEnVBCujyJ6dCCN4vZhxej0qmnNFkALruSgCnxnU+3Dh
 DornF7JNx6UrBtYkmcYfDd1gcPnA8UT2jTLmbisS+TQrU2PlVEXSPBcFay9tNWOn5K1n
 OtwO6meB5tE3kMKhLTcIPS4JplJLMDr8gqdd15UTLFwJvx+oAodwCEtynsy1JpjbVKhi
 Nni0efKDTY5WhThQVJCVL33NX/3LJlJQHM4x68QReGGmC5EU9SemhNd3reu2wk0T3A91
 Z5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695116431; x=1695721231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJoKyKte8CTOgWqDtK5N0/FL7H85FT62yijw6mj3qfU=;
 b=Awo5mOjgeaFHuj7maaBOMPJy5wkEWdHg07dJWGi1XeRFvy4PGdLCTIqYCzyZcAXldp
 Bwjv1R+1Bxgb1w9sx5bg588wiosrmm+knM8XqIGGoHN7F+3foFZ88+P8uZ7cg+Z0H403
 BSekdKI0a/zTy1Iz8Kp2W2b3NY68Jvsuy85P0qT6ZapVA+vjZiyOJkfs5Chr217VMekb
 6tgBuJXRc/up5ePKKjZEi1r5hxbyF8TvCOMFrg3RAIEJNlIF6l5nxqCADwJl9OwoL4lt
 kGaJHnmAzVWH5UTzAs7tyOzXTtxwZbdao0Yck72uwTfCp3mkJHlCKmAT7QVp2iJC1KgM
 lP4g==
X-Gm-Message-State: AOJu0YzQw3HStIPlL8LcoDFEny6nBFtuQ8i+Q1pQ2iipVIT6lUUkr/ch
 /O860svto4BYh8O4USjct5mzIA==
X-Google-Smtp-Source: AGHT+IFZ82zX8taEmqMUkdMcW5Cn56ZhenQUliuu472uvZ6U5PNVegX9pSELzmrzvICbdnB8bo6PfA==
X-Received: by 2002:a50:ee0d:0:b0:52a:6497:d02b with SMTP id
 g13-20020a50ee0d000000b0052a6497d02bmr10332548eds.16.1695116431344; 
 Tue, 19 Sep 2023 02:40:31 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 u22-20020aa7db96000000b0052348d74865sm7059270edt.61.2023.09.19.02.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 02:40:31 -0700 (PDT)
Message-ID: <f542cb77-8f05-6fa1-745b-813156440fd4@linaro.org>
Date: Tue, 19 Sep 2023 11:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 14/39] accel/tcg: Remove env_neg()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20230916214123.525796-1-richard.henderson@linaro.org>
 <20230916214123.525796-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230916214123.525796-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 16/9/23 23:40, Richard Henderson wrote:
> Replace the single use within env_tlb() and remove.
> 
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


