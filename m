Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B33B056D0
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 11:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc6s-0003uY-GY; Tue, 15 Jul 2025 05:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubc6n-0003ct-2B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubc6i-0007RK-Hv
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752572268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K53N6XM1syE2ueE8nydcX7i8PdpQtmM43EWYxf8i3sM=;
 b=aIlpETOdZHH8CsEeuwY6wWWapGA8lg4XarZmAoXFIxYhtQqQOtFVgnMsVLAxYhGr2hW/Kj
 pkOOPYwuHuMqoxm/+iaANPtPgraaqblMcxzC4DM32hItAixEVbrGf0TTumJJ4juup102IR
 deycQR3PVufrz6ZC2RtJR6zRqfWSHcM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-c-pv47qfMC2PGlndu5ckZg-1; Tue, 15 Jul 2025 05:37:46 -0400
X-MC-Unique: c-pv47qfMC2PGlndu5ckZg-1
X-Mimecast-MFC-AGG-ID: c-pv47qfMC2PGlndu5ckZg_1752572265
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so3295540f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572265; x=1753177065;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K53N6XM1syE2ueE8nydcX7i8PdpQtmM43EWYxf8i3sM=;
 b=qdUYcP2pfgy9qPhn+WZTfiqSB1g415D798dV7S+xyDNRwMIuEgyYw6fMyxEK5h82vx
 0t3KdT/BGE9HtJ1uXmhsdhPqu59GF4WtedzwwNO9ClL3Nqe+zPKXHu4KJuWm9tGJDvpN
 1iWGuiG8ljoj6GsI0cH4gSz7lis0Ce0T3XD4gGEBvXxL8w1B5hVFlCX6+u3+OPznZ5Md
 rYPXMAmJmxjtl5xPBkZGoy7Noxbiz5hxIwsMe9iUl/QYQWBN67h2mkfJK7fPk9or60qE
 9lOz7fRpcm8RpMUhIBT7/kJc0geRig08OCsexz6R8Ls6ExZX6awlx5BI28WW4V076zPS
 5lNg==
X-Gm-Message-State: AOJu0YzgnkhRgvCgu0GPz8nUSfZd/21nTUymGavLKOHZYntTxFiFFJrn
 3713b/JvyWvNlmbNQA5LAvF9APpc2CttMIg5Zbzw9+tmUH9p7Kk1U8xp37nriuVj3ER5Un+x4oB
 RVxymAoeMqPsIhw/sbJpo7iL4cAlq2niG4xiyLm2XAsAa1Da3O7gNl1m+
X-Gm-Gg: ASbGncuK2gjqNMNvj/QL+qd4ghMZoBIRV6/ViT4bHMGWfH9w/fjuRCxph9Ew7Ul1jJm
 WNcKL/zyjiLx8QeVCiimiWtxwY2j+g6VXiBRKZRh+MjY3miV2JrSxGClJK2PCTl7e6AtynNIGgk
 N2uhqWLP3v01PdNQZ/eQ1sCFkeJ28c1hY6vdbIJWSn6HZHctXwdUCztNpxnwPWicA2ILm4JN1jj
 SeCy5f4iWmle+t/Qwr7gHKd3CmbukXhbwikQ8BFWG8gpRslJZrBV/nC7ZdE0SCh07VrRw4/YZ+Q
 GFO7TSpZntS9jFMSs87kaJ6hqVqQwcea11qZrEIxOSp084qGRq/9yOtwTPW/71XBylnkVwh55o0
 =
X-Received: by 2002:a05:6000:2d0b:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b60952ece2mr1676583f8f.19.1752572264935; 
 Tue, 15 Jul 2025 02:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF91r41Lzn0APr08+LgUUsM5pkr8r+WlQ9nwFYzKPPzXSkpDaii+S3PvwOux4tmO+IYhttd9w==
X-Received: by 2002:a05:6000:2d0b:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b60952ece2mr1676562f8f.19.1752572264443; 
 Tue, 15 Jul 2025 02:37:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14cfcsm14867995f8f.67.2025.07.15.02.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:37:43 -0700 (PDT)
Message-ID: <85bd0b0a-3c9a-448d-8d91-e4e162e066b9@redhat.com>
Date: Tue, 15 Jul 2025 11:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/vfio-user: wait for proxy close correctly
To: John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
 <20250715055246.422834-4-john.levon@nutanix.com>
 <4e4d3102-050e-44c1-ab41-aa1da2d7f6d4@nutanix.com> <aHYgd9pF2V5tYylq@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aHYgd9pF2V5tYylq@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/15/25 11:33, John Levon wrote:
> On Tue, Jul 15, 2025 at 10:01:59AM +0100, Mark Cave-Ayland wrote:
> 
>> On 15/07/2025 06:52, John Levon wrote:
>>
>>> Coverity reported:
>>>
>>> CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)
>>>
>>> A wait is performed without a loop. If there is a spurious wakeup, the
>>> condition may not be satisfied.
>>>
>>> Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.
>>>
>>> Resolves: Coverity CID 1611806
>>> Fixes: 0b3d881a ("vfio-user: implement message receive infrastructure")
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>
>> Is this definitely the right patch? The v2 posted at
>> https://patchew.org/QEMU/20250711124500.1611628-1-john.levon@nutanix.com/
>> contains the updated commit message mentioning the rename of the callback,
>> whereas this one doesn't?
> 
> Yep, sorry, picked the wrong commit message (but same commit contents).
> 
> Should I resend?
yep. Please pick up the trailers.

Thanks,

C.


