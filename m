Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A9792558
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:15:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYgZ-0007ex-O6; Tue, 05 Sep 2023 12:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdYgY-0007en-4L
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdYgV-0004Cz-Tx
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693930426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9BoQghM8rrXH3S2GSqyc8YmdaV1j9zKJU6WP4CdmRQ=;
 b=ictUm5VJaM6WAYYq+dc3/6lw4w6Lhl0mPNPJV3j0mYYDrepg5LrRimdZlAWgAHSX54hacp
 5E84BFZpBKLwgfHaoS9Ra+hPwnVqmjPog8cZpF+LctYBMTuAuveb2mdIkdo3fbhierofmk
 ZKjiAHbOFjow8RLZX6a51yKaWTi1xLM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-D2sBQvYPOpGTuZ3T0uYi1A-1; Tue, 05 Sep 2023 12:13:45 -0400
X-MC-Unique: D2sBQvYPOpGTuZ3T0uYi1A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bbc1d8011dso30035161fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693930424; x=1694535224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9BoQghM8rrXH3S2GSqyc8YmdaV1j9zKJU6WP4CdmRQ=;
 b=KgJauIekuesZGD6ZWoO5MVA0pgw5Isp8+K6YJWSEBi0vu+TMd9nRHFBCqKUNZqyW3G
 lK3gcWIQlDIz5xVnd+t3vOjl7B6z8hpO+1E4/t3i/7Q9XNmVW2DZKDnu+OGlKK48ScXc
 UDnW7bcnhMwDLh/IdakG6nKMxi+4HY+4/Pq1Tbpn12QzHU8ehzTs1Q4NvINxEywQ8fq7
 l8iKWBiAOSVYmEV8yfetweb2BMK+6/xV1MfLTHvqpiz7g9uRPdCNhkMPemYtIKVbW72a
 lMgRs41OnSwj819JCoPCB8ud9gLyEy62ra2w1FC7vBU2ycTWcESvrILTu1KpAG6xeBc5
 ZiSQ==
X-Gm-Message-State: AOJu0Yylk1qaYO/1FDbCWkJuvXiZs9elx0GzblutdCh+/il+tBbd317c
 ZS92zrzAENo6htmTxe6CR3HrZCOFfbqK3eK229AZKG2kArTiNwUP0y3YbPLKH2RB96G17Ybq7V4
 9QfaKSUnyxlq2HlU=
X-Received: by 2002:a2e:8417:0:b0:2bb:9894:c3dc with SMTP id
 z23-20020a2e8417000000b002bb9894c3dcmr184167ljg.4.1693930424021; 
 Tue, 05 Sep 2023 09:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5nmmGNPssCXiUHz+4HeZYG2tFpXgqUgbQX9WoPCZl9ble/Z7h6HdwKZ2owecmD+f1ygTN2w==
X-Received: by 2002:a2e:8417:0:b0:2bb:9894:c3dc with SMTP id
 z23-20020a2e8417000000b002bb9894c3dcmr184152ljg.4.1693930423698; 
 Tue, 05 Sep 2023 09:13:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a05600c220800b003fe29dc0ff2sm17514883wml.21.2023.09.05.09.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 09:13:43 -0700 (PDT)
Message-ID: <94038246-216c-3304-3f8b-1fb6f6ed684d@redhat.com>
Date: Tue, 5 Sep 2023 18:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/5] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-4-avihaih@nvidia.com> <ZPIIEYhcwPJLg2Lj@x1n>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZPIIEYhcwPJLg2Lj@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/1/23 17:49, Peter Xu wrote:
> On Thu, Aug 31, 2023 at 03:57:00PM +0300, Avihai Horon wrote:
>> Add a new .save_prepare() handler to struct SaveVMHandlers. This handler
>> is called early, even before migration starts, and can be used by
>> devices to perform early checks.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> 
> Shouldn't be hard to unify the two call sites for qmp migrate and save
> snapshot, but we can leave that for later:

yes. It could be called from migrate_init() with minor changes.

We could probably move :

     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
     migration_reset_vfio_bytes_transferred();

under migrate_init() also. Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


