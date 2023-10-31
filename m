Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC07DD12D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:07:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrG9-0003Df-8W; Tue, 31 Oct 2023 12:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrG6-0003DJ-Fn
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxrG4-0000DY-Mu
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698768384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7eXWuNNPoImNG/HqQ+oR0JqFPP2JFUM14sk/Ou++iI=;
 b=Lvq3YyVw3BAngGl/zKilATeljzbMPIs7UBRT4fzY0H89prskTGMExAS2wzfkVZD/xoGTBe
 /3N8rookoF53g8lc/dHujdf4Sz1kSILoJGzqaZk0CjffUEQqBpl3t01P5Id7gA6AOHIE5I
 2k46OgKQOXAO1SG/2dM8YMmPy8SGVEw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Lt2U5_0CONqlPuJriPzqjw-1; Tue, 31 Oct 2023 12:06:22 -0400
X-MC-Unique: Lt2U5_0CONqlPuJriPzqjw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4094e5664a3so7577205e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698768381; x=1699373181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7eXWuNNPoImNG/HqQ+oR0JqFPP2JFUM14sk/Ou++iI=;
 b=nIGlrTns+Q/IpcOx4mt3YasMiK97U2SV9SmfTKzOqed01HQ2/Pef7ksrxt/TmxiV2t
 U7J9CGk4kmZozumQab3f8UdhPl4pTgU+/496nKSiatj6VWYFIrF0bkha1uaAlHgXrygB
 ea/ceoPeoXufKdtE25o01RYh3JRrAvkfqOnq60J1YoOpmD4BherBthXNJOcjxraQxFHv
 goD4VNG0cgTFQkZi71SOsDSvTNpun7jhzYXK88X7O0Ihi+nxflfnloAgD8th/TWxfF5b
 qK5IvuiZSBcTfq3upkIxyxuVtrOwHzHHetRI6X/Ar84xoB9NcRY9aL8YLX9pIElTQmqa
 VuLg==
X-Gm-Message-State: AOJu0YwTBirgnAUo5zu+54Etb/8gB4qleYdpqAL3f0dJSeT4tpouoohu
 RgFHrk5M22xMrfGr6a7HmO0ueQc93QAT24WpJOh+yQysX5Z+Si6vkh5iFltB4wZlXL18y9YmiEe
 lRmKuyz6WhZREqco=
X-Received: by 2002:a05:600c:154a:b0:401:73b2:f043 with SMTP id
 f10-20020a05600c154a00b0040173b2f043mr11933716wmg.1.1698768380837; 
 Tue, 31 Oct 2023 09:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6kW+SeS3t6ftDXumpNPByBemBudrKDMJquc0Z78vGvALZJ34VUQego4XaI/PwNdTFJ5LZ0g==
X-Received: by 2002:a05:600c:154a:b0:401:73b2:f043 with SMTP id
 f10-20020a05600c154a00b0040173b2f043mr11933696wmg.1.1698768380500; 
 Tue, 31 Oct 2023 09:06:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c4f4700b0040651505684sm2155329wmq.29.2023.10.31.09.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 09:06:19 -0700 (PDT)
Message-ID: <9a0ff38b-69b6-4d12-b8e0-4fc3d11807b9@redhat.com>
Date: Tue, 31 Oct 2023 17:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] qcow2: zeroize the entire cluster when there're no
 non-zero subclusters
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-4-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> When zeroizing the last non-zero subclusters within single cluster, it
> makes sense to go zeroize the entire cluster and go down zero_in_l2_slice()
> path right away.  That way we'd also update the corresponding refcount
> table.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


