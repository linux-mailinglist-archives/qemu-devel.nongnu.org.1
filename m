Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76575AD09
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 13:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMRtx-0000Fg-5d; Thu, 20 Jul 2023 07:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMRtj-000073-Cl
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMRtH-0003et-4i
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689852734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FokEBvi178FsPeMchnYzVxMIVas8Hi0JAMLL/cVs7I=;
 b=h+GzR9VgDYz0//C1+fveG+nRwERO+qdxQScPNzJhozn6KQ9pAcWamhR/8uq4fskE+jXi9Y
 IMARLMv9RH3jc31eqUv/1Ai2btSxJ4oXNtRGFm4ws2q1BYfuofRAW/ctbZZPcXyxxXK8dX
 D7r64N9ef1S9ibXIa3UNBCN6iKGEbbM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-hAz54RRxP-KQUJbRenJEzg-1; Thu, 20 Jul 2023 07:32:12 -0400
X-MC-Unique: hAz54RRxP-KQUJbRenJEzg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-992e6840901so93283466b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 04:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689852731; x=1690457531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FokEBvi178FsPeMchnYzVxMIVas8Hi0JAMLL/cVs7I=;
 b=ZiGSqc9+RinPwI1pHUHlUTo0dT3aDdh7kCB8fzMiDH6EzSLfdln7CHhrMVXPPk+5zt
 jMEF9B6wDtJurM1gEu9m3d/1O51vZ/A17GEBpvioH8cQSUd+5ZDdKGhBtyg1w2fN4sM7
 JI1kF+AU0MizPRW7fctxIeSjqPLnWchh2xzT/wPLP1cYkA9Bb3zhh+SxxdUNMT5+qwFa
 VIdpLiaFqn08/Tuc9c4odP6erXiBS1n9pWdMWzt4cznSFKbiclti+kD8DDeHUWB57ce9
 s8krSVxCIs32wn+KlqUF4aqFyTgx+DjZHz4c2Y3TS4pAK3B+/fuPg0sDZ/IomT2OLvKo
 +CZg==
X-Gm-Message-State: ABy/qLasDWXi3WyfLzcW0xKmIoMIPYIU7OwsATr7NlSkOgWE2OnA/kJf
 rloK0+MsGV8taseXSYhkxmBYJeVB9v0l4L/TBc9sWIov+B4SlSg7gOfCSIWVKoGJajcr/eXIJsM
 /7Psa1SxdDKQALRM=
X-Received: by 2002:a17:906:56:b0:997:6729:5f4b with SMTP id
 22-20020a170906005600b0099767295f4bmr5491652ejg.11.1689852731840; 
 Thu, 20 Jul 2023 04:32:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEAe42LSwSSyzP2Lnl+xHIhK7e7z8lRWId2QbLqP+YuyiAw34+s0CJnz1n5NxU+ixvym4IfaQ==
X-Received: by 2002:a17:906:56:b0:997:6729:5f4b with SMTP id
 22-20020a170906005600b0099767295f4bmr5491635ejg.11.1689852731534; 
 Thu, 20 Jul 2023 04:32:11 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 xo22-20020a170907bb9600b0098860721959sm560884ejc.198.2023.07.20.04.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 04:32:11 -0700 (PDT)
Message-ID: <59879fe8-c4c2-911c-89cd-9673c4879957@redhat.com>
Date: Thu, 20 Jul 2023 13:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Virtio-fs] [PATCH v2 1/4] vhost-user.rst: Migrating
 back-end-internal state
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-2-hreitz@redhat.com> <20230718161256.GK44841@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718161256.GK44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18.07.23 18:12, Stefan Hajnoczi wrote:
> On Wed, Jul 12, 2023 at 01:16:59PM +0200, Hanna Czenczek wrote:
>> @@ -1471,6 +1511,53 @@ Front-end message types
>>     before.  The back-end must again begin processing rings that are not
>>     stopped, and it may resume background operations.
>>   
>> +``VHOST_USER_SET_DEVICE_STATE_FD``
>> +  :id: 43
>> +  :equivalent ioctl: N/A
>> +  :request payload: device state transfer parameters
> Where are these defined?

...an excellent question.  Right, I forgot to add them!


