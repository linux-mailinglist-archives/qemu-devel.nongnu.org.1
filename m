Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45573673A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXOf-0003Ai-Ch; Tue, 20 Jun 2023 05:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOb-00030p-9m
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXOZ-0000Xb-Lo
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:11:29 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51a2c60c529so5447395a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252283; x=1689844283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDSN6ihfk9NmZslQbaGwstNERXKLRDtFfVZy3z9jsxM=;
 b=CcJVQ03/ZZhLYek+kFJyTjfDKYTRoqvi/ck2tqC2IgFOyLY6syVXT4IM9c4DgmaQZj
 4FBgh/Sm+V7QfPJMysNT+0jduv35m3BNeyNegiJaMRygCml4fFVXDnV8cEkPmVQ3tBuN
 bzEpFgrF8gh2/kfGRqA906Z8EwWt28ipNnys7lTRvhbRsVaWXsoDTKS4K38xXiX5j/JN
 NWTpcGf78I9G4G70f7zvMOzxA06In+2sH1uX8fle5dTL/JZIV3AyU63vTuwIKreNT/SL
 ygS9d6m9YX1TN4BU/eK5sCvnBuHvBrTcl6Y9XXuyVCFVfK+8Pub0Y77sPlRFmYQ3yyVg
 Tsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252283; x=1689844283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDSN6ihfk9NmZslQbaGwstNERXKLRDtFfVZy3z9jsxM=;
 b=iHHdfiaNdUii4y3+MC53wp3HSPxAP5m4zqzK7BCNjAo3jSEgd9E7yh2e6Emkwt8UdA
 NuwQWx3IZDQi68DK0RKRfvrEFBUuqFZ+J7zb679Oe8YNFRSVKmF/iq4IjYzh/H/n8d/O
 wHoalRRyWAIfjx/cTHPhRjdpyKCpILill8gM8YK+JjTlUME1PdsxqZ234jhh26XX6c9o
 /aed9iORXsK5mwrzqeB70y9nM5OGOoQ3rme2Q3oCgeTkg0Chbb4wzuW42BN2mcdhcbtS
 GS8bOofP+CXGGUGsQwl7GuI3STKawDWGYDhXhGlMtKnc712dG2Bz1vjhghrDSV4b+QYS
 1xnw==
X-Gm-Message-State: AC+VfDxwzBY+tOqs+9LwYzBNHH7rU7BygEO2OuTOecPifxunMBLSrF/7
 zS2tlSDl8SJmrPyydEm2/+6EyA==
X-Google-Smtp-Source: ACHHUZ5cTOLj0SYHBlDQIPxWk2luYXZseLaD89ABTtuubipFeoVhIv3Lfksw5Is9HshcgMdlUERgjA==
X-Received: by 2002:a17:907:7dab:b0:989:2cfb:444 with SMTP id
 oz43-20020a1709077dab00b009892cfb0444mr1035123ejc.43.1687252283253; 
 Tue, 20 Jun 2023 02:11:23 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a170906168800b0098884f86e41sm988520ejd.123.2023.06.20.02.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:22 -0700 (PDT)
Message-ID: <b317a2a5-f14a-7c5d-f324-997663e48460@linaro.org>
Date: Tue, 20 Jun 2023 11:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/9] MAINTAINERS: Add reviewer for XIVE
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-4-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> Fred discusses frequently with the IBM HW designers, he is fluent in
> XIVE logic, add him as a reviewer.
> 
> Cc: Frédéric Barrat<fbarrat@linux.ibm.com>
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


