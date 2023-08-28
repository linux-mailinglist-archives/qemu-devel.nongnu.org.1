Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA378BB25
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qal0R-0005r0-Cr; Mon, 28 Aug 2023 18:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal0O-0005qh-Fz
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:46:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal0M-0001uq-99
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:46:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso3358108f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693262800; x=1693867600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hy3QYk/tXy019tktPNoLIOreLksxwxhXzgTUVAQ9BL4=;
 b=YLubugl3634x/43RoWkY3HnDR6Wm7ON/5pxdExQEtzu2zQpvED0tmPcXbXFQ39wNwV
 elU6jR7wbUWIqm1KC3Br3cZ1zG3r8UVJXbQSQyoaBZ5xxg7ifSSLhB2WKT8LRoSMtxx7
 vmzKpyEo2IOAcQuIMcRS4YiC/5ysDd2+oYJcFYD281F2F5GG66uTcMuUhvg2WNIlnUqq
 /uolLEjDDdSrHBf3qNDxkeluu9garDhIj8UwWJmlJwfLh18Lo9Ac1LCUWRWfUQ+necwP
 cEWqR+3ifYyF7Cq/1t68fX5BQm1QDGGhWOzYZilBJxe6pyCDwuVwz0F//xw13fOwpcl+
 Lfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262800; x=1693867600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hy3QYk/tXy019tktPNoLIOreLksxwxhXzgTUVAQ9BL4=;
 b=lFk9xmjMKOeiSWc68l7ppozQ/rMg6KEVMUaJQd0P5xBCoaB/CfwMNbzkfExD/VJkux
 bf2vlB4+6TjxopAVzub25CICLuR6+dPl/iZYSuKXfNIwDQiLRpL1tvhqZJ/D5mh7TUHB
 3GPoohVwX86CFf3n9/o4OMGPCarldWS5vMcwyJyGQJ7qgpWPq8NOQbPsoI+73ShL+pze
 V4z38BnmnZafWmDdpkPhFGIQOs+Ak94jdByB1pjVQMzH9XZDPIDWVk8KE4h2RLfSNhFE
 9jzWbnCSB7ABL2mkRRRhEOIwgAuDZHgqDrnmmg/uqEQgDeulVxaZZGkl+wskFGtywa7n
 R5aQ==
X-Gm-Message-State: AOJu0Yw0sEJ3/6GajLgNYNNkfpuKmvBj8njsPGsdRlngsBK+bRBQO6z3
 pvFv2HOpFHa4UyuAR1P3H4XY9A==
X-Google-Smtp-Source: AGHT+IFCTiXaKN5h/6jTVrUjjy0gZiSMX0DOKHajIoES4aecCAOxGllXTUnawe0/U2XDpKWnpNHOLw==
X-Received: by 2002:adf:e710:0:b0:317:5849:c2e0 with SMTP id
 c16-20020adfe710000000b003175849c2e0mr23184686wrm.9.1693262800620; 
 Mon, 28 Aug 2023 15:46:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a056000118900b0031ad5fb5a0fsm11788616wrx.58.2023.08.28.15.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 15:46:40 -0700 (PDT)
Message-ID: <1851b13c-75bf-1b1c-18cc-a20818363728@linaro.org>
Date: Tue, 29 Aug 2023 00:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/7] vhost-user: factor out "vhost_user_write_msg"
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-4-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-4-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 27/8/23 20:29, Laszlo Ersek wrote:
> The tails of the "vhost_user_set_vring_addr" and "vhost_user_set_u64"
> functions are now byte-for-byte identical. Factor the common tail out to a
> new function called "vhost_user_write_msg".
> 
> This is purely refactoring -- no observable change.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 66 +++++++++-----------
>   1 file changed, 28 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


