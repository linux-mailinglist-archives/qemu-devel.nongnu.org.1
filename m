Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EE70E472
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WZU-0006C8-1T; Tue, 23 May 2023 14:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WZQ-0006BQ-Ex
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WZN-00022o-Ts
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684865832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MPdEE4BdprSdXiFHRD6vGV53LBq7DbOeU4PuMtkpjc=;
 b=Tw4bDJ+OARjMK488XaIUHUxrBvvR1g66WgxrU1Goc60EJpgQYW9tw6Sra4WmBwgm5O6Dlk
 uPlM34t9Yk4Aup102oOMHkDuet1sCWxH6bNDtAJnaWMZH50hLI1eyySyo0mVhtR1bsYjcB
 JO36S4KX6PXBGMIveX1B8k5gLo6cgWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-zsel03CwN96lL1ugnG01Zw-1; Tue, 23 May 2023 14:17:10 -0400
X-MC-Unique: zsel03CwN96lL1ugnG01Zw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30953bcb997so1831452f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684865825; x=1687457825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MPdEE4BdprSdXiFHRD6vGV53LBq7DbOeU4PuMtkpjc=;
 b=FEs2f7W4ygMTvPXbzGI9GABQqSOu67DIubjDgNdmrWyBAkWaFZbfEF70YPjRxZJFMo
 /Fb8O+VWyFLM6imcHKJVIAJROm0NbwWOKoZR7e4r4FCxvYf2JtJ3gecPbkkwL4aSDdH3
 KGrxz83ikHiUKQHHL3SlLqudlNqJCRS7++pcw9CSxwzcJb8rJ155ZLjY8N8mvQqRsUga
 SdsQYAupQ5LI8WrOqUEazo6de20s9J6uWpO7g5zAOMOK+t9nF8y5QvSgnpZ5D2eF2z0f
 /qMJhLGeBIuAWjGxk37jSZvFL1BhT5tRmKZ1NEvZpaCDOwdpM7eQ+/k2onTQJLY05JrY
 0LKQ==
X-Gm-Message-State: AC+VfDy7Q3gMwyVB3YpyImgBR3H6Kb8KjhQM+Zh1IVb3zDXcEX2m/iwm
 zJ2RFCPKY3R+qH7v5V2DCQQCNimFHQ3PUrZaqIAdffr1p1saIIGATmlB4Rr1vcwvmOP1JRhjclP
 Gfd+Grthi7N8xilg=
X-Received: by 2002:adf:f14e:0:b0:307:88ba:c999 with SMTP id
 y14-20020adff14e000000b0030788bac999mr11387829wro.62.1684865825409; 
 Tue, 23 May 2023 11:17:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aqP1NDzGqgu5DUyX7x2HHMIe+mFeYRn/R1GPFRYVxRsIISFVoPDPR16OHng+LxhD0h8gxWg==
X-Received: by 2002:adf:f14e:0:b0:307:88ba:c999 with SMTP id
 y14-20020adff14e000000b0030788bac999mr11387816wro.62.1684865825096; 
 Tue, 23 May 2023 11:17:05 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm11961066wrn.9.2023.05.23.11.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:17:04 -0700 (PDT)
Message-ID: <c70a82d9-b7e4-6cef-6fc4-d2d77048b3b0@redhat.com>
Date: Tue, 23 May 2023 20:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/11] softmmu: Introduce
 qemu_target_page_mask/qemu_target_page_align helpers
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
 <20230523163600.83391-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-2-philmd@linaro.org>
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
> Since TARGET_PAGE_MASK and TARGET_PAGE_ALIGN are poisoned in
> target-agnostic code, introduce the qemu_target_page_mask()
> and qemu_target_page_align() helpers to get these values from
> target-agnostic code at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/target_page.h |  2 ++
>   softmmu/physmem.c          | 10 ++++++++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


