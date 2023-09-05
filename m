Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B019B792137
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:59:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRsb-0002Kr-1r; Tue, 05 Sep 2023 04:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRsY-0002Ij-JI
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:57:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRsV-0008TD-42
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:57:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so22763815e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693904261; x=1694509061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v79Vp67t0wu7INzTM9V9wUXCXrocS2Y+HNPF9qPRgWk=;
 b=vLt4VLf2yirYV7546rFpWsMMRzih5vt3eTFBq+yQuoYXBWXh0ZWs9WKFG6D/mO2ihf
 XEtf+ndAzlYrdgcSI3ODnSZWifzaS+amfnYPeFxrsB198c18/gRc3shvc1oOZBXfbCjR
 axdAvzzcKq0f1kdMXc8ojN0+cZMXy9aadB/GGj7onM71hYF5GK6sz+Ym4gJkpQVMzpe4
 tTQJ43X3femgTvPbGmyFFc+Kd4zvk97h+yWZrZ3gZwF6y2GwDZ4Flca8flOgp5DDZsUw
 4iQf7z2C4NN0h9uoa/z7OvdGetrpPsI2fd3vJAJGh+5+zFJF7C2XjV2isMuK3hnFoIx2
 JCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904261; x=1694509061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v79Vp67t0wu7INzTM9V9wUXCXrocS2Y+HNPF9qPRgWk=;
 b=D+sXjkXdc7/nOU/bCGiFxlh2jgPh8rAU7+Ls9hMoQq9ewIRoa69gBAXQnKXWJxkusk
 TwQPgAVOldqDAqkBRSW6pfRpEd32WKoo8OAxDEqoChTPN9B4kKUrfnwIyUFh9p0/PIVy
 OmFkukjlmK2Dve5QXpTc80Rpc3LRrkNOhwjMSuUnIv+UiFxUgjIfyh9Br4dcrUY1mSd9
 RbJvGRXVqIXarKHAPXH6ii/8dBakKwj34HG39eTtMCAJ68fSaInAysTkqXdKWq6VrmZk
 +B6nxA2q/xtkga2eG4w6+z/A1lY5iWANWyAukMnZo6eb7BgzJX9iKBNcbf8IIxztPSoJ
 Oi3w==
X-Gm-Message-State: AOJu0YxE1BbIXjGbr6DPtKR2u051vTmMdQAJroXs5134x5FQlxNJjrY8
 vYsRYp2B9ysRDDhfBlk+SCMnghhPxbnyfqubcBU=
X-Google-Smtp-Source: AGHT+IE3+mJ69nsks5sMq/kErs7OpOTeV9r2todNYkVk8DOjR9SXuZgA/BQYX7CysP4wbODCajNPtw==
X-Received: by 2002:a05:6512:234a:b0:500:b872:7899 with SMTP id
 p10-20020a056512234a00b00500b8727899mr10427134lfu.62.1693903865146; 
 Tue, 05 Sep 2023 01:51:05 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 m18-20020a7bce12000000b00401dc20a070sm19330903wmc.43.2023.09.05.01.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:51:04 -0700 (PDT)
Message-ID: <0318a8c1-2c04-1a7b-ccbf-892946cf29b8@linaro.org>
Date: Tue, 5 Sep 2023 10:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 junhee.ryu@sk.com, kwangjin.ko@sk.com,
 Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-3-gregory.price@memverge.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-3-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 1/9/23 03:29, Gregory Price wrote:
> Call CXL_TYPE3 once at top of function to avoid multiple invocations.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/mem/cxl_type3.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


