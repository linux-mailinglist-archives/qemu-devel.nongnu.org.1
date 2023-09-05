Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7479230A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdW72-0005YU-Jn; Tue, 05 Sep 2023 09:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdW70-0005XH-Dx
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:28:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdW6x-0005Py-Mf
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:28:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so358746466b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693920533; x=1694525333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbFA9Za2sIt41Wj2KoYPcP58n8ZXuPdZupqzVmPphdY=;
 b=pR84g2nSz58Sd3Fc303IG9d0axwXl0HJJUBXihC65Q0DDYIigcMBU7jXCiEIcGOf1I
 rZOj9ROGmU+fFBoSPe/XB8yWIfAmEw3iHB/D8SCn7RzUCxyhKqGbXJkXYaaAI552ZDxp
 UG/XERr/5dKFEo72v4yuwzv6uWHbh5nKfFDor+J7ZjGr/IJ/Z1N5MArHOhn4GW+g1iiF
 Fei0yNmz/fyigOL56PfkbNzOIu1iRZRb9sG3OLwKaLMTwkjzIWNJ77zRa3HQIZ81xqHy
 sXFF5BfIBmUgyxK+l3IZbyAdq+mLuBiOJqDuLYDroVobtjAiouzw0d+YHqFaCmcYw9dH
 UBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693920533; x=1694525333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbFA9Za2sIt41Wj2KoYPcP58n8ZXuPdZupqzVmPphdY=;
 b=gByYuG1jOTrJTP2Nt1u5g0opBjkpj+9FVSP1rs/DuHTcLd0COrf3rx/NFV5AFXijZk
 h2kAjNYI8IAmQFnWHzDwIunnIa1Aa43khhJX9ut7KszHiN8Q0DRqz5o+YHmnv5fvl8jO
 dqZ68JA8HiUcsNBxgWfIK/SoEKGeJna2V71eRL4KHcn0a+z+I3Nl+IkUUf0k6lLOw8mX
 Mn07AQJ8U1zDwLhWjPABkwd+1Y69p0iLYQKfq09L4yHobO3Mbt/I0uHjCuB4itzBnyVe
 D2USAZME1QUGEi4WKsy3ADbaTngkmBhqIpsGJ0Sbvl+jyrfeA8CS8H5467G1xe4IyRFT
 vn8A==
X-Gm-Message-State: AOJu0Yw8K3Y5YQsR6S9DzO5zZIAOQggtQIIhpziCVl/Q+oyjTGcOeKsE
 2/ImHfJe9QQKmFMjuKSovbhZzA==
X-Google-Smtp-Source: AGHT+IGuAfgPzPNaGmGSa+4zVd6L+Z/VThbhMlFESv9F34mzR60/uHyzItwf36VnGpnIXRTr7AdFrA==
X-Received: by 2002:a17:906:76c4:b0:9a1:c221:465a with SMTP id
 q4-20020a17090676c400b009a1c221465amr9732130ejn.9.1693920533498; 
 Tue, 05 Sep 2023 06:28:53 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 f8-20020a1709067f8800b009a1a5a7ebacsm7468748ejr.201.2023.09.05.06.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 06:28:53 -0700 (PDT)
Message-ID: <73f5ca15-e079-08c4-5965-e373b3fa3770@linaro.org>
Date: Tue, 5 Sep 2023 15:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] block/meson.build: Restore alphabetical order of files
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230905130607.35134-1-kwolf@redhat.com>
 <20230905130607.35134-2-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905130607.35134-2-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 5/9/23 15:06, Kevin Wolf wrote:
> When commit 5e5733e5999 created block/meson.build, the list of
> unconditionally added files was in alphabetical order. Later commits
> added new files in random places. Reorder the list to be alphabetical
> again. (As for ordering foo.c against foo-*.c, there are both ways used
> currently; standardise on having foo.c first, even though this is
> different from the original commit 5e5733e5999.)
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/meson.build | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


