Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB97B9F86
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:25:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPHR-0005Zf-Th; Thu, 05 Oct 2023 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoPHF-0005WR-Ep
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:24:33 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoPHD-0002cq-NN
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:24:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1088506f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696515869; x=1697120669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QoksXV4VH41Q9nJf3qLN5IyOztrANqIOhVmpis5Ir5w=;
 b=EBQormuDwwUfD8xcMZ/K3WVyhe+NlFHJzRi1xXBNs7iQmQVeoOvsOKkCELWZYr71Mq
 dK4mUg0ALTXrXMx7a+sKWN7VD2d0fHBlfVtAcBdd9Cjxruqjscw0P8JpwMFfyGM1x2xi
 ZEUG+sbCTHKqZS+bzMxheIgZlnM2yo/DdbLEZXnDev1oUBDp63nUV8tI58XjIcpov3N2
 iTRlQR1uqlgX+YCXTGc2awY+PlTsWg6l/wo7ZKN3r+qt6Y3U1YhfPG5D/cWS0Xqcvohu
 nMfFogyWgxh+qLVDdLRYJCwjf6gKUtaBH15DEMUf4a9ISlfbUk6GsNh2sw5IFGOGshWy
 5Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696515869; x=1697120669;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QoksXV4VH41Q9nJf3qLN5IyOztrANqIOhVmpis5Ir5w=;
 b=WihDc1ZDrMdlJ90EFE0v4IzejVen0bXMj2aOBayvvQYgk+YW25jUv/CFTOTPmp/u57
 aPfopJojRgj/m2IhC1eIc2rNjFrBHsgVK3HdDuPWCaaTXg0Hph5Nm6WxL213/VH+a76a
 6TCIDEqb4P6d+419D5q8elx3Af4Zz6FIeyKn/8J5mhVlBgT8USzKS7P7xrcIK/bEIlLi
 9CU15znS5rCbPiuvxfWMkWI8XDgocodVJw81cNW1VZu19jgRmAK2G9/QolS64Zn5MKzO
 hvZTJgPmHcC+vPI70XziNRJcnYWDsHqwAZfEYgP5hzIuxzcVKx7K0eRLEOsS0n8tDXCr
 W80w==
X-Gm-Message-State: AOJu0YxLJyfj18ERuDhmjyaC7Q94zBhFyaIyaLc6ylHfTkFllulxN4hB
 sBU6LaB1jWfjJY0+HXE7nlzDNQ==
X-Google-Smtp-Source: AGHT+IEUTJbRfRJbXUZPVeEWO1PGozgefR3GIJmq2bFMEeIGw7WnuAfjePJB7CrDLRtWVaj9eX/FqQ==
X-Received: by 2002:a5d:538e:0:b0:317:6a7c:6e07 with SMTP id
 d14-20020a5d538e000000b003176a7c6e07mr4856257wrv.32.1696515868694; 
 Thu, 05 Oct 2023 07:24:28 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a5d6502000000b00323293bd023sm1931945wru.6.2023.10.05.07.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 07:24:28 -0700 (PDT)
Message-ID: <57414b7e-960b-e002-7d79-d76902a7ebac@linaro.org>
Date: Thu, 5 Oct 2023 16:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] configure: change $softmmu to $system
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231005125427.65625-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005125427.65625-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 5/10/23 14:54, Paolo Bonzini wrote:
> "softmmu" is a deprecated moniker, do the easy change matching
> the variable to the command line option.
> 
> Based-on: <20231004090629.37473-1-philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

