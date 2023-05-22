Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F470BA11
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q12kF-00012i-Rt; Mon, 22 May 2023 06:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q12jF-0000w3-FX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q12jB-0004Y5-Q6
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684751120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlEhYHlRTdxWbVJsqp903MKDmsA1fH7VX9qpEJ2ho14=;
 b=bbOIULMmTRgmFFS/TeV+nX4xTQAXMzY1cAa8Xap62o4GT7M8UVk7sPYX3nYpD/YFyDr44p
 qqnRNJS+fvUjxngRoP7I2QvqGgEcZoiV9L5TqkWsn7tbIC6ml3Ge6uP8xNEtN9nU/pHiGx
 nm1lNzU+/L6Jpzh+NpzMX2/B/fhgcCA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-CVmjXjXYP56iC-gzqyqm7Q-1; Mon, 22 May 2023 06:25:19 -0400
X-MC-Unique: CVmjXjXYP56iC-gzqyqm7Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f420ec766dso37253015e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684751118; x=1687343118;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlEhYHlRTdxWbVJsqp903MKDmsA1fH7VX9qpEJ2ho14=;
 b=GTpsCXrVXbtUGEsVsoA6sSC57PulRmIvvbFs+Btqz4kPjGpR0I1WYHyHhA0UeEY2Nh
 ll45eH+JfhlC0Q8LxgzRuOdF2gdtehJe5RullK3Pz7Fz5qIEZ98WGiLmPKuMscBTW1Tq
 g7Hf3DeYSgoALwZ1wrWWeafPRzNyvWuL6Mod3enIMjVjLSefs/hjMOVZKvC8iGUTKnY0
 GieDi5Od12KgIKaT90EDe0Nlruk3WQp9ZCh9Xaxk3HPJ9He+n9MdrUDOQcGpSmrLj1gy
 nDJNFgbXehi/YuhxNyGg/UtJ/WZG78SEheX3cdkmeaivUp+gmD7NfdIdV1t+VSixhaG3
 V7Sg==
X-Gm-Message-State: AC+VfDzzRNce5RR/GMf0rIBeEGQ65mBFlhrzdLcMN3cXC8+LAdqv12nr
 Wjn42FOZe9lfcgaYFQHxy9GKWKHMpv3oUxdMRcF9hgzkyi9CAYnNCU0aISBO4s0rZD41ueLO+Q2
 i47x3tQ1Rri7I9IM=
X-Received: by 2002:a7b:cb91:0:b0:3f6:1a9:b9db with SMTP id
 m17-20020a7bcb91000000b003f601a9b9dbmr3230293wmi.21.1684751117921; 
 Mon, 22 May 2023 03:25:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47SC/dPv2A2xqnYfEUHfqklTT7flr1e34AL57yIf747VRXkK/48bNJ2A9GU/RZSxyD+pBtdg==
X-Received: by 2002:a7b:cb91:0:b0:3f6:1a9:b9db with SMTP id
 m17-20020a7bcb91000000b003f601a9b9dbmr3230280wmi.21.1684751117637; 
 Mon, 22 May 2023 03:25:17 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-148.web.vodafone.de.
 [109.43.178.148]) by smtp.gmail.com with ESMTPSA id
 k1-20020a7bc301000000b003f50e88ffc1sm11289152wmj.0.2023.05.22.03.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 03:25:17 -0700 (PDT)
Message-ID: <36525a40-b4a5-517d-2926-8b646ec46d7e@redhat.com>
Date: Mon, 22 May 2023 12:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v12 15/15] docs/tb-stats: add how to
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-16-fei2.wu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230518135757.1442654-16-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/05/2023 15.57, Fei Wu wrote:
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>   docs/tb-stats.txt | 116 ++++++++++++++++++++++++++++++++++++++++++++++

I'd suggest to add this file in the docs/devel folder instead, and maybe use 
a "tcg-" prefix for the file name?

Anyway, please add it as a proper .rst file instead of using plain ASCII 
.txt for new documentation.

  Thanks,
   Thomas


