Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EA76BC8B
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQu9f-0000W3-0j; Tue, 01 Aug 2023 14:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQu9T-0000B4-I4
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQu9S-0002dm-3e
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690914680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PtqJ/OoEDl+WOMhiohHepsxNP/CUH9uXrafrmYJR7z0=;
 b=KzscdmQmYM1KV+GF5R+yFXiK9qzZOFANzrTiyphtauB4roIw0AGEOhvYm5AA44xZ/A3HW2
 lyXesfcNz2CvewLiI+apJ3p3aD/0oLMVZu/te2c2Jrmw4nmpZQ+4dt/kz69zCaTMqOOAhQ
 MEs2xp3bgflBdE6GLIItHagV6GMwvAU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-N2vyK13vMzK9b3uzQyd3ow-1; Tue, 01 Aug 2023 14:31:18 -0400
X-MC-Unique: N2vyK13vMzK9b3uzQyd3ow-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40fdb989957so1618541cf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690914678; x=1691519478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PtqJ/OoEDl+WOMhiohHepsxNP/CUH9uXrafrmYJR7z0=;
 b=d3ES9ih87EMx0yfpoXn1cd77RC4EDGMPk9w8WsfWnC1PCR1V1eVIGsO9m2TJamB4sS
 CLWIYRo1ZEYZx9uZv1hHfquHIOnvChxnpctntJCJJme2gwuFCBJsQwdXZKLUGm3K7U1q
 WaczG8jVlmXhEOhP8pymEK3NpifEFUmGI8EeoUutoupfeZheShdLzA5T1Kl4ixyVjKaM
 faUcH0m7ZlokED8RF8G9mFzJ23wfChQ4SZCgMR94HhPS4XHpKQseQDqLFxzBqrcTb2EZ
 YJqdgCrID9vkdQ7xY7A+9YQ84sZ5Z9gXHTHcrvdhrHpDMTP9+EXd/fJv2KVlMsm7CZR8
 qWKQ==
X-Gm-Message-State: ABy/qLazjgYPihWTYBbkQDKDCrVZbqe6FXSlh/rCU7bd4XrvYDTjlNt4
 uHLUUcq0FrrBCBgkxn7Lqdvc3SWMPmK/9ZcxZ6ygYcEzWAg+kaqx8lNyPEo/5Efi6VGUP/SBawI
 WmwEnjgYZ7ZaEG0s=
X-Received: by 2002:a05:622a:11d5:b0:403:edb0:65c5 with SMTP id
 n21-20020a05622a11d500b00403edb065c5mr18110078qtk.68.1690914678154; 
 Tue, 01 Aug 2023 11:31:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGXmZfrqr+DcYpfRpk07shJaJXWMFkfXMHXx66GiOxlxelJjtQ6ub1bJE7y4tWH2mVP9/jpQw==
X-Received: by 2002:a05:622a:11d5:b0:403:edb0:65c5 with SMTP id
 n21-20020a05622a11d500b00403edb065c5mr18110064qtk.68.1690914677952; 
 Tue, 01 Aug 2023 11:31:17 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 x28-20020ac84d5c000000b00405502aaf76sm4606414qtv.57.2023.08.01.11.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:31:17 -0700 (PDT)
Message-ID: <d32c11d6-0971-adb5-bf03-a1e7b5b74a03@redhat.com>
Date: Tue, 1 Aug 2023 20:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
 <ZMkNUWtnQzVE1wNP@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZMkNUWtnQzVE1wNP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01/08/2023 15.49, Daniel P. Berrangé wrote:
...
> If the value of the msys2 jobs is that they let us run the test suite,
> can we limit the usage of msys2 to just that part, and chain it upto
> the fedora mingw cross compile jobs ie.
> 
>    win64-fedora-cross-container
>      |
>      +-> cross-win64-system
>            |
> 	  +-> check-win64-msys
> 
> In the "cross-win64-system" job we would have to publish the entire QEMU
> 'build' directory as an artifact, to pass it over to the msys job.  If
> we also published /usr/x86_64-w64-mingw32/ as an artifact, then we would
> not need to install any mingw packages under msys. The basic msys installer
> can be run (which takes a couple of minutes), and then then we just dump
> the Fedora artifacts of /usr/x86_64-w64-mingw32/ into the right place
> and run the test suite.

It's a nice idea at a first glance - but at a second glance I doubt that 
this is easy to realize. You need the configured meson environment for 
running the tests, and you cannot easily pass that from the Fedora container 
to MSYS2. So you'd either need to re-run meson setup in the MSYS2 job and 
then trick it into believing that the binaries have already been built, or 
you have to run the test binaries "manually" without meson... both might be 
possible, but it sounds rather fragile to me.

  Thomas


