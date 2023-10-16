Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABB7CA49C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKMD-0004bk-Lm; Mon, 16 Oct 2023 05:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKMB-0004ar-A8
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKM9-0005m8-EP
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6V9dxaVn/99eF/ZvK8YhP5v01VZLuqoiSwhRH2Xlmcc=;
 b=Yp7OWbQadfVO9fyAb1ohmrGcdw5JezdQf+7KN51iaAW85kmCjNYqpRBh9HSTlIzPK320Wv
 jRjFr4d1YLtf/lQcWFpWCsSdLAZ2XEihF/mSQY4iP3LqOqoLH8rvxiJEtpA8KPakHeYGts
 yAnECjL3994fqNXvP+riPtK+hbMu5Tk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-psNIiKFSP1uoZ1NWMUrFmw-1; Mon, 16 Oct 2023 05:57:44 -0400
X-MC-Unique: psNIiKFSP1uoZ1NWMUrFmw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b9ecd8c351so292804066b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697450263; x=1698055063;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6V9dxaVn/99eF/ZvK8YhP5v01VZLuqoiSwhRH2Xlmcc=;
 b=BFoZGu7dJEDDJcHUFxDPbxUtp/AFBiYHRHWnxQCryLc0ZLg3J2jl8WW8Qkjh0bFX5V
 PQIQ6V3INUuwIczD8Td7H5TAPF/vc8vsmrdUyXvVXj+tEZLisO8QgvFyiUidK+HPMZzw
 /O/0o+fdNy62W6GxUAI2JQZQe6WGzGQqiMeRBMWpY6ylNaPQUtvaJGkPBOejHCXe1HFN
 h0CZ8ASYBpz8gmFZuGPAD0YXm32C0wIe6zTafLKhY8X3LtsIYirCqb3vii0A4OHeHe6o
 AH9xnnMTaXSSVHPEdpFSqnOJV7Q7tyWDKueFK2Zdwi7KvdjtxgO9rPZyUNO6DzPNq1q9
 1Izg==
X-Gm-Message-State: AOJu0YwH3OB0asWqeveQeJlSHnJdV1xGZFF9CubXD9uXlusRjM/+BUU4
 IOriny6kFNtNAByx7/P4GXb3JNpKLU6vISUCYw10F3o8yx45kqyw1KkVgXCG3g/eHjLJmelWONa
 tHkFUjjkPHQADrd4+6UPDrXk=
X-Received: by 2002:a17:907:9486:b0:9bf:30e8:5bf9 with SMTP id
 dm6-20020a170907948600b009bf30e85bf9mr4723656ejc.4.1697450263269; 
 Mon, 16 Oct 2023 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzmrZKoE5cvrHqcgEa/Qhpco1I0w5xPUbRhpokVk51Np5BSAcA9nP+STrCDwdTVR10UgtiLw==
X-Received: by 2002:a17:907:9486:b0:9bf:30e8:5bf9 with SMTP id
 dm6-20020a170907948600b009bf30e85bf9mr4723647ejc.4.1697450262951; 
 Mon, 16 Oct 2023 02:57:42 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.160.112])
 by smtp.googlemail.com with ESMTPSA id
 c22-20020a170906529600b0099c53c4407dsm3749392ejm.78.2023.10.16.02.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:57:42 -0700 (PDT)
Message-ID: <f212ba30-0d10-4bb8-900a-215dadac837c@redhat.com>
Date: Mon, 16 Oct 2023 11:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -drive if=none: can't we make this the default?
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/14/23 21:16, Michael Tokarev wrote:
> Can't we make -drive if=none the default?
> 
> Yes, I know current default is ide, and whole world have to use if=none explicitly
> to undo this.  I think at this point we can deprecate if=ide default and switch to
> if=none in the next release.  I think it will be a welcome change.

I think if anything we should have no default at all.  But if I had my way:

1) if=none would be deprecated (but with a much longer cycle than 1 
year, probably), and everything that uses it would have to use -blockdev.

2) -drive would be limited to a very small set of suboptions (file, 
cache, if, and the ones in qemu_common_drive_opts) and anything that 
specifies the driver would go through -blockdev.

Paolo


