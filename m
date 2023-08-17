Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183E77F2BF
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYyc-0007nb-EO; Thu, 17 Aug 2023 05:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWYya-0007mO-P8
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWYyY-0000ge-5k
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692263248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY8gKkIYznVpBkgl/FxcEAsJOiWROhejvt9C6fGqS4c=;
 b=RYVBFZoCDgyJ7iB3x5qJK4d4tVk/SH3noKe+uaYfwYYz2VDR66XtqPaXrA0MHraSdd9pst
 fWCCmuja/mCkBWJ3KHXPsBC8o52r7zz+iTs/ZFhct0xX1JkZi/FmwWwUMaduDZo6QRi/Ph
 JQ2wB1bdc7AxwyacWPhRLlwqL06cLcM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-7PiAYsJ2P2Wg9UHOV9Nwtw-1; Thu, 17 Aug 2023 05:07:26 -0400
X-MC-Unique: 7PiAYsJ2P2Wg9UHOV9Nwtw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe216798e9so49824265e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 02:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692263245; x=1692868045;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BY8gKkIYznVpBkgl/FxcEAsJOiWROhejvt9C6fGqS4c=;
 b=Oewr5xk9rxpQggqgBvWlpKl2/hjjDhqd2nFcU9ATNjoaVf1C3B02p1A55DgHBunG7d
 rTe3cNhmpKFE8sm3goexylvPZgGTe/+yTctkUamZ2bdiE2+y2vBnPAq5ks+Cp5g6RFLj
 QcDUJBEwWrzJH4v2jh9fN2i5ghwbmY3pRT27KT6I5xt3BPrsZTo3kYE6SlRclg8Ey8P4
 tdDrB3NlgR+SwjRjg03QKM9KDdGgzIrVjVuHrEzgKzshsrS+pC2gi66AUtjq14dOZnYR
 Elm3maiNDDVlPSSYExva5uMkh1UYkMZ3vY32W9qpV7clWoxfiShXII+BlZFIN+7kcL7O
 H/ug==
X-Gm-Message-State: AOJu0YznWPbfqycreBhChF7Uz77odOJoFSyniOOwqxnonY/iFxBA/w3o
 AnOpA8p7wJFj6L+S3hD4FjOPF/gUHfHTLWC7Jzm5+MGbbOKOwY6n+1dZZK021Q2Zc3RQseAbJtf
 3XZabaFX6mJF4bIo=
X-Received: by 2002:a05:600c:c2:b0:3fe:2011:a7bf with SMTP id
 u2-20020a05600c00c200b003fe2011a7bfmr3651371wmm.6.1692263245704; 
 Thu, 17 Aug 2023 02:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSq/bL2PZUBccH5DzrV21iUxrVcEQC19ACzySwJYrSk4MSJImWtUN4+nA2bgAIeAb5neT5xg==
X-Received: by 2002:a05:600c:c2:b0:3fe:2011:a7bf with SMTP id
 u2-20020a05600c00c200b003fe2011a7bfmr3651348wmm.6.1692263245238; 
 Thu, 17 Aug 2023 02:07:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a1ce903000000b003fc015ae1e1sm2228333wmc.3.2023.08.17.02.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 02:07:24 -0700 (PDT)
Message-ID: <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
Date: Thu, 17 Aug 2023 11:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.165, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

@Stefan, see below on a R/O NVDIMM question.

We're discussing how to get MAPR_PRIVATE R/W mapping of a
memory-backend-file running when using R/O files.

> 
> This seems a good idea. I am good with the solution you proposed
> here as well.

I was just going to get started working on that, when I realized
something important:


"@readonly: if true, the backing file is opened read-only; if false,
  it is opened read-write.  (default: false)"

"@share: if false, the memory is private to QEMU; if true, it is
  shared (default: false)"

So readonly is *all* about the file access mode already ... the mmap()
parameters are just a side-effect of that. Adding a new
"file-access-mode" or similar would be wrong.


Here are the combinations we have right now:

-object memory-backend-file,share=on,readonly=on

  -> Existing behavior: Open readonly, mmap readonly shared
  -> Makes sense, mmap'ing readwrite would fail

-object memory-backend-file,share=on,readonly=off

  -> Existing behavior: Open readwrite, mmap readwrite shared
  -> Mostly makes sense: why open a shared file R/W and not mmap it
     R/W?

-object memory-backend-file,share=off,readonly=off
  -> Existing behavior: Open readwrite, mmap readwrite private
  -> Mostly makes sense: why open a file R/W and not map it R/W (even if
     private)?

-object memory-backend-file,share=off,readonly=on
  -> Existing behavior: Open readonly, mmap readonly private
  -> That's the problematic one


So for your use case (VM templating using a readonly file), you
would actually want to use:

-object memory-backend-file,share=off,readonly=on

BUT, have the mmap be writable (instead of currently readonly).

Assuming we would change the current behavior, what if someone would
specify:

-object memory-backend-file,readonly=on

(because the default is share=off ...) and using it for a R/O NVDIMM,
where we expect any write access to fail.


But let's look at the commit that added the "readonly" parameter:

commit 86635aa4e9d627d5142b81c57a33dd1f36627d07
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Mon Jan 4 17:13:19 2021 +0000

     hostmem-file: add readonly=on|off option
     
     Let -object memory-backend-file work on read-only files when the
     readonly=on option is given. This can be used to share the contents of a
     file between multiple guests while preventing them from consuming
     Copy-on-Write memory if guests dirty the pages, for example.

That was part of

https://lore.kernel.org/all/20210104171320.575838-3-stefanha@redhat.com/T/#m712f995e6dcfdde433958bae5095b145dd0ee640

 From what I understand, for NVDIMMs we always use
"-object memory-backend-file,share=on", even when we want a
readonly NVDIMM.


So we have two options:

1) Change the current behavior of -object memory-backend-file,share=off,readonly=on:

-> Open the file r/o but mmap it writable

2) Add a new property to configure the mmap accessibility. Not a big fan of that.


@Stefan, do you have any concern when we would do 1) ?

As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:

+   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
+   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
+   persistent writes. Linux guest drivers set the device to read-only when this
+   bit is present. Set unarmed to on when the memdev has readonly=on.

So changing the behavior would not really break the nvdimm use case.

Further, we could warn in nvdimm code when we stumble over this configuration with
unarmed=on.

-- 
Cheers,

David / dhildenb


