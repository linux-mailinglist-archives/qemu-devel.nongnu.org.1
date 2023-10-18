Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE57CDC62
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt65M-0002F5-EP; Wed, 18 Oct 2023 08:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qt65F-0002CV-Hj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qt65E-0005dT-0h
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 08:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697633730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TThCL+S7NN9Akv2/hqLLkBhOsX2j9sROemPBaXm/xzw=;
 b=dXMQlpQoNxuARr8VYfl8PEzP59iAusucNIp98kOHnR5xNF8M2nQ+ZfMpKyv4wMFGCvsxuU
 lBND1FQaUATwsBqMoyLh01mv/0l0sxfGKzN1VbkaFG7ouoog27uNF/JZum5q62S8AEpCth
 dKShYVGjopnVfMFpZGAP6XN58RZ9EZs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-WsX9J1kFNWKRlJzlUBW2fA-1; Wed, 18 Oct 2023 08:55:29 -0400
X-MC-Unique: WsX9J1kFNWKRlJzlUBW2fA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d20c7dad2so68393516d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 05:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697633728; x=1698238528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TThCL+S7NN9Akv2/hqLLkBhOsX2j9sROemPBaXm/xzw=;
 b=S/QC16TEIwDYpFhu+UV9HYUeqspWGfllKOch87IyXQCDooBo9hAcutM5H+EyNkhz57
 uCDNiDsVwOUEMU1korRFQqlCVuLplZNTDhwMBiTDDNGX2eqLoK/pGak0sb9qoDKENmnf
 hwZbgeGWpWXSVntMuJ+90atDW9DL9RE4uisOllNE3IVfCUJgIjGFHCADJ4igkJZXyR+A
 YDG8iE7YgFt6ailteuWJc9p/scMt60ttEIwXg5/b4WVsfDiP2r17dwIQrQYskjl0wxLO
 pzmKV6r493lBREym36oks5atWu1YmmOcPvVfHUIWbobWcUit7ORtJQQRHybNQY6OKl4D
 DJRA==
X-Gm-Message-State: AOJu0Yya4jGBNuypp181Tr8uRMJVKk13+aZ2St1S/K3NscZKUfxz5ehE
 pPZ8CW9488zi2+mWEgTZOmRZdlMoX47Dmux9xtqFfbRHrOBzXJH/2qE9gZlSicMko04FWqQvIzU
 cwzpVDXHreWqhqWEBIBYXAK8MxqNFLz7esP2zzif1tb25vQ6UfDk+yohY28K/rjNM5OSr
X-Received: by 2002:a05:6214:528d:b0:66d:173a:aca7 with SMTP id
 kj13-20020a056214528d00b0066d173aaca7mr5067054qvb.55.1697633728678; 
 Wed, 18 Oct 2023 05:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYnunz3RfqW5DvlDTeEv87WLVoT/BJRj1d/wvRCsw5xUO59uUGHPLO+OZZgWHKuc+f5/Sxtw==
X-Received: by 2002:a05:6214:528d:b0:66d:173a:aca7 with SMTP id
 kj13-20020a056214528d00b0066d173aaca7mr5067029qvb.55.1697633728194; 
 Wed, 18 Oct 2023 05:55:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a05620a11ba00b00767e98535b7sm1457366qkk.67.2023.10.18.05.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 05:55:27 -0700 (PDT)
Message-ID: <ece76c5e-09e0-484d-9150-23aa611be342@redhat.com>
Date: Wed, 18 Oct 2023 14:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] igb: Add FLR support
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>
References: <20230829090529.184438-1-clg@kaod.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230829090529.184438-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jason,

On 8/29/23 11:05, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> Hello,
> 
> Here is a little series adding FLR to the new IGB models.

Gentle ping to remind you to grab this small series for the
next network PR. It has been reviewed. Or I can if you are
done for 8.2.

Thanks,

C.

> Thanks,
> 
> C.
> 
> Cédric Le Goater (2):
>    igb: Add a VF reset handler
>    igb: Add Function Level Reset to PF and VF
> 
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.h   |  3 +++
>   hw/net/igb.c        |  9 +++++++++
>   hw/net/igb_core.c   |  6 ++++--
>   hw/net/igbvf.c      | 13 +++++++++++++
>   hw/net/trace-events |  1 +
>   6 files changed, 31 insertions(+), 2 deletions(-)
> 


