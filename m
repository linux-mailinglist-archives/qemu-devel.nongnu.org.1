Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6470E476
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Wb3-0007VX-Db; Tue, 23 May 2023 14:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Wb0-0007T3-8S
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Wat-0002GY-Bv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684865926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXngjGk4hfPvUqVs2XSRb/xCX58g28fmmhBdf4+2HJA=;
 b=I/J+MTdBh3uW+aaMZFINJvD3wuUQuh/FhQmiBWyBB8v+zu0d3FDvE3g7CdgURIQXT0aDiY
 cXf9PgLd9/kLHVD5SqgFS5Q7GTcWzOI/kvpA9v/mLdID1FjO32KPwRNhByNWysGRfksyUK
 jLmv0ezWCgJq1GCeVvGC0zapRNfMJ14=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-hBLAivD8M1Sxcf71W1DSpA-1; Tue, 23 May 2023 14:18:45 -0400
X-MC-Unique: hBLAivD8M1Sxcf71W1DSpA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so627125e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684865924; x=1687457924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXngjGk4hfPvUqVs2XSRb/xCX58g28fmmhBdf4+2HJA=;
 b=Tt7iaQLGWm/WqzlZ9OF62AcZo3HoGCD4QZBjNaxsG3ORYaUZzq3CAOgKXDyO1Duwe5
 upSusEqVDmP9QP1Ewp9l81w/LWf023PjDc00pHR2F4iDuXPmY6ZPio7dv+W5KjUWBIKX
 HeuHZ2F6j0k5o10UkTnZ29MXz+5fmW2UdFJZ17WK2NYncNvXSyHsJotNq8xdnL4L0kjB
 qNR2fpQg8MUeYWBIcj+iN4o6tjlKNpQPeu4X/G09Ju0wkwB3lFf/SNoKiCT2m8OD8V4E
 tm8fBUk2gCWGaU9nXhXPWtNIXHjCGJU6/lhOYggRCjcx/koJM1eKEAndG4lfEi9i717P
 L/iA==
X-Gm-Message-State: AC+VfDweXluqW6tvaQS0yDHKeekXGHRZ7c/VINKKPEhTz48lF/XZkNU+
 4mlP2JXHmx8hRAemdTi43wZhWfntZaWRl62WQ0uXcKND04IK2QPPU9LB7jvtngHvUQgH2Tx2TgL
 fLXAJKNZdAV9ULCo=
X-Received: by 2002:adf:f2d2:0:b0:307:977a:e693 with SMTP id
 d18-20020adff2d2000000b00307977ae693mr10523160wrp.59.1684865924249; 
 Tue, 23 May 2023 11:18:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kq0owEulAkOw1tNK4oeDPiE+0pN+m3srGQp9gc9EY0p0zPLAuHot/iW/68gAVtV/rVj31MQ==
X-Received: by 2002:adf:f2d2:0:b0:307:977a:e693 with SMTP id
 d18-20020adff2d2000000b00307977ae693mr10523147wrp.59.1684865923996; 
 Tue, 23 May 2023 11:18:43 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm11782336wrm.19.2023.05.23.11.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:18:43 -0700 (PDT)
Message-ID: <b3601494-7af4-9635-421c-94f61b3ff1d1@redhat.com>
Date: Tue, 23 May 2023 20:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/11] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in
 Kconfig
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
> VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
> both symbols.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/Kconfig     | 6 ++++++
>   hw/scsi/meson.build | 6 ++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


