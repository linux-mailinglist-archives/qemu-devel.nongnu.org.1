Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C863D788BBA
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 16:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXod-0001wU-O1; Fri, 25 Aug 2023 10:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXoc-0001wB-3H
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXoa-0005mr-3d
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692973771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2HiEcmGNuuKCaHRsJ2MLT5j5ETwIklRdaNE2EPNnK8=;
 b=ORaXxqfYIlH2KgykjXcfdROMqpv4uvkt4RrVJ2ZqqyXmuaMSfP3PdieZlSdlSkX+gdNkOV
 eVuGae5Cvz7IxJv1ocnlvdaR3cbqGraQjJSjEAhgGKsBsE5lTupFWLPRk1LufHKmimbU2A
 X5Qeav2X6o3feit3GPVjDIr+F6QN9S0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-NTevnBBIO6ywdfREFcwNiw-1; Fri, 25 Aug 2023 10:29:28 -0400
X-MC-Unique: NTevnBBIO6ywdfREFcwNiw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so81202866b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 07:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692973765; x=1693578565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2HiEcmGNuuKCaHRsJ2MLT5j5ETwIklRdaNE2EPNnK8=;
 b=j5cfPhPpkaTQ+8sorLBErAshXfFU3iVw2WNVROr0SowoDAjM6T4GljevuMNLgXyD2J
 Yqrh8S7jNLdKH1bO3drOKkpbUxH6IncsaalxiGQ2wQXmvFQF1ySA9MTr/gdQpZGCshhF
 JC1pdjPMhgQcjWqEfh3T6kkGf5+Gil/xHkW6B1Pmfp6XHPKnDIRM+Pk1rKE7hH/KJgs5
 7UhyKV294dTPofUWrxaNbU6xGGWUFjkGz508qTyzIJjsYHSsj9hH03jGJCqW13JImWh/
 4Kn8uG64uootEXFoXUTppW0tnFkN7DamiXs6ApTPZx2+KI/D24PCZvISRd4poIL1v4db
 BABQ==
X-Gm-Message-State: AOJu0Yzpfjcrq3JwHeKktDkNf972OSnsA5ZQ/AmmvZCum34Vp0DBtW9b
 kMfnwEZo68gpCLQeSX02qTBxtmrCk4gDTIMxE3z0q9KMQfFkUhDSkoUG6IHHMSA4zzR8CknuMQT
 StVxzQzTG93r0vdE=
X-Received: by 2002:a17:906:2181:b0:99d:f93e:7206 with SMTP id
 1-20020a170906218100b0099df93e7206mr12750574eju.26.1692973765806; 
 Fri, 25 Aug 2023 07:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOmrlfqFMna0F/f1kwpdgwM0yy1ImyDpFBmZZ6VK4jiqpQtXUUVUiG0tvOK0k5Ju9miRMl5w==
X-Received: by 2002:a17:906:2181:b0:99d:f93e:7206 with SMTP id
 1-20020a170906218100b0099df93e7206mr12750564eju.26.1692973765664; 
 Fri, 25 Aug 2023 07:29:25 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a17090625cb00b009934855d8f1sm1017591ejb.34.2023.08.25.07.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 07:29:25 -0700 (PDT)
Message-ID: <13431ff6-60e2-baf3-3a06-ef4043689cb2@redhat.com>
Date: Fri, 25 Aug 2023 16:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] qemu-img: rebase: stop when reaching EOF of old
 backing file
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
> In case when we're rebasing within one backing chain, and when target image
> is larger than old backing file, bdrv_is_allocated_above() ends up setting
> *pnum = 0.  As a result, target offset isn't getting incremented, and we
> get stuck in an infinite for loop.  Let's detect this case and proceed
> further down the loop body, as the offsets beyond the old backing size need
> to be explicitly zeroed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   qemu-img.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


