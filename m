Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C05CA7824FA
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:58:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXznL-000404-CY; Mon, 21 Aug 2023 03:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qXzmt-0003yW-KA
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qXzmq-0003BE-Oj
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692604639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9eSWuTq44advvTPB06x5uLALPWnKocppnZ5oPo0BZU=;
 b=PyJeCsL5P3nq6SjNKtM9rJdUcv40Z9rYANVqGO6/oD8gkZS6EUrx0OxXjc4ucCgApiM+mp
 DgMNijpD5wSPyGgDv+z5mA8uG9K2M/Yk+SS7jxxYCc4j0TgKNCzVOyH6bSg5/MoNobkXTc
 m341VEsC81ODDB2kKrT3bxrQMGGi4pk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-a3_82ZX4OxezLAGqydJHXg-1; Mon, 21 Aug 2023 03:57:17 -0400
X-MC-Unique: a3_82ZX4OxezLAGqydJHXg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63cd05c0415so45255816d6.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604637; x=1693209437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9eSWuTq44advvTPB06x5uLALPWnKocppnZ5oPo0BZU=;
 b=ACbVk5/KfNS9TuutKWJVBw/zQRTKN74bBNyNZS/+bj0+VwpX1GnHvN8Ki/BUnDbz3a
 h58ajB9dGp+lx6boWdXSTB8lJ3viIfb6mUCB6ObYLcA8zxhe5pR6eO8s4npWVZddSA2z
 VVzhgc3HUQQsZ8YnGSVm7fpXoq5fhPLZvMyqZcmVyM5UNFTCZ4reCohp0w5rAW6We9dV
 f5Xuidhfu5s8eaNlqjwoow/QyGLgM04K6/d7Fs9hKDZIBR7/54o371FSWbwxjZe57Coo
 jS0yA1dF5C9nBf6gwRrxTeRa7PYqRGmLIirGOWC9WbrOVF+wejcS/x/sVEumwg5ay3aC
 n0Vg==
X-Gm-Message-State: AOJu0YweIYkXGML/gfzf/wTnpafEIpHiHsL/mM2/b5CvH2JzhQMwVSkd
 +m+v+C6HbUA/EGBrvNexg0O4KiMKMIMYTor/3wBQ8/4dKQdPCcthca/m9O8JB5DVxEBKQBO9hxF
 bKH3QpXT212MS+/s=
X-Received: by 2002:a0c:f0c7:0:b0:64f:3cc1:1449 with SMTP id
 d7-20020a0cf0c7000000b0064f3cc11449mr3578496qvl.1.1692604637223; 
 Mon, 21 Aug 2023 00:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbzNT8jHLeGkkJduWlv9Brz+nMAb8cSaPdrTh6o1uBAiIrTqF/917t07c/G0tMD+FY+NLyKg==
X-Received: by 2002:a0c:f0c7:0:b0:64f:3cc1:1449 with SMTP id
 d7-20020a0cf0c7000000b0064f3cc11449mr3578490qvl.1.1692604637021; 
 Mon, 21 Aug 2023 00:57:17 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a0cdc0e000000b0063d2898f210sm2371768qvk.103.2023.08.21.00.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:57:16 -0700 (PDT)
Message-ID: <7c8784a5-5045-8eec-361c-10852b14cd47@redhat.com>
Date: Mon, 21 Aug 2023 09:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/5] target/s390x/kvm: Refactor AP functionalities
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230818111520.698615-1-seiden@linux.ibm.com>
 <20230818111520.698615-5-seiden@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230818111520.698615-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 18/08/2023 13.15, Steffen Eiden wrote:
> kvm_s390_set_attr() is a misleading name as it only sets attributes for
> the KVM_S390_VM_CRYPTO group. Therefore, rename it to
> kvm_s390_set_crypto_attr().
> 
> Add new functions ap_available() and ap_enabled() to avoid code
> duplication later.
> 
> Reviewed-by: Michael Mueller <mimu@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   target/s390x/kvm/kvm.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


