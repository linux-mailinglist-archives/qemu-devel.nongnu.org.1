Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA777565F0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOxJ-0006XN-N6; Mon, 17 Jul 2023 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLOx7-0006PC-Mx
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLOx5-0008Mh-LX
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689603110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDqb+Yck5FSpqI2m5af3Do3k0WAk4wWd+pHmgZ0EuZg=;
 b=cyEDlqbbzmaa1YvMa4IKC+vkDiglmNS9wC3amffPBG1lZEyGBPxosMxu1IrZ+vhlvvIU9J
 qmROZsqtqHnDtQxfCkgbt9W9PwBUpnVlewRpt2mNCs4jeC4Udt89fIX20zCVBv2t70uMhW
 oNQW7j+GIEGOGMXzg/wrzHNgK9RxalM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-jwZ3-UXfNPyfSJVE6a2-gQ-1; Mon, 17 Jul 2023 10:11:48 -0400
X-MC-Unique: jwZ3-UXfNPyfSJVE6a2-gQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1a6545aa0e0so6687754fac.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689603107; x=1692195107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GDqb+Yck5FSpqI2m5af3Do3k0WAk4wWd+pHmgZ0EuZg=;
 b=MTZ40U49khBsL+3evmYG91idw0xlV6sWWopRQ1Q0QgiV7EUrtEdchUCcZ0ZqoWUy8r
 vO6YZsqVqjWiC+BPZ1z4NVVr/TqHSXanX3MyZe0NlsYGgJB5cVsHzugFrmZbA1UcHdlC
 R8GsxOXigevWLmJbZLri5hjK6UctxaDa0aYpoi1mEMc/sK55R+pdHaT66z1XXO+nZECX
 b87bYyFgAcWXx5FS4+//HcJGG3N3jNjxPC2KAmblHcPAVUSFjsbscFjtb8a8NTZpg+xf
 tPQkHt5b5T4Nc2PL01mTa7PMN6SV5hw1mTAIbAWYJjrmiqeOHYyBu6G08cv8HBgqPwbJ
 bfhw==
X-Gm-Message-State: ABy/qLZMNg+W7n6aA0ei1xoprlMov22D+jUGRSRQWC15iU6WGm0Fca/y
 qq0i3dhBRcGu9nBCzMYuPe5G4TAFO02CRV1SCkMQGPAj3vsEnnLN4hG2SdJBlXuDzfJFGg+sgjl
 gq8nHMvaq5qDv9gU=
X-Received: by 2002:a05:6870:d1d3:b0:1b7:8836:95c9 with SMTP id
 b19-20020a056870d1d300b001b7883695c9mr13379545oac.42.1689603107191; 
 Mon, 17 Jul 2023 07:11:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE5bOS6gn1Qrv4SxctianJhnE3XgTc7ZfAox8wWVye2VwxPaUmhyOQCIrFzqUPhELg4/Ne9bg==
X-Received: by 2002:a05:6870:d1d3:b0:1b7:8836:95c9 with SMTP id
 b19-20020a056870d1d300b001b7883695c9mr13379515oac.42.1689603106626; 
 Mon, 17 Jul 2023 07:11:46 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-137.web.vodafone.de.
 [109.43.177.137]) by smtp.gmail.com with ESMTPSA id
 c14-20020ac81e8e000000b0040331f93ee0sm6370638qtm.77.2023.07.17.07.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 07:11:46 -0700 (PDT)
Message-ID: <f1ec6d82-af18-b399-4ef3-7a1249e705f4@redhat.com>
Date: Mon, 17 Jul 2023 16:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.1] hw/arm/smmu: Handle big-endian hosts correctly
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>
References: <20230717132641.764660-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717132641.764660-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17/07/2023 15.26, Peter Maydell wrote:
> The implementation of the SMMUv3 has multiple places where it reads a
> data structure from the guest and directly operates on it without
> doing a guest-to-host endianness conversion.  Since all SMMU data
> structures are little-endian, this means that the SMMU doesn't work
> on a big-endian host.  In particular, this causes the Avocado test
>    machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
> to fail on an s390x host.
> 
> Add appropriate byte-swapping on reads and writes of guest in-memory
> data structures so that the device works correctly on big-endian
> hosts.
> 
> As part of this we constrain queue_read() to operate only on Cmd
> structs and queue_write() on Evt structs, because in practice these
> are the only data structures the two functions are used with, and we
> need to know what the data structure is to be able to byte-swap its
> parts correctly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   hw/arm/smmu-common.c |  3 +--
>   hw/arm/smmuv3.c      | 39 +++++++++++++++++++++++++++++++--------
>   2 files changed, 32 insertions(+), 10 deletions(-)

Thanks, this fixes the alpine test for me:

Tested-by: Thomas Huth <thuth@redhat.com>


