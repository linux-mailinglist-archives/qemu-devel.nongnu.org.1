Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF5986F56
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Sep 2024 10:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stkDo-0007hD-1k; Thu, 26 Sep 2024 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stkDX-0007fz-EB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1stkDV-000665-NV
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727340674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OBi+OzjBUbVlaARH/a7ZS2dMIXFXTuH8z/wBb3xJupk=;
 b=i4MFtAVhUxq4XXLi7074qYsDjtZLym4z3PqWg3S3++aNC6Yt71CMIVzEbVNMTrT4WBAEvu
 QoZA9sxs7eZXRp/dmlyaI9jzd45CmPsP4vsr9nRZ8fgEjO0YZRj7gxFruarHGUQM7VomKb
 hm5PWnKbqh6Dx904RxIjdtRQVPBeiT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-S5tEveuUNECcHDIRpoRVCg-1; Thu, 26 Sep 2024 04:51:13 -0400
X-MC-Unique: S5tEveuUNECcHDIRpoRVCg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42e8bf0f5e8so4377555e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 01:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727340672; x=1727945472;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBi+OzjBUbVlaARH/a7ZS2dMIXFXTuH8z/wBb3xJupk=;
 b=g/DAG2b16OQaqTTDYxb7YdSfDbg7CEIOrb5/jba+czfVtW5jBW202dIUw1m2B6KC5s
 TwjE3+1Zlf2t106UjVV9yMQGjg8kg0+u2KqKGGrEG/CTnMVyuddFzhIq5DTxdULY5ous
 D8laxyZXjaA3qhZUKlvIwpk/YTjnpPuM+e6CAfGp8B9uOqMfw9Gj3YBw3f5T0ULRnotw
 Hm9X8JV7ha/K5KmpUbYP21IqBXfc6G/buywC+Oj3/lxPhUd4TFgOwMIHQn17Odbk2iml
 j9vwWqAGyONsWT3eM5NhdnHrFKqpqZKYWvgZkiIm8PoOmBxdGBSATKpWu9HpNGsv2xqZ
 HmSA==
X-Gm-Message-State: AOJu0YwSkwotqVV0Xe7mplJZNywRnH2y4IWlxjycBphyP9AFu4fk2xMF
 Su3dMu8NW26gxPi7i7/0gM03wgS4jEvkioX7X4GLoT1AnqgleT/rmjL4IowF6QiBMy7ANDvHLgg
 UMrFsP22UUq/XCEaiLHu4khLEdhSTb6+aGr/cxNDMT2ZefzkUyOpp
X-Received: by 2002:a05:600c:3556:b0:42c:baf9:beed with SMTP id
 5b1f17b1804b1-42e96146c41mr36312885e9.27.1727340672054; 
 Thu, 26 Sep 2024 01:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXlsm9xoACKF6f2D7DIqQ9dCKh4gG2SS8L7pepaH/41ooQJcVRfcW6W9rZCcnzFX8aB2LG3g==
X-Received: by 2002:a05:600c:3556:b0:42c:baf9:beed with SMTP id
 5b1f17b1804b1-42e96146c41mr36312725e9.27.1727340671616; 
 Thu, 26 Sep 2024 01:51:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a?
 (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de.
 [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc1560a7sm5965160f8f.0.2024.09.26.01.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 01:51:11 -0700 (PDT)
Message-ID: <b43b821e-3fe9-47fe-af68-79e75f872b20@redhat.com>
Date: Thu, 26 Sep 2024 10:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: kconfig: memory devices are PCI only
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20240906101658.514470-1-pbonzini@redhat.com>
 <CAM9Jb+gZ4+M1GOvRy6x8eg8OgOCyoEkBwKS6ZYQhGOOYndh6_g@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAM9Jb+gZ4+M1GOvRy6x8eg8OgOCyoEkBwKS6ZYQhGOOYndh6_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.09.24 09:39, Pankaj Gupta wrote:
>> Virtio memory devices rely on PCI BARs to expose the contents of memory.
>> Because of this they cannot be used (yet) with virtio-mmio or virtio-ccw.
>> In fact the code that is common to virtio-mem and virtio-pmem, which
>> is in hw/virtio/virtio-md-pci.c, is only included if CONFIG_VIRTIO_PCI
>> is set.  Reproduce the same condition in the Kconfig file, only allowing
>> VIRTIO_MEM and VIRTIO_PMEM to be defined if the transport supports it.
>>
>> Without this patch it is possible to create a configuration with
>> CONFIG_VIRTIO_PCI=n and CONFIG_VIRTIO_MEM=y, but that causes a
>> linking failure.
> 
> Just curious what is required to make virtio-mem & virtio-pmem compatible with
> virtio-mmio?

I assume not that much: primarily implementing the virtio-md-mmio 
abstraction, and the virtio-mem-mmio/virtio-pmem-mmio proxy devices. 
Then, it needs to be wired up in the machine hotplug code.

I posted the virtio-ccw variant a couple of days ago [1].

> 
> Maybe late but still:
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

I already sent a merge request that includes this change. If I have to 
resend it, I'll include that. Thanks!


[1] https://lkml.kernel.org/r/20240910175809.2135596-1-david@redhat.com

-- 
Cheers,

David / dhildenb


