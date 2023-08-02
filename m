Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 306EF76D94F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJCr-00034N-Af; Wed, 02 Aug 2023 17:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJCp-00033K-Dh
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:16:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJCn-0003BA-Rn
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:16:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso254384f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691010988; x=1691615788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DWOOT9KwsP+cYX9+/EIsuHGmQPEQXG0TqA2IY36m8mo=;
 b=VQ6klePfl5UShTHshcCxVlqXxBhlePXMJu8rAqkPNZvT9tnHpY7DRM4P0473e4sPQl
 tU+4gXm+JojcoRAKuEJ/QQpzKL0wI2N4k3q0Cd5Seqxf/Qz6+6DjXlHzYrTGbJVkHyfB
 xITVic6CzcAgcQDPYU9MVVz9NBZ3kE4okcjjxRrv5kjbH5DUhVI5GYLtadkDITyt4KCG
 xhiWOBcjfaetWi1abhIme9j/rBInaAzi8JcegrOFBmgJK3DCDc2mzN0SMOUlwANT0emM
 MdBB1DpqRdEc99l0Hq8n4lqcTtrdsMX1isAkyzVYZn3nQxZDGYxDIpddlGbp1glLju7+
 PXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010988; x=1691615788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWOOT9KwsP+cYX9+/EIsuHGmQPEQXG0TqA2IY36m8mo=;
 b=EV/8AYyf2K6QPYbKyFw3EtNTm3ABr/C/1Xxy9s0ZQUaCKeiLrJmjUxJT8dKxT5avG5
 GeJ2a03IPFOTbrYMwjz3RSYQewrpkPv77utDT+Ivz0Jyoifyr5mZ5zzvSYVuSMjxEKT6
 rJpB5PogICSgKr7HCO00yT1uEx4BQsfZVtTdUc3EC7y5gI7RJ8sQZHNfu0n0w58jn253
 I+V09kYTPzS8T+P7fO+HZfwgt0ZJcoV5PGjbqSrExo8/J6OoZPgkVj6rKIR+N8JWMHz5
 HWX+1lVnh22MpXWKHrQkia3fJ0rIWqfZLTauxZuvUQoBwN4Ztg1u0gDy3p5yMPfcrEHz
 zajg==
X-Gm-Message-State: ABy/qLZz0RMo+GhJyEi/adO960q5CacUPcW/Aox5S8FBJlpx6kmTqlqh
 NcvnmoXetrhO/DCm4rJqbvHqvg==
X-Google-Smtp-Source: APBJJlHO7TFS1qA8xmWO22eX7aIwo0zi/G63cGyMPLPEXQ+qD+HHOZX0T+WY5AN9PpsmQ43MfncxJw==
X-Received: by 2002:adf:facc:0:b0:317:7081:9a6a with SMTP id
 a12-20020adffacc000000b0031770819a6amr5598694wrs.24.1691010988200; 
 Wed, 02 Aug 2023 14:16:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 n7-20020adffe07000000b0031274a184d5sm19981891wrr.109.2023.08.02.14.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:16:27 -0700 (PDT)
Message-ID: <b19594b1-5dea-e633-4b9b-ff06f538141f@linaro.org>
Date: Wed, 2 Aug 2023 23:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big
 endian hosts
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
 <20230802135723.178083-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802135723.178083-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 15:57, Thomas Huth wrote:
> On big endian hosts, we need to reverse the bitfield order in the
> struct VTDInvDescIEC, just like it is already done for the other
> bitfields in the various structs of the intel-iommu device.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h | 9 +++++++++
>   1 file changed, 9 insertions(+)

Isn't it a bit hacky? Bitfields can be accessed in a portable
way using the deposit/extract API, right?

