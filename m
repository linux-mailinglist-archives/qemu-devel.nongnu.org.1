Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476B802B16
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0xG-0003M0-Hg; Sun, 03 Dec 2023 23:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0x5-0003L8-Er
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0x4-0004kc-1u
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhkhYZQbbUXXiK1cLa8d44dccTRmthTs2mi1xHWzj6A=;
 b=dGPzUu+clujDpDbolrYS//28iH4QKkHPoynHXa7BJcdw2ssXqbtBlvHXgNxzF3CKITn4ny
 chMX5zB29IgxWuisXFyrSuprZOQiSEjn88cm2BfyfxX9Yj4P3P+E6a5lG4YUbUIjXMM0FZ
 iF0cWM4TPbDsrQrCkLglrCrO59A0pGw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-rzG8tTi0P6SSuTnirogLFA-1; Sun, 03 Dec 2023 23:52:55 -0500
X-MC-Unique: rzG8tTi0P6SSuTnirogLFA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5be154fe98bso1787079a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665574; x=1702270374;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhkhYZQbbUXXiK1cLa8d44dccTRmthTs2mi1xHWzj6A=;
 b=vHqsCzNenKHuldcHb1iC5+GAqlNs1BhoQ4HQBuZ3ncbIGmN2LYFOy5N7mdjgzRmrOp
 cWi0sGrmuqgQHWnuDzrwgBZPFJswVvb07Cl00hwb77u3VjfXWeL78PqWNV+SFgkQw0mh
 Rxh6mmZCbt9PBiTpgE2moTVi+6TYSdShxh0nwdDQwRil09ZL4PR84BlDoYeVH85w2Zw+
 rPDmVmHCHmdLOKtKcO70cZEuKA8EDZ/txLrLrT6Afcf/r4/maEHYLqajm/18XuR5x8Kz
 P7kohn1CWkryzQRexGvrQbu98GgULEyirvQFRzwenm+1/OF4oOuudTyFstfQpKv2NezA
 sBYg==
X-Gm-Message-State: AOJu0Yw8dL1k6lWWt4Irp6fG/siIkmSn3zOkvQMR1kb+RTwxPxglunHo
 4ARB+qTKK8XrAA3f4maj2ZYprr5f9c5QGnDPZLd5p/8JeZuj3/OOTXC4gLqiOm4XwYXbkPT+PQb
 06PwnagHdi7xaCCg=
X-Received: by 2002:a17:90b:180e:b0:286:7471:41e4 with SMTP id
 lw14-20020a17090b180e00b00286747141e4mr3079219pjb.0.1701665574047; 
 Sun, 03 Dec 2023 20:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSGJVU5m55QTOW3vTQEvfwWRy0dQjD9fh3y7lhhJsSj67wi8viDhPyBdHGQ55KtLkedb2A0A==
X-Received: by 2002:a17:90b:180e:b0:286:7471:41e4 with SMTP id
 lw14-20020a17090b180e00b00286747141e4mr3079200pjb.0.1701665573725; 
 Sun, 03 Dec 2023 20:52:53 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:52:53 -0800 (PST)
Message-ID: <b02b89e2-ea70-460b-917e-c497b83d17f0@redhat.com>
Date: Mon, 4 Dec 2023 14:52:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 11/25] memory: Have
 memory_region_init_resizeable_ram() return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-12-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

s/cpu_exec_realizefn()/memory_region_init_resizeable_ram()

Reviewed-by: Gavin Shan <gshan@redhat.com>


