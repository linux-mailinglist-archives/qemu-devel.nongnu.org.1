Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF070E413
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WFo-0008TL-Nw; Tue, 23 May 2023 13:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WFk-0008Ph-KN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:56:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WFi-00055R-TJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:56:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d41d8bc63so58189b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684864613; x=1687456613;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWfE1s3dEoxdzezHEdnEqzQTpmAVMFGFs/5zKLNGahI=;
 b=ESekVPCzxPxi+jwgF049ce6CJWuqbExRcAKgOk6smsxpXjRa/dcc84cbnKl4L35L6G
 96dWbKgG/KSp8x1GDnjK0kOo1CgY8VK/gV7WlE2ziOxvJWYXhTuRxBnTxIfF/RaAUUvp
 yr2q5syjwSuwMWvVRbkY0gZa322CAHnDnbWZb+MvY/AAnr23qSLga8S1uLefM2urSUhc
 Aap42rYCRLx0JFauy3hMeytp6roTCxAPZCIUdX0fe7dZULEifv3r/OpvE31GI3A1AEai
 O0FxDoNVimieyTFuDXkHiaof6o6PSkcgCHGyq0jkR/S4WyN7OJy/zg/veFe6+pnnKBeV
 tl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864613; x=1687456613;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWfE1s3dEoxdzezHEdnEqzQTpmAVMFGFs/5zKLNGahI=;
 b=SroV+OcmhqvtiPvZzU4xwOz4AYCbI0Wxxz1s/FHfBL8whLd2W7lU0itDMIDX0ty536
 QNswC0C8uskUP5vw/tdYRmzHRE91afmsQ6RG0LaHLZAWCt+oJWYygOmc9VUOb6LBbxFS
 B0KCSLtbTEZszL+3SovF+iGcs/Orkf6G26He1/DxcenECovcTLhwY4Sd4oGL2auU0lCj
 7aRSst7VPFN5XoQbWFUDXOdBWNSfpmpydDPZuKoAZFfCJur3QwNJXHAxaal2O+qql1I+
 QqRxO5NwwWAhfo7NY6PKsBiHu9xvkCQK/kNUfzF75NSlJJ/SvB7jSURyW0avMsLE4Fzh
 sG/Q==
X-Gm-Message-State: AC+VfDxBXexPz+nyLEwN829bDtBZWV1zy7KUrEN2qhvB8e1LJK6+Aw+j
 pRJJVRc3DMV7iosY7wTwlULoXQ==
X-Google-Smtp-Source: ACHHUZ71gCObVfMaMWzXZRqtLva5390Lk3Q/2DHwsCozCZUDHD2IVomM6qXN5bADPKbAhnJH0r0aYw==
X-Received: by 2002:a17:903:2796:b0:1ac:65ab:cf7b with SMTP id
 jw22-20020a170903279600b001ac65abcf7bmr15254250plb.9.1684864613423; 
 Tue, 23 May 2023 10:56:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a170902694c00b001aaeaa27dd5sm4775222plt.252.2023.05.23.10.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:56:52 -0700 (PDT)
Message-ID: <75baeada-17f2-cd0d-51dd-7c08961b6609@linaro.org>
Date: Tue, 23 May 2023 10:56:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/50] Net patches
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20230523073238.54236-1-jasowang@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/23/23 00:31, Jason Wang wrote:
> The following changes since commit 886c0453cbf10eebd42a9ccf89c3e46eb389c357:
> 
>    Merge tag 'pull-qapi-2023-05-17-v2' ofhttps://repo.or.cz/qemu/armbru  into staging (2023-05-22 15:54:21 -0700)
> 
> are available in the git repository at:
> 
>    https://github.com/jasowang/qemu.git  tags/net-pull-request
> 
> for you to fetch changes up to 792676c165159c11412346870fd58fd243ab2166:
> 
>    rtl8139: fix large_send_mss divide-by-zero (2023-05-23 15:20:15 +0800)
> 
> ----------------------------------------------------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


