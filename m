Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D197E3FDD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:16:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LvT-0000T5-Bn; Tue, 07 Nov 2023 08:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0LvI-0000Sn-SU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0LvH-0008QY-2J
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699362913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytvm0GnWaaMOiRgfIxg3dLAg1KnynMOAvN6vMUJJqmY=;
 b=fKZQg059Da5NUQELCTswCrPtTb+WFJZjyc/zLWC0vQs4v9Y/PHca5/TbLaNbFhoqtwmHZj
 0W8bBeCDRbGFnl0Zo2Ra2yppkaBd2tr5FQKkQP/cJ6Zc2shzxDAalLZE113TNrIVq2fJ4H
 tRbsvupsN4H1FU/l3MT1phWHYmoKW78=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-pkzcGSmMONi8XEKBioXIoQ-1; Tue, 07 Nov 2023 08:15:02 -0500
X-MC-Unique: pkzcGSmMONi8XEKBioXIoQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7788ce62d50so609308885a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699362902; x=1699967702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytvm0GnWaaMOiRgfIxg3dLAg1KnynMOAvN6vMUJJqmY=;
 b=qUotNxkWePq9lnb6K+6mI/p53Heks01fo8kW4IURcAXz04L7t8g+3IDfr6r1QC6BR/
 UPdmJciAsDMWPoXHuhZwBydI/djN4MhPCnxizMEVzNb0NTUzaIDLwJQ1MfFlj/770QEr
 EGzHFy3QhLzThsnLp303iqq2x6fCysYoSFHnT2dTHmAH7oIiodZNNrdw0fhnhDJh3abb
 7cO5X9W0/Vy1BUOrj3FF8jYM8yEL+dN727nRrRzowB6OS9q9BXsbQFeLdXBizc9TQKor
 vgYUENw1mmXoCohPHLGT+nAC9mU736HxRW27XW6VcNyRH89xVOEi0LNFqcc6TpNOpQjc
 r4DA==
X-Gm-Message-State: AOJu0Yw1ImQEOU18YhPopW5SAc4y+FOLUXsWTYVLLwGiA9wuenex4fB6
 I+xvOrpJcLtGNscc7ekfdOVJEd0WKRZNkYnWlLzhmjVsGpWAGp9fpaCeWv9F/VkD3G9nsT6FNFh
 qmuMRj7eyeelBL9M=
X-Received: by 2002:a05:6214:1d26:b0:66c:f0b8:a2c2 with SMTP id
 f6-20020a0562141d2600b0066cf0b8a2c2mr41225168qvd.65.1699362902093; 
 Tue, 07 Nov 2023 05:15:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKb6FWIWez3MLIEJh6ToE/Ttn7CnEn7sWyGvM0feZGF1uCslr+QohBo5EGmbdcBYT64yp9hA==
X-Received: by 2002:a05:6214:1d26:b0:66c:f0b8:a2c2 with SMTP id
 f6-20020a0562141d2600b0066cf0b8a2c2mr41225145qvd.65.1699362901847; 
 Tue, 07 Nov 2023 05:15:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a05620a229600b007788dac6b24sm4178856qkh.41.2023.11.07.05.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:15:01 -0800 (PST)
Message-ID: <b20a0864-6592-4544-9b73-4ba029f707da@redhat.com>
Date: Tue, 7 Nov 2023 14:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/41] Add iommufd configure option
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-26-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-26-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> iommufd support, enabled by default.

I don't think a configure option is the right approach. I will
comment other patches to propose another solution relying on
Kconfig and activating IOMMUFD for aarch64, s390x, x86_64 only.
  
Please drop this patch.

Thanks,

C.



> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   meson.build                   | 6 ++++++
>   meson_options.txt             | 2 ++
>   scripts/meson-buildoptions.sh | 3 +++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..72a57288a0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -560,6 +560,10 @@ have_tpm = get_option('tpm') \
>     .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
>     .allowed()
>   
> +have_iommufd = get_option('iommufd') \
> +  .require(targetos == 'linux', error_message: 'iommufd is supported only on Linux') \
> +  .allowed()
> +
>   # vhost
>   have_vhost_user = get_option('vhost_user') \
>     .disable_auto_if(targetos != 'linux') \
> @@ -2133,6 +2137,7 @@ if get_option('tcg').allowed()
>   endif
>   config_host_data.set('CONFIG_TPM', have_tpm)
>   config_host_data.set('CONFIG_TSAN', get_option('tsan'))
> +config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
>   config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
>   config_host_data.set('CONFIG_VDE', vde.found())
>   config_host_data.set('CONFIG_VHOST', have_vhost)
> @@ -4075,6 +4080,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
>   summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
>   summary_info += {'vhost-vdpa support': have_vhost_vdpa}
>   summary_info += {'build guest agent': have_ga}
> +summary_info += {'iommufd support': have_iommufd}
>   summary(summary_info, bool_yn: true, section: 'Configurable features')
>   
>   # Compilation information
> diff --git a/meson_options.txt b/meson_options.txt
> index 3c7398f3c6..91bb958cae 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -109,6 +109,8 @@ option('dbus_display', type: 'feature', value: 'auto',
>          description: '-display dbus support')
>   option('tpm', type : 'feature', value : 'auto',
>          description: 'TPM support')
> +option('iommufd', type : 'feature', value : 'auto',
> +       description: 'iommufd support')
>   
>   # Do not enable it by default even for Mingw32, because it doesn't
>   # work on Wine.
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 7ca4b77eae..1effc46f7d 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -125,6 +125,7 @@ meson_options_help() {
>     printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
>     printf "%s\n" '  hvf             HVF acceleration support'
>     printf "%s\n" '  iconv           Font glyph conversion support'
> +  printf "%s\n" '  iommufd         iommufd support'
>     printf "%s\n" '  jack            JACK sound support'
>     printf "%s\n" '  keyring         Linux keyring support'
>     printf "%s\n" '  kvm             KVM acceleration support'
> @@ -342,6 +343,8 @@ _meson_option_parse() {
>       --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
>       --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
>       --interp-prefix=*) quote_sh "-Dinterp_prefix=$2" ;;
> +    --enable-iommufd) printf "%s" -Diommufd=enabled ;;
> +    --disable-iommufd) printf "%s" -Diommufd=disabled ;;
>       --enable-jack) printf "%s" -Djack=enabled ;;
>       --disable-jack) printf "%s" -Djack=disabled ;;
>       --enable-keyring) printf "%s" -Dkeyring=enabled ;;


