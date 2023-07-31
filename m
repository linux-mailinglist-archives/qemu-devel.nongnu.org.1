Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A57696FF
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSW5-00082i-2U; Mon, 31 Jul 2023 09:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQSVt-0007tR-0x
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qQSVr-00005w-CF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690808438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHnF+sy+d3zFQbgHmPB9jYr/hDJRe+YhEB6Mqx1kcUQ=;
 b=U50li3uhIMHTVgl0KQKqTNCSLpUWUyMS8lVgpyIc1fzyZ7pPJkiJehFOW7L7hmyrlxsDdO
 hGRpP+qGnzETSN5Ls6B4JTz839x05vhqqnn+z+pWIc5m5ImuEZAojyuQOKGawzdLgAykaF
 gzAU+pbF5fUTHf/gYmFhyZ7rSHOTqy0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-y_rKht7QPY-P_cyCgv8h5Q-1; Mon, 31 Jul 2023 09:00:35 -0400
X-MC-Unique: y_rKht7QPY-P_cyCgv8h5Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe13f529f5so16548605e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690808434; x=1691413234;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHnF+sy+d3zFQbgHmPB9jYr/hDJRe+YhEB6Mqx1kcUQ=;
 b=aMvDsGA/mp9NUjj9ytq2MLrh1VWcUtppktHh7tmbTJv2iRXicI7X6aQ0YIaUi7xOhs
 SMf6tQK04IXv/DmY28PYBtgD71Ks90oF+iDKIayr6Kox+0h+TNMsgJL7NKONXqEb2p22
 6DmmUEV7XguIyzmZnxaueKVz8stfKXI518xU9jUe/He7+Xs4dYOxTfWK/MxlHedvw0cu
 6IIFekZu15uTU4K79T5e3ezCx0Wib83Ba8bqeURTTLdt9rLgv9gcijLG9CZe5Ot3FT1i
 D1lzTrpQhY/QhAe5x0Dtt5b62DifItMAk5Sn2KiAse2E9wWXeo4SUf30zoDtchtOuxqK
 o8AA==
X-Gm-Message-State: ABy/qLYlxM9gpAnMHgGGzjCHqkJZnH0o5EF9CtUdd9oNBCkSnCBrf4S9
 Ksmnhqiq5NxxcOvs+Vy4vvQmSYmtI13lZKwmZtsLOpyyurbY3+HQozTzNF1ZnVuFkT2Vx9DSjl6
 bmb7p5e1FxC+jch4=
X-Received: by 2002:a1c:f202:0:b0:3fb:a0fc:1ba1 with SMTP id
 s2-20020a1cf202000000b003fba0fc1ba1mr8373853wmc.35.1690808433999; 
 Mon, 31 Jul 2023 06:00:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJs4d0JSubOVy3i34droRuNIImJOF0Y8wJ8e4yOlX/w0GH2xoMVbGt2dZybU/OHJgkT7pGPg==
X-Received: by 2002:a1c:f202:0:b0:3fb:a0fc:1ba1 with SMTP id
 s2-20020a1cf202000000b003fba0fc1ba1mr8373833wmc.35.1690808433548; 
 Mon, 31 Jul 2023 06:00:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3?
 (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de.
 [2003:cb:c723:4c00:5c85:5575:c321:cea3])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c230900b003fbe561f6a3sm14139827wmo.37.2023.07.31.06.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:00:33 -0700 (PDT)
Message-ID: <008f4ae2-c5bb-3570-3ec9-4ace4b5c4788@redhat.com>
Date: Mon, 31 Jul 2023 15:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] kvm: Fix crash due to access uninitialized kvm_state
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, shan.gavin@gmail.com
References: <20230731125946.2038742-1-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230731125946.2038742-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31.07.23 14:59, Gavin Shan wrote:
> Runs into core dump on arm64 and the backtrace extracted from the
> core dump is shown as below. It's caused by accessing uninitialized
> @kvm_state in kvm_flush_coalesced_mmio_buffer() due to commit 176d073029
> ("hw/arm/virt: Use machine_memory_devices_init()"), where the machine's
> memory region is added earlier than before.
> 
>      main
>      qemu_init
>      configure_accelerators
>      qemu_opts_foreach
>      do_configure_accelerator
>      accel_init_machine
>      kvm_init
>      virt_kvm_type
>      virt_set_memmap
>      machine_memory_devices_init
>      memory_region_add_subregion
>      memory_region_add_subregion_common
>      memory_region_update_container_subregions
>      memory_region_transaction_begin
>      qemu_flush_coalesced_mmio_buffer
>      kvm_flush_coalesced_mmio_buffer
> 
> Fix it by bailing early in kvm_flush_coalesced_mmio_buffer() on the
> uninitialized @kvm_state. With this applied, no crash is observed on
> arm64.
> 
> Fixes: 176d073029 ("hw/arm/virt: Use machine_memory_devices_init()")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Bail early in kvm_flush_coalesced_mmio_buffer() on the uninitialized
>      @kvm_state and improved changelog        (David/Peter)
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 373d876c05..7b3da8dc3a 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2812,7 +2812,7 @@ void kvm_flush_coalesced_mmio_buffer(void)
>   {
>       KVMState *s = kvm_state;
>   
> -    if (s->coalesced_flush_in_progress) {
> +    if (!s || s->coalesced_flush_in_progress) {
>           return;
>       }
>   

Thanks Gavin!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


