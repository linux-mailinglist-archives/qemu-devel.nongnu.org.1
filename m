Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1330E831FD7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYIM-0003Tm-M9; Thu, 18 Jan 2024 14:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQYIK-0003Sb-CJ
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rQYIH-0006nO-O3
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 14:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705606996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koQvKLzgiJBRbM9rn4dUnnEjUWHFJOOfyaTh0yVMhdo=;
 b=dU7AK2AI9DWJzxBUu6jeFuP1kHZN44fdmlS1EZD5cQax8Jc19HXuGnxRQwnMOn5KoLCik3
 V5IDACtoy6iPAz3cQVNvYtX1wDjectc260eP42NiR1KyYubrllNCyjxD3489e7/KBdQBdj
 KR/FILYqkvqypuzWke8+nOoN+033W6M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-bFXdgTooOTi1J3L1wXA3bQ-1; Thu, 18 Jan 2024 14:43:15 -0500
X-MC-Unique: bFXdgTooOTi1J3L1wXA3bQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-783163c7c38so4117285a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 11:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705606994; x=1706211794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=koQvKLzgiJBRbM9rn4dUnnEjUWHFJOOfyaTh0yVMhdo=;
 b=NUO+5w2lgdoQJfPWLdy4kT0h2FYMqbOsOEdgfukfF+w8gL1d5r+Kzf4aYXNk4z4coI
 d5rVRUaE171OH3gnZsl5+JX7tG7Ham24O7C2NJRskZgKaW/iS88O+hNsY2hg1eYcFIMZ
 /cqvZ99UII9KcthioKJ768GA+Tf4xzXiQ0553CfggSBULavAw1Um205Yfrrv/jsCT/3z
 9dAQ01T5vQUJ7u2vm3vE1zfU/6xrcVSZjAdD23QvS64duTHyGKyt2Tlt+JhE0HK9NFqN
 Ec4DAyL0fDJSho3eW+zl4HhWZBE4SCq7lIXqKTzCAZP8r7/jvf8YDejw8TjyDuPDLXua
 k8lA==
X-Gm-Message-State: AOJu0YwDQjeF9kkcYCywLi3OnXZ1VjRy8oQn9DHhULVqudXqO17AybrR
 JmQ5O4nMH2Ybf4P7enNgwvQh/KYT5R7jpQQp/4OdeEhEinVckzKEtdaAoK4qo2yq4MYsg1/mUhD
 GDSOXxtza+XasSVFbDW1zcvRLq8vVYRpddnzGbmos+cKnQ7B9zkMO
X-Received: by 2002:a05:620a:2117:b0:783:85df:e6f6 with SMTP id
 l23-20020a05620a211700b0078385dfe6f6mr162447qkl.12.1705606994701; 
 Thu, 18 Jan 2024 11:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEggDvMmVatCVrU7+8yu0JCQLG69ubxYCYo7UpD5rbAvsnUDbZgEvlzDnTWr+PJZiYPoONqMw==
X-Received: by 2002:a05:620a:2117:b0:783:85df:e6f6 with SMTP id
 l23-20020a05620a211700b0078385dfe6f6mr162441qkl.12.1705606994408; 
 Thu, 18 Jan 2024 11:43:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 os5-20020a05620a810500b007831ffa4234sm5514948qkn.42.2024.01.18.11.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 11:43:14 -0800 (PST)
Message-ID: <8090142d-0a05-4940-86f1-e7ee1af6845d@redhat.com>
Date: Thu, 18 Jan 2024 20:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] s390x/pci: fix ISM reset
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240118185151.265329-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/18/24 19:51, Matthew Rosato wrote:
> Commit ef1535901a0 (re-)introduced an issue where passthrough ISM devices
> on s390x would enter an error state after reboot.  This was previously fixed
> by 03451953c79e, using device reset callbacks, however the change in
> ef1535901a0 effectively triggers a cold reset of the pci bus before the
> device reset callbacks are triggered.
> 
> To resolve this, this series proposes to remove the use of the reset callback
> for ISM cleanup and instead trigger ISM reset from subsystem_reset before
> triggering bus resets.  This has to happen before the bus resets because the
> reset of s390-pcihost will trigger reset of the PCI bus followed by the
> s390-pci bus, and the former will trigger vfio-pci reset / the aperture-wide
> unmap that ISM gets upset about.
>   
>    /s390-pcihost (s390-pcihost)
>      /pci.0 (PCI)
>      /s390-pcibus.0 (s390-pcibus)
>      
> While fixing this, it was also noted that kernel warnings could be seen that
> indicate a guest ISC reference count error.  That's because in some reset
> cases we were not bothering to disable AIF, but would again re-enable it after
> the reset (causing the reference count to grow erroneously).  This was a base
> issue that went unnoticed because the kernel previously did not detect and
> issue a warning for this scenario.
> 
> 
> Changes for v2:
> - Fold a typo fix from patch 2 into patch 1 where it belongs
> - Add block comment re: timing of ISM reset
> - Add review tags


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




