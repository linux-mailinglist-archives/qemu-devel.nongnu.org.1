Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD87D7198
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:21:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgcn-0007VB-BR; Wed, 25 Oct 2023 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvgcl-0007Uu-EH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:20:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvgcU-0008Oj-5j
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:20:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so906554866b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698250832; x=1698855632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6ACUGP0WRTgQ0plbvMgUUM/ZJ2o1YyqfktgMdANNlk=;
 b=yD+YtncKJbNg6qMUY4wlVDxJAeT4cWzFC8rX3I1aMUW3QWjyZBVgIKoNLPd0U9tL7P
 5VGb1B/6GrI3OxCbw0YZn6bm8rHSwhfk/oCytS5ZLc55pMHMll9BFX1UFHMFgTlv6/U3
 BVhWq+MJQeYIjotABHDTWPOhHZOQySx01tbN739lrakHUGZbKssBAWApdac1uaDFIp8c
 mZJ6izoCiR+CIAHslONEZTrPhn9S5wDjPmMyUnzyQ9DXjnWzk82IWlnvts05HouKpIW+
 uXVGuaAyaJ19UQZ1QLF4Cf178/ZrtxcbXolGm5bHNZcQus3kWp315wI6AXxVNolifRGg
 54OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250832; x=1698855632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6ACUGP0WRTgQ0plbvMgUUM/ZJ2o1YyqfktgMdANNlk=;
 b=xKueyPhjvtwVlxdH8Jo/4AuqrT4QRzVmGGya0XXTK248JSa6jshiF6B126sRaqi4WI
 paoFNLt8dXpUQRl59hhwD39rlHUXjoCnWhIiGA46p46LgUbSdQwvgJ4dRTLVbZWQFAsv
 qyqzdTvfAYS+EMIn4rDJZ/6E/jyObQOaTG694WD5ryEHXKDMAzKq5ySU7nAhA+jWoIO+
 IctrbfslYCI6LagM4+ZOoic6Cs1kEPwguKfm36fCkn0TEn8LgjIM7ThWIyh1QcqLoxHb
 oD2izBorHLonfQ5JJYRQDSGeQCE8GMrlFpQBi2fQGT0dDlQIVJ56yhq2I3v4Bq43vMgq
 9loQ==
X-Gm-Message-State: AOJu0YxSyl8a58JtOc55RX6ZZ3993OrzXR8VFnSjnTflx0c38ugt+9Eo
 rjagVN57h1drbnhFSDcknmlzSArVd2cRzES00KU=
X-Google-Smtp-Source: AGHT+IEGAFyZ593bv1ySvwEmdeo9EaRWbMZ8Rclvq6uKAGr1xTqj3U4vP8bN/H4Cw1Eddp7IBqbBMg==
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id
 ht19-20020a170907609300b009ba2f203d7bmr13764939ejc.71.1698250832262; 
 Wed, 25 Oct 2023 09:20:32 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 lu12-20020a170906facc00b009cc1e8ed7c5sm2992574ejb.133.2023.10.25.09.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 09:20:31 -0700 (PDT)
Message-ID: <71523694-bc93-e7e5-7144-d00bec2b1614@linaro.org>
Date: Wed, 25 Oct 2023 18:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/29] tcg/optimize: Split out arg_is_const_val
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231025072707.833943-1-richard.henderson@linaro.org>
 <20231025072707.833943-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231025072707.833943-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 25/10/23 09:26, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


