Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D17414F4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEX6o-0006uM-GL; Wed, 28 Jun 2023 11:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEX6l-0006ba-Kq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEX6j-0005MT-BU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:29:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fba66f3b14so147375e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687966164; x=1690558164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vrv3fLjtHODPQjbHDZAG2iddRLY4RTSPDAIa4x08/44=;
 b=hVXeYtrmlZfygcd8KTh2eXc7a0Xi6A9nX55goWwOuoKErRnWFaATvaozWLBbeHbjk8
 p4pvabayOJQLSwG7/mj6eDz4H9CtlUSi0PxErAYx7bc1+U7k6IM9YrMKrhQ0wGIBLn08
 dMZ7KeHYgG2DPn4Q8SxV4jzIuY1/MZ10m2VAdfDKR+Fxq1BAm94solNhTO3XXmKdkBo1
 Sudh6mAKvQg8UisSyhYEuN79pp6ScWJqTdCtYuI641lERtA66YjfxOxiOYWKYKosvsXW
 sMWYhVj/RjaWZJRRBw6uMqC49Xql+p2gKfKxoklLUxREpfpkrmNJ4OHPw1l77H4lbBut
 CaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687966164; x=1690558164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vrv3fLjtHODPQjbHDZAG2iddRLY4RTSPDAIa4x08/44=;
 b=ZPlTlAnyHJO/pKR6Nn6OvHNuLnsC1hHl9W37PM9YoUu16iREtUBBUA2czyaWJBOj3d
 v+jmarqeeQz0tydRQnpC+WXZFEmVrQqPOHdBPT2MWSDl5xOPfFR+9rAnT460PGubLU5O
 FcI98vaQw34EEk/Us6AoF5ESXhwU8OqWdcHZ1WmIY+OZs+rNU44YyrYel/ni/GDX62sX
 mulfReWFS6iGLjc7BRrAANKRodxuuK/jvn4QweVKHaPgvyzMFwb0LPs/5LCmwGjfEu+n
 U3k6skkxqCeMqzx5AWaFEWU5VwiUBpGDdr1AGmavprmwiCR26itZ9PoDKLY63H3fA3WL
 8DLw==
X-Gm-Message-State: AC+VfDzicpFmLy4b3gnk39ZAyJCJR3sKfG5tjDqPI4NPgO9Q8KKgqjVo
 R5SpJkpkX/L9QexbCcUrjCxOiw==
X-Google-Smtp-Source: ACHHUZ6WVEfv0SCBbRU+Q3YxQn6YgN2LN/R1Q68PkmDFFWCrVkEy/oRwTdN+Jes3jQB4xFGD39BBvw==
X-Received: by 2002:a5d:53c2:0:b0:313:e03c:292a with SMTP id
 a2-20020a5d53c2000000b00313e03c292amr11096703wrw.61.1687966163746; 
 Wed, 28 Jun 2023 08:29:23 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 s7-20020adfeb07000000b0030ae901bc54sm13543010wrn.62.2023.06.28.08.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 08:29:23 -0700 (PDT)
Message-ID: <475b00f2-3fd0-ba96-9c65-4103a97497ef@linaro.org>
Date: Wed, 28 Jun 2023 17:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/1] virtio: regression fix
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1687952477.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1687952477.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/28/23 13:41, Michael S. Tsirkin wrote:
> The following changes since commit a0d7215e339b61c7d7a7b3fcf754954d80d93eb8:
> 
>    vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present (2023-06-26 09:50:00 -0400)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 0585e97f070014265e5ec3b28d27dcb963cde25b:
> 
>    net/vhost-net: do not assert on null pointer return from tap_get_vhost_net() (2023-06-28 07:38:59 -0400)
> 
> ----------------------------------------------------------------
> virtio: regression fix
> 
> A regression was introduced in the last pull request. Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


