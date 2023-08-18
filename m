Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D7578073A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 10:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWuvD-0004tp-Mf; Fri, 18 Aug 2023 04:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWuvA-0004tU-S7
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:33:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWuv8-0004lI-GU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:33:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5257f2c0773so794796a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692347605; x=1692952405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6B6reclpzzsqyu3GltKPx/1+vUT6rdQgVTwvqAcIGs=;
 b=mDuI2K73sG7+5NxFPZRZlJXZ5KSoqV9Cs+aW0/5S+yvrD6030fXShHseiMnofJoMMS
 vCBYoy7ZrlIxH7fxS0WV8efXhIiqworCPIWvbz6fZj/aQ5GmoCXGkAZimz8jIH3ECD4q
 LeG8GdaTamQSUypMUwQkpxLGz+dp7nRNmb5eDOSIa+wKPMJuLsoRhFxPlMbOWr1pK3/G
 AIzZC5CLk6D5+A8rB3mPouvE2rpBs4iM9WrKTxtNs3v006SvChx7KDH1EqdwsWHZoxGS
 cBCRar7rkFfqdCbp57eB7HmyAvwqjxcniReuXiTVMIP4TBsScJn5iwKjWrRtvhB6cjO0
 f6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692347605; x=1692952405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6B6reclpzzsqyu3GltKPx/1+vUT6rdQgVTwvqAcIGs=;
 b=arMy8c5E0r3+OO8pjFmSpqe0Jyeie2/z2othcOr1PB79KdamG3E98svF3i+HAtKf0x
 z+Ms65uZsXXJF4RnJ8hL860m/vYTHRvSx75S/cb6FqZoD4HTNCpFdQwEz4yKsSXRe1JR
 7+1ZLUWSJYsjpBKm+tLLgzTTYxA8eXiJp2fVFTTZFHdsQBusD/iv3ib3BoknF++m0QMv
 frv3CijdsPFc7JHgpYbmMQn5LJ2ieutY9vVNSOaMCnzQe2cMTfgFgzQHEZO3s24jqCL7
 u5Jw6aIDMyL4GetP+B4UYJP5c+t6N1dSIl6k7Q9pYvSFKZ+oqw7IjcgtmfEiYquYM2Mr
 M7Yg==
X-Gm-Message-State: AOJu0Yy8IoWvI1QWU72+ZpHuy0BIi41mpWGZKBkTccV4otbRfx8CAPtJ
 s0Tcn7xx7aIqWk1vby5y20T9TQ==
X-Google-Smtp-Source: AGHT+IEVGTXx+aqxF3YAMS/s3iznP3vmLGfMlX8GyLK0NY+uy1m2WAzwUikiXNblzUrGIPKOK+Un6Q==
X-Received: by 2002:a17:907:7886:b0:99d:f34c:7a0f with SMTP id
 ku6-20020a170907788600b0099df34c7a0fmr1131079ejc.23.1692347604770; 
 Fri, 18 Aug 2023 01:33:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.114])
 by smtp.gmail.com with ESMTPSA id
 sb25-20020a170906edd900b0098ec690e6d7sm912432ejb.73.2023.08.18.01.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 01:33:24 -0700 (PDT)
Message-ID: <8d4d54ae-84c8-d0ba-2a9e-330898a1e4bd@linaro.org>
Date: Fri, 18 Aug 2023 10:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] block: rename blk_io_plug_call() API to
 defer_call()
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Ilya Maximets <i.maximets@ovn.org>
References: <20230817155847.3605115-1-stefanha@redhat.com>
 <20230817155847.3605115-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817155847.3605115-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/8/23 17:58, Stefan Hajnoczi wrote:
> Prepare to move the blk_io_plug_call() API out of the block layer so
> that other subsystems call use this deferred call mechanism. Rename it
> to defer_call() but leave the code in block/plug.c.
> 
> The next commit will move the code out of the block layer.
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/sysemu/block-backend-io.h |   6 +-
>   block/blkio.c                     |   8 +--
>   block/io_uring.c                  |   4 +-
>   block/linux-aio.c                 |   4 +-
>   block/nvme.c                      |   4 +-
>   block/plug.c                      | 109 +++++++++++++++---------------
>   hw/block/dataplane/xen-block.c    |  10 +--
>   hw/block/virtio-blk.c             |   4 +-
>   hw/scsi/virtio-scsi.c             |   6 +-
>   9 files changed, 76 insertions(+), 79 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


