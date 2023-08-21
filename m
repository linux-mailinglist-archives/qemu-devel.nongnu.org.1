Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA378241E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyx7-0007RQ-9M; Mon, 21 Aug 2023 03:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXywv-0007R5-Js
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:03:45 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyws-0006Ua-IH
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:03:41 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ff933f9ca8so4348272e87.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601416; x=1693206216;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wB25B/5CkUFGE0SH3qrYIUC2YOr71tCDVnZOe40EHpQ=;
 b=j4KBT7BXjXyXZ9wLjM2gmWQmRRplywC+6kcWS1/ZHjuVn1nPC4YsbOMBGScime72Bs
 VG5NJftmSeC+LZgWjwEl42tc5VFXBuUc/2vLGh4pASx14iopMiPudLR1ZfmoIGVzLX+t
 SV/PmBaUfWqNPV6ZwJ33kFXyS1FhOaUCr77X0ue9Yw4Ivqk+C9+nWGkkDrOIwp5+/TEm
 fjVsAP5e1wK7tDxKEdOZt6ISu2D4EbFtL10mzG0XvMMm8RTPQDMnObU2gaBWpwDH116Q
 8YGkZJg+xkh9WcGwcbWSd87d9DPWUpyqgB4eiz8WiwglDlR6JWR+yWMhYBT9z/BrSr/S
 vL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601416; x=1693206216;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wB25B/5CkUFGE0SH3qrYIUC2YOr71tCDVnZOe40EHpQ=;
 b=XFKBG1g4YMK4+5R+BnqgitvG1EWeg+QGdIGTo0jvYZx6rQ9vxvw7O4IRogTMuUh8FH
 azdn4B6noSqGZQ/Zocurd8dBDQ4FcXVJ/PITF7Gcn8W5KqvcmF6aqcvyBXR5TmQcv9j0
 jFZUzIwk4i4tc3bDmPvwMsCqXgnW0bISwdYrG8Q5tQbZ6E68jHl5FxBVOMS93G1BzXz9
 jFuOa4uyn9aSDp99r/r+mTlMKi6gpRMm3RfEoBtZUmZAomXBel8h3LqlHjYdc31m0gDz
 ANpluG62yL/iedHnGLBW6GpchY6mc47lke0ic6fhI4d8rTSf2HXsVA2LsW3Cax+DJs3g
 1YqQ==
X-Gm-Message-State: AOJu0Ywpujh5a+piO4ixqbtlwyROi67yYlhXcIh3VxSsMh29z5yM6z5E
 SvvLDuK9v9DM9LZZovA5UhHjJQ==
X-Google-Smtp-Source: AGHT+IGm0dIr1xeB9cpYIj8v0GEYik2OzN9reO7JMv1ihxcl/sfuhdCEVlYLedVLR286Cml+Jp+Wqg==
X-Received: by 2002:a05:6512:3d8b:b0:4ff:80d4:e12f with SMTP id
 k11-20020a0565123d8b00b004ff80d4e12fmr4259835lfv.60.1692601416087; 
 Mon, 21 Aug 2023 00:03:36 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 f14-20020a7bc8ce000000b003fed4fa0c19sm10265731wml.5.2023.08.21.00.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:03:35 -0700 (PDT)
Message-ID: <d7c48fb6-92e5-a18b-fd54-2997f6c4f2bc@linaro.org>
Date: Mon, 21 Aug 2023 09:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 28/33] accel/tcg: Disconnect TargetPageDataNode from page
 size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-29-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Dynamically size the node for the runtime target page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


