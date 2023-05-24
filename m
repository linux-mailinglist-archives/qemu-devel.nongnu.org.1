Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFED70EF96
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1j4h-0004ZN-VF; Wed, 24 May 2023 03:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1j4c-0004Xo-QR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:38:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1j4a-0007PO-1S
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:38:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3093d10442aso263649f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684913894; x=1687505894;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7nDpnpQZDMmm2vk5tybDiMX7CX496rZM7XJglahguA=;
 b=Byucy0e5ng7UjaYQI0BtitikY14cfn5OIbZW9lr84X0LsQTbPVCC5Eai7RXUxrdCUk
 rbV8RvKroKX1WPDKO/WSp0+WWFHxO6GWY0Gwep0iyG45okWyLVqXGxXEcdP2cw/BcVKE
 Z2Le+mmdCuLvlxSKkmZr60OQ82dA9HVXBIZ6MaBZT3X6ZyK/CzB2ZRs8R+VrofrX4Bpq
 EifKnEHkWBUXFyo3pisfvKVH+CgUNO4ew2u2JVYMAs6rmyrRkJfVJpZ7A15GkRoeSpXK
 9DrLIDdxIXfVhYgGKHP86ApiquaDADWVAs81raviozjTtFD3QRAaynj+/tbxgb1qX/1H
 G/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684913894; x=1687505894;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7nDpnpQZDMmm2vk5tybDiMX7CX496rZM7XJglahguA=;
 b=dclCnaEzGLaQbd6hnzvLD6lPrrI2A/1jlamnoMXgwk174riCeUOBVbm09DIltk2pT0
 9/3JneftZdHp4NmPdcI3tnKoABpBFvDAahg5sRFSBKTvtJw9lEfu+RZw9Xv0SzfWU6xj
 P3Geicg1u00JlXP3mHeid3OpiOCJl+4HxORuyZ9uRn5vFuYKgK0y3hAiZPENHZedrQZF
 jgP98UIbo059av4m8+sogcqa8fZWiYjTcio88JtA5sbad4y3cRFdKFPtZT2gfdiqss9y
 aIzTMtG6GHfJW+89eUMUhHfXF0L+jArB2up4Lq/Pmsz07fDC1WhDFFtQJVfXZ+24BDV3
 eC7g==
X-Gm-Message-State: AC+VfDyXBxiu6GCVOWmGI80xGk+FRsfxDTLLvdvoZzg+wUyiQ/pcyt1k
 bUKCblWfLdFvmzgLD0lQF3izzA==
X-Google-Smtp-Source: ACHHUZ5v3jnlc+vd2rHXqt0WpeBwQKceKUBLrrNVhXhdg0DD81aZg6udwTWJgg4DgvXxbBzZaFnSMw==
X-Received: by 2002:a5d:46c8:0:b0:306:4550:f651 with SMTP id
 g8-20020a5d46c8000000b003064550f651mr10784290wrs.4.1684913894447; 
 Wed, 24 May 2023 00:38:14 -0700 (PDT)
Received: from [192.168.215.175] (35.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.35]) by smtp.gmail.com with ESMTPSA id
 e3-20020adff343000000b003048477729asm13470603wrp.81.2023.05.24.00.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:38:14 -0700 (PDT)
Message-ID: <4a41f378-d8be-6e67-9e85-c6a4aa321e97@linaro.org>
Date: Wed, 24 May 2023 09:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/11] hw/virtio: Remove unnecessary 'virtio-access.h'
 header
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
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
 <20230523163600.83391-10-philmd@linaro.org>
 <b9a1db8d-8800-3103-c6ca-076d5b14919a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b9a1db8d-8800-3103-c6ca-076d5b14919a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/5/23 09:29, Thomas Huth wrote:
> On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
>> None of these files use the VirtIO Load/Store API declared
>> by "hw/virtio/virtio-access.h". This header probably crept
>> in via copy/pasting, remove it.
>>
>> Note, "virtio-access.h" is target-specific, so any file
>> including it also become tainted as target-specific.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/block/dataplane/virtio-blk.c | 1 -
>>   hw/s390x/virtio-ccw.c           | 1 -
>>   hw/scsi/vhost-scsi.c            | 1 -
>>   hw/scsi/vhost-user-scsi.c       | 1 -
>>   hw/scsi/virtio-scsi-dataplane.c | 1 -
>>   hw/virtio/vdpa-dev.c            | 1 -
>>   hw/virtio/vhost-vdpa.c          | 1 -
>>   hw/virtio/vhost-vsock-common.c  | 1 -
>>   hw/virtio/vhost.c               | 1 -
>>   hw/virtio/virtio-crypto.c       | 1 -
>>   hw/virtio/virtio-iommu.c        | 1 -
>>   hw/virtio/virtio-mem.c          | 1 -
>>   12 files changed, 12 deletions(-)
> 
> Very good catch! I checked that it compiles and links fine with this 
> change, so:
> 
> Tested-by: Thomas Huth <thuth@redhat.com>

Thanks, FYI this list was built doing:

   $ git grep -l virtio-access.h \
     | xargs git grep -LE 'virtio_(st|ld)' \
     | xargs git grep virtio-access.h

(I don't think the command is relevant enough to include in the
  commit description, but can amend it)

