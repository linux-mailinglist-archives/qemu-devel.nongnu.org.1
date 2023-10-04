Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC687B7F53
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo17z-0001gm-L5; Wed, 04 Oct 2023 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo17y-0001fk-89
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo17v-00011t-N0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAi0IIFmd1uLGA69a3sYX8NgxiuutGABC52gw0w1l+k=;
 b=X4bZLOb0K8SGJSrpkSGC6ieN5/wamWVPucrvS3JyzdSEKVHKC4r1TbYz47ljBzaWr7AC5y
 TzDlYWLYMTlJKao+6Hp0ae+Qako7wsNUaop12K4Sk2bro4iJgtKsHdhOifHIcHvDCmeVfu
 pGIp8hlLQu/vjRt358NMQ8TCHdhMvd0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-83mB7VynOsS7eYN0wSMVng-1; Wed, 04 Oct 2023 08:37:17 -0400
X-MC-Unique: 83mB7VynOsS7eYN0wSMVng-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4180b3a5119so21790401cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696423037; x=1697027837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAi0IIFmd1uLGA69a3sYX8NgxiuutGABC52gw0w1l+k=;
 b=CVXrjHasR4DVjBam6Trk617DeKGEB/OyeTM0Cx/2HpL0pplJT3tWQv0qxfMi6OEGmN
 jehLjciy63gBQJ7SdH/NK70CN0qId06X1MEc3ivOhDj0eTnOFkEmQmg1Ac7posxWITfs
 q0JDU2xQZ2bC3SzGFb3/6eHoadLpz9vebsh+T+lVN/I/4bFf4ckvqaDk99AjUAp+g1vz
 Bu9QnBmmNnz8pgkmxkFp7z0rWtKd5u6LN4cK+wBuYsrDuC1hrf5GstJSZSxHKbpiPE2w
 kssAwNQAzg+U4AL94uABSUO23Bc55A/8lxcXUgSTlcLZNW6lyzMi8ZXwMxmT1LSTCw0X
 Q3Kw==
X-Gm-Message-State: AOJu0YyeybQTEcC7PN67QdsySonu2sFzavDlFSudpvQzp7dloSlJQe8y
 yTGWIAK3M4+zCeYeGJHGKRdN0gSFfzuZtkkWPMo2QdunJuovgP5xCACNkLAE2CvgS3En5CZ1u//
 jzLYhBQQko8ZrDU819/TVK+c=
X-Received: by 2002:a05:622a:30c:b0:417:f9e1:664f with SMTP id
 q12-20020a05622a030c00b00417f9e1664fmr2064826qtw.36.1696423037202; 
 Wed, 04 Oct 2023 05:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEIEGPh3VjHBS2G5OxAuSF9eExLVpg8FiVDNgJE9L4xs9bmKUgF0JBLq/AWSHfMT+tUsI1ig==
X-Received: by 2002:a05:622a:30c:b0:417:f9e1:664f with SMTP id
 q12-20020a05622a030c00b00417f9e1664fmr2064814qtw.36.1696423036930; 
 Wed, 04 Oct 2023 05:37:16 -0700 (PDT)
Received: from [10.200.209.159] (nat-pool-str-u.redhat.com. [149.14.88.107])
 by smtp.gmail.com with ESMTPSA id
 b6-20020ac87546000000b00419792c1be7sm1179462qtr.30.2023.10.04.05.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 05:37:16 -0700 (PDT)
Message-ID: <85be2979-c0ca-3eb4-dae9-bbabf256c201@redhat.com>
Date: Wed, 4 Oct 2023 14:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231004090629.37473-1-philmd@linaro.org>
 <ZR1bjpEi5HdFp2xj@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZR1bjpEi5HdFp2xj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 14.33, Daniel P. Berrangé wrote:
> On Wed, Oct 04, 2023 at 11:06:15AM +0200, Philippe Mathieu-Daudé wrote:
>> This series finishes the cleanup which remove the confusion
>> of using 'softmmu' when we really mean 'system emulation',
>> as opposition to 'user emulation'.
> 
> Am I mis-understanding what you mean by 'finishes' here, as
> I see many references to softmmu remaining
> 
>    $ git grep softmmu | wc -l
>    270
> 
> In particular under configs/
> 
> I was also hoping it meant that we'd be changing configure
> to allow
> 
>      configure --target-list=x86_64-system
> 
> though the lazy side of me would like
> 
>      configure --target-list=x86_64-vm
> 
> for less typing

Maybe we should also bikeshed about the naming first... "system" is a quite 
overloaded word in this context already, and "vm" sounds rather like 
hardware-accelerated stuff ... what about using something like "sysemu"? Or 
"fullsys" for "full system emulation" (in contrast to "user space"-only 
emulation)?

  Thomas


