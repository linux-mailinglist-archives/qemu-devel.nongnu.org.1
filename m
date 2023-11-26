Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC617F96AD
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:55:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7OyG-0002iu-S7; Sun, 26 Nov 2023 18:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OyC-0002gb-0R
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OyA-0004Lv-L1
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxfvYBKXypDKKOJdtBdCSrtt2NRiDyHztGG2xsCdrEI=;
 b=aJybTscTL0zkdBTKLOIjK+z/wBR+HLCnPfBYf8Mnsirgd/h5ECc3dd890VKLVIKB/h8lMq
 Kv9UywPfJ7Liwe9XuzPJZ9j2HudmRZcHNg1qDrCVAZKlpofvzM7zeBdool4KjriAB6InpW
 Oi+zeftggKNZmwQ1tZWcbVRocnJkESU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-roOt1wKDPK6wKOs_9U23LA-1; Sun, 26 Nov 2023 18:55:15 -0500
X-MC-Unique: roOt1wKDPK6wKOs_9U23LA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cf8b6db1a3so35632745ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042914; x=1701647714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxfvYBKXypDKKOJdtBdCSrtt2NRiDyHztGG2xsCdrEI=;
 b=KUsjiUvgLkcVIvM37U4USEfLDViteB6gItg2KYFl7vHIBoacT7LkJRZUg/+1Ke/UKr
 ss6+MN82F28cpfzl391ZFo36pgsCGzY7PvbrFqRCpHn39cK62Ze0t9liM8BG6yfOZwMV
 zQFlbtMBfizLcDOj2zB+qHExiS5FhknVbUOCK2ntGNH3haAtxn4XeGEKr8ycp0mGMvLV
 3GHcz51elTb9uNWklPpOhG9ni9UIrqYqmt4tJlKaNrYn3Dsv/sf9IwJ/ey9StxhTXb+Z
 chii14K9mV+1xzL0yTzem5VknEJRWYMnvhgTHWkIBXPFyyR1iAUgkfUrlUOb0YOdXfv7
 HIEg==
X-Gm-Message-State: AOJu0Yy/3l0hNU5ESmGeQBt0H/ULHI4B6z6Y6h6obBUdP8UPFuiGWFBZ
 Pg7HgK62DeJw9PcIADku5GrmYNfasORSbKDmFOiQDBiSK/bGfg26SlwGf0DzCNOLM34Tt/mpG/+
 LRPHIlXcndWoIn+8=
X-Received: by 2002:a17:902:cecf:b0:1cc:31c4:3426 with SMTP id
 d15-20020a170902cecf00b001cc31c43426mr13001834plg.11.1701042914697; 
 Sun, 26 Nov 2023 15:55:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg6+W2Kxypkv5vYDoxmnxFzPBALwVxwcyjMZi0vjMhPSwwyBaffP/U/SLsjCFKa0RluEYVcQ==
X-Received: by 2002:a17:902:cecf:b0:1cc:31c4:3426 with SMTP id
 d15-20020a170902cecf00b001cc31c43426mr13001819plg.11.1701042914403; 
 Sun, 26 Nov 2023 15:55:14 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a17090282c700b001c5f77e23a8sm6864887plz.73.2023.11.26.15.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:55:14 -0800 (PST)
Message-ID: <bb0137f5-6de2-4079-a4ae-736eca4f4788@redhat.com>
Date: Mon, 27 Nov 2023 10:55:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] target/arm/kvm: Unexport kvm_arm_{get,
 put}_virtual_time
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-9-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 16 ----------------
>   target/arm/kvm.c     | 16 ++++++++++++++--
>   2 files changed, 14 insertions(+), 18 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


