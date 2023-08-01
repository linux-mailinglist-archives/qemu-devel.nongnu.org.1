Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5076BC96
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuGM-0004Ac-DJ; Tue, 01 Aug 2023 14:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuG3-0003ka-BK
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuG1-0004eG-7r
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q487sGxE9e1RUOn7GjtdkAgY1g/TQgIUN1tD0edAsxQ=;
 b=Gqv5ZpmFVcw8seje9YoaTmBGljM4dZbwYXRBkPPKzZSA/CQCGbExUWpAkzq1xEacDSTjn0
 5JpgF7a0UhWdFuvn4rVwD95EB06rFkbFLWsS0yhQIcxV9CkSTUciC/W+si2SQlJdOt8dPj
 sUSZLuq2HYtpgPbNpdMOYxN/9mFNhkg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Vk1adGYFO_qco9aUSBJQ_Q-1; Tue, 01 Aug 2023 14:38:06 -0400
X-MC-Unique: Vk1adGYFO_qco9aUSBJQ_Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40fb76bd50aso20886671cf.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915085; x=1691519885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q487sGxE9e1RUOn7GjtdkAgY1g/TQgIUN1tD0edAsxQ=;
 b=XjFXzNkmPotuclOnGK7kWVQOcWLfKWNymt/u6bDfPqwHPY3yRhM9vrOIz2iwawFX15
 k2J9qqeZYCBB5JMF9goybZCQPzAvs5Yuej2Fvtxl4LRaPzqkbXR0i4wEkwFLDShJxLLN
 gxjVTYI6xx35nQ0ycVRUiZP+xmVk3OgujPeZVRgdw7uC93YswDRSd1iz4DivxEzxIbcM
 dN1QCt39ZgU+JLkXKxwAHiAcbvc8WOTVFT5QQzVuUl9jlzlX63xBGRzH2oCVbINsnT9z
 JBG2g7vrAcojZesv/w6FMeBXAihvSgWHRDOf00VMSnnlR4fkO9bjp41gtCqAj74E88a/
 z9QA==
X-Gm-Message-State: ABy/qLYbeNM2E0kRha0PlZS7US1Anxy+sdSlUbCE82A+EpVhMVfkhkpw
 7qG0vERmXoWrfefTqv0kvMpi+jqUm7jMxo8agqsFREIv/cctQIoFIZX+d3a0CGsdOugDA8iX3g5
 XP4yYch14ZvBJ3YU=
X-Received: by 2002:ac8:7d90:0:b0:403:a1d4:18d3 with SMTP id
 c16-20020ac87d90000000b00403a1d418d3mr12963549qtd.68.1690915085571; 
 Tue, 01 Aug 2023 11:38:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEp7Zb5fnjOTlDFilp4E3gjBQsmP0dx4P53k2beSXY2TJFm7VK7kclRR2beeehmnBXCYQQxCg==
X-Received: by 2002:ac8:7d90:0:b0:403:a1d4:18d3 with SMTP id
 c16-20020ac87d90000000b00403a1d418d3mr12963537qtd.68.1690915085321; 
 Tue, 01 Aug 2023 11:38:05 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 bv20-20020a05622a0a1400b004036ec58b11sm4565099qtb.84.2023.08.01.11.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:38:04 -0700 (PDT)
Message-ID: <7965d358-b29d-433c-a5b4-6c6900cb8538@redhat.com>
Date: Tue, 1 Aug 2023 20:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/8] gitlab: print timestamps during windows msys jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> It is hard to get visibility into where time is consumed in our Windows
> msys jobs. Adding a few log console messages with the timestamp will
> aid in our debugging.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index f086540e40..831b080d12 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -19,6 +19,7 @@
>       reports:
>         junit: "build/meson-logs/testlog.junit.xml"
>     before_script:
> +  - Write-Output "Acquiring msys2.exe installer at $(Get-Date -Format u)"
>     - If ( !(Test-Path -Path msys64\var\cache ) ) {
>         mkdir msys64\var\cache
>       }
> @@ -27,6 +28,7 @@
>         "https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe"
>         -outfile "msys64\var\cache\msys2.exe"
>       }
> +  - Write-Output "Invoking msys2.exe installer at $(Get-Date -Format u)"
>     - msys64\var\cache\msys2.exe -y
>     - ((Get-Content -path .\msys64\etc\\post-install\\07-pacman-key.post -Raw)
>         -replace '--refresh-keys', '--version') |
> @@ -36,6 +38,7 @@
>     - .\msys64\usr\bin\bash -lc 'pacman --noconfirm -Syuu'  # Normal update
>     - taskkill /F /FI "MODULES eq msys-2.0.dll"
>     script:
> +  - Write-Output "Installing mingw packages at $(Get-Date -Format u)"
>     - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
>         bison diffutils flex
>         git grep make sed
> @@ -66,6 +69,7 @@
>         $MINGW_TARGET-spice
>         $MINGW_TARGET-usbredir
>         $MINGW_TARGET-zstd "
> +  - Write-Output "Running build at $(Get-Date -Format u)"
>     - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
>     - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
>     - mkdir build
> @@ -73,6 +77,7 @@
>     - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
>     - ..\msys64\usr\bin\bash -lc "make"
>     - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
> +  - Write-Output "Finished build at $(Get-Date -Format u)"
>   
>   msys2-64bit:
>     extends: .shared_msys2_builder

Reviewed-by: Thomas Huth <thuth@redhat.com>


