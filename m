Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BDB741940
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 22:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbQa-0008GW-DV; Wed, 28 Jun 2023 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEbQW-0008GM-Ty
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:06:08 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEbQV-0002Vr-BN
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:06:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb94b1423eso56165e87.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687982765; x=1690574765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ao+nlAAaQO+qwt21svd5tGnfeGzylI5cAWlXh9/PmIE=;
 b=CdygSXxExO41pKtlCgsMpVhnMeouCwvr4VNMcXZKPm9Ro6h5C+s4vXCvfAEsW2YKH1
 YbZRC+cvDa0ZM9G3NUP+Dwz+PscWDdbGFPOqPfqA7WW+U1Zwt0tDYR78rSjP528N0UdZ
 UE+xKkMyA7MSHWs3tygP6cV4imdMfv/COFWLYco8zDaWBwAhuXYGim4aKrkRQuOjf0kI
 NSix4ojhDQFiPnrd99c0A25U93L6oN0BmXn4xF0I1daAw93i8IS/PSPeq4HdG8n4XFxa
 /NqQisYsSQbH5HhP0EP0lXNXZnP4VTG4l2+8oiIGO8pCF4CNI7DtEQ8qF47woOcZbIop
 vu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687982765; x=1690574765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ao+nlAAaQO+qwt21svd5tGnfeGzylI5cAWlXh9/PmIE=;
 b=Eeixzb6ol+uO4d0JRC6cjXpavWgcpAfmRB4oXaJ0miJxQVNumBG+C3D4kAaPWEWilu
 /oKHp2szV97n04zZRh0Y+08QYsZK/Q2gZIEoDnI3UOqgFjpGnjr5IaVy3Ew3B3409dLV
 pfOH7iQRfcvVblxmSP2N8D8fgSo4oDyjtfLOGFfSFHk6JR6zZRboiB9BgsZYIvzORcW3
 z94fRjGCw/ws58Y9SQ2wRRPXBjEbYIvdPPeaC798vg7SzVpRMzPgnZBd0BNPHwB/dkuG
 gAhd6Sg1adraqHZ4Ah7Ot4lol/UKySSLwyuV7yNw30YQX3yrUGhxQW+gxuDEJ+P7d7DK
 cI/g==
X-Gm-Message-State: AC+VfDyqtfZUkIs/fr2sLHb34Fw6wzuXofkbnispbFVBwWhgBpDubkDk
 pCBdW4fzP/gmCPeuovPu9hHoug==
X-Google-Smtp-Source: ACHHUZ45EyHqKECedlfCqKOhiDvTeijlF9gq1uBYuhY2ysdW9QmwQrv4+g8H7x+BdTqefeR33IL18g==
X-Received: by 2002:a19:8c01:0:b0:4f8:6d99:f4f3 with SMTP id
 o1-20020a198c01000000b004f86d99f4f3mr17721207lfd.52.1687982765020; 
 Wed, 28 Jun 2023 13:06:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a056402121300b0051dd19d6d6esm732484edw.73.2023.06.28.13.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 13:06:04 -0700 (PDT)
Message-ID: <7f034120-14d0-fc2d-5903-7926382587da@linaro.org>
Date: Wed, 28 Jun 2023 22:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_MAINTAINERS=3a_Promote_C=c3=a9dric_to_V?=
 =?UTF-8?Q?FIO_co-maintainer?=
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
References: <20230628172932.287318-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628172932.287318-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 19:29, Alex Williamson wrote:
> Cédric has stepped up involvement in vfio, reviewing and managing
> patches, as well as pull requests.  This work deserves gratitude and
> punishment with a promotion to co-maintainer ;)
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Cédric, I'd also support if you wanted to add a tree entry here.
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



