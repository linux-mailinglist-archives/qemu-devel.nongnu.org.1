Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122976CF6C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 16:03:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCQx-0004fv-RG; Wed, 02 Aug 2023 10:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRCQt-0004fH-DZ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRCQp-00089z-00
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690984950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKIPztBQtpHAo8YN6W0nHdp3hJqPfL7BeFcNopspSms=;
 b=QkX1FCGoniv1394iJVj4NDM0JSS3UBgM3Trql+YVXRWZ2DjuP6HV8ckw92zXBeuUdajf6L
 +ml0ezNmTBSU5Wecss0l3Uo7YdkdYwVod0cFmQBZR2JiG0DjzDkRpZ6Uhl76clh1IKX9w4
 evw6aTZP3rUSjbXT1LVn+miPs+jVrr4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-1edohgpBN-u36pDYboypDA-1; Wed, 02 Aug 2023 10:02:23 -0400
X-MC-Unique: 1edohgpBN-u36pDYboypDA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d2b88325bso14320066d6.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 07:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690984939; x=1691589739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKIPztBQtpHAo8YN6W0nHdp3hJqPfL7BeFcNopspSms=;
 b=h8tADBHccfI2BPLq0PXOlIT7coRrdDdpVaYh8gZVT7iiFc/6sq34tQY1RUmOolQRYr
 EMwNDu8WaiZ6uP3Y3fOOW684Bn+pGj+5xihOmY5d/ZJuSKxcrtuMqf1wcUXzs3dcmqvn
 m0+SPGaMJSbFf/gWNJ9UlJqbnDQk0+JC3yPcPeLpgU/xnZO+iu3XoxifUlEVahsU4RO5
 vv9AULqu5Ey5saO99eUSYCj1fZjCmRnD7bT++mXpcO4tg03JwMu4trLtz50/UrfLIxlR
 j7EMaPO1WDxU/T5AaIVLHR/m1Tj6Dhb9r+6bkQvBnW5H7Gw/1dzfAw2VbuoeN9oFzMvk
 w3mQ==
X-Gm-Message-State: ABy/qLakNQJrG3pycfu1fuyrOY7Tchi6B+cd+D/Llf1IWYPPiFDJLvXy
 86mooWJ3hQkJaLrABO7+NoyuwbnIdONNIKdamEi3NDhHswR1nk4UQfCWUGLxr0/ERW2iOcKjk86
 6TbiWsjEQwpiaR3A=
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id
 r13-20020a0562140c8d00b0063c7427e7e9mr16429301qvr.6.1690984939037; 
 Wed, 02 Aug 2023 07:02:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMej31nes8klme36+iD0DCFpTCAWq7UkLqrxjJJZBZLV/4VcaZi9K+yQtbCgiwBemqFi9t5A==
X-Received: by 2002:a05:6214:c8d:b0:63c:7427:e7e9 with SMTP id
 r13-20020a0562140c8d00b0063c7427e7e9mr16429235qvr.6.1690984937953; 
 Wed, 02 Aug 2023 07:02:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p18-20020a0cf552000000b0063cf4d0d564sm5499320qvm.107.2023.08.02.07.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 07:02:17 -0700 (PDT)
Date: Wed, 2 Aug 2023 10:02:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix endianness problems related to
 VTD_IR_TableEntry
Message-ID: <ZMph6J8reFmxOpit@x1n>
References: <20230802092837.153689-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802092837.153689-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 02, 2023 at 11:28:37AM +0200, Thomas Huth wrote:
>  #if HOST_BIG_ENDIAN
> -        uint32_t __reserved_1:8;     /* Reserved 1 */
> -        uint32_t vector:8;           /* Interrupt Vector */
> -        uint32_t irte_mode:1;        /* IRTE Mode */
> -        uint32_t __reserved_0:3;     /* Reserved 0 */
> -        uint32_t __avail:4;          /* Available spaces for software */
> -        uint32_t delivery_mode:3;    /* Delivery Mode */
> -        uint32_t trigger_mode:1;     /* Trigger Mode */
> -        uint32_t redir_hint:1;       /* Redirection Hint */
> -        uint32_t dest_mode:1;        /* Destination Mode */
> -        uint32_t fault_disable:1;    /* Fault Processing Disable */
> -        uint32_t present:1;          /* Whether entry present/available */
> +        uint64_t dest_id:32;         /* Destination ID */
> +        uint64_t __reserved_1:8;     /* Reserved 1 */
> +        uint64_t vector:8;           /* Interrupt Vector */
> +        uint64_t irte_mode:1;        /* IRTE Mode */
> +        uint64_t __reserved_0:3;     /* Reserved 0 */
> +        uint64_t __avail:4;          /* Available spaces for software */
> +        uint64_t delivery_mode:3;    /* Delivery Mode */
> +        uint64_t trigger_mode:1;     /* Trigger Mode */
> +        uint64_t redir_hint:1;       /* Redirection Hint */
> +        uint64_t dest_mode:1;        /* Destination Mode */
> +        uint64_t fault_disable:1;    /* Fault Processing Disable */
> +        uint64_t present:1;          /* Whether entry present/available */
>  #else
> -        uint32_t present:1;          /* Whether entry present/available */
> -        uint32_t fault_disable:1;    /* Fault Processing Disable */
> -        uint32_t dest_mode:1;        /* Destination Mode */
> -        uint32_t redir_hint:1;       /* Redirection Hint */
> -        uint32_t trigger_mode:1;     /* Trigger Mode */
> -        uint32_t delivery_mode:3;    /* Delivery Mode */
> -        uint32_t __avail:4;          /* Available spaces for software */
> -        uint32_t __reserved_0:3;     /* Reserved 0 */
> -        uint32_t irte_mode:1;        /* IRTE Mode */
> -        uint32_t vector:8;           /* Interrupt Vector */
> -        uint32_t __reserved_1:8;     /* Reserved 1 */
> +        uint64_t present:1;          /* Whether entry present/available */
> +        uint64_t fault_disable:1;    /* Fault Processing Disable */
> +        uint64_t dest_mode:1;        /* Destination Mode */
> +        uint64_t redir_hint:1;       /* Redirection Hint */
> +        uint64_t trigger_mode:1;     /* Trigger Mode */
> +        uint64_t delivery_mode:3;    /* Delivery Mode */
> +        uint64_t __avail:4;          /* Available spaces for software */
> +        uint64_t __reserved_0:3;     /* Reserved 0 */
> +        uint64_t irte_mode:1;        /* IRTE Mode */
> +        uint64_t vector:8;           /* Interrupt Vector */
> +        uint64_t __reserved_1:8;     /* Reserved 1 */
> +        uint64_t dest_id:32;         /* Destination ID */
>  #endif
> -        uint32_t dest_id;            /* Destination ID */
> -        uint16_t source_id;          /* Source-ID */
>  #if HOST_BIG_ENDIAN
>          uint64_t __reserved_2:44;    /* Reserved 2 */
>          uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>          uint64_t sid_q:2;            /* Source-ID Qualifier */
> +        uint64_t source_id:16;       /* Source-ID */
>  #else
> +        uint64_t source_id:16;       /* Source-ID */
>          uint64_t sid_q:2;            /* Source-ID Qualifier */
>          uint64_t sid_vtype:2;        /* Source-ID Validation Type */
>          uint64_t __reserved_2:44;    /* Reserved 2 */

A quick comment before a repost: we can merge the two HOST_BIG_ENDIAN
blocks into one now?

Thanks,

-- 
Peter Xu


