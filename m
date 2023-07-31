Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD3769595
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRf1-0006VL-AK; Mon, 31 Jul 2023 08:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQRey-0006Ut-MM
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQRex-0003qR-8L
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690805158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0KuzuV06GbQo7/O1WO9uVWpLN7q0oKw8pENNtPhyH0=;
 b=eD6r8HGCE/LaQsZ9/0jKPKIPzRnPLYIeLWCowfx4KQr1d8QXsa/9edgun8Av2MXZA2ZMJ8
 yymzUKd7T/2a32Gt7yhX43uyTT07Fsrm70E/GCTyo6U0d7XGVi1YI81nDKhcSjnLy/huC0
 bdXE0/04J0PQLT8MAwj9iq76E2L0jHE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-GoeSZb-8MPqOOaywc5zkOw-1; Mon, 31 Jul 2023 08:05:57 -0400
X-MC-Unique: GoeSZb-8MPqOOaywc5zkOw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63cfc4ebcecso41122436d6.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805156; x=1691409956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0KuzuV06GbQo7/O1WO9uVWpLN7q0oKw8pENNtPhyH0=;
 b=HuC55z2WRV1IRJD1o/l0feIbsm9nA32spIi1X1q4+N6G+Bxyez3Kq30ESa23E34UPM
 1V+sCERogyUohqh++vrNi1V+VDkHuvPix+0ug1S1EcFuJxgKNwbfP9R/YzOp3ENXGTpz
 N6Jhvp3yL/81pGyYGO5CJFBf0PaQz1jf3wNFLrQTwIk2I63xZyx/EXbRBoSZcGGzjZ+u
 Abr/7rdM99LWVfu6BeRDgOfLfFbEsFhrx2zdGgc5HYOIPdEmnCkcKzj8/4EcCqTlelg0
 wGKVshksfJ87qkvwDN/pZsi7ZkQNs/rZNFQyhHle6koFoesNJUKk4ZJlYsfhoKxac78q
 YOfQ==
X-Gm-Message-State: ABy/qLafMFAP7bZNgZsUGEtEJPKF/OLI1qcAZdSX3YRQg/EYhc4YP11c
 8Veqan/vH1aIznlcFKUTiuXVVObQ7BeAzycrTA8lWR6ndlaNx3/jDnv/+c2MF5Xrf2G+g79qYVv
 Tkz1sE31M3vwmADo=
X-Received: by 2002:a0c:f292:0:b0:63c:fed2:d197 with SMTP id
 k18-20020a0cf292000000b0063cfed2d197mr8330357qvl.63.1690805156585; 
 Mon, 31 Jul 2023 05:05:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHJtEx4OXmhN0maW+sKNa3WYyuXFE0LfpLtex3FjAh5LyQ++R8ms8cvnikMPnMVXDKURHfGA==
X-Received: by 2002:a0c:f292:0:b0:63c:fed2:d197 with SMTP id
 k18-20020a0cf292000000b0063cfed2d197mr8330340qvl.63.1690805156373; 
 Mon, 31 Jul 2023 05:05:56 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 c14-20020a0ca9ce000000b00632191a70aesm3690617qvb.88.2023.07.31.05.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 05:05:55 -0700 (PDT)
Message-ID: <f7fb8575-59ea-a5a8-7b1c-917e65522785@redhat.com>
Date: Mon, 31 Jul 2023 14:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 31/07/2023 12.05, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
>> Or do you see another possibility how we could fix that timeout problem in
>> the 64-bit MSYS2 job? Still switching to clang, but compiling with
>> --extra-cflags="-Wno-unknown-attributes" maybe?
> 
> Is there any way we can separate out the "take 25 minutes to
> install a pile of packages" part from the "actually compile and
> test QEMU" part ?

At least I don't have a clue ... we'd need someone who knows how to deal 
with that Windows stuff...

  Thomas



