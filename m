Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0287378D6D0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMkR-00074b-2k; Wed, 30 Aug 2023 11:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMkP-00073u-FN
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMkN-0003Rm-8U
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:04:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso4543089f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407882; x=1694012682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/r0wr0aqRF2FoJX6EniN6nRRKTmFdKaHmNsYHmdWLF4=;
 b=mryhUgXf7HKDdRQ/qAiGddEKVMh7ucueuX56KhkyJcGa6WHH9/+LFuxSQn7Dvgv8hu
 37sD8UuTzrqML9inzsrf+81T6C6BQMll9WcNbdvXOfHh3+MlMe8SfIDOFXbkofxluH+0
 8UbdIDMYxsfkXTYdbTjYtAuDF382wH6epfWQkpe1aMGCtRpV/rwa/viXDfZrLkdBa/Y2
 FZH2rd3zWnFwSePWwEQJuNUzvTkDh/L5FMrnMwSyZRV3mJrAvchWzuYwx5DpWyRxtx+o
 G+uUFtOCdOuqUqjoOyvXJb5lUz/5d1EVXhPEY88Rdkid+8HXG/Dba2eNpgHRMC63E6gv
 ofLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407882; x=1694012682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/r0wr0aqRF2FoJX6EniN6nRRKTmFdKaHmNsYHmdWLF4=;
 b=DeDC54IhDivvC6V+hPA1LXHZvbZv0HjKrcygO7rqIBuDytY54C9zwdc7TyTpa8LKLl
 HMe2QbCx/+oFjy95r0I4tBrOgZv1A22N+1i+wZsH4ByAkkAjA5CnYY1HmRklgSt+qdAT
 YXufFp6F626uCRju6UliviqMt5LsTc2Ul+iNM37ERjyep2klmMxWvAuYmHbNtlQ2oZjQ
 n0ZLvsMeg64ryphIfPbfvsw+wTV6FQ5kYBfb0tg6QncaMXCpHu//MDKJEOPfHAQzAy1r
 WMgQsap45+/RhnUuUI6DLBFZxaSfd6gVGaII+g9s2hhkItGGmi6FYSFKU80NKzIVmA/E
 mWtA==
X-Gm-Message-State: AOJu0YwixAokp1I5aSKohJLHnDON+iyqqYbCpAuEJttFjlTj517OqptF
 o8a6oNkRiryRIYfFC+lAQDW7VA==
X-Google-Smtp-Source: AGHT+IFkyCcPpszop1l4pVClObyA1rC0U4SC6ngBxW7gQieP61dF4LO4koImAidkYq7FcUm9kebabQ==
X-Received: by 2002:adf:eec1:0:b0:314:1ce9:3c86 with SMTP id
 a1-20020adfeec1000000b003141ce93c86mr2026630wrp.0.1693407881886; 
 Wed, 30 Aug 2023 08:04:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b003179b3fd837sm16913303wrh.33.2023.08.30.08.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:04:41 -0700 (PDT)
Message-ID: <6c12069e-da31-9758-4972-7121ab5ffdee@linaro.org>
Date: Wed, 30 Aug 2023 17:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/7] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230827182937.146450-3-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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
> In the vhost_user_set_vring_addr() function, we calculate
> "reply_supported" unconditionally, even though we'll only need it if
> "wait_for_reply" is also true.
> 
> Restrict the scope of "reply_supported" to the minimum.
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
>   hw/virtio/vhost-user.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


