Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC070DF24
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Sxs-0001vv-VZ; Tue, 23 May 2023 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1Sxh-0001oo-Fs
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q1Sxf-0003az-V3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684851963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nSJnhnTOPYaFeb05skw6BUAim7PMCRhf8PzS8WG9V4=;
 b=LJRZ1KJ/zXHV4+xD48vkqIoOvbnLr/k71mfmAItRgnlTgmhABKePZ9eJKJCHLadaHDLZax
 ONrtepx8dJzXC50b4uHT8bldVjPPUenf8n415IykGxqoGDjGG3kHM2OJqNXlEKXFBoRpuY
 0U7xdw+3flMwRxr3GcJiap5WMM2qwPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-gsXuQy9NP0qP_xvdi4--Pg-1; Tue, 23 May 2023 10:26:01 -0400
X-MC-Unique: gsXuQy9NP0qP_xvdi4--Pg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso21996155e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684851959; x=1687443959;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0nSJnhnTOPYaFeb05skw6BUAim7PMCRhf8PzS8WG9V4=;
 b=ETZs6r9+idYG3DdGWZhBpDyvkeHzCbFg8VRnuuM1wY1rHPKTW6dQd+5CJG+DdhW87o
 pOqggM4KzJ0OfIWxCtc3tkVl3iZZFNweUSYh5B6zypVlSiU9vHzwSOfWpQYDtkWByfbe
 JxrSVGPt+HebiwgJqlLHUoAg8rAbOWiiCxPpeNCw8uPCybReECXpaOfpXXq8KuxpwPa2
 aYDsYecT6fZrF1J61pKgaLJ+3GU/4Oy0p0REmmAlJGGufDF7hU6HCg7Rtd6q5Ee52Ek8
 4HMegm3wpCqkWz59Bj+wCZmP9OgSxpCJdeOJHXlj4TrW2LVZ0YwhFHhL8qbsUQ73+tnm
 toXw==
X-Gm-Message-State: AC+VfDxx48D+jA7IG1qyJ67fir7nNPwEBFq8zSTVjU+JIDSNUKGLuj+7
 WiteODD1quHrzxT8gi34QZ9XvBr+Cf/wU4O6wDvlS4imL5g5VnM93fPMmZ6u7sRepcjD2xQaG+b
 Jb0Z4a7w84DTj+Xzr8rafGo4xit4NlP5+2y5p/z7wgTdNSJ2U+kRPNmVRQ07fjkHOBI1xmig=
X-Received: by 2002:a7b:c3c6:0:b0:3f4:2770:f7e9 with SMTP id
 t6-20020a7bc3c6000000b003f42770f7e9mr10430088wmj.17.1684851958816; 
 Tue, 23 May 2023 07:25:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mw6o2fzE1O96A7jUNmIY6MOi8MKrh05A1PlxRoiSZ9N+qesnv1HzLKD4LudeE6o0G/FaoIw==
X-Received: by 2002:a7b:c3c6:0:b0:3f4:2770:f7e9 with SMTP id
 t6-20020a7bc3c6000000b003f42770f7e9mr10430068wmj.17.1684851958448; 
 Tue, 23 May 2023 07:25:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd?
 (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de.
 [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c00cf00b003f4268f51f5sm12078679wmm.0.2023.05.23.07.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 07:25:58 -0700 (PDT)
Message-ID: <bf76bd8d-67b2-ce1b-df8d-bd74a3f24cb0@redhat.com>
Date: Tue, 23 May 2023 16:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] vhost: memslot handling improvements
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230503172121.733642-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230503172121.733642-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 03.05.23 19:21, David Hildenbrand wrote:
> Following up on my previous work to make virtio-mem consume multiple
> memslots dynamically [1] that requires precise accounting between used vs.
> reserved memslots, I realized that vhost makes this extra hard by
> filtering out some memory region sections (so they don't consume a
> memslot) in the vhost-user case, which messes up the whole memslot
> accounting.
> 
> This series fixes what I found to be broken and prepares for more work on
> [1]. Further, it cleanes up the merge checks that I consider unnecessary.
> 
> [1] https://lkml.kernel.org/r/20211027124531.57561-8-david@redhat.com
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> 

Ping, probably fell through the cracks.

-- 
Thanks,

David / dhildenb


