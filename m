Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D034370EF76
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1iyz-0001kJ-4h; Wed, 24 May 2023 03:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1iyr-0001hO-8Q
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1iyp-0005PH-0W
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684913538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zZMujTuJhdtYfPmPVtjqj8Osmcq+LsNTPt354vzLMQ=;
 b=DDFEdVwxIbEq2S2YVZ1TpiS9pj/2GK464RM9EVYUddM06PwTR48uRzQaY4F40FUTatqY7r
 Du1lqCaRe2/Vg5AOdtasD8hUc6CtxpUus7/kMmH7y5YyyfyM+sob4ygGqXM0PPK8avGOaA
 eBh5nVrAJXdlaZn25UAPLVWXj+bZI18=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-R79YJS80NXmo48THE5YDQg-1; Wed, 24 May 2023 03:32:16 -0400
X-MC-Unique: R79YJS80NXmo48THE5YDQg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50dfa390825so828396a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684913536; x=1687505536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7zZMujTuJhdtYfPmPVtjqj8Osmcq+LsNTPt354vzLMQ=;
 b=UC2E5SiwwefDqo0/lI/8IEy5KImK/FF42F7a9cEF4i6rV5XJNqVb+D1R4+FnD0yBCR
 68/OYfwAcTulQo0Tjxuf0PEAeXrDt0TH6LWQ5Yc40LzQCGQNaNMnS59ZgmIA9k2Kyn7M
 7UWAjasBQ49OMj0aDVCkteX8KEZxOuD+cVuM4fGCFfZl9FOgYYeW/Yw713h6uZ1Olonb
 o80nw+FX6WLjCSqd5g9rDB4PS7ntZFm/oX+hkFeVEYCZl/XFSW034ZwR0St50FV0eKnI
 lCilJZyf02BtqtQDfGK6ODT8qnAzkZQ2DsFXIr4m+lwRuJHaiAGL9S4X5Lz2TxTnmu5H
 Vm3w==
X-Gm-Message-State: AC+VfDyFnd2yGeUzNfLEVZZSX/gkKrXCZFv7zSsd1ISBY0XwEQO4zCH1
 lfyglKuP3O6nWhBB2yrkWsGxZZ/35fVn4f50HTo2i7jbdj7nTU1b3S6v/sLr7cRBiEqGvv4KV68
 rIigmljruKiMtsNQ=
X-Received: by 2002:a05:6402:2038:b0:50b:d4e8:3173 with SMTP id
 ay24-20020a056402203800b0050bd4e83173mr1297092edb.8.1684913535945; 
 Wed, 24 May 2023 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Q0zd3s+PqDpn2Y/pwznwKeCvUTrmhgMmk2NqWQ+cxzK0nU0kLlRxoDxcv9n7XAH4PEmu9JA==
X-Received: by 2002:a05:6402:2038:b0:50b:d4e8:3173 with SMTP id
 ay24-20020a056402203800b0050bd4e83173mr1297062edb.8.1684913535684; 
 Wed, 24 May 2023 00:32:15 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 b17-20020aa7c911000000b00502689a06b2sm4708084edt.91.2023.05.24.00.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:32:15 -0700 (PDT)
Message-ID: <289fee09-ced3-bb69-44fb-2bc8d5968dd2@redhat.com>
Date: Wed, 24 May 2023 09:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/11] hw/virtio: Build various target-agnostic objects
 just once
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
 <20230523163600.83391-11-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
> The previous commit remove the unnecessary "virtio-access.h"
> header. These files no longer have target-specific dependency.
> Move them to the generic 'softmmu_ss' source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/block/dataplane/meson.build |  2 +-
>   hw/scsi/meson.build            | 10 +++++++---
>   hw/virtio/meson.build          | 11 ++++++-----
>   3 files changed, 14 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


