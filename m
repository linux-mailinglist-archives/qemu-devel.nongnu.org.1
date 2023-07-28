Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412D7668AD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJ4w-0001yz-MA; Fri, 28 Jul 2023 04:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPJ4s-0001uG-Ga
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPJ4o-0004nL-E7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690533837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQPSOWiHWym18h67/LbxEB7Z7ClK6gaLhrq3I6bzTwU=;
 b=jR/oe64sxdYO/BsKmvMwqhdA7NMx/0OmkUBj8IhkeP13+kM8YN+BiRZae7hn3UQM30v1rC
 6WR92iZZ/btvG5u2Z8w1V/l46j/WC51MUYLe5Lmt7ttcEE+K/6nuF6xHaDghYj5//PJZZ9
 X/0q3YMxY9bqTctwTdBhFer4zfMIf4I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-cvJxCr6aNKq7GOKnFRfc8w-1; Fri, 28 Jul 2023 04:43:55 -0400
X-MC-Unique: cvJxCr6aNKq7GOKnFRfc8w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d0c38e986so19090546d6.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 01:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690533835; x=1691138635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQPSOWiHWym18h67/LbxEB7Z7ClK6gaLhrq3I6bzTwU=;
 b=lgx76+LlKWT6RNb1MX5WIiAa1SWIcZqotzqa9gPEGOSAECa+FngsCUbEUKzNUYqoQU
 uNEHQbVv/uhy2LifPHHi+jgYz0doDADLhdzozl4RHQmboNffYEhu46Z4avv+5hOPDe5n
 uvUNnqpqocqHdPU231GvhXH38cyWadUvznDFv92HyYFuiDGNAgtVutFae0CCzOawmCFd
 paZyRr30Hha2T1FncRBwp8Leu5odb6HfTQDCa9bvQe3QLzNQ+XtIUTn6Ya25P2n3dhMG
 uAnCVyOVCv/xmsjO8cOQ3+tIx1X32SX3bLcPvgte/RfbXYD+G/UoncoH8Cf5Yl3VXcWx
 BdGw==
X-Gm-Message-State: ABy/qLaBgiFWzBfOHQwNQN8oSnNc+18fz0m8k42hElEQ2YJQyTprpPna
 xwtQu5Kg2HhUTkORO5plCp6+A+ii/aYfJ19tZGM5kYl8PpNpt98lnZSFsyrcDg26SjRf26QZCdB
 DT1SGBV6noSTgM/8=
X-Received: by 2002:a05:6214:4011:b0:632:3633:7012 with SMTP id
 kd17-20020a056214401100b0063236337012mr2045513qvb.8.1690533835326; 
 Fri, 28 Jul 2023 01:43:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGx4JTtnM7FhvI1Ro9N9TT3fPhYwrW9YhUsX5y/Yw7jpFj5ecKfVqo2SWYPbTCXfVcrbeLURQ==
X-Received: by 2002:a05:6214:4011:b0:632:3633:7012 with SMTP id
 kd17-20020a056214401100b0063236337012mr2045503qvb.8.1690533835133; 
 Fri, 28 Jul 2023 01:43:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a0cdc0f000000b00637abbfaac9sm502428qvk.98.2023.07.28.01.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 01:43:54 -0700 (PDT)
Message-ID: <8e44b87f-c22c-9071-1ffe-7d16cff58869@redhat.com>
Date: Fri, 28 Jul 2023 10:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: "Liu, Jing2" <jing2.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
 <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

[ ... ]

> Sorry I didn't quite understand "info.flags be tested against VFIO_IRQ_INFO_NORESIZE".
> I saw kernel < 6.4 simply added NORESIZE to info.flags and latest kernel adds if has_dyn_msix.
> Would you please kindly describe more on your point?

I was trying to find the conditions to detect safely that the kernel didn't
have dynamic MSI-X support. Testing VFIO_IRQ_INFO_NORESIZE seems enough.

>> In that case, QEMU should report an error and the trace event is not needed.
> 
> I replied an email with new error handling draft code based on my understanding, which
> reports the error and need no trace. Could you please help review if that is what we want?

yes. It looked good. Please send a v1 !

Thanks,

Cédric.


