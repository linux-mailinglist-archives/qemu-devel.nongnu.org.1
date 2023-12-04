Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054A802B29
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:02:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA15h-0001gS-26; Mon, 04 Dec 2023 00:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA14k-0001WV-3o
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA14a-0000CI-Gz
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppQjEqdOFHBnYLUjitMJu96xV6aJmU7ATh1429JesKM=;
 b=YLV/H/YJYFlBynSZT5ySFMQ51jCZkAxnOIEIRDSf9O/CW1a59PoNFo/iSGlxI+NZVKK9++
 v8nYQaGDFh4XNpVauq6C4Gtd4o87tMu7FRewf+3kxntAON06ntHQKju/5JGu7W5TONMTOg
 YRQ5K3aP1yxQlz1q0SbFKqEoxrywhOE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ACD7XYowOGmpZ0VzMMGMrw-1; Mon, 04 Dec 2023 00:00:30 -0500
X-MC-Unique: ACD7XYowOGmpZ0VzMMGMrw-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c1b986082dso1802679a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666029; x=1702270829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppQjEqdOFHBnYLUjitMJu96xV6aJmU7ATh1429JesKM=;
 b=CrtLXa4d4yHOrGPEcejvlXiF4HMOy9n3XqXC9i9rZDx/ifY+6J5c9kCkRlRx1xLPP4
 vGo9GxdvXXpIQbD4urcEiz7p7qjwkEW3IMPSgP9DxCIJUHW/5iYUwIWkbkWOobx91o0a
 96k1a1ret9Z2LqgntCCVgaks9uF5/HjSHmF3izS/VrRrjyZG9w70qiQe93PldUHreaZD
 0k7Cajebs0dHwI/FKyvf8hsvzLGXumFj23u/28w5dFnYKC/sciw0yepgMvkCs0FCX4LL
 Ezvqa8drLfVkLwnFZ82/cb3R1eaxq8vpglP/frJ2xA2Ev1dld/Ivd64ke+8wuQjwnd9t
 pfPg==
X-Gm-Message-State: AOJu0YxILGG+m9ektXI8PLs0vom4yDhbtMQJ49yHhVMGr3y3WLWH6eM8
 XSYwBIGlZpCY+d5+VdjAGLBS86ZRwIUxgDZJ9Hd9dpgVX1KGcMj1vuoVwLLBllPS+BtS4bp9bhi
 B6RA4BvL2spKSpO9YHdUnhkI=
X-Received: by 2002:a17:902:74ca:b0:1d0:6ffd:6103 with SMTP id
 f10-20020a17090274ca00b001d06ffd6103mr3338159plt.37.1701666029033; 
 Sun, 03 Dec 2023 21:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIqpEr+1QVYnxU4y5C1lEJruCWmRKf8zc0yNwlNpyDaU7bjcS7iWv9Sqj1drSkNrParTq0Gw==
X-Received: by 2002:a17:902:74ca:b0:1d0:6ffd:6103 with SMTP id
 f10-20020a17090274ca00b001d06ffd6103mr3338146plt.37.1701666028706; 
 Sun, 03 Dec 2023 21:00:28 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:00:28 -0800 (PST)
Message-ID: <05959afc-fa2b-44c5-a961-08e8fc250237@redhat.com>
Date: Mon, 4 Dec 2023 15:00:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 19/25] misc: Simplify qemu_prealloc_mem() calls
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
 <20231120213301.24349-20-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/hostmem.c     | 22 +++++++---------------
>   hw/virtio/virtio-mem.c |  6 ++----
>   2 files changed, 9 insertions(+), 19 deletions(-)
>

Reviewed-by: Gavin Shan <gshan@redhat.com>


