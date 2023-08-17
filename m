Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC677F7A0
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcx4-0001Vd-OJ; Thu, 17 Aug 2023 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWcwv-0001Kl-Di
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWcwp-0002sN-6Q
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692278518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bra9B4FJKWtICGmHrk5b8nWh6aL8qPmXNxNWyq3Q5Qk=;
 b=f+4i54wv7Ld3TuD566Aa7y35XjmMVh0Oqypl5vrBsRHwZiFV5FFgk0Ne/qqDzROny+PEmb
 WAprhcnpzSNUlrlSidJ8VsS0myhBea5Sajxxnoxu+TZ8N0QGkgDrHB29VdFIamkqLXj2X5
 NB3NWDw04USaygtJBBwSZUF/1W6fgp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-MNODbSM6NDSs-wUo8JXocw-1; Thu, 17 Aug 2023 09:21:56 -0400
X-MC-Unique: MNODbSM6NDSs-wUo8JXocw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so49451265e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692278515; x=1692883315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bra9B4FJKWtICGmHrk5b8nWh6aL8qPmXNxNWyq3Q5Qk=;
 b=SO+GIYDgGbhh9r1wlgkJLxc2oADy2qGBW/YpznD54hJ/z+TyINGeQrChERbSWrP0/P
 ztR5POj20S0IuBNIelC8pl1MnoIPr2JSyPndFK9RWTKXppNwta3YLkJFrliSjRzTUADT
 hPPSNkhcPBnb+K3wY+KwvkLDCj0/yRGvELXlq0lBznZIQ5oc/DkiG9Tpl8ilLEya1f4l
 gx2XhXrYWagPk0+5+cSZQRHlOcynTcvaML9MwZrc6+qABPkB1PmdHl1APKAvqDGl99h1
 Qdvj8WmUkKRgxZNIVFweCWWEgGELn61rquc1760qrxYRRT4+lpKr3Ub1H/GtByiwo8JE
 OXAw==
X-Gm-Message-State: AOJu0YyU3mYDub/+iK8c5lWPH16NdMWOpra9wdsgK2hD9gPQTqwhy4g6
 Zprcnvl0MMD/n32XA1KujgeXfk0P2qFuq1HY+mYvfuybZ2FZjzQh2q7AjkmePp+6I4iTS/iuxTc
 rkhmDjIZU+bwX2zg=
X-Received: by 2002:adf:f7ca:0:b0:319:7ac6:5161 with SMTP id
 a10-20020adff7ca000000b003197ac65161mr4274929wrq.43.1692278515814; 
 Thu, 17 Aug 2023 06:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2NC714LTr43DNn+FGE0Rq/9NTNNI5VqXpmUhs+XnjsNZEITyU4MJjl3j5sTOLBdd9au3HUA==
X-Received: by 2002:adf:f7ca:0:b0:319:7ac6:5161 with SMTP id
 a10-20020adff7ca000000b003197ac65161mr4274909wrq.43.1692278515447; 
 Thu, 17 Aug 2023 06:21:55 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-113-156.web.vodafone.de.
 [109.42.113.156]) by smtp.gmail.com with ESMTPSA id
 b11-20020adfde0b000000b003197e3520ddsm11719544wrm.109.2023.08.17.06.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 06:21:54 -0700 (PDT)
Message-ID: <9e2a9dcf-c15a-8e64-aea9-a40c871cbc8c@redhat.com>
Date: Thu, 17 Aug 2023 15:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] qxl: don't assert() if device isn't yet initialized
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-stable <qemu-stable@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230814193331.375778-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230814193331.375778-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 14/08/2023 21.33, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> If the PCI BAR isn't yet mapped or was unmapped, QXL_IO_SET_MODE will
> assert(). Instead, report a guest bug and keep going.
> 
> This can be reproduced with:
> 
> cat << EOF | ./qemu-system-x86_64 -vga qxl -m 2048 -nodefaults -qtest stdio
> outl 0xcf8 0x8000101c
> outl 0xcfc 0xc000
> outl 0xcf8 0x80001001
> outl 0xcfc 0x01000000
> outl 0xc006 0x00
> EOF
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1829
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index f1c0eb7dfc..70b73820b2 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1591,7 +1591,10 @@ static void qxl_set_mode(PCIQXLDevice *d, unsigned int modenr, int loadvm)
>       }
>   
>       d->guest_slots[0].slot = slot;
> -    assert(qxl_add_memslot(d, 0, devmem, QXL_SYNC) == 0);
> +    if (qxl_add_memslot(d, 0, devmem, QXL_SYNC) != 0) {
> +        qxl_set_guest_bug(d, "device isn't initialized yet");
> +        return;
> +    }
>   
>       d->guest_primary.surface = surface;
>       qxl_create_guest_primary(d, 0, QXL_SYNC);

Reviewed-by: Thomas Huth <thuth@redhat.com>


