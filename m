Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D475974B84F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsMZ-0006ei-Mo; Fri, 07 Jul 2023 16:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsMW-0006eZ-Ok
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:47:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsMV-0000pJ-7U
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:47:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc0981755so25898045e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762849; x=1691354849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pV++l1AdoNEW60sAx7mDN1yJQgxgqTf9vLrdb/cL3kw=;
 b=eGFG0GTUHSvbyj29luGZp2yNAjkJXmZIwLxyDWrBq+9joG6RoCY/aTcMzap0EDXdqu
 Aza45S81pt1ho1pQ6Vkh7kbCaV7r8ECVsYJLpb/yL8G+uxGHqgc0ssEW1G09ZBorT7Pc
 0MYsGsjWNNRaeaYZo8f2TLU6L35oDySnhMDcbXfIVLcfu31yXt+RjL1qv1ucYFxNYcjy
 IaBoLju/E5EBTWn9XVqKSRcfTs9jC/4K0ZpFD02ZdSS82R4wpGwgOsk2o+VmSOdtmFid
 u7YwM0TjaL+tfQlG1CwjVTOtJjyVusqZDYBtB0rf/16knNJNeTE8n6X4GY324cnWSQAo
 KH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762849; x=1691354849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pV++l1AdoNEW60sAx7mDN1yJQgxgqTf9vLrdb/cL3kw=;
 b=KQOgKxlHsx01mZw2KH/E3n66FzLPYFeLynEnCeyNZsVQNwgFHkf+ldHR+EqvdT32FJ
 TQNIO6Uw6+GnHoKYhrVkUilodDIKb0Xuhsy946KQlBtSX1LnIPlC1/RWj3Kbk5tPV8Gl
 bG3JTVp8pcKpT40/O5zdgRA2tIW7Ezd+qCQy5bHPnOf4VuTClwg8B7tF+VM4wSJHgvbq
 YvpGsf9zrLoAWTEVC2WEQpwbpcV7GeYLzPZTWKjQAaGQXPsHjjsyGFUeTWKbZzRKwAzP
 /8xudTuCkZojf9fHc0xEcmMUAfk+IjkAWuHa8EaZwlXTW8XAaVe8wt7Gz+KzEKNmx/wn
 mCvA==
X-Gm-Message-State: ABy/qLb9i1JM82Fia+ffJ7Rd2eNUj3PlYhDcHyXTEzEgqshtC7a6eI/K
 6i7HRq7ygtwa+88GsHADDdjfSA==
X-Google-Smtp-Source: APBJJlEqH9YblUpfS9eeceFs5ns3WVS1ta1fK4fuvLQz5/7YPgeZPkV7IAcPzXXIR0zDa7WNE0ShQQ==
X-Received: by 2002:a05:600c:ad8:b0:3fb:fa61:a4ea with SMTP id
 c24-20020a05600c0ad800b003fbfa61a4eamr3145620wmr.11.1688762849507; 
 Fri, 07 Jul 2023 13:47:29 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003fb225d414fsm3357233wmf.21.2023.07.07.13.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:47:29 -0700 (PDT)
Message-ID: <f877dda3-a3d9-5081-c2b3-c10eeb7b6814@linaro.org>
Date: Fri, 7 Jul 2023 21:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/7/23 16:17, Philippe Mathieu-Daudé wrote:
> +    int page_size = qemu_target_page_size();
> +    int page_mask = page_size - 1;

TARGET_PAGE_MASK is -TARGET_PAGE_SIZE.


r~

