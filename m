Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A981AFD2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:52:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDpL-0005yk-A7; Thu, 21 Dec 2023 02:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGDpH-0005yF-8D
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:50:39 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGDpD-0006qG-6a
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:50:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d408c2908cso457095ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703145033; x=1703749833;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLUNEaNazWElk5LNvSjgKYQHnJmPtc7ll3wR32irQhE=;
 b=0VVK1fq+yluENwlCjtH7vAngBc4Ka/pLHxerYjZdH081HxQWGp8re9SFIsXNNwWcKa
 1EvMZAZVJghnW+f9p4Z/JMuxUdyacAorOq5/G9qzXT5nbaTFFBRHoNAC3mJC4OzdotJr
 DNfVqcQUaTDQEeYstWDdX2SDs9aZPJxzmP2LqGRjW61QUuTO9vQiR6JgbkiRMemd3vV5
 yCfNSW/+Ji+L/wlWj34jYI1Fb6TDe/x9ISDwvPc8dNGgL11Fe47oHWBmavlHFvR66AEL
 25F+PsiRC2RiO2cU/pAlmsLm+iGNH/ydjeiDUzJyVHTAj5mL8bJYFJAJXRzEMMgEJaL/
 FS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703145033; x=1703749833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLUNEaNazWElk5LNvSjgKYQHnJmPtc7ll3wR32irQhE=;
 b=GMf8RQUpw4XtLr4vBRAPP+wOFAMka+1WBIK1VoBln6C5l36u3I4IKY7INhvJNF6RtH
 iRzXikUYZG3p5CxwCrCX8+B7IlKtZI6uFM3RC63acqp0Xslyp/fgmN96PK5w80H/qt1s
 KR8xIvNuRE++fonLa8Dwwk+g2kBjhiJNn00AKAxCx5DksPnSrqRWr5crn35yyEzsChp+
 6JBqBJVtkKhdwSugh5pBmdy20ZwnirZj1aLiWFuvrwWVs4d3PzYCLH/haUf659TtSlWr
 5JMjztjUOYgZTpS2V7hvlaBuXcI6ozhQbl3awQeKBCU7ttZgyzE9RsDyvF77gBYjbzIu
 /t9g==
X-Gm-Message-State: AOJu0YwLMcZ99aAZrpPADRJV7rq6VQ02SppFYinc2awyfUKzGbURlFm0
 dVc2Xz5tJBVx27u/Vn6/ov+3vA==
X-Google-Smtp-Source: AGHT+IFRkKA+vhyi+S3UFsA8cjOfaflfAeEhCaGNiKFgvhAVyfdCpal5yYhxJ1UkT7WFGCcLiHX3CA==
X-Received: by 2002:a17:902:ea05:b0:1d3:bb5b:c51 with SMTP id
 s5-20020a170902ea0500b001d3bb5b0c51mr5088668plg.72.1703145033585; 
 Wed, 20 Dec 2023 23:50:33 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a170902c19500b001d0c3328a63sm972461pld.66.2023.12.20.23.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:50:33 -0800 (PST)
Message-ID: <9fb98128-eada-4a50-996e-b442ce8035cd@daynix.com>
Date: Thu, 21 Dec 2023 16:50:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] softmmu/memory: enable automatic deallocation of
 memory regions
To: Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui
 <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-7-ray.huang@amd.com>
 <a88696bc-2ffe-442a-a171-50e6120bbf97@daynix.com>
 <5dd37851-0b68-45ae-9843-9c1d6dc078f9@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5dd37851-0b68-45ae-9843-9c1d6dc078f9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/21 16:35, Xenia Ragiadakou wrote:
> 
> On 21/12/23 07:45, Akihiko Odaki wrote:
>> On 2023/12/19 16:53, Huang Rui wrote:
>>> From: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>>>
>>> When the memory region has a different life-cycle from that of her 
>>> parent,
>>> could be automatically released, once has been unparent and once all 
>>> of her
>>> references have gone away, via the object's free callback.
>>>
>>> However, currently, the address space subsystem keeps references to the
>>> memory region without first incrementing its object's reference count.
>>> As a result, the automatic deallocation of the object, not taking into
>>> account those references, results in use-after-free memory corruption.
>>>
>>> More specifically, reference to the memory region is kept in flatview
>>> ranges. If the reference count of the memory region is not incremented,
>>> flatview_destroy(), that is asynchronous, may be called after memory
>>> region's destruction. If the reference count of the memory region is
>>> incremented, memory region's destruction will take place after
>>> flatview_destroy() has released its references.
>>>
>>> This patch increases the reference count of an owned memory region 
>>> object
>>> on each memory_region_ref() and decreases it on each 
>>> memory_region_unref().
>>
>> Why not pass the memory region itself as the owner parameter of 
>> memory_region_init_ram_ptr()?
> 
> Hmm, in that case, how will it be guaranteed that the VirtIOGPU won't 
> disappear while the memory region is still in use?

You can object_ref() when you do memory_region_init_ram_ptr() and 
object_unref() when the memory region is being destroyed.

