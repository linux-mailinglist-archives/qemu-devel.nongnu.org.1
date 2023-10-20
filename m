Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF367D1837
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtx8Q-00086K-KU; Fri, 20 Oct 2023 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx8J-0007no-EJ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:34:15 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtx8E-00038n-C0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:34:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b95622c620so197212666b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697837647; x=1698442447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ELGquMGKVVECrLQcJwvjtRydX+WAJn+p1gMGI/qJcQg=;
 b=B/SRb2wszUxn94XQ3RQOh9/fah4uudc0dxqc2amom092cgJqty78i/qs5xpvMgc4NQ
 UKKuCsnlp2+LUzPifxEtaw3QBTU/rmkoN0D1A53WVOzWlC3hMhIAXmgUGuEawfDggtrR
 cm6pcaBEqKuaxFssbG32wdlxcYctxKIoDf/J9SXt5a1pexw1908gTKiX8nyP38skNEKi
 S7pDsr28s76vsZKZMIa+uhDr8yjFNmgiaxi2qhQUKrbWEsX1xNrhLeyTGgLjVCPad4wP
 B0AbMnFw6lXBom0VuMYv+zKY8O0mfXqajRTfqs6uNdndC4DPjEETMD6Io6Qplc80VUK6
 TcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697837647; x=1698442447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ELGquMGKVVECrLQcJwvjtRydX+WAJn+p1gMGI/qJcQg=;
 b=tvoiHBhhfGi2ZkQHZlXI/6UmYi3nKxHa+a8MACFGP9RtLuy09lv0449RkxWv4pkhDE
 kM3y1xNWSV3ftEwSypgwiIagYx0XlTfbyWHGEmyxN+onEyft3Uujn7E88jljtEJ2+G00
 F+sbgzFPinKNTmFEgUMS4CC9z7H10M2elLZpJ4ZgS3I5gBdg+4pJjcVsRlR0dz/j3nCA
 zf9CZX0dCYZO9bLW8hrAuS3irsb9n1EyKJCCLwpweVe/04B9Nj5bi8qMoL080W+3dS9m
 LWdGcgV2m/ACpRtv7epz9HEzXNZAJ+Bkzz9C2sP/PYoJfagFDvErMB0Mnp6pQhFznZY2
 tIpQ==
X-Gm-Message-State: AOJu0YxP+xWsTl+ldPftE/WV3gzD4U7rbexhsk4MHNMvph2kPk803Ys1
 bqVpFETD07fQ7kUpQo6civ+5iQ==
X-Google-Smtp-Source: AGHT+IEwhb5fipKNZEl8QHnGMjUXUBIQR3gypwQr9QFEPwFN76Dw7QRybjTFasC2k7s2u4dtWpuWjg==
X-Received: by 2002:a17:907:720f:b0:9be:e6d4:575a with SMTP id
 dr15-20020a170907720f00b009bee6d4575amr2265405ejc.13.1697837647268; 
 Fri, 20 Oct 2023 14:34:07 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170906080600b009c70b392051sm2243563ejd.100.2023.10.20.14.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:34:06 -0700 (PDT)
Message-ID: <b4c3b4d6-61ad-4be8-8c62-a19b8efe07ae@linaro.org>
Date: Fri, 20 Oct 2023 23:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 46/65] hw/hppa: Use uint32_t instead of target_ureg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-47-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/23 22:43, Richard Henderson wrote:
> The size of target_ureg is going to change.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/hppa/machine.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


