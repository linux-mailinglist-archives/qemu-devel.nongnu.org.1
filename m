Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD527BF3DC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:13:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq6uI-00025i-6g; Tue, 10 Oct 2023 03:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq6u8-00025A-4c
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq6u4-0003mG-RR
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696921900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0mNIjMVHCz9ohHeSZg/ku/hqb0MKUrwWMv9gf84CMw=;
 b=hbnFakll7d5/+cH6YK8OMPNO9/kd+R77t6ndP6K8C+fdF2KwiCG2Jy+Giu3BhMTqhZ/E+S
 OSed5qKP2kkyUgWLJJDbApomH+BYDFJ1byh3+seyVS2kw5Jt2dV6MOro8b/6JbRaUutfDh
 wN7jrWqVG57imyU7alpHd9THuWKkNe4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-lEvBRCoIMP-xcaqCEFTjqA-1; Tue, 10 Oct 2023 03:11:36 -0400
X-MC-Unique: lEvBRCoIMP-xcaqCEFTjqA-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-49a94be026dso2559695e0c.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696921896; x=1697526696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0mNIjMVHCz9ohHeSZg/ku/hqb0MKUrwWMv9gf84CMw=;
 b=rzle0OuvyRYaEtwKCCEmP33Zz97uwulvg5zL9T0e00ODYrkkoeL53GnipL5SO7A+vm
 +hAcrR+ZIrXwJ3+vi/XAZ9yQ5qYe6tODq7k5vteVz7qy4IWbinUj/2N71JVBRyXGQ4rG
 WBTfXDOxoYyIQK0kR+n2uWbjYaUHaSl0bKRc+JV5VHCjqZc2mERaPaRJPY0n3c7dj/pz
 OU10uizL1UeiYCtls42bufZDveGFXBFq4Kl/mS3Aky8TVjspqTfxOSpGsB/xn0LNl12e
 SAUsKp8+m3c1Two/wKe0Gf4ztyFhSHs+1AmcjMt5iZARSAypYvTlNt1oC5zcLewIIPTT
 YE8g==
X-Gm-Message-State: AOJu0YxO/g6qQQkGz2CP8Xcs3KkrYf+jBurEp5u13kaW3/4KIVBwUWem
 2xPVYG/75hrfHhRXTdIiwqptfKbiNgAAUkunnZDQWYDjPrcEbXlfvjd772AKtHeHh59nqelM1xA
 zlhVo3aoebTZUYXs=
X-Received: by 2002:a1f:a9d0:0:b0:49d:92e0:9cd1 with SMTP id
 s199-20020a1fa9d0000000b0049d92e09cd1mr13163144vke.11.1696921896138; 
 Tue, 10 Oct 2023 00:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC2hOPKJt1RqeZV+yaa2RxdZIycrMtu2YO7JNVqwgHGKyVm3qxEn8lbdbKFtZPEY0hv/BdkQ==
X-Received: by 2002:a1f:a9d0:0:b0:49d:92e0:9cd1 with SMTP id
 s199-20020a1fa9d0000000b0049d92e09cd1mr13163129vke.11.1696921895844; 
 Tue, 10 Oct 2023 00:11:35 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 x25-20020ac84a19000000b004108ce94882sm4257759qtq.83.2023.10.10.00.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:11:35 -0700 (PDT)
Message-ID: <ccde2106-9d71-4e59-38e4-4b042fc5943c@redhat.com>
Date: Tue, 10 Oct 2023 09:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/6] tests/qtest/migration: Add a test for the
 analyze-migration script
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-7-farosas@suse.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231009184326.15777-7-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 09/10/2023 20.43, Fabiano Rosas wrote:
> Add a smoke test that migrates to a file and gives it to the
> script. It should catch the most annoying errors such as changes in
> the ram flags.
> 
> After code has been merged it becomes way harder to figure out what is
> causing the script to fail, the person making the change is the most
> likely to know right away what the problem is.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/meson.build      |  2 ++
>   tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>


