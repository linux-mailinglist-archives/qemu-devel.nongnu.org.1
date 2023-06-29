Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF87424D9
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpZS-00020X-7l; Thu, 29 Jun 2023 07:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpZP-0001zt-TD
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:12:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpZO-0005GO-E8
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:12:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso4522555e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688037132; x=1690629132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w+tsYH8FgvAwCXz+SPqSm450BBcbFww7+8yOOmdoO2o=;
 b=ps7FmnYBWw36sAtEvXEVOlnbxCKvBFhoqhXiVXcv4XfPDjkCB2wRnBcODjkRjtlGnC
 8zcrzxGwZZAHiVeIo4xLeiZMf6t4YMCdurRhLU8kw/ZCLUZds64QQszHubaYwM9AM6Pz
 l81OflF9owa7pcTe7YN3yAkEIqVN29B7NrwPYdNZJO9gIVtrttaoFzXL8zkxuDUMvtiA
 ypc+dMqIAd6K+68To3lySSFVqxgf1FUqUds7GNZwOPdjE8c/TsGhIUyJnG7E/ThOVOHF
 hK7OZywA4M7d7wJudJS8ma7pf7o6satVRs/imVIywuDjAFOzbyIweZCPUrSkFGY/gWHw
 bhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688037132; x=1690629132;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w+tsYH8FgvAwCXz+SPqSm450BBcbFww7+8yOOmdoO2o=;
 b=W4AMQ2+MEb/DBJK52FiWvZg2oxyV4bodb76UpmE3VRddIaIJl3HyU/gX6//SA/2kso
 u9cBQqOjwR0PBeiRuIxMLJB7MHZSIW2Av9tY6bNsC8By8i+z6RHqub+WkjIB6K26At8Z
 oTEyzxDkigfsjiLu4NW1GtBx21AiWonM5kEIIqS9ROiAy4eyTApkZGayiVYFCyj7hKQD
 6z4XPvjZYS0jzPjXSfzxDnLyWhUpzjPLyyCb8qbJJGmEi6PYQAYOAB4qKyH2fvC8MWby
 rFXUPEls+bBR1BVzRNtInL+qAhWcz5h920eKFnW3s+enmsDaXQYwUlU+so+Ag4G2uOnS
 vcnQ==
X-Gm-Message-State: AC+VfDxiIlde+D7GKS0R2ldHFekdjjXJ4at9Y7KvMYU3b3jOsjyQIqSV
 cOupM/Su3zwdTHZHUBh8ADiOOg==
X-Google-Smtp-Source: ACHHUZ6ArkSQses1hDgIzY3qPySbprRwLVLzlv/yZXKYTAO4EuSugcOv949KqkNb5pJRDvLTyhdi5w==
X-Received: by 2002:a05:600c:3647:b0:3fb:a6ee:4cd3 with SMTP id
 y7-20020a05600c364700b003fba6ee4cd3mr4181298wmq.16.1688037132111; 
 Thu, 29 Jun 2023 04:12:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fbc0ea491dsm371625wmc.40.2023.06.29.04.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:12:11 -0700 (PDT)
Message-ID: <152bc0f2-f20e-e2cb-7a1d-86cfb8e2c419@linaro.org>
Date: Thu, 29 Jun 2023 13:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/7] s390-ccw: Getting rid of ulong
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20230629104821.194859-1-thuth@redhat.com>
 <20230629104821.194859-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629104821.194859-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 29/6/23 12:48, Thomas Huth wrote:
> From: Juan Quintela <quintela@redhat.com>
> 
> Any good reason why this still exist?
> I can understand u* and __u* to be linux kernel like, but ulong?
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230510143925.4094-4-quintela@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/helper.h        |  2 +-
>   pc-bios/s390-ccw/s390-ccw.h      |  7 +++----
>   pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
>   pc-bios/s390-ccw/virtio.h        |  4 ++--
>   pc-bios/s390-ccw/virtio-blkdev.c | 12 ++++++------
>   pc-bios/s390-ccw/virtio-scsi.c   |  4 ++--
>   pc-bios/s390-ccw/virtio.c        | 12 ++++++------
>   7 files changed, 21 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


