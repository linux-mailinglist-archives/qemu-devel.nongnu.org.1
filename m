Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D649802AFA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:46:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0px-0005Ku-Uj; Sun, 03 Dec 2023 23:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0pb-0005Jk-5l
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0pZ-0008Mb-2v
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bb0tykILfPLEILdRE8hVCumwIs1g9/yBXuZq77yrMVI=;
 b=OGX30BkesO9EOEQmZM4iScUq/rnxPqJBhbytfAgA8WUY97vJv35Yj/OJuEXnJ/CHRNqeFz
 x/przv/ZGbASqZ0bS8BwFvBNYbt9SKn76tFkwlFpRNukzBFweCanYXbZ1zrdRbWy+20VVj
 gMIWn9uCQhOobBMPZfg8CX4I3P6aps0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-24bx8An_PxifeSnt5xtcqA-1; Sun, 03 Dec 2023 23:45:14 -0500
X-MC-Unique: 24bx8An_PxifeSnt5xtcqA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d06b8d7982so9143875ad.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665113; x=1702269913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bb0tykILfPLEILdRE8hVCumwIs1g9/yBXuZq77yrMVI=;
 b=XyVpzenxTVb1/9SIzw98AxLJZ5/9wUaA+GHHfM9jWf8xlHddis7/3SulCUVp6szjkg
 fpcC6oi2AYWdePmjG0iT+S94kE0XwqT4p3ibIo9VQIJjhNFlhS4+mB9GjXvhNboC1R3s
 wTHxL0S1GwPv9qKnF7YWNB7AeZuEss/hNLHRt1dhA4W883OGsq79kKGXQ5RY4WdFHg2m
 Jrzt/nrR9qdpTNS/4/xakBfonkvhXo+Zya+FLJ5nDm4gH8Kg715rGoX4ytjMboTv9Dpw
 coms+kK7E5dp+IdsouMmR6aUzl6QPDMtcHzMyywKmRHr51w0Y16QgqOhEhFHaN896BnB
 Qx6g==
X-Gm-Message-State: AOJu0Yxh1h32PJgG01FrWNdgTE8g4ElpYlgjXPZKgJtoh/78Y4oGYa8H
 JL67mfs2e4LYkZg2Pw0pDPEfZ63rmPFKIEzdXMvWgmR1Hj7ruwnjXfY9iXgd8n8cdNrJk2TXR6Q
 m4IAjfY3FiZaJe1eiUVUDkDU=
X-Received: by 2002:a17:903:2616:b0:1d0:60ce:be09 with SMTP id
 jd22-20020a170903261600b001d060cebe09mr3047401plb.61.1701665113298; 
 Sun, 03 Dec 2023 20:45:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGA6LcuOhCLHsKXDNvFYjPNytkSncq118B++plG+BhYSoWtJViqWDvoQTR3BUk/2hwiy/+NA==
X-Received: by 2002:a17:903:2616:b0:1d0:60ce:be09 with SMTP id
 jd22-20020a170903261600b001d060cebe09mr3047395plb.61.1701665113039; 
 Sun, 03 Dec 2023 20:45:13 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:45:12 -0800 (PST)
Message-ID: <99075540-364e-4d8a-bad9-eb52d50a129c@redhat.com>
Date: Mon, 4 Dec 2023 14:45:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/25] memory: Have
 memory_region_init_rom_nomigrate() handler return a boolean
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
 <20231120213301.24349-4-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-4-philmd@linaro.org>
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
>   system/memory.c       | 8 ++++++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 

s/cpu_exec_realizefn()/memory_region_init_rom_nomigrate() in the
commit message, mentioned by Peter Xu. With this:

Reviewed-by: Gavin Shan <gshan@redhat.com>


