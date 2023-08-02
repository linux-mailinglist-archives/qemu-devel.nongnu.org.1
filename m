Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2476D2F5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRE8R-0003Nu-HU; Wed, 02 Aug 2023 11:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE8O-0003Ke-Es
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE8M-0000W3-W0
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690991493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8XJ0jRx8+t2OsvjSXVv7Y3NnOGDrP7Ab6nEray1cX1s=;
 b=UN9rYpGdzsBcOHyhZEFCu7Q0QW8WGLKUZsFaKREGp+sDMkDBAWgNlSwaj8tHRnUSCV/+fh
 DbfiBBzPMPhOADf3MpdVE3521BkbbVyclw866CpSnb/wQN7O2qEG1+nUntwnRcZxk4XKDb
 VkWv6jq5l/8skLbTGWGgMUJOKuMFK8g=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-I_acxcRHN3mplSh-m904rg-1; Wed, 02 Aug 2023 11:50:31 -0400
X-MC-Unique: I_acxcRHN3mplSh-m904rg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-56d11c2fc66so1235269eaf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690991416; x=1691596216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XJ0jRx8+t2OsvjSXVv7Y3NnOGDrP7Ab6nEray1cX1s=;
 b=H5qqM9mm9PPYCv3fFZIVva25G0YzFF7fPZ12bTNM9CpiU7mQ6T9nwEgk4QX/1Vt/Uw
 /uIUy3xjGo1BDaGvlI3KZihcybob8QGHjvKoxBr8NMKMMQVgpJqMZ8aVbLQjTO7dzNOI
 tz0xONhVayURIDTaSzg48z3KvtjkfGCbiEgZtLGGq5t65jw3wvLg+K7EbYreElqW4YQH
 TVZHvyJ2Pq2l2E82vbHEuhlRB/GwXuqyAmLOuagiE1jFKukDdddTUHPDbgeMl5p/m2tO
 2VyDOIRmuoO3D4LtMA/lacb4GHyuV0EFoyvpHG0SIZ3FYzrKvF52E6V0VmHOnxYM29aA
 2pOA==
X-Gm-Message-State: ABy/qLbhPMqgUmnV40Q71QIUjRvaPOUzYzZM/2wteBBTu9HMdluPDKcP
 Ybjd4ZZOYaJSlK/fP0pe13AH84j7/lOVUKH1j0MdVW4vFuPtG6Pk1lyGadqcddpMO8rXrNg1uPZ
 NyVWq7piZxOE0IKA=
X-Received: by 2002:a05:6358:c28:b0:139:c4ee:8680 with SMTP id
 f40-20020a0563580c2800b00139c4ee8680mr8452911rwj.16.1690991416053; 
 Wed, 02 Aug 2023 08:50:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGx8S6RxTXAZE7u8GO/+sa7MkAbVfCO2qYa78lE9KLaf1zIiKJNyC0UtcKa7LdvhsuLWfl0fQ==
X-Received: by 2002:a05:6358:c28:b0:139:c4ee:8680 with SMTP id
 f40-20020a0563580c2800b00139c4ee8680mr8452893rwj.16.1690991415792; 
 Wed, 02 Aug 2023 08:50:15 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-230.web.vodafone.de.
 [109.43.178.230]) by smtp.gmail.com with ESMTPSA id
 e18-20020a0ce3d2000000b00635efe2f65csm5624752qvl.30.2023.08.02.08.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:50:15 -0700 (PDT)
Message-ID: <eb70383f-45f7-4e92-f9bf-9b22f1cab621@redhat.com>
Date: Wed, 2 Aug 2023 17:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/8] gitlab: drop $CI_PROJECT_DIR from cache path
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> The gitlab cache is limited to only handle content within the
> $CI_PROJECT_DIR hierarchy, and as such relative paths are always
> implicitly relative to $CI_PROJECT_DIR.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 0bc04ad068..6454880cb7 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -7,7 +7,7 @@
>     cache:
>       key: "${CI_JOB_NAME}-cache"
>       paths:
> -      - ${CI_PROJECT_DIR}/msys64/var/cache
> +      - msys64/var/cache
>     needs: []
>     stage: build
>     timeout: 80m

Reviewed-by: Thomas Huth <thuth@redhat.com>


