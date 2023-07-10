Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93474CF53
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIloe-0002mi-Ht; Mon, 10 Jul 2023 04:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlob-0002g2-Ia
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIloY-0003x7-1T
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688976009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OIg98FGSn97DoGjsh3vISKMlcxZjewM9qOA+D9oNS8=;
 b=IPciVDjkPSFc/981bygee0PAEL2hr/eLeaEfyna3EY/X5sD65oTCk7qyQ0b8HzMf3lOsb4
 7sEzlAGXMCcbD13IqC5+Gd/LSm0argxDXWOw5kIb23Olo0s9PE2GO++6zht1uAPBIhZ957
 tNI1fGRE7bDrhIy9EJ87+z7TPD/G0LE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-CP3ytQsMP1-pAhzw8PYHyg-1; Mon, 10 Jul 2023 04:00:07 -0400
X-MC-Unique: CP3ytQsMP1-pAhzw8PYHyg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4033e4d51ecso45038231cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976007; x=1691568007;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+OIg98FGSn97DoGjsh3vISKMlcxZjewM9qOA+D9oNS8=;
 b=NUGeovhONU31mduRgqCMgHqD98zrbH3I7pAE4dy8w+lOqbvJ3VtWXQbn0paOGfXCpR
 eVndymGke9BgmjGU3tOFFX2QU3Bt4nOK3leHJtCJ6yCR8aJJh2ZRGP4b38fnF6knNsGF
 /3rw6Z19k0JU/VDfoVua7JWSGDsHSEcpehqrUE0eIsydKwxXUBD7GvVKnPWLKvGH8Eoj
 CKkgHEe7Pzf3GYVAoOYs7Xdo4e990dNsDxHF16UYWFQpawTS0UMiQFSgDqb+qm22gmym
 2vWuXSD2ikEQ5nKGz6TRDOLqhHA6+UXjOyWQbTCSneRsFB96HSs3+poPkK4gulM325f4
 lccg==
X-Gm-Message-State: ABy/qLZxJ6PIYOzF8z5Ce4ymUBkdvEvAEjjgTaaJPASZxqcpztR49xCf
 Fujf42ReORFZcFeA3Da/Obn227f+BrKtcuwr4gdR4fSPIaoa/mWrDci5e5Q1xEBtV/M5OKuvLFR
 Il2QiiW9a7bw9yxc=
X-Received: by 2002:a05:622a:1a23:b0:3fd:dd80:52a6 with SMTP id
 f35-20020a05622a1a2300b003fddd8052a6mr14181157qtb.16.1688976007290; 
 Mon, 10 Jul 2023 01:00:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjdswWt5C0FdQdNRS+bEBOzj1IdjGFoKw7BT14iFiQ3fD1S6/g0EJ3+wkNjJecwC0/DceCzg==
X-Received: by 2002:a05:622a:1a23:b0:3fd:dd80:52a6 with SMTP id
 f35-20020a05622a1a2300b003fddd8052a6mr14181150qtb.16.1688976007066; 
 Mon, 10 Jul 2023 01:00:07 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 l29-20020ac8459d000000b004035cf1cc1asm4014537qtn.41.2023.07.10.01.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:00:06 -0700 (PDT)
Message-ID: <664eb456-d812-a5e2-4470-534777d0fda4@redhat.com>
Date: Mon, 10 Jul 2023 10:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230710074639.996030-1-kkostiuk@redhat.com>
 <20230710074639.996030-3-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
In-Reply-To: <20230710074639.996030-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

On 10/07/2023 09.46, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qga/vss-win32/install.cpp   | 12 ++++++------
>   qga/vss-win32/requester.cpp |  9 +++++----
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index ff93b08a9e..9bd2c52b70 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -13,6 +13,7 @@
>   #include "qemu/osdep.h"
> 
>   #include "vss-common.h"
> +#include "vss-debug.h"
>   #ifdef HAVE_VSS_SDK
>   #include <vscoordint.h>
>   #else
> @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)
>                     FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
>                     NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
>                     (char *)&msg, 0, NULL);
> -    fprintf(stderr, "%.*s. (Error: %lx) %s\n", len, text, err, msg);
> +    qga_debug("%.*s. (Error: %lx) %s\n", len, text, err, msg);

Here you kept the "\n" at the end of the string...

>       LocalFree(msg);
>   }
> 
> @@ -219,7 +220,7 @@ static HRESULT QGAProviderRemove(ICatalogCollection *coll, int i, void *arg)
>   {
>       HRESULT hr;
> 
> -    fprintf(stderr, "Removing COM+ Application: %s\n", QGA_PROVIDER_NAME);
> +    qga_debug("Removing COM+ Application: %s", QGA_PROVIDER_NAME);
>       chk(coll->Remove(i));
>   out:
>       return hr;
> @@ -304,9 +305,8 @@ STDAPI COMRegister(void)
>       }
>       strcpy(tlbPath, dllPath);
>       strcpy(tlbPath+n-3, "tlb");
> -    fprintf(stderr, "Registering " QGA_PROVIDER_NAME ":\n");
> -    fprintf(stderr, "  %s\n", dllPath);
> -    fprintf(stderr, "  %s\n", tlbPath);
> +    qga_debug("Registering " QGA_PROVIDER_NAME ": %s %s",
> +              dllPath, tlbPath);

... but here you remove the "\n" ... looks weird. Looking at the first 
patch, I assume the "\n" should now always be removed from the strings here?

  Thomas


