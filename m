Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77A739DA3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGud-0001Dj-Ko; Thu, 22 Jun 2023 05:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGub-0001BA-9T
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGuZ-00035j-Ba
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687427250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Bz1MDUAGegLmUcMTYwL65VY1c4z30rvlkSNatPGiU=;
 b=RlxsFmsgVmwRO0XvujBGHRWRMwrLxcFLR2GEGDDhYs7z0T58iJZCSloQf854uUHJCusydk
 IpZcpHysRqIkz2iZmHNLdiFFvfOGp4X+hhBvbcDn2O+m8ZtJRTspiGfI/UdpBR1ggHiW2S
 IgNRhTJc0lWP1M0r3JZ8j+fqK1leAuI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-RJpHbpjmOvuoQVbObV-icQ-1; Thu, 22 Jun 2023 05:47:28 -0400
X-MC-Unique: RJpHbpjmOvuoQVbObV-icQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9879d2fc970so384915866b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427247; x=1690019247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d3Bz1MDUAGegLmUcMTYwL65VY1c4z30rvlkSNatPGiU=;
 b=faQV4ZgbKGO1gogv9V5JSlwUWqPbZNX7B1L5OBriZ/ceiOVpQPKjgTcYikSqQXMsk8
 dH32TRPcy7XirBWaorsyQ4BfLxcxLEy/CvCjkKeJnmJfoEQlVtn3RYPNImqNaFzDmDFx
 15rdPnltkJjb4GNWsnY/fyNvtLSjq87gno266Swv4sXv754OrSBpVAwb1DDwj1fqhA65
 3nL8VdX+eTBdwr3wafIdXZepBm/X5DOXnsplOThlzJgfqlW6AmYb/3B+YB7jNehMdebl
 sBPlpPtIwoZWCCd8yAxuWtHv1QfvefVnTPi0DDSYDLd/bx3rbgW8G2Dl9o5/G2XB6Lym
 mIUQ==
X-Gm-Message-State: AC+VfDyannbThE/eT6GZTfdIaJHAWTFqfo6+N4kF1ee2ZAiTRm7VF9fg
 9R4h53Nt89462gqfxuHcoAKjVSGh+pzDEmcuzYc+vbQTdHTCj/KHXAZtoUro9dCneF83Gn5TQsc
 iFBY1amt30bDYQw4=
X-Received: by 2002:a17:907:60c9:b0:988:e243:7a9f with SMTP id
 hv9-20020a17090760c900b00988e2437a9fmr9581729ejc.35.1687427247785; 
 Thu, 22 Jun 2023 02:47:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7X5Eq8yMPllWTFGlz9dPAPeTy/chqET/jupG/cpx7YD6b/rjAXxZ8YgMtDfVlhmOr93h3Axw==
X-Received: by 2002:a17:907:60c9:b0:988:e243:7a9f with SMTP id
 hv9-20020a17090760c900b00988e2437a9fmr9581715ejc.35.1687427247506; 
 Thu, 22 Jun 2023 02:47:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 u15-20020a170906780f00b009884b9da1f7sm4384904ejm.106.2023.06.22.02.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:47:26 -0700 (PDT)
Message-ID: <39ab6c4d-9c02-db9d-e6b3-fdbc29f96e94@redhat.com>
Date: Thu, 22 Jun 2023 11:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: always build network bootloader
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-8-pbonzini@redhat.com>
 <bcd7bd4829ba2046b7cc8196e8e83fba338f2f94.camel@linux.ibm.com>
 <2c0f81cc-af61-515d-8d83-84da6f3aefb5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2c0f81cc-af61-515d-8d83-84da6f3aefb5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/22/23 10:42, Thomas Huth wrote:
>>
>> Only if run in a git repository, not in a tree generated with 
>> archive-source.sh
>> which doesn't package roms/SLOF.
>> So without the check below the build fails.
>> This is not inteded, is it?
> 
> I guess archive-source.sh needs to be changed to include the SLOF 
> sources now? Paolo, what would you recommend?

It's not strictly necessary, I have sent a patch at 
https://patchew.org/QEMU/20230618212039.102052-1-pbonzini@redhat.com/ 
and I'll have to send v2 based on Nina's comments.

Paolo


