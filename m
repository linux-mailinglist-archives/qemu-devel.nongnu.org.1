Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5457667BB
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIws-0008JI-1r; Fri, 28 Jul 2023 04:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPIwp-0008J3-I7
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPIwn-0001IW-VL
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690533340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kq1LgYi6oC3fMR4NuUg6fWErYqzAV2rHjq3iUcm74qA=;
 b=Ylj1zVsDU9af6GnT8r93Grc89PShXvcHzqeEkzGFSFOJHhB04pY5W62lS+Z7brHgueivez
 /jbrBsVrUDYVJTgIVy/ZgPOGrpBIo+pVmPZ4gDE4R2a+2gCy2D1XsZY0oxxLfbopjvksWr
 a9N0SMF9m+CXiVj+YvJnjG5j6OGccFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-7v1F9RTiNmWhgsju_e4lxA-1; Fri, 28 Jul 2023 04:35:38 -0400
X-MC-Unique: 7v1F9RTiNmWhgsju_e4lxA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd2778f5e4so9867945e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 01:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690533337; x=1691138137;
 h=content-transfer-encoding:in-reply-to:subject:from:content-language
 :references:cc:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kq1LgYi6oC3fMR4NuUg6fWErYqzAV2rHjq3iUcm74qA=;
 b=W+8snpFjEaaVAs7Fjv1rFDIfgJ5I6k90jBj7PM1pDoF6q4UjHWkFjnehM5YAiZed9+
 Ls4rRLNdZJnN3QxfXkqQf8GbTTRcebsRVf83Q4rpBwRcoTmYJv5vSsHPX6iIwulKHmLd
 Oi8Ru7t4JVqKBSgFMrJm2l/5IgvyJ4+tgW8C6qfv2WziXZ9+v9eOBnolbxK3+OGpkwPo
 m8JUuHdbAgRjU50iL5JH8L/LtASl9JKl8naTgAMzjAteqMlCqJE2Ty+GRj6LwUHp+KLT
 BgQCMq1dBHgxHb8eSU82ZO7wlcyeXBRWguOPGC8JfrioqUGa68FOC6pP3D1huMtQWM4v
 iZFQ==
X-Gm-Message-State: ABy/qLYTjNekC4wCOAoN8MC/GXyzR0cVt7hZyVugL3/VhSPqAbAp0FqX
 MIv6hW9AsQdPWPG1PyLSHIbsFwHgCfjNL0KnqwFVK5kDj2OdSAHYg9M93a9clrQCIfT4KPmLHnm
 SD1Stiz9Apwf25c8=
X-Received: by 2002:a1c:7211:0:b0:3fb:416d:7324 with SMTP id
 n17-20020a1c7211000000b003fb416d7324mr1437407wmc.6.1690533337485; 
 Fri, 28 Jul 2023 01:35:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJLflB75ntTeoI7vGpvSzSoQwNgB3qqzIBaGU6dqlvwML+IoEWB6OdoiO2ugVyABfYIsHVtg==
X-Received: by 2002:a1c:7211:0:b0:3fb:416d:7324 with SMTP id
 n17-20020a1c7211000000b003fb416d7324mr1437391wmc.6.1690533337209; 
 Fri, 28 Jul 2023 01:35:37 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm6471342wmc.39.2023.07.28.01.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 01:35:36 -0700 (PDT)
Message-ID: <a56c06a0-a6b4-cee6-be97-3586a836f4d3@redhat.com>
Date: Fri, 28 Jul 2023 10:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>
References: <20230726161942.229093-1-berrange@redhat.com>
 <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
 <ZMJJS5lUtPKpld0q@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
In-Reply-To: <ZMJJS5lUtPKpld0q@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 27/07/2023 12.39, Daniel P. Berrangé wrote:
> On Wed, Jul 26, 2023 at 08:21:33PM +0200, Thomas Huth wrote:
>> On 26/07/2023 18.19, Daniel P. Berrangé wrote:
...
>> Anyway, before we unify the compiler package name suffix between the two
>> jobs, I really would like to see whether the mingw Clang builds QEMU faster
>> in the 64-bit job ... but so far I failed to convince meson to accept the
>> Clang from the mingw package ... does anybody know how to use Clang with
>> MSYS2 properly?
> 
> AFAIK it shouldn't be anything worse than
> 
>    CC=clang ./configure ....
> 
> if that doesn't work then its a bug IMHO

No, it's not that easy ... As Marc-André explained to me, MSYS2 maintains a 
completely separate environment for Clang, i.e. you have to select this 
different environment with $env:MSYSTEM = 'CLANG64' and then install the 
packages that have the "mingw-w64-clang-x86_64-" prefix.

After lots of trial and error, I was able to get a test build here:

  https://gitlab.com/thuth/qemu/-/jobs/4758605925

I had to disable Spice and use --disable-werror in that build to make it 
succeed, but at least it shows that Clang seems to be a little bit faster - 
the job finished in 58 minutes. So if we can get the warnings fixed, this 
might be a solution for the timeouts here...

  Thomas


