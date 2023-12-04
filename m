Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BE802B19
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:55:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0yy-0004tl-Gs; Sun, 03 Dec 2023 23:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0yw-0004tB-MA
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0yu-0004xh-1f
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tjo6iUwbCcRTY8sn+MBPdkyi1mWYRvZ61wyiSN4A4PA=;
 b=XkenwDT+HzTzWfnf/d0++p0TVp6bpEMRJETscDO+NKKg5nSUukZnjVJvyBSEipRRrbJzRQ
 hW2wl6l86x+4agA3a6uOdsHiEddSe+/t6SR4bHF99vtkByXGS7gmjWUbZXhkS/EMwkoa6p
 WgiELumgR/gIsW+5i4P8252XplOb+xU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-iDq9-6VxOuy04Vs7DEwZNQ-1; Sun, 03 Dec 2023 23:54:54 -0500
X-MC-Unique: iDq9-6VxOuy04Vs7DEwZNQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28696c070a8so412812a91.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665693; x=1702270493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tjo6iUwbCcRTY8sn+MBPdkyi1mWYRvZ61wyiSN4A4PA=;
 b=J4cqrOwoQwbfioTEdRSqAFkGWNuBRU3z8mg1REM7hutnm+UXFA7Y2l3Kzxm7AlQ0Wm
 odMugxR387TCOnvOQGHIoQGkEu3g0Akf50YIfVZNpQPHPwcugvTS4ikP7wYyc9YcbTqj
 5KxtoNSP1QQJcpUutyQZnRnUfB6hKb/XAp0By0H2Dfi6UNFQE3gW3Xw47P+03Ob1+hDB
 CZEVOb53eMx4UGZuNyVOqJElw7Uptc7W/CGBcTBBpNtfa3iaOMJdof3w+JsIno5LP3k/
 B3K1HXgkrYkxzmC6nKodP6yDWwdfeshOAIVJLHNulyu41ToINu/Ji7qVBAQyuwjblNtX
 auHA==
X-Gm-Message-State: AOJu0YxEXf9l6tp+fOyIkkPYzLKiMtAKxfbExWFo7YNkIFnuteNRgNA0
 5ifXDPo7hPlWeKR8T/QPk1+AXFVLKXEDBEEL7gxlICjaIs48ErN9SjHfl4kgG9WWh0E70hCdQ5d
 G98jqStIsiJom3gA=
X-Received: by 2002:a17:903:41c5:b0:1d0:7051:d316 with SMTP id
 u5-20020a17090341c500b001d07051d316mr1392235ple.102.1701665693088; 
 Sun, 03 Dec 2023 20:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWjsDr4ECUpzlnKCPfswGRWcM7+cGKar+jQ4HFKLujY+OMMmytE7GAyRvOJKVB0ejbRdx5tA==
X-Received: by 2002:a17:903:41c5:b0:1d0:7051:d316 with SMTP id
 u5-20020a17090341c500b001d07051d316mr1392231ple.102.1701665692822; 
 Sun, 03 Dec 2023 20:54:52 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:54:52 -0800 (PST)
Message-ID: <cb51f930-7d39-4c43-a62f-780cc32b9896@redhat.com>
Date: Mon, 4 Dec 2023 14:54:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 13/25] memory: Have
 memory_region_init_ram_from_fd() handler return a boolean
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
 <20231120213301.24349-14-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

s/cpu_exec_realizefn()/memory_region_init_ram_from_fd()

Reviewed-by: Gavin Shan <gshan@redhat.com>


