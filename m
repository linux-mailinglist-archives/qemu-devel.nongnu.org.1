Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898ED704E05
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyu6H-0004Jv-Ay; Tue, 16 May 2023 08:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pyu6E-0004IE-CD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pyu6C-00062o-D8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:48:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f509ec3196so25016335e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684241294; x=1686833294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gh5B+4K4CvU78bUf8v7lL2l4ylcLrSTavuAIiIUaxZU=;
 b=I6eJkqDYn4WKkpV5M/Blcx4TapngelAZrr1AowZz7d5xBcl2pbnhYwXsi7OLeOC8Jb
 tIIMiriRoDDRMOZGo838Sfqv7+xpY8yhPgyz/6T50+QA3sUAHr2Paj+fpJPZGDv5qskN
 eyEQlvwu5VJPIpdo88CS3WFWSPxmaJfdAgYZyoxSwjN19WHGRmFF6qS+LT3TgJIMaY4b
 0PgwU6zo16RI6jH+AsnI8MHpHClCrnl2Ucdkjp22XLd6y4jgZuWsR7FxdXI3GOyAx/t8
 fMn+RRtwgISJFNJ5BTgpUeYsuOAyN6GPeGdrEUILpAowUdyghShiA14W15Ec0HC1dpid
 Umew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684241294; x=1686833294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gh5B+4K4CvU78bUf8v7lL2l4ylcLrSTavuAIiIUaxZU=;
 b=H8amBNXxJAaPUKihd7Li+DiNWb+FxJGZZOqsIcqaFbpiP6SIvoWX0gB9NNjOYJU+If
 NEud+Mb0BWhToKz9GEvvxlHvH5mIihr57MfGrKZHnV6SDKedWyQvUpQzGTQGER75UgPO
 QNfwkV/oZk4iRw38/kLAnjplhLyhmPn+hKbZcL4x3YoJ4r2srmLygH4929puYtC4p3Cw
 K+TbeQ0GO6WuUHaGuuV9CC5u57pcdsuwICagxdkbkWDV+qLVle6TAGNVNPOqIP4yjuae
 biqJvXYE1BqD4hdZl/HyMPkioGBcJ1FWzsyDt/j/ZbsVhErvZfq2PjlKKsj5Wq7Jbmij
 7Kyg==
X-Gm-Message-State: AC+VfDyIlzOjbP3ca0ds4K1OcFChGQSIlwO78XhCx0zy/jC394NQyYT/
 An0+rvP06m5gAK8olRgs83D0RfHcUunt6Jt/LGTVfA==
X-Google-Smtp-Source: ACHHUZ7mkXh1brflzo1etElWWra3H2L6xx4BAUFIOR//GSQzAdOa3bQd+DK4EcBUtMAi0mAHlFuB5Q==
X-Received: by 2002:adf:fdd1:0:b0:306:2ff1:5227 with SMTP id
 i17-20020adffdd1000000b003062ff15227mr26798307wrs.23.1684241294210; 
 Tue, 16 May 2023 05:48:14 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.175.66])
 by smtp.gmail.com with ESMTPSA id
 w1-20020adfec41000000b00307c8d6b4a0sm2489354wrn.26.2023.05.16.05.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 05:48:13 -0700 (PDT)
Message-ID: <cf3a2417-f553-df8f-b6e1-2d57819fa69b@linaro.org>
Date: Tue, 16 May 2023 14:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/6] qemu: log reservations in fw_cfg e820 table
To: Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org
References: <20230505071117.369471-1-kraxel@redhat.com>
 <20230505071117.369471-6-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230505071117.369471-6-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/5/23 09:11, Gerd Hoffmann wrote:
> With loglevel 1 (same we use for RAM entries),
> so it is included in the firmware log by default.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   src/fw/paravirt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


