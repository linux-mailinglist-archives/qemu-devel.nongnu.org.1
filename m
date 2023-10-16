Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F087CA9FD
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNrF-0008Lt-DZ; Mon, 16 Oct 2023 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNrC-0008KS-Qs
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNrB-0003Cg-B3
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:42:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso4403476f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697463724; x=1698068524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TheAOitW8gBkDzaFkFGdvcpXeVFi7PA5VVtLtjuC7bs=;
 b=lcII0pRIvQg+KYK3cezzPjbkS8uaqqgv8OWliBpfUK1giIJ7THGde7uLA5M+p0a54O
 0m0UXGB3MfmmJgQbp6IImpKZKPo7Lm+aJ5Y8arqdJyRt2jPJrr24Z6ucvc417y//Fzoc
 RMUiS3felga14iPh63HNWsmPxfz3Tf1zb2NsExiBwgRGYEA09xn7cgxKcCAOdlYZF4UC
 G0YaLD6NsxD83Htp8U/JDb6azoCnuJDjNAIPMk5L683VqnVBi5avQiLWm7QUc300ywX5
 NUJfhKRES2UL/y7xn2BJ9j72CHYU7R6YAFDWWLug4MnydWOG8tZI7joyAl87LQtcq0Pm
 peFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697463724; x=1698068524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TheAOitW8gBkDzaFkFGdvcpXeVFi7PA5VVtLtjuC7bs=;
 b=JZ1PDvgz/G3YSDsYpAc+JPxYfXhi4SEvnLoRtPuMeu3pvQv1RMOAO2HmSTFKhZ4l7M
 qWyCu+u4fyDPKPm78hNtiIN9UP0uAOspkQPzWxVmpShxK/MYk0vdDDnPpkRHcLGhBG61
 qLSiunVPVPIphI9BfA46ewEdG9kzcquAdFLyf5mchzfzhzYCvSu3co+BLy0k7Q53guCV
 M+bVFPrVgix/AW0OYWaH+dN8a9ACMAT1BLenUhVqA5EfmfpFTWzxVdJ6z7qFL0tjpaN8
 kF4EGp+MonsaKsr1P8m43r7lrJua6wdkplPV48jE/UnQDkJCuGTXzlvgOFpkp+W7A+tB
 E3xg==
X-Gm-Message-State: AOJu0Yy6u7gThzyIE4UGjJO/DCGcSc4vH0n0XC2ChU9MYK5kV91BL6ui
 IppFxdszrUb3Rqx0QR6qFLebJw==
X-Google-Smtp-Source: AGHT+IGX/QN0neIWH15zxxHaAk+5B1aUecdJFufVoYq5O8PAfogBG/f8WIIn/UnN9mWIACuBdhAlRQ==
X-Received: by 2002:a05:6000:1c5:b0:32d:83b7:bdb4 with SMTP id
 t5-20020a05600001c500b0032d83b7bdb4mr11897951wrx.9.1697463723837; 
 Mon, 16 Oct 2023 06:42:03 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 e11-20020adfe7cb000000b003176c6e87b1sm27237231wrn.81.2023.10.16.06.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:42:03 -0700 (PDT)
Message-ID: <09fe73a9-40b4-0d4d-7baf-4d4dc7fcd5db@linaro.org>
Date: Mon, 16 Oct 2023 15:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/docker: avoid invalid escape in Python string
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231016062300.160160-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231016062300.160160-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/10/23 08:23, Paolo Bonzini wrote:
> This is an error in Python 3.12; fix it by using a raw string literal.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/docker.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


