Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992C7150F4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 23:30:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3kQf-0007rY-5O; Mon, 29 May 2023 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3kQd-0007qz-1M
 for qemu-devel@nongnu.org; Mon, 29 May 2023 17:29:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3kQb-0004eY-E8
 for qemu-devel@nongnu.org; Mon, 29 May 2023 17:29:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b021cddb74so17653435ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685395760; x=1687987760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+TtWJV0UoBAGq3dunTNkocnj6spss+BD5M/crRUQXE=;
 b=oJzh4OvnOsNvVDrw7GQ0PeXnNVR8hG04vyC0vmk0ruKEvCrRnc2hDsPQAM6X5Ud9T2
 LoSpLQwgh634AOEPetkGbekphhnqYu//XGpQzq5PE7bDRy0jOmcSrmnuVeTOLrl3pM+3
 EeLdmaTO8bDWd9Lt8AB95OZFRepO+xUzsmybHFj/HK7BmMLDYaJEDwa8Z5L/0Zw4V4rH
 FyfAL+B2NMln1UclFeFKYa5ombsXVqp/xP1ZlPVHJ5SuYHvc/3gS2ZuT1EyR3iDoPds+
 kWkpWTU2prGaWZQaLra5jfLwW4fvlJrIk9lHYtc0EmeCWre7wGWYffXDe/OaSILODjR9
 EYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685395760; x=1687987760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+TtWJV0UoBAGq3dunTNkocnj6spss+BD5M/crRUQXE=;
 b=H92JIfFCeIwZnc9o7SAfUOBlnX8hRSfPnvVUnVCmQVoWRqm/+NIbat+0RLDn5rFBbB
 Q5DhzPkeAbcs+L+MlNTIpCCQYf0pjYN6csf1/kRoLNUmzkBb1K9Ysjacz5VaBxhMejr4
 smaKPxzH519MdLPYTmmeSWJQ1u5Ejvv2pLlZldJsOE0WPuVKh5iShlyOqnncPDBtSmiT
 edCEWgjudq8UWqsoCkBJZMNyetIiwtDpfFnAywwNsFOQStuniI3nIyw6VFdOiJzXsoyi
 oWTFxePx5UUy5zuidaNRSp7t8ANKfs4zoA1xHWWnI/sKxUIe+vCAZYXcCo5JS5/UF/TW
 HimQ==
X-Gm-Message-State: AC+VfDwaxaNvycx1v+p6nEc0I+pR7cRTLQLU+/sCH5QIT1BOuWbLXSk8
 YEFT8toz9vy3zg2qn+DScTYbGg==
X-Google-Smtp-Source: ACHHUZ4YndMU2ILAa96IifGnO3CKMrC5iRd25OPgoIQJpAKMYrBdt1wHAqUUGYeEhEDBtkoG0B1NJQ==
X-Received: by 2002:a17:902:bd81:b0:1ad:dac1:1955 with SMTP id
 q1-20020a170902bd8100b001addac11955mr361406pls.53.1685395759778; 
 Mon, 29 May 2023 14:29:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9923:e5b8:e7d9:7a28?
 ([2602:ae:1598:4c01:9923:e5b8:e7d9:7a28])
 by smtp.gmail.com with ESMTPSA id
 ij13-20020a170902ab4d00b001a1a07d04e6sm8850726plb.77.2023.05.29.14.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 14:29:19 -0700 (PDT)
Message-ID: <bad05f69-e988-516c-7ca4-35a4ad0f417f@linaro.org>
Date: Mon, 29 May 2023 14:29:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/19] Ui patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/28/23 06:19, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit ac84b57b4d74606f7f83667a0606deef32b2049d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2023-05-26 14:40:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git  tags/ui-pull-request
> 
> for you to fetch changes up to 5a4cb61ae1ab0068ab53535ed0ccaf41a5e97d2f:
> 
>    ui/gtk: enable backend to send multi-touch events (2023-05-28 16:25:38 +0400)
> 
> ----------------------------------------------------------------
> UI queue
> 
> - virtio: add virtio-multitouch device
> - sdl: various keyboard grab fixes
> - gtk: enable multi-touch events
> - misc fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


