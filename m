Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACB7D5420
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvISK-0005OD-C6; Tue, 24 Oct 2023 10:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvISG-0005Jq-PW
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:32:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvISE-0001lG-7j
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:32:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso26527555e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698157940; x=1698762740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8ASkYfBT83DzI2Y3E+QUpM/rSYztNN2Dn3OWclTYnN8=;
 b=i2hxsyDbqkWUmR1lmhiwMWLRXMoO1V0dSB/1jddTnKEKwMaiG6cC9BtTWFArne4BcS
 +JQsKQYTk2D8lnUtYSPK2Q1IZpivGeMlk8s7KCuU+6qfSwE8Jo0mTPt7jXpAix4I9/OH
 5B+CdtV1ohEXXv4VPXLAz9bWWcPs9FlNdZOH3bccGRwHkR5Nj1jeArzLQZIO+aahU82O
 AFLL/tKDRicDy0vGqyZzID1Tob3MycXymN+VykS3mNmGEOtuqaOFJ1zH69c/4LbBZFg4
 DNlKy3a+ssqqQcWOMGZnjC6slMNAbPufo8Aon562a6RrxUO79y95r9We7mlJCMLG2x0+
 hBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698157940; x=1698762740;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ASkYfBT83DzI2Y3E+QUpM/rSYztNN2Dn3OWclTYnN8=;
 b=irKvFU4XV0Hhk6YynCUcWP9VgglgLNAnax2NS1CWavE8tCnvpVHHt1VanU1iZhqD06
 DMxUtXlKGLNducTBfVeFisshhR/qtxZ2f6j8JD2lvdPZ0mEl8W56HGHl0xmvG7pFU5+K
 ygRVypkPgw0BL6ls26AzEn++wx0J223stp9XCTbDLX/f+5rSp5uC14vophx6593of1Gh
 x56J8CusrYD6UHCE6nc16y4ZcteVmRjkj/+9bYmmHKJhAwOoDkKAL/aOqUJOq6ss2Dr8
 v96tavBAv6YbNjCsTnw7UKC34+BVn5ijoGrjDTTrWlrqMslAfYoBxcb6t8J5iREtJix5
 IHMg==
X-Gm-Message-State: AOJu0YyXzeMmji8Wk0HqqkcYfMMCd/BRIjnqMr4LQL6rCzF37e+APkXZ
 UuIyZdFqALCpKfW1DgxOKzM=
X-Google-Smtp-Source: AGHT+IH3S3oghRgfgbsQqo86KSVXvTtoeL3gUJvVrDNxZr+FihJ6lz9hqg6acdcxsulSLEku5uUYmA==
X-Received: by 2002:a05:600c:154c:b0:408:3634:b81e with SMTP id
 f12-20020a05600c154c00b004083634b81emr11099647wmg.13.1698157940248; 
 Tue, 24 Oct 2023 07:32:20 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c314c00b004068def185asm2868465wmo.28.2023.10.24.07.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 07:32:19 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <1408fb32-3d91-4eb2-b0e7-4eba0f449906@xen.org>
Date: Tue, 24 Oct 2023 15:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/xen: only remove peers of PCI NICs on unplug
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Jason Wang
 <jasowang@redhat.com>, xen-devel@lists.xenproject.org
References: <20231017182545.97973-1-dwmw2@infradead.org>
 <20231017182545.97973-2-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231017182545.97973-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x332.google.com
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

On 17/10/2023 19:25, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When the Xen guest asks to unplug *emulated* NICs, it's kind of unhelpful
> also to unplug the peer of the *Xen* PV NIC.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/xen/xen_platform.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 17457ff3de..e2dd1b536a 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -140,9 +140,14 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
>   /* Remove the peer of the NIC device. Normally, this would be a tap device. */
>   static void del_nic_peer(NICState *nic, void *opaque)
>   {
> -    NetClientState *nc;
> +    NetClientState *nc = qemu_get_queue(nic);
> +    ObjectClass *klass = module_object_class_by_name(nc->model);
> +
> +    /* Only delete peers of PCI NICs that we're about to delete */
> +    if (!klass || !object_class_dynamic_cast(klass, TYPE_PCI_DEVICE)) {

Would it not be better to test for object_class_dynamic_cast(klass, 
TYPE_XEN_DEVICE)?

   Paul

> +        return;
> +    }
>   
> -    nc = qemu_get_queue(nic);
>       if (nc->peer)
>           qemu_del_net_client(nc->peer);
>   }


