Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C473673C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXPG-0004cH-Hh; Tue, 20 Jun 2023 05:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXP8-0004NN-UD
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:12:03 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXP7-0000cN-DN
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:12:02 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so10553653a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252320; x=1689844320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3gif1IxSp3f99xEMoIr1useawRrU6RHI0oi8P12TIKQ=;
 b=hSnLzUnk2KDP+QTlcN6RXfGB2y/6jDh0e7bDljW9P+wqufWX357nSoPBNuEsW09VGL
 owMYpuVFaA1aatur6ub6xNJ3z9pTpupnfSeqKh5qwFt034zI3wX0VXUqx1WGmDU0VRnZ
 9UdGCYDhgMv42vSN6qMWtCGGc4nzkeVXLjIesBnQ2QJV5kG5lKZ/LuSOdtW2kl3Awq3Z
 jBgOJzO82UDcTaY6JnyUg0c+saw6u00SD7ScJ0GkUEtaVRozNjz83TwqmLu/RlM2c+z3
 plA0q7uFwfnh+lIA/prWWsqfNBykD+nt31UE3PN+XVAB79T4uQdKLsU+NsUE2zPY7xDS
 V4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252320; x=1689844320;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3gif1IxSp3f99xEMoIr1useawRrU6RHI0oi8P12TIKQ=;
 b=TTfs7AMbuwUHZkdemP/jpVnmB7XRWlWGn3GswyQxnZ0+Mh0OXXNV2MsJ8XSVi/wkKX
 /LbkTCqA+c0eKKIWMwZUma7SvWLsHyu7h8++oETX5r168urGEFx+UUKritwe1IWGOeDc
 wCezCDuIsG/0T2dp23TzVpWXnS3gbSBllV0jOFLJtEWCgpfRZQrrn93V33jtc3sJCgaJ
 3pFIDqHSHcXeH3kQN1crWEKgIkQ1hnrX3WoS8oo9ylswtAr2D4KCotxrCa+VRpjHFGge
 5z18CXYSj7hFt2ztxHAYY1zpQ7XYGz1g3TpH3NwT1H4waqw7V5PMq+wBc+0YBJEabX8S
 o2kA==
X-Gm-Message-State: AC+VfDwG8sjXN8Nk5j9j67jA8Zlf3GZ47FKuIP3fL5D2HEni9WxnAUnc
 hc0zj9WBvSq2Xzg27wVFDaeHQSx79TUi0f51kF2YslYw
X-Google-Smtp-Source: ACHHUZ4SEcG4vadKXUb9/rYO28zWrImuIMxAYVyudshDOIBqyS5KFwcSd/py8sgRrz/e6ffMqlEw0Q==
X-Received: by 2002:a50:ee14:0:b0:51a:4d20:3b1c with SMTP id
 g20-20020a50ee14000000b0051a4d203b1cmr7044797eds.18.1687252320176; 
 Tue, 20 Jun 2023 02:12:00 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 j20-20020aa7c414000000b0051a3334f873sm821633edq.89.2023.06.20.02.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:11:59 -0700 (PDT)
Message-ID: <3b9309c8-9407-ebd0-f135-55b27b8b1fec@linaro.org>
Date: Tue, 20 Jun 2023 11:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/9] ppc/bamboo: Report an error when run with KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-8-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-8-clg@kaod.org>
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> The 'bamboo' machine was used as a KVM platform in the early days (~2008).
> It clearly doesn't support it anymore.
> 
> Signed-off-by: Cédric Le Goater<clg@kaod.org>
> ---
>   hw/ppc/ppc440_bamboo.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

