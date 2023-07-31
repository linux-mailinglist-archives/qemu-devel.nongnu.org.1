Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D8769592
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRds-0005o9-Lw; Mon, 31 Jul 2023 08:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQRdq-0005ns-Qz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQRdp-0003QF-7m
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690805087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUwDYRm9SBP3FX1ljOD7CIZzzFg60DUeDXGqaffiMZQ=;
 b=QG350PPCxk8z0Sx1W2ycyQHYYYVuZcc9dcDX73TZxkf7WJCq+w1Dy8vkOg3zDA5YS4uXiF
 213KpRXpKA/VHPyR6APrY7Wp/zcGP1S9oSmJlZ0oJ9nx3xG1+vTtCvdyTDJwxJA08wNDOt
 7MK2zRPEdo0F3+Pap10LMOlvqxI50Lw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-IeuGIxmFP-Gw33v4S9Ytmg-1; Mon, 31 Jul 2023 08:04:46 -0400
X-MC-Unique: IeuGIxmFP-Gw33v4S9Ytmg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63d0b65ae89so33429326d6.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805086; x=1691409886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUwDYRm9SBP3FX1ljOD7CIZzzFg60DUeDXGqaffiMZQ=;
 b=NdZhpX/8BTdEkdA35NZWR5DEkASa/grJ7RTenNr6ZnXkhJS9oB2jeIWpGd8VZB1700
 j1iOU22P9/NSowc3j8ossiyOVtk/9mFr1M5D87pClos1E6rtoB78mJwONMmKnyc20d4a
 /GAV2mpRXjLx+MhWqsJJMblYBalBC/EH/KXBs82u2FnXyojIeJaa9j34KMshMeqfi2mi
 kfZM7vbtMvCrg1vZkXyk6SPejhO8+ELwKDCD7gph3uWQYC+QB9owXkgLrOliWMbF4lPp
 D8IFg2/b2hGhyrYQvnWSSaimgQqjRJ5w2KzDA3U/E+fiBKtKpG6kBLEKILx/2csAbO/t
 odag==
X-Gm-Message-State: ABy/qLZ6Md2tqM67b63kDDQEjjWIkoAixfsD7RYcII2+MzmgR+c+O8EC
 JHwQBWxwP0abN5qpsue94Dp4mZYuJDqdv78iCPLuAztWW5fc2URVhT83idw25jcDziDsfj/dfci
 kcD2haUs3ePvNhKs=
X-Received: by 2002:a05:6214:20a4:b0:637:a75:247a with SMTP id
 4-20020a05621420a400b006370a75247amr13281199qvd.23.1690805085979; 
 Mon, 31 Jul 2023 05:04:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQc9vcvL3ityWVa6Lz/kVuzsBdyE3HggC+yOJmtzoVbZ9pTWzzMa6wTM/KIeIJdkbiALJDgQ==
X-Received: by 2002:a05:6214:20a4:b0:637:a75:247a with SMTP id
 4-20020a05621420a400b006370a75247amr13281172qvd.23.1690805085744; 
 Mon, 31 Jul 2023 05:04:45 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 b19-20020a0cb3d3000000b005dd8b9345b4sm3693970qvf.76.2023.07.31.05.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 05:04:45 -0700 (PDT)
Message-ID: <925f0feb-b3c1-685e-1261-243963f232f6@redhat.com>
Date: Mon, 31 Jul 2023 14:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <ZMd/pdT5DmPxtjYW@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZMd/pdT5DmPxtjYW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/07/2023 11.32, Daniel P. Berrangé wrote:
> On Mon, Jul 31, 2023 at 11:10:58AM +0200, Thomas Huth wrote:
...
>> Or do you see another possibility how we could fix that timeout problem in
>> the 64-bit MSYS2 job? Still switching to clang, but compiling with
>> --extra-cflags="-Wno-unknown-attributes" maybe?
> 
> I was surprised to see that we're not using ccache in gitlab CI. It wouldn't
> help the from-clean compile time, but thereafter it ought to help. I'm doing
> some tests with that to see the impact.

I tried that two years ago, but the results were rather disappointing:

  https://lists.nongnu.org/archive/html/qemu-devel/2021-04/msg02189.html

... but that was only with the Linux runners. Maybe it helps with the MSYS 
runners?

  Thomas


