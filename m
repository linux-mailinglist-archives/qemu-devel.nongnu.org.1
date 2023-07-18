Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEF757A22
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLib7-0001Xg-FZ; Tue, 18 Jul 2023 07:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLib4-0001Wc-S4
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLib3-0002R3-Ae
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689678623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tiRjftD76nY+seb5qnKGmCVpBDCykY5rBrB820fXpGY=;
 b=GsJEJzVM04CYGWI4yonXqCfb8WDCasScpM5l+SKyM0mLTDux3e5mLJftGxV5cg5suC+voc
 6hKv18Vz0hcQrGnq1eoI1Q4IbGPbyo8viBxmXu1gNoQK8692E3oij3bocve73CTiWD2OB9
 MDfFlxVkatqkuLfUNdRbckCbDvQqK0c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-R8NH934uOiuRkndQXpuRgA-1; Tue, 18 Jul 2023 07:10:22 -0400
X-MC-Unique: R8NH934uOiuRkndQXpuRgA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635a3b9d24eso39545286d6.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 04:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689678622; x=1692270622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tiRjftD76nY+seb5qnKGmCVpBDCykY5rBrB820fXpGY=;
 b=fUk/KEqhMXglVwcudPG7Z5tyWDrmqYNjPDxgoYdQS8wl8lrCP842SknYQIeu4cmdLR
 gPIraRTg+z4X5IBgTj0HT+6/E+GrL1vkn3T6MRxXjs3/38VU5elBteavNZerxZ7cLYgN
 Ijxn6owVSYf1qogKrnqKp9jFAiSXgHTsQcXfSxBGqOHn6rxINqf/iCZBbQijtMahPBmp
 xKrNzMxEwRcvVIX6Xs0UwiUUaZnvvDbchdhqfhjhoQS1Glt+p99h8IeHCPy1wOj/Qi05
 ltphKa10x6erqFNxG6AZqDVKuqsfhbak/7Wp6MAdIIAV9Gl2Mc0+W/kqJxD/xHEgCBNK
 GOmg==
X-Gm-Message-State: ABy/qLaRiJjwQhX09EinUIBcFaqNYkUxz2O3clehjJtbR1TMgtweOoOx
 2eS51IbNlEzH6GQiic6nRHEf3gNl1HiqfuNf5U9xhLhlMMYpTx5Tdxe7umI8qu3XS30XGkVDi2n
 oSd0Kwmou255jV1I=
X-Received: by 2002:a0c:b353:0:b0:626:2e70:1f9e with SMTP id
 a19-20020a0cb353000000b006262e701f9emr11210177qvf.43.1689678622411; 
 Tue, 18 Jul 2023 04:10:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEuk8z1M3MZJpNerIDOHVk+GobcBKRXSbokmehM5OL9W/rHr/DcG32eiUfxC1cReQNrZ8heXQ==
X-Received: by 2002:a0c:b353:0:b0:626:2e70:1f9e with SMTP id
 a19-20020a0cb353000000b006262e701f9emr11210164qvf.43.1689678622196; 
 Tue, 18 Jul 2023 04:10:22 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-122.web.vodafone.de.
 [109.43.177.122]) by smtp.gmail.com with ESMTPSA id
 a30-20020a0cb35e000000b0063600a119fcsm655642qvf.37.2023.07.18.04.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 04:10:21 -0700 (PDT)
Message-ID: <edce1ccf-d9a6-4cbe-41d7-9fc56e7720de@redhat.com>
Date: Tue, 18 Jul 2023 13:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
References: <20230718103511.53767-2-its@irrelevant.dk>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230718103511.53767-2-its@irrelevant.dk>
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

On 18/07/2023 12.35, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
> doorbell buffers"), we fixed shadow doorbells for big-endian guests
> running on little endian hosts. But I did not fix little-endian guests
> on big-endian hosts. Fix this.
> 
> Solves issue #1765.
> 
> Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)

Thank you very much, this fixes 
tests/avocado/boot_linux_console.py:BootLinuxConsole.test_ppc_powernv8 on my 
s390x host:

Tested-by: Thomas Huth <thuth@redhat.com>


