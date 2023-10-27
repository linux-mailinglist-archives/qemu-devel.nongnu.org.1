Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1E7D9284
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwISP-0006d6-Ly; Fri, 27 Oct 2023 04:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwISN-0006cl-W2; Fri, 27 Oct 2023 04:44:40 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwISM-0001wz-Bj; Fri, 27 Oct 2023 04:44:39 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so27470881fa.1; 
 Fri, 27 Oct 2023 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698396276; x=1699001076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tNlTPL/h1q0gctttAApwRF+1wbJdOYFnWGSZhWSB3FY=;
 b=fna1YlTbNsN04ZumvnmzMB0YektH6xWRwIzYKx8pdKlTR3feNcYjrZFdyqz260CvqX
 eu87jWjGShNbFRDk4hSS9cvTYWY9ENeP7nqoc/6YJIxnqlCqMa4vDb2AItv2F9Xc3hlO
 Tl5rShjQ3U3fkm7xjUx4nAC37OS14U85wOZiNS4gvtWx1ULJone9RJA0hd036EQx5TyL
 cB/3PeUDz5YZZj4uAmv/kkSdlDstxE6SYz1XlSm/ZxHrBL5GpTCu3IO37ivo7vqcCiXU
 hRWMYnKYpihj15+U7lG8WnBnpCKcDwOFGiCAV4CjlggXGCtuOXYDdynBcXgmr39x9iTD
 CyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698396276; x=1699001076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNlTPL/h1q0gctttAApwRF+1wbJdOYFnWGSZhWSB3FY=;
 b=SZqFI0xC99Av7BDC0F3lnJYSlaCNIMFWjRx8B8jP5GivuRkUJ4DNxOrTwjXziYJgSe
 YjY0HhDR/013udSYISD17l+TjARzm+FsvJMzCOw+SrLdKFWG72DjoIgavqGAtgdT67cF
 hvS0YSF9sJwQOyxMNUCgb4yJlAXw6Y2bLMEqdd97EngGxRkq27RJneh57QClcYM/9IbD
 PCaVHX76uO4vJ9Fr89IIZ6rwosIn3VJdcC3SEul0UF4+CLd+ziZnjrlgSBrvBNCk1hJh
 S7m+VK2ANGEkbJyyNu5MNuM6SATJxtLPi7O2GaGohOM1K9VxTCh6g7xvIxEANoIXTGEF
 TvGw==
X-Gm-Message-State: AOJu0YwZNjHx+ocsDZAGGnV7keHDsi2VOJCuF04KswUVd7x77Nup1pmR
 iCeE82V0ExfNXj9NnYsA/MY=
X-Google-Smtp-Source: AGHT+IGDgLtfXBaR32xR7jkwm7OjIsXKvGrggAwxMX3BfT7FEKsGbWVQFL/Ib+4ohIFSlDse9DRe/w==
X-Received: by 2002:a19:6d03:0:b0:507:c763:27a5 with SMTP id
 i3-20020a196d03000000b00507c76327a5mr1182175lfc.62.1698396275565; 
 Fri, 27 Oct 2023 01:44:35 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a5d6704000000b0032dde679398sm1276365wru.8.2023.10.27.01.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:44:35 -0700 (PDT)
Message-ID: <db350375-9bb3-4ae7-bd2b-7bcce9974577@gmail.com>
Date: Fri, 27 Oct 2023 09:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/28] net: do not delete nics in net_cleanup()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-21-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-21-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> In net_cleanup() we only need to delete the netdevs, as those may have
> state which outlives Qemu when it exits, and thus may actually need to
> be cleaned up on exit.
> 
> The nics, on the other hand, are owned by the device which created them.
> Most devices don't bother to clean up on exit because they don't have
> any state which will outlive Qemu... but XenBus devices do need to clean
> up their nodes in XenStore, and do have an exit handler to delete them.
> 
> When the XenBus exit handler destroys the xen-net-device, it attempts
> to delete its nic after net_cleanup() had already done so. And crashes.
> 
> Fix this by only deleting netdevs as we walk the list. As the comment
> notes, we can't use QTAILQ_FOREACH_SAFE() as each deletion may remove
> *multiple* entries, including the "safely" saved 'next' pointer. But
> we can store the *previous* entry, since nics are safe.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   net/net.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


