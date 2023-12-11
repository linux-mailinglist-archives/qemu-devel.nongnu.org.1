Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93580C131
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZXa-0000Su-5g; Mon, 11 Dec 2023 01:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rCZXX-0000Se-1m
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rCZXV-0000yP-Eu
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702275192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X8yc8vtMP3rJ05sZgKZOX27hhOcd1/VodHgi1PFjUW8=;
 b=SZ8stLajhBP54HGAqo9Udw31QSTJMNzRbIWxPHPwjHHVzm9hqc0vdBZ4UiNYPwUmGABD4l
 q99XaeftGSK4Odjsr4AC8q08tAohi+KSSd72kj/wNjMklrD0SLAJrAiYFQt1pUFfEtlniO
 yLmi0SV/CWUYCmyAeZpts+xYckrn/w8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-nFRGvbYRPW-bQ4_gCsyP9A-1; Mon, 11 Dec 2023 01:13:08 -0500
X-MC-Unique: nFRGvbYRPW-bQ4_gCsyP9A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77f38f2f6fbso651891185a.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702275188; x=1702879988;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X8yc8vtMP3rJ05sZgKZOX27hhOcd1/VodHgi1PFjUW8=;
 b=Dnbs3WQNoWxYqTfeVdvfLJGpecoSU8OTHialHWLnbLsbxVogZDtT794R//H89tcalU
 8kEfMETgmC9HKOg5+dkQbm6se2z1kb4eVXkLr7m46IDISurMGakujo8D+sWAv6d6b/ET
 gGkneKiFrpbc0cNKyP0z3Cgm+r2EZa1/i7h2EJVHJhA3UbrsDC/ZTW5tFaKLG1kG5fIx
 NIsSk7BnVczHeB1u/1A3KMll4m64b9reK56Pjy/JBEznzapei3MtdoyLJb0wH+wpXwQ0
 9/JUqBmDAlMbphKNUjC9E2yJF7dqJ+t3cWNPfJQdpGAhJfa9pQDMeD2XSG7P+c4Qypy/
 87Yg==
X-Gm-Message-State: AOJu0YzRJjHVxfvpQa+QafyiOshd8k8TfpdvR6HsYArgCXncPpgx2mnW
 nPE4aJDsZqggTJ+XH0jq3Jw5abX3yDqpEL51HChrtV1J2Biszd26cJUhE8WNYL/8qmYb/FjCP1i
 sfL6QdYamZjQMVQM=
X-Received: by 2002:a05:620a:27d4:b0:77d:98a6:35aa with SMTP id
 i20-20020a05620a27d400b0077d98a635aamr6391774qkp.13.1702275188284; 
 Sun, 10 Dec 2023 22:13:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBCcgjk84xqlMYUDi++0WFcR3zQXo3AydRUp0s3O1WBLP1oPb0Meei4AyEowBzY12nMIMeBQ==
X-Received: by 2002:a05:620a:27d4:b0:77d:98a6:35aa with SMTP id
 i20-20020a05620a27d400b0077d98a635aamr6391764qkp.13.1702275188040; 
 Sun, 10 Dec 2023 22:13:08 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-138.web.vodafone.de.
 [109.43.178.138]) by smtp.gmail.com with ESMTPSA id
 qt6-20020a05620a8a0600b0077d8622ee6csm2661336qkn.81.2023.12.10.22.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Dec 2023 22:13:07 -0800 (PST)
Message-ID: <91f10a94-5337-490a-8799-886ab47131a7@redhat.com>
Date: Mon, 11 Dec 2023 07:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for New PPC Machine Supporting Multiple SMP Cores
Content-Language: en-US
To: aziz tlili <aziztlili2222@gmail.com>, qemu-devel@nongnu.org,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
References: <CAHwHw5Bk7qbDfTmDpV82xcO+YujeJa09mCgdd7c8oQvNLxVKKA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAHwHw5Bk7qbDfTmDpV82xcO+YujeJa09mCgdd7c8oQvNLxVKKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 07/12/2023 13.53, aziz tlili wrote:
> Dear QEMU Team,
> 
> I hope this message finds you well. I've been a user of QEMU for well over a 
> year.
> 
> I wanted to share an idea for a potential enhancement that I believe could 
> benefit many users, including myself. It would be fantastic to have a new 
> PPC machine model similar to the existing mac99, but with support for 
> multiple SMP cores.

  Hi!

Does it have to be a mac compatible machine? You can use the "pseries" or 
the "powernv" machines already if you need SMP in a PPC guest...

  Thomas


> The ability to simulate multiple SMP cores within a PPC machine environment 
> would significantly enhance the capabilities of QEMU for various 
> applications, testing scenarios, and development purposes. This addition 
> could greatly benefit the community working on PowerPC architecture.
> 
> I understand the complexities involved in such developments but wanted to 
> express the potential advantages and how this enhancement could contribute 
> to expanding QEMU's capabilities.
> 
> Thank you for considering my suggestion. I would be more than happy to 
> provide further details or collaborate in any way that could assist in 
> making this idea a reality.
> 
> Best regards,
> Aziz Tlili


