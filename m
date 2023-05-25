Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F2710217
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 02:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1z8N-0005ze-Ag; Wed, 24 May 2023 20:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1z8D-0005yV-8n
 for qemu-devel@nongnu.org; Wed, 24 May 2023 20:47:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1z88-0006tb-KR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 20:47:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d30ab1f89so1198914b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684975619; x=1687567619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKnYJ6Jv9C0P1AsUj3iH2Nebn6buY/nG3Yti0ErQMNE=;
 b=EbsrPWFRloKUxTlkpxJ5Ho6ZFAg9aZiMyJ2URGxTNLZaoci00S9ONVuD/8X35hY78D
 Gri5L5IPK9NahXf5Zf69X2lGqvpudBQQpeKv+C2YycpN+KYBY3K5cQPBr14KgTwR9Nyw
 Ihq2RaNzZRu6twl+JT26Xy8s3C2yhpyt8+8g8eFhAd+hDa9XH+quN5Nj20sRu3pyNX0x
 YCVCfK2w2BN/QWA8Sh/1jdKcQMJ4V9ff7Gw9hYAhy69fhRE/7g8L5wvnFKDPjr+vYx53
 fPHsdlfi9I62m9CIWcWY1kho534GAHgHWuegsly8QxVYeKNUvKNH4YtthgKUDuuaDQJi
 qT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684975619; x=1687567619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKnYJ6Jv9C0P1AsUj3iH2Nebn6buY/nG3Yti0ErQMNE=;
 b=ikfXX6MTsOnQGeoJZQmhZ8ezbOJxSPAgXT5axXeX8AUaOhciJYmyvIFJYbLqTLmQPu
 re+tHLFyYtzEE8mVtEJJ51d3hHtAbsGoEHCWrdBzXOXKTkpDbsXOoVDBopHvrmXbTthx
 RuLqr7IesASQCl2LZpaPlGmrvs7ggqDKVbqSNaNPZFudN/8Ha5fyK7A+2uHKcvJ4iXAj
 Kcm8aiCg8KTwFpkyly7M4eloTKegzM01HmTdvZIrTLTmKyJLfXfBQj9jbiAw9yvqPlCS
 UzRHrSBHC5+NvaO+6hg4ke62oWWgV4MzLizM0hLmY2BcoBf3K/VWlHhY25WpIFG+00uV
 R+vw==
X-Gm-Message-State: AC+VfDyLizYDMHw8KsyX9YR6bsUL0tHYWCUF9PmBbCQwn64ucK4eHnS0
 PbRFzwc20E8gSqV6q0pQXsWk1g==
X-Google-Smtp-Source: ACHHUZ4DB7+V0n2Gcuatm3DZdrUFEh/nxgFt052VDKrs7x9vVcXXelfkFX8zAIYR8euJlQBdZ3CXpQ==
X-Received: by 2002:a05:6a20:8e05:b0:102:a593:a161 with SMTP id
 y5-20020a056a208e0500b00102a593a161mr23037755pzj.57.1684975618731; 
 Wed, 24 May 2023 17:46:58 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 q89-20020a17090a756200b002508f0ac3edsm2012212pjk.53.2023.05.24.17.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 17:46:58 -0700 (PDT)
Message-ID: <9aa98335-6f84-aee1-b943-8f79a1ac1ed1@linaro.org>
Date: Wed, 24 May 2023 17:46:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/2] vfio queue
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20230524084724.2511267-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524084724.2511267-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 01:47, Cédric Le Goater wrote:
> The following changes since commit aa33508196f4e2da04625bee36e1f7be5b9267e7:
> 
>    Merge tag 'mem-2023-05-23' ofhttps://github.com/davidhildenbrand/qemu  into staging (2023-05-23 10:57:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20230524
> 
> for you to fetch changes up to dbdea0dbfe2cef9ef6c752e9077e4fc98724194c:
> 
>    util/vfio-helpers: Use g_file_read_link() (2023-05-24 09:21:22 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix for a memory corruption due to an extra free
> * Fix for a compile breakage

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


