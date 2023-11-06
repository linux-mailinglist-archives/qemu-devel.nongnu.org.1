Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE617E27A3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00nx-0007GY-MP; Mon, 06 Nov 2023 09:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00nu-0007AG-0U
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:42:14 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00ns-0002E2-95
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:42:13 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50906f941so65533321fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281729; x=1699886529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cxQBX4prONbM7Syoc9xTNYWRY1Hp6Xw4jGv0zwqcn9Q=;
 b=wgw7hq4x7bMU56a2FWR1YNVSwpm9EeQqrXlifyt0pSdxLYX8IXK0pZ6BPb9uUhS+qO
 W4IeOCLh4VifEgjwwZTYcPLdVFK+mgty39ig4r4MX6nMre/s74LdRB6Ox6vWDhYV4a81
 KF4+lXFIWUJ7L9tjX1DQfmA/V6x73MTvfxjfV9FnnQmWL7ILkn9nnyts12W4tVDdWL1e
 2mxjS0ReMNAlGQwhTSRwqgy31CYVnyt3HQwmx5+gIUg8pew0lyNsCWANijaW4Vlpi6ll
 Rfh+rIO9Svml2X6qm8MIjHXUDWeja+/a4jVKS6EYlWrjGS2EBsq/TTg/wcQn+rFTvkVE
 EGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281729; x=1699886529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxQBX4prONbM7Syoc9xTNYWRY1Hp6Xw4jGv0zwqcn9Q=;
 b=V0RqHfQ/VQBhvj556dPDQSZY+HBQjAgXsbO3m6EPIIbUS+SgkoUyoiOd8/epO8XZ8Y
 pMat1l9hoG2udvyoKU+AXZwk2wJT4WoizDmsUViZmYUiqokXX9YlQiJ/QYh5zAthLYl4
 QYtuYYo6mV7+1aEABtxizrNU72iWOZPG1aCJsGkGd+5TlZ4Ewa3zQn9Ulu40EKVN1oOa
 wBlfaUk/hLypzp72vvhAncTksYRKwyCXjVoI4jEbRMmAxGiunA7yHdULzV1dyV4Qotoc
 5arrUcAhc5rQwkPATK0K1usOpLAmjuWKRdTMWHGEKRvdv+e1kpDT1E7xW+i1mSJkpgxv
 8o+w==
X-Gm-Message-State: AOJu0YwBKTlWinw33N88dxw4l2MgAqs3eIrKbp9Afl/8w6kw5VVTdWkw
 8YXzC+GgfJb3uOtGtqnbwHCAagTF2lS8/w3MScM=
X-Google-Smtp-Source: AGHT+IEiFSlMzG/B6QFzKgyduS7MgXVrZxgvCZWjNh3XH62bKuwGRpz6S2dXZq8XKfvDbG078HveUg==
X-Received: by 2002:a2e:8847:0:b0:2bb:78ad:56cb with SMTP id
 z7-20020a2e8847000000b002bb78ad56cbmr22617269ljj.37.1699281728853; 
 Mon, 06 Nov 2023 06:42:08 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b004053e9276easm12173265wmi.32.2023.11.06.06.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:42:08 -0800 (PST)
Message-ID: <2bac7544-b293-986c-c612-259f5d45663e@linaro.org>
Date: Mon, 6 Nov 2023 15:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] tcg/optimize: Canonicalize subi to addi during
 optimization
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
 <20231026013945.1152174-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026013945.1152174-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 26/10/23 03:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


