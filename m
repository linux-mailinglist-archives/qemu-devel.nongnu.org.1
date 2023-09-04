Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B6791915
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9us-0002MB-Pi; Mon, 04 Sep 2023 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9ud-0002Le-AQ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:46:43 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9ua-0004jW-T4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:46:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1949902a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693835199; x=1694439999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fPvaJPFVBpM2rTDHekNU1+xDkQWhPcj+1om5P1ebX5U=;
 b=efGA650s7uO17x5spO9Ul3xB7nmZGVSUDVieXK7Y0LlfTf5AADeSfWTqHVE27805XB
 Wlkbr9MJ8/ZXYcUA8NkJZi4SpFtugIfD3LkXcJ514D1v6wqzZSlYo8hZ7Dc1seuM9AwN
 u1LVusSFoMFSsWJ6hdtzoUXtnY3nAB2HnUfxYvbEExQhZ9nL2mNwwtIuMRZaiWV80v27
 6ViqTlt6RGhHkw9DravZGDOihk0boB88lqRtLE9t5dNEYbV9+Wzgks/9WNKyfh+Q9Zvf
 VC52svCD+sq38D5koe+f/9uySFA/2obvh5GHgNkLWMz9MuNpAai0WfuROslbNWoyt15O
 R5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693835199; x=1694439999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPvaJPFVBpM2rTDHekNU1+xDkQWhPcj+1om5P1ebX5U=;
 b=Cj/xScO1tAxDSqcU/oeMHddgcK3wTJQyuKFHfObSWfjIbfkBKMllKIkd83fCDbZzR2
 UVZ0vpMeJa3Lt7Qabqg7XJkMJMbfm0sCFO0bAFOhdqK0t7JliNjHHHQGschkI0/Y9pjq
 dDtKJzMIDPTG0GlrHEQLeNLb4GmXErawFjhEerTUaTbzIPoj96904+G1jgrto8KJEJS6
 9WPixRciiTLod1SZUnWco1Lb+slh3B3RC4GmyVhZklmTtxFVRybE2aQGogPEmlaLwsWA
 B0kD2S6CjAPF0x/JzTMjVnFg4VXEgrGsJNwqTKClGOgQx9H0ph9uq5x21zTH86WOqjYT
 AHyw==
X-Gm-Message-State: AOJu0YyH6EiijcgCiD/6Dr3Gy+me6mB/GfHv+lpD6l6jSmS+K8igxB1I
 aQHDKapNzBieRFtGZJU2JJTJsQ==
X-Google-Smtp-Source: AGHT+IGPsJmFzFzg8M3jmQ4yBjnho2pweXGuDIIFXtx3fiLE1YUJh+QvDAfFY0GBivkkHqskkMDwgw==
X-Received: by 2002:a17:906:738c:b0:9a2:ecd:d962 with SMTP id
 f12-20020a170906738c00b009a20ecdd962mr7271120ejl.4.1693835199538; 
 Mon, 04 Sep 2023 06:46:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 gj17-20020a170906e11100b0098921e1b064sm6195235ejb.181.2023.09.04.06.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:46:38 -0700 (PDT)
Message-ID: <6661927c-d054-5747-3ceb-c2c88fb01265@linaro.org>
Date: Mon, 4 Sep 2023 15:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 4/4] docs/cxl: Change to lowercase as others
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> Using the same style as elsewhere for topology / topo
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Link: https://lore.kernel.org/r/20230519085802.2106900-2-lizhijian@cn.fujitsu.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   docs/system/devices/cxl.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


