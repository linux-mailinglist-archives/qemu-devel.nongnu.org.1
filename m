Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BC70E9A6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bTf-0003eM-9h; Tue, 23 May 2023 19:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bTc-0003e3-UD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:31:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bTb-0002ee-4r
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:31:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso94167b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884693; x=1687476693;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T49jv0sjH97dVSCY4k+3sKfL9x7mTrfr1JiA9WQmemY=;
 b=pMmqQl7biA1CUYBfbo3tgOzdrqFB7Rs5ZLSdI8eRKiYRSDObeUcxZVTJwvj1iORTBz
 1jnuiC+EBKdfqDTlEi4bByQgmndc4j0ou1EjsxNgxHhM34p5qAovmveEyiBkL7TOYP40
 PVzEhD4BNI/zTncyy0iIJs/7SU3BaXVh7Tr9ajk8QmhZxBYwdaMgdFOoMbxx31MWMPA7
 U/BDDFDD8LLT2s7wRDv5EgSmoJ7V4K9frKLKqB4i0jAafsamIkIc+J1JGYNHa5C1hEL/
 9IVLa4Fu5hEPll4wVhiJRr0Kd0R3R48p0lNEl8uvCdxgbl2f6Z2WlZFWJOzpvV7uUUE+
 hujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884693; x=1687476693;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T49jv0sjH97dVSCY4k+3sKfL9x7mTrfr1JiA9WQmemY=;
 b=Z4hUX3Hkv++4ee6ON25/RxyQlpGwESwlQOm4d7kijxgJm2vNVDmZp+XlF6cG4QrVb8
 mwCrglsQ6E51GqUaaoDqDXa7WP3ST+5iOHTv5bMAP1Ki4qsKuWeSZ3m+CK/tN2oUxxNM
 b2piEjmHBa7HRhik+sPd2W500NMSVI0c0XdSXdpsn/wktRG93lVO9z7NwnBoDg8t11eT
 gzzgP6p5InS97MJok3ZxvsBRuu7j+VxJ6WT0IQcCbZkoQd6Tyfx2h0nDHQFYqzVCE6d6
 QB5W9LnPqJEXDsuavI/c4ZILTLWJDi9/CTr5b7HxZsek+9E10Kij0W0m+LvVXR/W4Y+H
 Q+2w==
X-Gm-Message-State: AC+VfDy8WtIWsVgBiz9DDkmSd8ry6YPTtEJDJgXfQdvZBZ5SbyuE/BVJ
 yBxDYuyRIevJA9XMj8r9v2NSQw==
X-Google-Smtp-Source: ACHHUZ6QqtpWb15Tql9mbizSH6DJTbY4C8FsL/CdvsshGIHsQfHIs8inldwPehFlKb8aOojsZcsHVQ==
X-Received: by 2002:a05:6a20:8f05:b0:10c:49e:6c67 with SMTP id
 b5-20020a056a208f0500b0010c049e6c67mr6978104pzk.33.1684884693628; 
 Tue, 23 May 2023 16:31:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a634c08000000b00524cfd635cesm6356904pga.69.2023.05.23.16.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:31:33 -0700 (PDT)
Message-ID: <7c19f6ed-366d-fbad-ae60-09ff4a4b1e2d@linaro.org>
Date: Tue, 23 May 2023 16:31:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/11] hw/virtio: Build various target-agnostic objects
 just once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> The previous commit remove the unnecessary "virtio-access.h"
> header. These files no longer have target-specific dependency.
> Move them to the generic 'softmmu_ss' source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/block/dataplane/meson.build |  2 +-
>   hw/scsi/meson.build            | 10 +++++++---
>   hw/virtio/meson.build          | 11 ++++++-----
>   3 files changed, 14 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

