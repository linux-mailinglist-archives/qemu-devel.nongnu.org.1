Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02A73B83C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgHX-0005vg-6z; Fri, 23 Jun 2023 08:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgH0-0005ov-35
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgGy-00028f-Ax
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687524739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GO3TUHimbNhwNtdnxAHZ9lCqYq135j1p8mrN0Hfk2po=;
 b=AwgTk+1ZYMpQXMwGQhc8LxrThz3nF1RA9j0UfyJMJN0tkcaZe3VwjoOI4oMOR9vRhgTRa9
 c/69ZZwtZF6DbjX84QkhsAdhLWTwe883vUmA6UUf7+LZCe7Z/30Y25wm0wMwqWVXtZfRAz
 QhLC921bAy3sPnzlB0But72VDtc8DXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-XpE6qqqkNcqnCCnulnLzgg-1; Fri, 23 Jun 2023 08:52:18 -0400
X-MC-Unique: XpE6qqqkNcqnCCnulnLzgg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f8f8e29771so8788155e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687524737; x=1690116737;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GO3TUHimbNhwNtdnxAHZ9lCqYq135j1p8mrN0Hfk2po=;
 b=guqtVZQw0empTvyO/MHGtNJtbvXwAAZc4yTU1/zYLp2qxSblRytEJGe6ScvKiV8pdV
 rn4KJaIVl87651f8ubrotuRJS8+OD73fa00BX5h296y5Shrl9s/11XhGbTjYLGApE3fQ
 VupBxOV8IaVhRzkLl+3of7mmjHzA+S+xzO3nAd68gGzvYsQ1Ox086ncmtFNXN2Pj9KTN
 KLXcU0k22mwfiLl0q5YCMt15z03nhWE2s4KT1R27U4dMcl7MXMoOaTgd28W/VL2SJRX8
 A12/6B3hMOFxy5oud18MvQFTa3ql+K0BpYpTFYxS/8LnGj2Io7e5AZuLZ9+EZABwO//K
 f/7Q==
X-Gm-Message-State: AC+VfDxEs6FRFjCbWOnfelpRHj+J9WxlQ6mdfJbnBiVn1rFAE2z6+5wM
 tbt2nbM8AwzVXTzSVD9pq+2APXhuakNHiqy+p9NA1aGYXrP9l7KNJULTPtrQ0ST4rJC+GYY4QDq
 2pbxnac9pbVcQLap0u7wBjR7R4OQMncMNRuUDHRO0Iq++Y/l/g31zz9X2FL6WlTaKOQuY+kk=
X-Received: by 2002:a05:600c:3b97:b0:3f9:b535:381a with SMTP id
 n23-20020a05600c3b9700b003f9b535381amr11541557wms.10.1687524736859; 
 Fri, 23 Jun 2023 05:52:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64eOgWDr+E9s1KhjWf+IqQG5NuUOfPyiW5c2k9+McDu0Xv2NUdSBPQKdyJ4RXwio7IzMbHYg==
X-Received: by 2002:a05:600c:3b97:b0:3f9:b535:381a with SMTP id
 n23-20020a05600c3b9700b003f9b535381amr11541535wms.10.1687524736540; 
 Fri, 23 Jun 2023 05:52:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:1700:9783:58ba:9db:1221?
 (p200300cbc7291700978358ba09db1221.dip0.t-ipconnect.de.
 [2003:cb:c729:1700:9783:58ba:9db:1221])
 by smtp.gmail.com with ESMTPSA id
 m13-20020adff38d000000b003113ed02080sm9527747wro.95.2023.06.23.05.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 05:52:16 -0700 (PDT)
Message-ID: <7266ab51-51a4-e470-e134-8c2b338838ea@redhat.com>
Date: Fri, 23 Jun 2023 14:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/3] vhost: memslot handling improvements
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230523185915.540373-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523185915.540373-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23.05.23 20:59, David Hildenbrand wrote:
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

Gentle ping that this wants to get picked up :)

-- 
Cheers,

David / dhildenb


