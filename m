Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1B71811A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LaQ-0005UI-2d; Wed, 31 May 2023 09:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4LaI-0005T2-II
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4LaG-0001Rz-HN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685538587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EeoR1a6tsxx1ZoCgp4rR7DvaKF+kAsPBsltfZvJw+U=;
 b=b+b8dnoAMdiZD/ugjniLqJRw4pz8wUrBETnmvIEcnsiqGAknjsy4dQB4cJOjVWAoMcSvVo
 NLkkRa7h7T5ignvTHePE/GpicGQv4gA5Z1P8eGuVQN7sG8hi0nxadqPYbbGcy0SOIHjCnZ
 EtFZ+8nQkTkgL9v2K/Z1YV1LouSbmDo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-utoMPLHAMeOhL00UOqsunA-1; Wed, 31 May 2023 09:09:46 -0400
X-MC-Unique: utoMPLHAMeOhL00UOqsunA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso26449085e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685538585; x=1688130585;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4EeoR1a6tsxx1ZoCgp4rR7DvaKF+kAsPBsltfZvJw+U=;
 b=bgJ0rwaKZrKoprlmSt8Ag5DZMPNRYuaXiKo5hUWuJ0ojvNukVtEEdYtliEf01AGMH9
 53TqE7bAPv5zWeBOSnYRw+cEFtAGedJvArvMNe6rDtN6bVZO3s90BrvJGdasvQZA2vS6
 KBhgp7l1/dclTlqhcu9/LJT+luKSgcDmg7eWJxZ3soWEMtqsnh0C76npNDiMRzzEFK/t
 KDTIb6EtvQZj4hr2cbysB+YZoaW04SFrnoI+T2M+qwsdnUR2DvZ3acC/ePI/LlBLuhyz
 hODktffW+09T9FY8D11VgzouTsUK2kS7eL9hstIIdoWa8dvgi1xH5qqCZal5PxFenBoX
 rhtQ==
X-Gm-Message-State: AC+VfDzIp6XH8YS6rzdWb34p3iu5afTVdUADXSXwsk2j6cVo3M6imTZX
 J1d1EBLExO8YnJ0yLY+8R2Db6wjz0t2wd2bWo7N15Jrf9UEJ8jBlrO8OXyZqrukdQXUWjJQj9A1
 kYjkc1uBG02vfWz8a0AUWPV61CHEg+aRR8oFRM/XDYMlXO0RoxrIAmCesxoE5CRvX3lXnX9U=
X-Received: by 2002:a05:600c:2158:b0:3f5:fb97:eafe with SMTP id
 v24-20020a05600c215800b003f5fb97eafemr4004960wml.30.1685538585541; 
 Wed, 31 May 2023 06:09:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ee5m0Bwub09dv9if1RAhf5BNFJHDvGVF9v5M6QuRmjHPeN526huDF6QtL9ZwxVDOCJoF5Ew==
X-Received: by 2002:a05:600c:2158:b0:3f5:fb97:eafe with SMTP id
 v24-20020a05600c215800b003f5fb97eafemr4004947wml.30.1685538585261; 
 Wed, 31 May 2023 06:09:45 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a7bcc10000000b003f60fb2addbsm24786876wmh.44.2023.05.31.06.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:09:44 -0700 (PDT)
Message-ID: <d1649124-9c28-b779-41dc-ec77739828b6@redhat.com>
Date: Wed, 31 May 2023 15:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH qemu 1/1] [meson.build] Add conditional dependency for
 libkeyutils
Content-Language: en-US
To: qemu-devel@nongnu.org, Max Fritz <antischmock@googlemail.com>
References: <168471463402.18155.3575359027429939965-1@git.sr.ht>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <168471463402.18155.3575359027429939965-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/05/2023 02.12, ~_6d6178667269747a wrote:
> From: Max Fritz <antischmock@googlemail.com>
> 
> This modification enables better control over the inclusion of libkeyutils
> based on the configuration, enhancing the flexibility of the build system.
> 
> Signed-off-by: Max Fritz <antischmock@googlemail.com>
> ---
>   meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d..206d4033bf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1764,8 +1764,11 @@ if gnutls.found()
>     tasn1 = dependency('libtasn1',
>                        method: 'pkg-config')
>   endif
> -keyutils = dependency('libkeyutils', required: false,
> -                      method: 'pkg-config')
> +keyutils = not_found
> +if get_option('keyring').enabled()
> +  keyutils = dependency('libkeyutils', required: false,
> +                        method: 'pkg-config', kwargs: static_kwargs)
> +endif

FYI, since nobody else picked this up yet, I'll add this to my next pull 
request (dropping the "kwargs" part from the patch, AFAIK it's not needed 
anymore, see commit 063d5119c18af76).

  Thomas


