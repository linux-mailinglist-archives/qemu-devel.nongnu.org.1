Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D625878BB2B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qal3b-0000FC-TZ; Mon, 28 Aug 2023 18:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal3Z-0000Ep-Gb
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:50:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qal3X-0002OA-7x
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 18:50:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c6d17aec4so3160357f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693262997; x=1693867797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XFDUspoV1/Mj16fdEh9vaVHWbiuEgFkZxHG+xGtQeno=;
 b=GjNPXUPzy/WII87i0opQupAuVZfU1Apd7tPwC8C496gguhMFEJahuFPACVv/VZM8lx
 4FfGL6vYI6AdzfNrzaRP2JJUdAGuNFKsluHeUHe8yq6I3bZI6VqyaXlQAWBfQhzivhnd
 bloLwFG7pPPgPLDS2WXvKSpxWxTCP2/eYtuizrly4ehdAe5rDycOytz1XVvBKzqGGnnO
 1SoGvzDcuJGTp+4vESkIaz5V11+g83K4TaKxB9pehOsacRBpPkCHRAP9FB48LuCnty8E
 Az1FUW50feR9fvCxHtFottZ/t1xNrqjYA3amW2R5jfrE1brEc/tK16m6mf7jJTCWJaDR
 cMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693262997; x=1693867797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XFDUspoV1/Mj16fdEh9vaVHWbiuEgFkZxHG+xGtQeno=;
 b=l6Dr463iPFoRyFy8TtpV7EcI+wuSK/1IRAbqcHdEHgRs3/LV0t5PS1LBTmnhrJQX0b
 dIMcMaCsgQSf9tegnXfdWJimUSFZ/yM4r6+wvpUJujEHkJVrYNwzXNg7UPMkH2helwP6
 4JjxKzJhaQ9rrO8G510fSXn9ZYPR5qE1NQMapjKNyaG/5+g+uj+JQAP/z714J4X6Bpx/
 qT22Z5stIdJHOR9Su09HJ4LkPr6f+Fc4yXL3VSkOdulYcfF+E2j6e3TnakkPoMWyVuvw
 uzA7lRpLly81OyD9aP0nRe7XKPjFRecazFhFXqC/YzkdkKdPutICwas+KqC7yvuqbFyc
 a1JQ==
X-Gm-Message-State: AOJu0YyYIx+EwE+Fx7JFpz5lVSTqd7iVKVPiUpQ8DQDJR+qxXYorc2if
 3KzJw0iE7Idxi83Krv6BdYeDGA==
X-Google-Smtp-Source: AGHT+IFix0Ni/X8chlqqnZSzB/I4GczCkq3vVIi5gnvLPCYHAxi9oB5AX10U5rslhwfACFn6iuxCKw==
X-Received: by 2002:a5d:4146:0:b0:319:8444:939f with SMTP id
 c6-20020a5d4146000000b003198444939fmr21711110wrq.32.1693262997615; 
 Mon, 28 Aug 2023 15:49:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a056000118500b00317b063590fsm11849948wrx.55.2023.08.28.15.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 15:49:57 -0700 (PDT)
Message-ID: <1d0c927d-3b75-a307-cf05-a4236c7decf5@linaro.org>
Date: Tue, 29 Aug 2023 00:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 6/7] vhost-user: allow "vhost_set_vring" to wait for a
 reply
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-7-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-7-lersek@redhat.com>
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
> The "vhost_set_vring" function already centralizes the common parts of
> "vhost_user_set_vring_num", "vhost_user_set_vring_base" and
> "vhost_user_set_vring_enable". We'll want to allow some of those callers
> to wait for a reply.
> 
> Therefore, rebase "vhost_set_vring" from just "vhost_user_write" to
> "vhost_user_write_msg", exposing the "wait_for_reply" parameter.
> 
> This is purely refactoring -- there is no observable change. That's
> because:
> 
> - all three callers pass in "false" for "wait_for_reply", which disables
>    all logic in "vhost_user_write_msg" except the call to
>    "vhost_user_write";
> 
> - the fds=NULL and fd_num=0 arguments of the original "vhost_user_write"
>    call inside "vhost_set_vring" are hard-coded within
>    "vhost_user_write_msg".
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


