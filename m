Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70FB7DB59A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxO7l-0003ec-6o; Mon, 30 Oct 2023 04:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO7h-0003eG-Gb
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO7e-0000O9-BU
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698656384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2FO3yKkYhDy4ghACNW2SPWw9q777/slTUEns7gVko8=;
 b=DBH9Rrg2hCWPVbdiqu4NGL/0W7KZcD+FKRsGLP9RxhQWRdEHco8YbY8iy4UBXKa45b12+8
 2Uj+KBsjLGFc72yz/KPVSv2JY0BRAOVn607+yeWYn6HmixmUYS6BjIOnNYqa8sQfqqHBQ9
 kljV1xThiCQFRJqHYD3PfcW92qnhyuo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-KMNRGa7cPxGZnJ8j8mBqmQ-1; Mon, 30 Oct 2023 04:59:43 -0400
X-MC-Unique: KMNRGa7cPxGZnJ8j8mBqmQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6712bdfe06dso14098206d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 01:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698656382; x=1699261182;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2FO3yKkYhDy4ghACNW2SPWw9q777/slTUEns7gVko8=;
 b=XPBNyBPXEeFaKVOhInTIxCW1d/TUHF/+ylqc0uhSFncxuGrWJQy/yYU3VJFN/OMtVO
 W8d6uNMYLbFODqvP/v+eKXy+o+kT/uSGsfKN/eZaaPMy/u6IDg41W4JKFb3SER/DoQt6
 ZjS3xhoqSQWt4d2olctt0QFKVu4p5Y9/3lxgKQOSmcEaE9tMSdS6J4cmQpaK6IMwgGYV
 mzROJZn6i5tvoL8mjR8Crfd2eqR/hg6jRFgVNtRtoBGX7Did7C9QvGvlIlWcIJ9yZRfZ
 RheX+lH2R2+pHL58UGF2hK1wbePh/mRC21qmW6hwBNb9El08owA3abjTsdKv074nxNPj
 3RBA==
X-Gm-Message-State: AOJu0Yy0hflRmJQ6gkFfcQbB8BzJeZNWFKFlWvsuSun5VA4KXqOvHW2h
 t4wxJFN+hla4vtc1GldAZlWbJEqyPD3vjTuP1xkExsPsOy9KoDDD7hUXMP10PYh7TE6ESxoQzdd
 M7gb4G5wluu6tBhzE/Rb0ZuoCG1q6VBwRGZl1ZETHWBFEsaYeua1g7V9w3TnVxDeQ7bL7
X-Received: by 2002:ad4:5c6f:0:b0:66d:57ca:fa59 with SMTP id
 i15-20020ad45c6f000000b0066d57cafa59mr10616437qvh.37.1698656382665; 
 Mon, 30 Oct 2023 01:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24v3DU9BTcQi6FuWy1uaRppNEsjVmrbhqj+IA5pRvIt0bzMNJ6BJ1wTvhtOAA6nobhq0oPg==
X-Received: by 2002:ad4:5c6f:0:b0:66d:57ca:fa59 with SMTP id
 i15-20020ad45c6f000000b0066d57cafa59mr10616413qvh.37.1698656382292; 
 Mon, 30 Oct 2023 01:59:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a0ce14b000000b0065823d20381sm3241993qvl.8.2023.10.30.01.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 01:59:41 -0700 (PDT)
Message-ID: <235fbfa2-82c3-48f1-bd4d-cc84b20fa1e5@redhat.com>
Date: Mon, 30 Oct 2023 09:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231026070636.1165037-1-clg@redhat.com>
 <8a9d26d0-ccb4-448b-9fc2-d7ce521646ae@redhat.com>
In-Reply-To: <8a9d26d0-ccb4-448b-9fc2-d7ce521646ae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/26/23 16:00, Cédric Le Goater wrote:
> On 10/26/23 09:06, Cédric Le Goater wrote:
>> Hello,
>>
>> This series fixes a buffer overrun in VFIO. The buffer used in
>> vfio_realize() by qemu_uuid_unparse() is too small, UUID_FMT_LEN lacks
>> one byte for the trailing NUL.
>>
>> Instead of adding + 1, as done elsewhere, the changes introduce a
>> UUID_STR_LEN define for the correct size and use it where required.
> 
> Cc: qemu-stable@nongnu.org # 8.1+
> 
> I propose to take this series in vfio-next if no one objects.


Applied to vfio-next.

Thanks,

C.


