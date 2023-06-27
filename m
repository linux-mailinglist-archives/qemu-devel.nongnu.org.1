Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841B73FF39
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAEl-00084L-Ia; Tue, 27 Jun 2023 11:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEAEj-00083o-BT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:04:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEAEh-0002X6-Pq
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:04:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-312824aa384so4133441f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687878246; x=1690470246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TRlVccEf+qJu+AE9CinxrFon/7uXtHyNHz5jmyE+jy8=;
 b=myJcq2XrQMIdsTx6st4GvnR3K2JXDqY41P2kLaphIxG+VKmjxZ7tuZETa7Vhj7J43J
 SRS7zbJXjZt5xreo9posCRzk5jxySVXDn8/GGpsNujNs2k9ZN0jK7w7EXmb3J1NvYCb4
 J8nQk6keiWSm+qKRTf8YnyQNamJuK3px+VUzmFQlW0slyauYOjkQ1+c5yCdZE2WAxHG4
 KwwXooLPCIdgRgSaFWARNTChbtDnltCd+s+Q2b9bR5m+OVefM5v8hDQ9b6tMwNsoIFX5
 3EvrPpUOhOQ9Ovbor0uJ/Ff4W9bQd+5pIC3F9oydpGPYmvtVrUpBdJ8UYwrH5qRCOFNF
 sqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687878246; x=1690470246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRlVccEf+qJu+AE9CinxrFon/7uXtHyNHz5jmyE+jy8=;
 b=ieMGs7lPjGEtoAMW65Bg+RNDWXOW13GZwWrkR1Vq1c6FCwwcjdZKIY4VABYkZrZGjg
 /Z/SDM89UiRyvvXTyVCLbseL+yLwNikukmwXK7FIslQQ2ffeEQRw3bW+2nPsob8C37dx
 fn9L9ZRKpiEV/VeLPeAukrfCSIKNExpD1MRFen15LHmd2uc0K4Le5RKSGsFwyNiPnw8C
 RuUcclbr+P0DXz/a5ejHxm6gOgIPEX01JbdBLCF2n2j3nOiJMR7nDzOGqyBG1Y6Q3AcA
 zD61QLUwl0hINSZnTzHcseH9BP5+gM6hvq2lJPPUUVqtkovBF49CiorOx+ylPQjJd8c0
 52WQ==
X-Gm-Message-State: AC+VfDwQpKuk5tR78vMJKFyVU/9nvwnnX4QfD/MVOJfu9vPnjoRhHq4t
 9xL4YUk2CmOFv22LYI98XbkXSg==
X-Google-Smtp-Source: ACHHUZ4hu0A3HfwWxylM4/hbyi4mSY03T1cdqf6wxQYIi/HcVx+00cpk8hyBkUhBE7R0+cbTl2ahnA==
X-Received: by 2002:adf:eb42:0:b0:30f:b7b4:3e55 with SMTP id
 u2-20020adfeb42000000b0030fb7b43e55mr11242306wrn.19.1687878246103; 
 Tue, 27 Jun 2023 08:04:06 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe101000000b0030fb828511csm10578066wrz.100.2023.06.27.08.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 08:04:05 -0700 (PDT)
Message-ID: <3798dec7-5798-5703-86f9-fd45787eaac2@linaro.org>
Date: Tue, 27 Jun 2023 17:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 04/33] virtio-gpu: Optimize 2D resource data transfer
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Keqian Zhu <zhukeqian1@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-5-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627130231.1614896-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 15:02, marcandre.lureau@redhat.com wrote:
> From: Keqian Zhu via <qemu-devel@nongnu.org>

You need to fix the author for this patch.


r~

