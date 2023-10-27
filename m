Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C17D8F8C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwH6m-0003ne-Ip; Fri, 27 Oct 2023 03:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwH6i-0003nO-Rl
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:18:12 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwH6f-0000ac-RC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:18:12 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c54c8934abso25164191fa.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698391087; x=1698995887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nODLAA126rPWGM+C1PEOQeGqVTZVsBvmRAupX9El6tE=;
 b=n+yAEgMjjI2PbISwk3vcjNvMZOFYWNgDC3WebSDaWNRUAN/HpO5Ip9h1NnGobs5lNm
 3OGG4CCtuKnDrqn5iLsJgqirOjWj8VXovc9VenyS7bOTBQagjdRjHQVWn0l/tEo7Ugga
 EGoKm9CNFq2ocjgPOFVJiu14cpKApr6M5dqx4OghbXdqcZiJWEF1gV1U1XAxXfYlldBL
 8eWJ/P06RetKtNUDZjOmlu7KA4QMRFC1+SBxDN17EVyu9NVh+5K9cECCUDuHupZVF6mo
 ZBPwVrLleW8GrHzPmGF8dBqF5o+ci4OugNI4GvsmQgRRFZkQeBcvuu8qrQi+XdjGCcKf
 8ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698391087; x=1698995887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nODLAA126rPWGM+C1PEOQeGqVTZVsBvmRAupX9El6tE=;
 b=COa+JoiAF6gFa3hwZiDapUC9VDRqnj5n0PvofI1u2dtx6eURqeVCU5dK6ZDh7lRDSu
 AU2YPTuWHfjSVxA5BOULicmgsU9W2kX0mMYbyIadJEfxbDVBT3zZ1qbPDrYhtKxyjpVe
 IfAmjW6qQRqxUGpvw+8yEagwuNdPQ+8njXfY3UVQ1Uwocv1xtvog8NAe8+L0BekOklKh
 /j7gsaVdiMqiObTBViQXl/DsmEYS3C+ESYdO6LtK3eAGTpsngdrjAL2TJZQ7iIPgJ08K
 iRbSdrhQH2HHMNP1krEosVSttIjAaxyiUupyFPOGTQYA5drNRAuyC5vrAri0tpsSkmWm
 owRw==
X-Gm-Message-State: AOJu0YxAo6hJBnQZagSa0BxpjkXA47MviFPQbaWOT6cuvYzOLP7LW+MW
 BthroZOMA19SvvqF6ixa3DzWnKmFBOXyWYLCksA=
X-Google-Smtp-Source: AGHT+IGA69zHVy+VRJ9ae8ScF6HWoOV3O5B6x78/giiYllpDMlTGzPXxxjgv/0diGDNuly+P36oUew==
X-Received: by 2002:a05:651c:1307:b0:2c5:14f9:aa1 with SMTP id
 u7-20020a05651c130700b002c514f90aa1mr1366406lja.15.1698391087485; 
 Fri, 27 Oct 2023 00:18:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b003fc0505be19sm899799wmq.37.2023.10.27.00.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:18:07 -0700 (PDT)
Message-ID: <daa13c97-2ee3-1137-85c2-86778aba1783@linaro.org>
Date: Fri, 27 Oct 2023 09:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] util/uuid: Define UUID_STR_LEN from UUID_NONE string
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>
References: <20231027065443.1305431-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231027065443.1305431-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 27/10/23 08:54, Cédric Le Goater wrote:
> Cc: Fam Zheng <fam@euphon.net>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Follow up on :
>   
>   https://lore.kernel.org/qemu-devel/20231026070636.1165037-1-clg@redhat.com/
> 
>   include/qemu/uuid.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

