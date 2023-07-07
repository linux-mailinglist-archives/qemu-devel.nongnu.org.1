Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7274B85B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsNh-0007kw-G6; Fri, 07 Jul 2023 16:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsNe-0007ai-Am
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:48:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsNc-0002D0-KY
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:48:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so2420778f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762918; x=1691354918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/uNPAr3KHkqYYxgB85js1f9sQm0mSoi+/6vW4xb9CKU=;
 b=YZpgk4tDNDzVETR+ILg7PM7wxdG/CUFcBVbfk9RB66BTbV0UXwLqRbcjpfKujVyF8F
 tLlOA2tAij3WpCkGCOkU6kN76M5wP5CJX2CuWryBNpHeiYltQ4cqjhAOmCUIaFCNW737
 DcX2F5GrIQj0/0T8GolAMFatI9QVvT+uUnXoVchK2THMmHOe1FJ1Uunwu87R0r6GOjKz
 UciDjWI3WUu/1BMp2qX5vBSbzowoO/4qo6gKLen8dKma4n5L44TudcY8AJg2YruTHzKa
 8iXl0BKC7xqox5TmzrAs8Nj2ceV7sfvobGesSrHe9s/PULsFMkWRle7NmpurPbGO1sbD
 WC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762918; x=1691354918;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/uNPAr3KHkqYYxgB85js1f9sQm0mSoi+/6vW4xb9CKU=;
 b=L6nOy2R3fJlSOLy18AFo0NHJmAMFiqQSQEF9nAu+4zuk/xDwE8f+6Hf6J8LvNjUH5v
 RsZGnh9ez6QuelwVwz+PKfBlK1CukZWSxpinElSyRLkXqlCT2PFkmJ4AhWOQoAyu+DMu
 14tBee0O6D5+j4HEjIWDsesDPDcuQ/o2JTSG3wGp9N83swH7vsLMC9DITnWZv7wB2Xky
 457JGOqVhMsMRtwNWqQsus6BHWIctlbhpcx7KBslvTBCcZ4LbyO3FQpaQofwBb9HHa4R
 a2XGQQaZfuzZbOZxK8e/Ja/8dByjY+9dJoIqUtAKZX9fnA7AIKSoty5mXMGMfSt6a43Z
 pHZg==
X-Gm-Message-State: ABy/qLbQqxpsv+XXmoqrpOBnIZ7mz31ylg9p2jfTIqw+y12Q8L7TTwiW
 KAcvIqNmSVSeGnzahy9DBZPP/Q==
X-Google-Smtp-Source: APBJJlGUO8I0R8LADCPM6rdqiROGS6eSUe3VlrPpgS2Oro80jNXY4GchTGVjcUYnQsWWjbgG+7Dybw==
X-Received: by 2002:a05:6000:cf:b0:313:f38f:1f4e with SMTP id
 q15-20020a05600000cf00b00313f38f1f4emr4399004wrx.27.1688762918044; 
 Fri, 07 Jul 2023 13:48:38 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a5d5908000000b0031437ec7ec1sm5362038wrd.2.2023.07.07.13.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:48:37 -0700 (PDT)
Message-ID: <dbd9dee2-7a3d-615d-5538-d31b048b2817@linaro.org>
Date: Fri, 7 Jul 2023 21:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] hw/virtio/meson: Rename softmmu_virtio_ss[] ->
 system_virtio_ss[]
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
> Similarly to commit de6cd7599b ("meson: Replace softmmu_ss
> -> system_ss"), rename the virtio source set common to all
> system emulation as 'system_virtio_ss[]'. This is clearer
> because softmmu can be used for user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/meson.build | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

