Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2FC78E21C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTMM-0004tH-L2; Wed, 30 Aug 2023 18:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTML-0004t3-5O
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:08:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTMI-0001uj-W8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:08:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c1e128135aso1121655ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693433297; x=1694038097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QwLwM1/RLjs6N4oo5vhdzdLN1LQK2YlckSgbs+8Ods=;
 b=a5LbQj0PQfTgjachGiU0bbd0s7uiNXnqsGiBOcPOVA7kRmWmqIe6pSkpIKC1HXSnWv
 vpPhOW3Sv4uUGBrd1J79RMSIv0DSiHCAOrDSZowI6FSsT+14x9i6QGjDjKnHR2I5Y3DP
 mf0zC64/mxyNkIKxIC6WjcUUECMr7Y4jToSQR8jCEtWm+KDZLnqjd1KjbTEX7kBg9bAk
 iYYj+n+DwRCKBuqaqpx220C7mMa3Flv8gim0fgoQqGdWq1uHI5HhtaSaI+ii31ptUv0B
 PKWO0TAabVG2O9HN4v6CA70fu1BjqQQi1eju+Jf8yOvkGCYVZnjay/SscpD/GLvxaj7T
 jnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693433297; x=1694038097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QwLwM1/RLjs6N4oo5vhdzdLN1LQK2YlckSgbs+8Ods=;
 b=RL2n7aKrYr3lue++toqPkmlpM8Xt7UqaBR4fboCVYjk/RwpMVQepwZip8LRblqNbqm
 uurtEoxl/0PssRYbaR7wK4ZIrpqCgm1y80htRhvss5Udxl1CfZjpN92nkLgmpFEqa1mp
 1Pk1+8sEmH5Q8hra3jgASZ0X0rpL/vnKi/pBOv7hnFuK6Jq3PfC3/b3YuzlAC8FtmIZj
 FDpmnioibzRJ0Cp2uelCgT8PcB8HEvBsIP27zpe6+dx7VzuVKkW5mwCR4/eb21EhH6mD
 yVaFhLkefcuhZi+UVFyQNVv3aRdDAVmptNKDa+z31Jwq90gVhBEyNdXF7dOaPpoEKrnY
 Uz7Q==
X-Gm-Message-State: AOJu0YyfCUjf4kRJc1DLbBq8WNeBLq59smE3YpusNEJpDeAGv9VllaeU
 w6jUa/ngqzoikaqJQZQVTkkpdA==
X-Google-Smtp-Source: AGHT+IEtmJZ5nAolDfuSYwvscZkiiZLYdVnCKAK1mm6tswE/E2OWB80BIynoSwFRK8f/fYLFPsD/RQ==
X-Received: by 2002:a17:903:25d4:b0:1c1:ebcc:612e with SMTP id
 jc20-20020a17090325d400b001c1ebcc612emr3214351plb.69.1693433297251; 
 Wed, 30 Aug 2023 15:08:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001bdf046ed71sm11573214plb.120.2023.08.30.15.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:08:16 -0700 (PDT)
Message-ID: <d99d661f-9de0-a6a7-91b4-9cfa5b6af02f@linaro.org>
Date: Wed, 30 Aug 2023 15:08:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/20] linux-user: Load vdso image if available
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-9-richard.henderson@linaro.org>
 <d703be2d-8131-58d4-2ed8-7104316a8e21@linaro.org>
 <e5685d29-bb2a-f0c2-5030-453dae529c03@linaro.org>
 <e299f256-9af8-a63e-2107-f6566c623f75@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e299f256-9af8-a63e-2107-f6566c623f75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/30/23 13:56, Philippe Mathieu-Daudé wrote:
>>>> +    for (unsigned i = 0, n = vdso->reloc_count; i < n; i++) {
>>>
>>> Do we really need 'n'?
>>
>> You should always have an loop invariant condition if possible.
> 
> vdso->reloc_count doesn't seem updated, but I get your point.

But the compiler doesn't know that -- it must assume that the store to *addr may overlap 
reloc_count.


r~

