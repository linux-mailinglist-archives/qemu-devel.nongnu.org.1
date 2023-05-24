Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F170F33E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1l0V-0005Ms-MW; Wed, 24 May 2023 05:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1l0S-0005IQ-Er
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1l0K-0007fZ-40
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684921319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9or2w2+2evzZiPLu7xJ0WdNNCjJn9jlCx3hOTRo/gM=;
 b=LB8nU0PJhVP7irwzRh0BMDKItCUcOOaYbZSYmYZQ8zrqHvvaClp84UQuiHFYj+MqYrncqi
 BxtdLKIZzi5GB/3j6viIbqFLiXONvTdVLo7n3fotNQoBfxfOj5nqot9Ux6hX9lGHvpkEL1
 OLkKMvptJKJDpOL3kSEg0iCHy/65EXg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-CIsa1J1xNYuK9Nc5NNTxeA-1; Wed, 24 May 2023 05:41:58 -0400
X-MC-Unique: CIsa1J1xNYuK9Nc5NNTxeA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f50aa22cd2so4737185e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921317; x=1687513317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9or2w2+2evzZiPLu7xJ0WdNNCjJn9jlCx3hOTRo/gM=;
 b=lDcLtZ695AGENmMlyma2IqRQvdY3wv3G6Iyl5MvEhKP82kqegm2IZdMI74vmNPHQ80
 GSpyt2IC9HDjlagkGqzX8MbOrBTbHETit0iMZ8Gg/i9zZE3kkYAz30LTfRjnF+sRQUv5
 Breq3R7ouCSsF4IJlNpduyWQwK9qh9k5YPfNNkWvEoFw8cV+JGRoswKskgSAFPuDRip7
 1sCusMgQOlSnG273HhDgYAbyqz8zbA8EW02HpITMDK1N77HxmjWelLTl5QbVY4bKesQV
 Hnyk1ufaRNH0thc56Rb9O2uvb56vEL8wJ/RmVxSh4vix2Y0fnQSfrnZiz/0LIubCTQov
 plYw==
X-Gm-Message-State: AC+VfDyo+CUoLlc7w4qxrJ8Cj0ppu00rGxqIucJnRj5RO0yyig3IDqn8
 w9cgV5nI12gTnWq2M4MWJC1jNwtRyXC7yBOUCm+Pf2xeaBhCvzrvBng5F/WotBYQ5lOX2o8IFk3
 bGmK4Q1bgQRrzmoI=
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2506:3d58 with SMTP id
 l12-20020a1ced0c000000b003f425063d58mr11339405wmh.23.1684921317079; 
 Wed, 24 May 2023 02:41:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70xajtY3+hjFdSg18TsYakiLYxxjTsNPqUnmL5AnBflFUwl6gbltbVfHd4KiePCTHW15Sqrw==
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2506:3d58 with SMTP id
 l12-20020a1ced0c000000b003f425063d58mr11339392wmh.23.1684921316927; 
 Wed, 24 May 2023 02:41:56 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c0b5400b003f611b2aedesm1682759wmr.38.2023.05.24.02.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 02:41:56 -0700 (PDT)
Message-ID: <d3d37a46-719d-2f02-e7d5-7e0ea14991e7@redhat.com>
Date: Wed, 24 May 2023 11:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 04/10] hw/scsi: Rename target-specific source set as
 'specific_virtio_scsi_ss'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524093744.88442-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 24/05/2023 11.37, Philippe Mathieu-Daudé wrote:
> Following the SCSI variable named '[specific_]scsi_ss', rename the
> target-specific VirtIO/SCSI set prefixed with 'specific_'. This will
> help when adding target-agnostic VirtIO/SCSI set in few commits.
> 
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/scsi/meson.build | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



