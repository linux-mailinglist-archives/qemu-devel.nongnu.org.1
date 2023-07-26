Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C56763027
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOa7r-0001zG-Jk; Wed, 26 Jul 2023 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOa7p-0001z3-RN
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:44:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOa7o-000671-9X
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:44:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31758eb5db8so3344688f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690361042; x=1690965842;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TLHCyT22OHs+LJV54wrD4aED9tLGhvIvXXAt/egjBSY=;
 b=DLADNVBGmTSGdHRZaNpM2fe1FcWsyWRES1oDq8lhAoYARsVrVqyWlvE89HAouS0pye
 /mf4wxvZJxU3RemM7vuCt0XElsxdHUoDt3KblOJe8hBayI6+KiBWhUZ/iMS3K3gYZDCA
 4Y+96tqq6EPUcylKRUkNvrILLgn2JNg9uDLkl8GpHi8KT8rUYqA/azceb7qXmGIHzaKk
 FLuA0Vl+ggJ7IgchZw70Kz1y+u4PlBWfq6cZgdozQXxuaP9cd2GB20TcTCs4R3rjLmj/
 xJl7rc6Rtpz9AffiDuyCxqwjgSFHmKmqovGsJBb212L4bC+ddQtLkTG7beu+QJMCgew3
 OBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690361042; x=1690965842;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLHCyT22OHs+LJV54wrD4aED9tLGhvIvXXAt/egjBSY=;
 b=GexKe1FHtzBfcQi5Wy1/Q5s104pcpLBkrciPD01vQubzM7plzIWtg5zozyCUZMWPMu
 FTOptgWhqPPZlXf56fFm41kd9+r7uTF0jJZm19oCda7cn01npe0LjaIOh1AXggfgMUfY
 exlWKEAK0Ll0DuSceDToXhtgyxiaz8gbFnS9yz/vwL7Tla2K6mpOXNxmd+MOlfY0WgW4
 uwRa23YP1dIr6BwKz/4Pw7pdmXQLGCWSbqBUMrFp9cpJUaZxyewgsd8i1U4QSxi9dTTo
 3SiZ7XuIE4o3K4licpr0KvzzxvU+laQeEatsdnwGl23EPuBme57XSeAfxKmtRa6TiVfE
 bPaw==
X-Gm-Message-State: ABy/qLaKL612DdeAsh2K7P/QWv4GXooLFKKNQekk9+PVsXLx6QyzRwla
 xfCumgJJzBhvBFra3xG+ICg=
X-Google-Smtp-Source: APBJJlEFhFR9BzWR9nyf7SoybIgXrceFTt8PAO+gnJV4DHrZnQZKabpMLYuJdAlT4roc881scQIPBg==
X-Received: by 2002:adf:de09:0:b0:317:6310:a616 with SMTP id
 b9-20020adfde09000000b003176310a616mr923261wrm.36.1690361041697; 
 Wed, 26 Jul 2023 01:44:01 -0700 (PDT)
Received: from [192.168.24.200] (54-240-197-226.amazon.com. [54.240.197.226])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d640b000000b003174f6dc947sm12755731wru.32.2023.07.26.01.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 01:44:01 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2df69f7-d7d1-a2c4-6bf0-e2142f64a53b@xen.org>
Date: Wed, 26 Jul 2023 09:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: i386/xen: prevent guest from binding loopback event channel to
 itself
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <c976d480399a44e09b1da3ad201e3021def223f7.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <c976d480399a44e09b1da3ad201e3021def223f7.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/07/2023 11:05, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Fuzzing showed that a guest could bind an interdomain port to itself, by
> guessing the next port to be allocated and putting that as the 'remote'
> port number. By chance, that works because the newly-allocated port has
> type EVTCHNSTAT_unbound. It shouldn't.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


