Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE954726914
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6y7A-0005Mj-3F; Wed, 07 Jun 2023 14:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6y77-0005MK-Aa
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:42:33 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6y75-0000ER-Gz
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:42:33 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b01d912a76so35851965ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686163350; x=1688755350;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFgOWDijZ/zapm7gsnGrRtG4Zr3qtCOuGN9B0sbL9IU=;
 b=RNjvqc2jrFVHxe5zky51FbHjAK+LjFgVF6lXwwgBgrL8W0MVAqof+TaN6mRp7yZMCB
 O3Nh7DlQPI9hs6VB8wXWjflMVX9LF1SgdRjwAqi3bB8wjFJU2stvRK3ZAV1iGnMSJPHE
 PKWCDVBQ+Iyn4x2HUbCtE6MiUj7S8LaTgAhGLm9CDoKq7kTbHxcEp7u43KIACdOelUEd
 a+BZmZcyAeOWFZM/c9KHXE0lk1PT2DEXGTzI0tqQW/sLplgkG8wxUnZ5AU6I4g93VIf/
 p9IFbQtoEX1LYVgqUXyp8N5HPmRH5jWT1+e+r5B9osLQQt1AfQetkle507+ZpLjSvxMF
 euJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686163350; x=1688755350;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFgOWDijZ/zapm7gsnGrRtG4Zr3qtCOuGN9B0sbL9IU=;
 b=PAYHtsDuixwGe+5ldFhWer8rzi1NkmwBp/9vh7qiW6+lJ2MjjFRas9ThQUWw/3MMY6
 eF3+RZqS6PYj1g3DorhXlLYZE83RDEgB76JjOYEuMevVH+/UVxVojksOqpERocbNHTVK
 khrH+B1u/YWHDx+wLhhCbfJdDWbNb352/1NeQG0Gkr5LHywWO189oK4KTzrU+UVrUx4x
 A/YhgPqCjzM5PaShJ4NnibAVJsh78WeSlxxy7A5DD3ulSM1fUmUz6G0hOdE1zbKhmKdd
 ssTUrR9Xrk4gozsAqQH8qCQq5ijp/9Oyk2qDQZFp66soXMOfDjP4+tX5XGenP7W/Jupw
 a6xQ==
X-Gm-Message-State: AC+VfDwB5RwCBCXlBz9dBfALeX/mcdmlyxRQfrNdhaV8zJ1X7uj9pT6K
 x/L4wms3RumeGtUoW/RyAQfs0Q==
X-Google-Smtp-Source: ACHHUZ6G3h5VMgYGyd03aAtqV619a2JoAL/qNuChB+vvjPaJZChfXUhJzgQ06RuUuCcRUamRWK2bBA==
X-Received: by 2002:a17:902:c102:b0:1af:d9d2:a234 with SMTP id
 2-20020a170902c10200b001afd9d2a234mr2245723pli.3.1686163349774; 
 Wed, 07 Jun 2023 11:42:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001ae5fe602c3sm10767170plp.159.2023.06.07.11.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 11:42:29 -0700 (PDT)
Message-ID: <459b5161-6f47-a43d-27a1-83acd54f3580@linaro.org>
Date: Wed, 7 Jun 2023 11:42:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/2] vfio-user queue
Content-Language: en-US
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <20230607143827.1435488-1-jag.raman@oracle.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607143827.1435488-1-jag.raman@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/7/23 07:38, Jagannathan Raman wrote:
> The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:
> 
>    Merge tag 'pull-target-arm-20230606' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-06-06 12:11:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jraman/qemu.git  tags/pull-vfio-user-20230607
> 
> for you to fetch changes up to 7771e8b86335968ee46538d1afd44246e7a062bc:
> 
>    docs: fix multi-process QEMU documentation (2023-06-07 10:21:53 -0400)
> 
> ----------------------------------------------------------------
> vfio-user: Fix the documentation for vfio-user and multi-process QEMU
> 
> Signed-off-by: Jagannathan Raman<jag.raman@oracle.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


