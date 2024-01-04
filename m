Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E9824A5C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:32:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVIs-0001gb-CC; Thu, 04 Jan 2024 16:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rLVIq-0001gT-F8
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rLVIo-00012N-E4
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704403856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8L6EWvhJPF/zb9OOBelfxiKlRzNaoujVPynLq1bV+8Q=;
 b=ItkMWYAc05r5fpuzlkt05ENu1SxM9tsyTDj76VjklyVPvjSTagUM8a7Wl/wWzkoNza/Zet
 lPvIsLDBYkcomNLfwBRj22mhEa/gaTlEIUtnd/83vkySHaYcKYjJvlIoIV2GjcODoIUk5/
 9AAnbq7ULB3dWSXKxOKECwyZ8b2UiwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-uTnSqP8NOrG9QR5u5JLmNA-1; Thu, 04 Jan 2024 16:30:54 -0500
X-MC-Unique: uTnSqP8NOrG9QR5u5JLmNA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d8f402742so6321105e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403853; x=1705008653;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L6EWvhJPF/zb9OOBelfxiKlRzNaoujVPynLq1bV+8Q=;
 b=CJ9NAFidkE0bDqtdLnbmeSSJ1E7JWcpy3LxgiGFrm5Cr29EPmIQLQycHfkQMKbQM14
 eB2KjMoVNyUOXOfU/pzPQ2H20w2F2ClVBQf1wyvXZ905LYmoXm2Z96MArSDKpKrMTlrl
 PoR/325p4UdraBvu6z3adJ/Pf9yaHK5k8xTB8jQptDqt+HPw/7FL0T92OC812ce4JYB+
 cpEb1J0yjrHAiNeWpsRXrx4oNBtCWdoULIyOOYR3A85d6Zxm3JmC/CY0j6ltp8zgZ3kh
 F0yldZKymZsbOi2dOnpS+F1JOTwjtGgcAyTSmsHA1yIeZ2ANmkiDgDGw/3TcoB9S3VmE
 mkqw==
X-Gm-Message-State: AOJu0Yxjr5gjYPPsg5QUwQ+6QYRFytAHOy/e4iWq7AEnQ5oj90BGk5cb
 tpvhFyfvFPoCFAjkUBgeUnkql4g7RmRjpc0wnBz+BNA2UM/SEdFzvWnXyMT7LrdMBRfDUDZxzVd
 qwQ+YUXYUxe2FbVyqzDcEYgI=
X-Received: by 2002:a05:600c:4f10:b0:40d:596e:f250 with SMTP id
 l16-20020a05600c4f1000b0040d596ef250mr688084wmq.13.1704403853387; 
 Thu, 04 Jan 2024 13:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI8/vIFEAeGOJZlY4p0xXhJDiyLh3dVhtQ0Keh5plAl2zzX/wnlSxsA761WmqiI05H6WCv9Q==
X-Received: by 2002:a05:600c:4f10:b0:40d:596e:f250 with SMTP id
 l16-20020a05600c4f1000b0040d596ef250mr688080wmq.13.1704403852995; 
 Thu, 04 Jan 2024 13:30:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c720:6400:963d:9726:6d56:aa61?
 (p200300cbc7206400963d97266d56aa61.dip0.t-ipconnect.de.
 [2003:cb:c720:6400:963d:9726:6d56:aa61])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c139200b0040d5ae2905asm392011wmf.30.2024.01.04.13.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 13:30:52 -0800 (PST)
Message-ID: <9318bc3d-5a6d-4c4b-90f5-1209c7e4dc20@redhat.com>
Date: Thu, 4 Jan 2024 22:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Add ioeventfd option for balloon
Content-Language: en-US
To: =?UTF-8?B?5rKI5ZOy6LWf?= <szy0127@sjtu.edu.cn>, qemu-devel@nongnu.org
Cc: mst@redhat.com
References: <799810807.232349.1704352540541.JavaMail.zimbra@sjtu.edu.cn>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <799810807.232349.1704352540541.JavaMail.zimbra@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.01.24 08:15, 沈哲赟 wrote:
> Traditional mmio in balloon makes Qemu do balloon inflation in the same
> thread as vcpu thread. In a CPU overcommitment scenario, host may run
> more than one vcpu threads on one host CPU, which makes
> madvise_dontneed_free() wait for a long time due to the function
> cond_resched() at host side.
> 
> If using SEV/ES and the kernel provided by AMD, the overhead will
> become even much larger.(From 90s to 1400s when reclaming 4GB)

I recall that encrypted VMs etc are not compatible with ballooning. Are 
there other (i.e., guest kernel) changes required for this setup to 
work? ("provided by AMD")

> 
> With ioeventfd, the thread for host to do balloon inflation will
> be separated from the VCPU thread, leading to better performance
> for the whole process of balloon inflation.(1400s to 263s
> in SEV CPU overcommitment scenario)
> 
> As a para-virtual solution, balloon serves for host so the process
> of inflation in host needs to run on a host iothread instead of a guest
> VCPU thread.
> 
> Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>

If this a resend i.e., v2, please indicate changes below the "---" and 
use versions like "PATCH v2".

https://lkml.kernel.org/r/https://lkml.kernel.org/r/20231212075058.710918-1-szy0127@sjtu.edu.cn

-- 
Cheers,

David / dhildenb


