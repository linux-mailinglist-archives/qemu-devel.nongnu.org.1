Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D047091B6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvUr-0006te-84; Fri, 19 May 2023 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvUp-0006tU-Gw
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvUn-00042K-69
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684484992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhXrQ/+2v2wwXuHALY4/4MGiskQNkfHfvZ4vQ1eWVqY=;
 b=GodUx6KUrxLgU63xjgX6Vwds1QTmjeZ9+zmEPwJ5sTwV6ZC7aYcm7S6LDqmitigIMe0GHJ
 MnqxMN9siaIXDIBf0x4KS+JFghgG/nPcSRZcl5J5v979gIPV9Res8kw3qbjWziOhcsE4Db
 UCnLcfrr0hCsvZb+QqiqUp3CzzE5krA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-72mCG47eMDuggLyWcGMwIw-1; Fri, 19 May 2023 04:29:50 -0400
X-MC-Unique: 72mCG47eMDuggLyWcGMwIw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50dfa390825so1754503a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684484989; x=1687076989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YhXrQ/+2v2wwXuHALY4/4MGiskQNkfHfvZ4vQ1eWVqY=;
 b=OLrJzBQ9ErwLenuZroE/AYk2YFtbcUUwRo/09MxSwwPWr2pAdk0/Nrweka8URJMhsk
 E9NDQsW8O1e6gpWI9nvezhlDAynRVh8oecSvvWJb5qkVPUfzYNV3j+p76LnPI8dn2O/S
 Px9zez2VakzOW5oVFNLFS+6xhwrtv0C83sA6pPho2/4O3cNYQDfEiWfEjq3Pxfn+ijEP
 5Ck2lkEHAEFPicLuDQLBv9QxfCkSVp1E0iavXwNZWVBhq4Y0ngIU7VQqmxTSuWChLqRd
 3I2x3yQUT6bXpUQvEZLf89hMpoWtsV3vADPJgO9GXzxE3/ShkhrRbgZ0A5bXLuG9R+mb
 KAcg==
X-Gm-Message-State: AC+VfDyYRTbw1UY4XlBId1hYYzvw5L2Ddmkmc/1Qm2fbMI1ZpoMhsw4l
 7ikBxcFy+qOFuT0XRk9zCrUlU9pB2i23ncG6BJ/SlZImV0/QLQeM+6iMqmRVG8CC9r3wpE75VEt
 J/SWlb7Fe/dQD+iCSrwc3oEA=
X-Received: by 2002:a17:907:3e24:b0:96a:5bdd:7557 with SMTP id
 hp36-20020a1709073e2400b0096a5bdd7557mr1060949ejc.70.1684484989515; 
 Fri, 19 May 2023 01:29:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/GYw5QSeMfsMFlor0ScsVLbLR2FUB998embyjmoqyj+PpZfi7OJ1lxuF/W5ezsoncUk4G9w==
X-Received: by 2002:a17:907:3e24:b0:96a:5bdd:7557 with SMTP id
 hp36-20020a1709073e2400b0096a5bdd7557mr1060936ejc.70.1684484989235; 
 Fri, 19 May 2023 01:29:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 jx27-20020a170907761b00b0094f67ea6598sm2005220ejc.193.2023.05.19.01.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 01:29:48 -0700 (PDT)
Message-ID: <7e2b211f-8da8-3345-528d-bc6f3b35484d@redhat.com>
Date: Fri, 19 May 2023 10:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Yang Zhong <yang.zhong@linux.intel.com>
Cc: qemu-devel@nongnu.org
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <ZGbnrwKTTO1PsDhT@yangzhon>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZGbnrwKTTO1PsDhT@yangzhon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 5/19/23 05:06, Yang Zhong wrote:
> 
> Paolo, please help add below queued sgx fix into this PULL request, which was
> missed from last time, thanks a lot!
> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00841.html
> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg00896.html

Isn't this commit 72497cff896fecf74306ed33626c30e43633cdd6?

Author: Yang Zhong <yang.zhong@linux.intel.com>
Date:   Thu Apr 6 02:40:41 2023 -0400

     target/i386: Change wrong XFRM value in SGX CPUID leaf
     
     The previous patch wrongly replaced FEAT_XSAVE_XCR0_{LO|HI} with
     FEAT_XSAVE_XSS_{LO|HI} in CPUID(EAX=12,ECX=1):{ECX,EDX}.  As a result,
     SGX enclaves only supported SSE and x87 feature (xfrm=0x3).
     
     Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
     Signed-off-by: Yang Zhong <yang.zhong@linux.intel.com>
     Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>
     Reviewed-by: Kai Huang <kai.huang@intel.com>
     Message-Id: <20230406064041.420039-1-yang.zhong@linux.intel.com>
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


