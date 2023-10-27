Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2757D905F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHe4-0004M0-VQ; Fri, 27 Oct 2023 03:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHdk-0004Hb-0I
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:52:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHdi-0005oD-0d
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:52:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so14150935ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698393135; x=1698997935;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnSa+DpWc0K/rO72kGfukEievl64M0E8SDSPTOKg21U=;
 b=G0uUJvazMC/NmFki/A7eYbLJ9RlAwZD78UAhq1epPWqut7XzRypylTO26sfkrtDNZE
 XQiCKCtX5qibbo6/Go5xHFY/ASpVpdKJYMOr7wn/tyWKeW/6odX958ZT8GIk5paoyjVr
 bdjPm3391Loh9YhN1fc7fb6jeuGcGOESXC4OI9+LXG1xkG5LR/oiwKuEENlutv+QmJX/
 uuNx3VWb4kaWubGjgLjc1gsAuWFB4blyy4A119Sn/GKUTlFQLPlTBxh+b9a62dij3ISf
 WuQi162rs7ixmjM2uReE8TfnMbm8ggx4IhkENvZaUEY8sx8IktlC23PQS80dJd6EmqCS
 FCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698393135; x=1698997935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnSa+DpWc0K/rO72kGfukEievl64M0E8SDSPTOKg21U=;
 b=aMIn+sDl9dhmEw3PwbEABSw60QGcAbADttaSHBljcZ4wMe8xMUNkrIjJvLhCVVzIwV
 NoYnt6qHKLNC8vHH+Ef6tACRKHlKZav2DMNSIXArNR6KE+LajRf2UDUoXBFVvP5ImMf/
 CI7Ofd8kxBEeoiuv/6ktKq4YojMYHVqDn3O58pkVO0SrQpBan+aUZU2zatD2fOM168CL
 P1HwiqsyYuX0VmduSdE7I8ABd3hg5uekEeJ0jngV34eT2jEt9B1+ivGrv/7+N6CvoHpn
 6nOGw1nS+kk+5cuNatJe7HOO1gHOX+ItPaRhU6xBNiosgGR8WBvnc5nZ4EMkdvKweCDV
 3XWA==
X-Gm-Message-State: AOJu0YxoZrl5+cXFlJ34rgHIbg7tDIHJTprimoDm203cGNr919OhR5Tv
 O7XT8pRyYaUClnQgR20VdWy71A==
X-Google-Smtp-Source: AGHT+IG+VYW6HAe8IifJZY2BlQsJPYaOD1Oxo+NVPGQu2WJHCsjmSAT6Uo9SQSnlc6/wueSIO4jLqg==
X-Received: by 2002:a17:902:c7c2:b0:1c0:bcbc:d64 with SMTP id
 r2-20020a170902c7c200b001c0bcbc0d64mr1558227pla.51.1698393135524; 
 Fri, 27 Oct 2023 00:52:15 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 iw6-20020a170903044600b001b896d0eb3dsm925445plb.8.2023.10.27.00.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:52:15 -0700 (PDT)
Message-ID: <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
Date: Fri, 27 Oct 2023 16:52:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
 <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/27 15:49, Jason Wang wrote:
> On Tue, Oct 17, 2023 at 12:09 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> While netmap implements virtio-net header, it does not implement
>> receive_raw().
> 
> The only user for raw is the announcing. Netmap probably doesn't it at all.

In my understanding, the announcing *sends* a raw packet. Both of tap 
and netmap *receive* packets with virtio-net headers.

Regards,
Akihiko Odaki

