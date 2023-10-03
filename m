Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B47B6C9F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngxr-0006fp-Sh; Tue, 03 Oct 2023 11:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngxl-0006fF-Gl
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:05:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngxj-0005bL-G1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:05:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3226b8de467so1067159f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696345521; x=1696950321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZjEY+Ufv4OQgp2sez+vy3B2PzpQ6/k3MHIStPI5Cn+g=;
 b=MjShlndSXryKJJc8kjp4idrpYNs5HbC+nWaEAIaFwzJAi5HvnJeVrjkNK8dI+MsvcP
 LGFJLst/vlGtCL84G+bIUTkjEim4eHVEQdNLVwXE5LjHjtcggyFdCdD1XnWKu+g6eWKE
 t4KoESVD6kB04IbnEnPyfZRbgBxkd4SyxaNn/oHkKrkjDrZjwVB4A1WhsfUVolbSOnVE
 eIySerB6PUCfLQFokn7/kYhsBbvlOQsFaw6STTc3s7EFz8OF/1k9GHwsm3/3GYZWfiLH
 Cgr1CQ/nPO1IV7gDehgq/mQL3hHTPJr57KNMoibcdYx1g7WODy6zNpMHKqnWpoMnYtAi
 oJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696345521; x=1696950321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZjEY+Ufv4OQgp2sez+vy3B2PzpQ6/k3MHIStPI5Cn+g=;
 b=AVNg1HrSIX8btLW7n4lkzGb1PNKFOyYJ4wVGHLgTWrAK2Ai6ljxSbro3N3035PkFgJ
 ABIkVVLr7FEwWTLVwLf5U+9knQcfZPm4TUom7rqevaUz5vwlis9KtgSK+zEoqrqJ/qY3
 0b+0lnJARZYDK8et7pvpNCFo3JHn8DtEONFfY8XaXhrx2wDNBOYayB+taSdK2M0JZoKG
 lcz2KJyojKCU3uDW0ptURYc3bzblicBuf0SRBp/rbG5BUNf31aV0WTk8BjhHErccOUSi
 B01qvmzgclalQzn2XOCqoMQ+JtTMz+Ivk2fsK90UQm5/Hw/I0LdtgoZ5CzpN6ffE44dl
 rIHQ==
X-Gm-Message-State: AOJu0YyAyLjq9dXXKGro43JLNfZc0ww+OTltOssxR/ZLGu04XIooYYHI
 L04iUTb0QkzoIaHnoc749QTbQg==
X-Google-Smtp-Source: AGHT+IFVYy778rcwYvo0A5ICqjuOxfTsf4tpuzVnCt+58v5QW02t6DFJad1tFMGVW3CH+SvrJBWZMQ==
X-Received: by 2002:a5d:46cb:0:b0:321:8181:601e with SMTP id
 g11-20020a5d46cb000000b003218181601emr12704124wrs.8.1696345520473; 
 Tue, 03 Oct 2023 08:05:20 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0031fd849e797sm1765329wro.105.2023.10.03.08.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:05:19 -0700 (PDT)
Message-ID: <9cc52750-3e37-3010-b55f-e06a7d428b5e@linaro.org>
Date: Tue, 3 Oct 2023 17:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] migration: Add co-maintainers for migration
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>
References: <20231003143847.9245-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003143847.9245-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 16:38, Peter Xu wrote:
> Per the qemu upstream call a few hours ago, proposing Fabiano and myself as
> the co-maintainer for migration subsystem to help Juan.
> 
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> Fabiano, would you please ack here publically to acknowledge that you're
> fine with it?  Thank you!
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81625f036b..fc6e09aa31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3207,7 +3207,8 @@ F: scripts/checkpatch.pl
>   
>   Migration
>   M: Juan Quintela <quintela@redhat.com>
> -R: Peter Xu <peterx@redhat.com>
> +M: Peter Xu <peterx@redhat.com>
> +M: Fabiano Rosas <farosas@suse.de>

Thanks both of you!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


