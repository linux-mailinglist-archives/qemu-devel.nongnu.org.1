Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F86A7F0CB2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 08:17:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4yWj-00069E-D0; Mon, 20 Nov 2023 02:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yWg-00067I-MI
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r4yWd-0004RL-Jg
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 02:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700464614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnX92o5G/pxpRnAbxEljgMuArVQ+ol9+ahZrHOljPsg=;
 b=irebXfLbI1TjJbvmCdqxxNJ7CSeP/sVFxFtQtIZk7tiTCOvLqIugXMxdA4UsvmbVqT1VJ1
 jjIvcdLH50BAln/ib+2EsJ9Hi/V9khG6uC/LhDGwOcJAhbsdtev9VFGyA5ZgX7dUmVOzp1
 oQgfKbE/xh7bzyi3ygDjD8yWOpGeI0U=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LkCne_CfOnCXSWL9gBGRwQ-1; Mon, 20 Nov 2023 02:16:52 -0500
X-MC-Unique: LkCne_CfOnCXSWL9gBGRwQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c1d1212631so6731025a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 23:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700464611; x=1701069411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lnX92o5G/pxpRnAbxEljgMuArVQ+ol9+ahZrHOljPsg=;
 b=kEVePkULZNrkvcjKtTdYK7C4HFFvRZ5BAX0Ff83iAI9TvpQAHOh9hHMqUCu/iq95a/
 jfzpo6b6yB4yLjueAzqqEBXDxqNs6b3FS4tZCTHvOajJ9UZyb/LFupBjC7vfZoecqCMw
 qRos3urlSHF07E7RTwsDPSnCtlUH22K4AG43O3U4qN4R4oViISA4OGfDo8we9xkO0Wzs
 eNab0v5HxsyvOF4truxvQoMZS26qp4WtQBEH834XOgePIKWt7yKunIr68X2nP+IcEE0y
 /NAk6FMaefbMRPx7XO+tqH+dAVZ+hvoUsZRxncYIrCpaducF4NcqBUJ/HSLDGoKXNla1
 Y2Tg==
X-Gm-Message-State: AOJu0YzzvkpMTHcJod5Ck9IKJ/+fbuUzZobjvsOe/MuXbJu1fBJ8V3eT
 AfmCYrhj7GwaXyQb/P4CZL+js6WSCEelBsWhAjEmbK9EbS30e/H9MVJBqJvGkraHo0PUaP7u3zt
 DhPRf+fRiRxrqFQY=
X-Received: by 2002:a05:6a21:328a:b0:187:1c5c:49e4 with SMTP id
 yt10-20020a056a21328a00b001871c5c49e4mr9692005pzb.46.1700464611006; 
 Sun, 19 Nov 2023 23:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzpKfQvHmTO/SJ/xh8dipvLtli+G2nu20Y591zB6RhciHBmxOGi/mp3cV1RgPXAy1jDbLi+A==
X-Received: by 2002:a05:6a21:328a:b0:187:1c5c:49e4 with SMTP id
 yt10-20020a056a21328a00b001871c5c49e4mr9691985pzb.46.1700464610683; 
 Sun, 19 Nov 2023 23:16:50 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902d50b00b001cf66056a1bsm434487plg.97.2023.11.19.23.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 23:16:50 -0800 (PST)
Message-ID: <b70d6f7f-b9ba-4153-b1cc-564c4ce7b83b@redhat.com>
Date: Mon, 20 Nov 2023 17:16:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? v2 3/4] hw/arm/stm32f205: Report error when
 incorrect CPU is used
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20231117071704.35040-1-philmd@linaro.org>
 <20231117071704.35040-4-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231117071704.35040-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/17/23 17:17, Philippe Mathieu-Daudé wrote:
> The 'netduino2' machine ignores the CPU type requested by the
> command line. This might confuse users, since the following will
> create a machine with a Cortex-M3 CPU:
> 
>    $ qemu-system-arm -M netduino2 -cpu cortex-a9
> 
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.
> 
> We now get:
> 
>    $ qemu-system-arm -M netduino2 -cpu cortex-a9
>    qemu-system-arm: Invalid CPU type: cortex-a9-arm-cpu
>    The valid types are: cortex-m3-arm-cpu
> 
> Since the SoC family can only use Cortex-M3 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/stm32f205_soc.h | 4 ----
>   hw/arm/netduino2.c             | 7 ++++++-
>   hw/arm/stm32f205_soc.c         | 9 ++-------
>   3 files changed, 8 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


