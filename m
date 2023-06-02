Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E0071FE38
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51O3-0005zh-FA; Fri, 02 Jun 2023 05:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q51O2-0005zY-1e
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q51O0-0003OU-9F
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685699274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5OxEqpOH95YsyA3Hzu2eARQJ3e8qjdUHAyedj8VipM=;
 b=eytpxbUh3tgetJ1+OfsG3Q2Xp11KrZxjYAmk7poXqU/kw2OR1UXJwscM7aGA0mlhA+jOIm
 w1TAvLNjyZMGOpBBs1kM/b0OTe0M0O++5ZJX/NH1ubyhMTZhAhIT6KGTEz4qqOc/c5rWFI
 N5b5C7LE+/Dt9W/agZbX8XlJLfYSRA4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-G_lIIsRhMVOyc3jOsuezbQ-1; Fri, 02 Jun 2023 05:47:53 -0400
X-MC-Unique: G_lIIsRhMVOyc3jOsuezbQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edc7406cb5so1376493e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685699272; x=1688291272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5OxEqpOH95YsyA3Hzu2eARQJ3e8qjdUHAyedj8VipM=;
 b=VjBW0Dbb0Q1Y4eUZyo/jG3LY6LHq3fKZJKZC25T6IaydfyBmQUbQM1Jb9VZI6kF79D
 KtpFksu5O9im3EZpVpl9MO+BOwucPlwcT7tQhPeVnYLcsGiUBCd369s0Fj+FGbJNuz0V
 y38kIf+LewT1H4llO99nrtkFiZFejY8c7S3AdhwL+gzUI1PgGHguyEnylnfyPqQ5rqb2
 VRxixEze1S1u16pfHbkMh1DUGDVgQnsUo+0IwB/CLL0Vu64TaE1ENbd+CuQA4v5PSFW3
 58edP24d1BbcKBDBMsCrVZNco8hzrfWA2ED6B577MUuefOxDTh0tCwqqRUsYyOUba3j4
 5Jdw==
X-Gm-Message-State: AC+VfDx3wZ8MKMXp4rpx+GQOwOs06VI9bwW+ATUDTTFM7bDhvyMURttD
 vmpF4DvU6sHUHOn468KbiPrSJgwNCTEkDzdt48hpGXtU4srvViVQ2dKdxahrTlGVlUqJl8NJs7f
 Z8+1NRK6VKc0+Bi0=
X-Received: by 2002:ac2:4831:0:b0:4f4:e3fa:73d8 with SMTP id
 17-20020ac24831000000b004f4e3fa73d8mr1562264lft.62.1685699272031; 
 Fri, 02 Jun 2023 02:47:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QUbB80HMWgMJur/VLiOItR6Sb/wfoA21W21Y2qQOe4MVNtbrp+UHdzevqVGzXb9682+Ya8w==
X-Received: by 2002:ac2:4831:0:b0:4f4:e3fa:73d8 with SMTP id
 17-20020ac24831000000b004f4e3fa73d8mr1562256lft.62.1685699271726; 
 Fri, 02 Jun 2023 02:47:51 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-14.web.vodafone.de.
 [109.43.176.14]) by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c205100b003f604ca479esm4974369wmg.3.2023.06.02.02.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:47:51 -0700 (PDT)
Message-ID: <ea218aad-6ba8-0f82-2570-a16354abff58@redhat.com>
Date: Fri, 2 Jun 2023 11:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Big TCG slowdown when using zstd with aarch64
Content-Language: en-US
To: quintela@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <rth@twiddle.net>, Peter Xu <peterx@redhat.com>
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
 <ae4540a2-f4d1-aece-d1e5-d631d9814233@redhat.com>
 <87leh2p5qb.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87leh2p5qb.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02/06/2023 11.34, Juan Quintela wrote:
...
> The compression on precopy is a complete different beast:
> - It is *VERY* buggy (no races fixed there)
> - It is *VERY* inneficient
>    copy page to thread
>    thread compress page in a different buffer
>    go back to main thread
>    copy page to migration stream
> 
>    And we have to reset the compression dictionaries over each page, so
>    we don't get the benefits of compression.
> 
> So I can't wait the day that we can remove it.

So could you maybe write a patch to add it to the docs/about/deprecated.rst 
file?

  Thomas


