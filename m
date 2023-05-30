Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3A715F1B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yOe-0005wV-Tc; Tue, 30 May 2023 08:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yOK-0005rQ-2b
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:23:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yOI-00085h-E5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:23:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30aa1eb95a0so4439180f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449433; x=1688041433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TcgUn3HHQH5E5gr43nISbrABGWYsHohZSLzGYj71h1Y=;
 b=FBmN+n+UVEVYXoMVSqcAYZkv4aDlOBHcMv2yMFptljMNuuX9ruD4tqXj2lv6FiWuxI
 Gc834XAk7ZAV9iWEw9vWoM90yfsHVIP2Z6sON/0DtI8CK0dvsXMeyzIwzizy4dhZwBRV
 bqr3vm4zheQ0fUoffD/oFBqiN+hnIYjQzYLufkoad+wG8VT8DuiqzbTSLXI//x46HZkP
 /sW7RVATguxN157JkCKfJunuCde0y/TTnmgeIjTMM+GT0Gyx8MX/n61Vp01No5LGU40T
 zR1PGCn7nJEjgXWDuNv37YvKeTmn6tdkgyVCeuwXMAN8huApRRjbW5azWudVNsU4MuNH
 33Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449433; x=1688041433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcgUn3HHQH5E5gr43nISbrABGWYsHohZSLzGYj71h1Y=;
 b=OtfZ/T3Dl9WP0sEhADmqZQF21cd73X1xM24CViTAAEAAOCOPH+YLAkCT8TeMHt4iLt
 z8eKhAQwL5TECcHe9zQHnOXEx80MkeLSUNDFieGWPX/EaXp2f6C6DjkXOsyUlmHlq2rj
 JpZEIonMNcvCHzgqJAu3oA6KUm1Bd2lvInTz6AjI8/0OglG0FI3OiMgLR5YZT41wGf7W
 kFBs2shqet4HwAtQuLfkgEpNv1hS/+G2WFz4IFCD4voxq1beOvJ/b/9zKiZ4E1UiSexx
 xJwu5pfL4jebIe+TtRdPNgZhpDN1SZB1g44J1jfwMxJgRBIewTVNdS13ZudnPGyS+vi3
 kJSA==
X-Gm-Message-State: AC+VfDxEkosBBsmWROjvTdfGMd5srQYIctNOdOSpWXGI2w0iptBQZixE
 Ud/+uzoUkaq9a/pBPtRX1INz2A==
X-Google-Smtp-Source: ACHHUZ4WA6HHM7AWWEsH35oICIeA1teV+gTMnnAyqS1PlqTE4iSVpC10gbubQ5zIvebeAGnpptq+5A==
X-Received: by 2002:a5d:6188:0:b0:30a:f05f:ce46 with SMTP id
 j8-20020a5d6188000000b0030af05fce46mr1362055wru.8.1685449432967; 
 Tue, 30 May 2023 05:23:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d5272000000b002fb60c7995esm3154719wrc.8.2023.05.30.05.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:23:52 -0700 (PDT)
Message-ID: <77694e60-a811-3fd5-bf05-2c644995e2b6@linaro.org>
Date: Tue, 30 May 2023 14:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 10/10] memory-device: Track used region size in
 DeviceMemoryState
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-11-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/5/23 13:38, David Hildenbrand wrote:
> Let's avoid iterating over all devices and simply track it in the
> DeviceMemoryState.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/mem/memory-device.c | 22 +++-------------------
>   include/hw/boards.h    |  2 ++
>   2 files changed, 5 insertions(+), 19 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


