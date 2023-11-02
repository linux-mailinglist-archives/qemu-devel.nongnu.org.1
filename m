Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD77DF4CD
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:20:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYXA-0002a1-J6; Thu, 02 Nov 2023 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyYX7-0002XM-MR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qyYX6-0004ub-6q
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698934730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAmYQAmp51i+PHc40s4THT8/1TLplt0nGX4p/H7ds+k=;
 b=E321ME9JbRRsAyJrbLBj9o/Jafhd0gndwl+kWAHVH7iheLJJxiDMKxH9J19LIS1MqQEZrt
 7GN0XATlpYHp/AhZUp/8iV8ppgVRmqVEpIMRrguh/jXncbswayvqQ8Fywa8fV1XyG53QEi
 e8I5jdIuZ8MzDcyS1MoFAF/7W+RgEHU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-GDfKgbWBONiCeRlv3vnXmQ-1; Thu, 02 Nov 2023 10:18:48 -0400
X-MC-Unique: GDfKgbWBONiCeRlv3vnXmQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso6220245e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 07:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698934727; x=1699539527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAmYQAmp51i+PHc40s4THT8/1TLplt0nGX4p/H7ds+k=;
 b=rd3y+Ekwci2fUY9dNGLNQAt9yGKWPcwc4/C0ci5vN6dmeJaE1fpNn/RLngRWA1S49a
 1OeyBzYEquiSvYcSS/xToWnN4GYdSi+cAPYhcN5thsyTUagj++8nv8A9QYH/7NimW8U7
 m8sFPYbeOpMZTxseDN8X9Vf6EvdEmrtdlfHnlfa1EvqcX+ppWnD2++foNtiXO/lLrjla
 /zcrTiMJLo/YRkiSdsFX8WRT2VS8yxjTg3Uk1n4tiUqfyn3OMt8p4XyoN/8vyDrL6Evr
 HaRL1hLGkR02BK7KcvOpPkHLQq0zQ1ChiWiwJC3VYRdmtRyzoSZHdW3I90GJ+eGmGqgJ
 AOkQ==
X-Gm-Message-State: AOJu0Yyr2mSU3UOPZEiOULiGWCwxTZ0RrdldrSYrAPfdRj2AfpQaPq//
 aGTTlKqb+omOm/diC4ky23xjfjA7az5bDRme+YlbPy29lw9+B21UMsYvXt4yBJdYjAIz3Fp2X4S
 NVhefgHy2kWpsxWVdoxFtl1Iu7CjkwFEHHAiNBYu1dOqcuK0bIVfDwMfOV086W1y9BC2XepSd
X-Received: by 2002:a05:600c:1d83:b0:407:8ee2:997e with SMTP id
 p3-20020a05600c1d8300b004078ee2997emr17069989wms.27.1698934727299; 
 Thu, 02 Nov 2023 07:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa8mpwecDva8clnsWhfFMCIbscdzop3vKIFikwmPNFL5rKYcSvoouH+D+U8c1ud5eHIAgiMQ==
X-Received: by 2002:a05:600c:1d83:b0:407:8ee2:997e with SMTP id
 p3-20020a05600c1d8300b004078ee2997emr17069965wms.27.1698934726942; 
 Thu, 02 Nov 2023 07:18:46 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a05600c35d600b00401e32b25adsm3079298wmq.4.2023.11.02.07.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 07:18:46 -0700 (PDT)
Message-ID: <4527971d-b408-400f-8004-591885c9fa80@redhat.com>
Date: Thu, 2 Nov 2023 15:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] vhost-user: Back-end state migration
To: qemu-devel@nongnu.org, virtio-fs@redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione
 <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>
References: <20231016134243.68248-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231016134243.68248-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16.10.23 15:42, Hanna Czenczek wrote:
> Based-on: <20231004014532.1228637-1-stefanha@redhat.com>
>            ([PATCH v2 0/3] vhost: clean up device reset)
>
> Based-on: <20231016083201.23736-1-hreitz@redhat.com>
>            ([PATCH] vhost-user: Fix protocol feature bit conflict)
>
>
> Hi,
>
> v5 is basically the same as v4, only that I’ve dropped the patch
> deprecating F_STATUS (which doesn’t affect the rest of the series), that
> I’ve amended the documentation in patch 1 as suggested by Stefan and
> with help from Michael, and that I’ve rebased everything on top of the
> F_SHARED_OBJECT changes that have been merged upstream.

Ping – both of the dependencies are merged.

Hanna


