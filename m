Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A77AB8FD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkk9-0001vg-CO; Fri, 22 Sep 2023 14:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkk3-0001tG-N6
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:19:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkk2-0000IE-4w
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:19:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405524e6769so916885e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695406740; x=1696011540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJ4F5rytmSfqPiL3troGKTKxCoWz7NpQqmqkarHtJB8=;
 b=KNzfzI/UURoEOsh/DcA/UglRkT+7q2fh/sACseRM14dW50I5GeK42+zG/5iMFPmW+K
 7+Etzm5a9cclxa/TiwY9QXvIbrlfDO5u7HEDOpLCpmgwIRqpSXyfrvQzZD7sClU0HX3n
 +U7yM7kT8wL4t4cE+dhxy98Iy026gzhe8EmSmjRse77rXqgTaEzILavzutwIalFwUisv
 Phw+Bb7ZFL21xTN9IVbBCinSvWG5X3Hkw4Ix7xcswPs818WQRyUZ2SvLqNb3ko39N+2x
 25VzmlTpktOMsAZTZt3eBaAGGwZqSSA5wojFWXVM8ruHBZZiofd1yvZkjkPkE2Mc9kek
 rfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406740; x=1696011540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ4F5rytmSfqPiL3troGKTKxCoWz7NpQqmqkarHtJB8=;
 b=vgIsg0ePfPlIic0CmrmCRVKNlrd4ynmgOwUdXkIkMnjg7DDi5FleBZ9cwsx8Yd2o24
 I/gY0WjxXuTaW0bzRbNu2zBjQEJhrlpPdhonOJ5/W06rSzCZmjRRz8j+ncvee/o5cstE
 ScKJ1+S/kGqEjEiUwnwQrO+w8HpkhZCS9uw2v3nvm1T/1GvSHkJYB2Lj4AAYH3COTpjv
 KuQQh6Myi8oJfOq1VlxdMfwJINV30KxFKN0mBopkQ+E2X2osocSBkQFDTTyz/Ag8lUTt
 ezs+7P3YLZcPnAPhf/wFjscfdMuIKKH1MVMxib7ibOLp5ligfL5sUK+Sl/KT3eWke1Pa
 rc+w==
X-Gm-Message-State: AOJu0YwZy6QESghNAavFZn0cnEAJCKTFUzYwlHeWR1mXXVJaAZ393YWz
 AbPbt6z8YjozXb5IawlENxQLIQ==
X-Google-Smtp-Source: AGHT+IGS87hy1Pgvp40fJhGF839VNgGDA2poM6Z0ZhN+iqklVFPC9T9UnmjYsZAVRpjkOtc3/PeSJw==
X-Received: by 2002:a7b:ce0b:0:b0:3fe:4341:a5aa with SMTP id
 m11-20020a7bce0b000000b003fe4341a5aamr314351wmc.8.1695406739624; 
 Fri, 22 Sep 2023 11:18:59 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 x8-20020adff0c8000000b0031f3780ce60sm5075986wro.7.2023.09.22.11.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:18:59 -0700 (PDT)
Message-ID: <ff1a30f9-9b1c-8a7d-1bd0-0fa45f0d53f3@linaro.org>
Date: Fri, 22 Sep 2023 20:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] intel_iommu: Fix shadow local variables on "size"
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230922160410.138786-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922160410.138786-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 22/9/23 18:04, Peter Xu wrote:
> This patch fixes the warning of shadowed local variable:
> 
> ../hw/i386/intel_iommu.c: In function ‘vtd_address_space_unmap’:
> ../hw/i386/intel_iommu.c:3773:18: warning: declaration of ‘size’ shadows a previous local [-Wshadow=compatible-local]
>   3773 |         uint64_t size = mask + 1;
>        |                  ^~~~
> ../hw/i386/intel_iommu.c:3747:12: note: shadowed declaration is here
>   3747 |     hwaddr size, remain;
>        |            ^~~~
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


