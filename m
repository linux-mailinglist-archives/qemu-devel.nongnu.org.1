Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F47A6965
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieCY-0004id-Fk; Tue, 19 Sep 2023 13:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qieCR-0004g7-7T
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qieCO-0004le-T6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695143263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwlPqlxFJ5TEXoMcnKS8Wo8lXolUmIDboRTPdHdQTZM=;
 b=HsICf6bWBsR2A9eZx6tg0qMOVgfSk68twMwgtHOidvMcLmMtxBvBPtXfV6YdrYg9oqk6Bt
 Kcy57eXF5Rb99M43vraka+tCzB0wsXAw6Bwqr5mbzXk1pObisu72bTqU4z0kDvHBg27bu5
 ZuuLEOqYXfOM0lg+wPtMvU4cR9On4fQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-mKklcC5sNKqBHJ9cqrq-rQ-1; Tue, 19 Sep 2023 13:07:40 -0400
X-MC-Unique: mKklcC5sNKqBHJ9cqrq-rQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76ef92fadefso766633485a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695143260; x=1695748060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LwlPqlxFJ5TEXoMcnKS8Wo8lXolUmIDboRTPdHdQTZM=;
 b=eOOU0Z157UZKBrXRfIsGDqYqzUOQRglvg75ukpVBfkPE1oIgkdgcvJUwL3UyWz+wo2
 IzcUn0z5LHhyQEvNgr43RllhYDWNaN9FTVcRSOOWbU7ketS9ZARLHxR6cjtjs0oEcMmP
 ROVjT7c6KOUDdyi7VqCJ34F/wg2owBS9EJH2rwTh/6iqS89rOenR1MlmoXqkOFgDSas0
 8zN0F8FBsdoVAwYm/wcuxfXjkkJ3lQKXUqzXMi+KocK3wkOogj7Y4SVpek7pc9fd+Qnh
 fsTU26Xeluww3UauuPYDUZPC7tXKJIzmQXA4AzFw60cOeA4toLIqtbfqWFqe9DKxPXqC
 XE4Q==
X-Gm-Message-State: AOJu0YyzpLdMEEH0b3xvrb5DaCcB3CfsTLvf4t2AmyxfIFgaijqwYYOU
 OhLO/g6adx76/R7H5bFwsXixfAyTTNP2QHNgSprMfJ54RgTsFN6h2vYbZ1WsMBdKZ+mynSbDmUi
 9yYVSXTRLQaxtuZ8=
X-Received: by 2002:a05:620a:2912:b0:767:e65b:5fcd with SMTP id
 m18-20020a05620a291200b00767e65b5fcdmr256626qkp.68.1695143259970; 
 Tue, 19 Sep 2023 10:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjUP4AlLGGBFOSOiG/C7Lnp53udSCTdqNlxjZIYKd0tzjWLeHat+ZL/YAL2QdogdASG+JIaQ==
X-Received: by 2002:a05:620a:2912:b0:767:e65b:5fcd with SMTP id
 m18-20020a05620a291200b00767e65b5fcdmr256600qkp.68.1695143259715; 
 Tue, 19 Sep 2023 10:07:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a05620a166800b0076ceb5eb309sm4113049qko.74.2023.09.19.10.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 10:07:39 -0700 (PDT)
Message-ID: <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
Date: Tue, 19 Sep 2023 19:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> iommufd support, enabled by default.

Why would someone want to disable support at compile time ? It might
have been useful for dev but now QEMU should self-adjust at runtime
depending only on the host capabilities AFAIUI. Am I missing something ?

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
> index 98e68ef0b1..6526d8cc9b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -574,6 +574,10 @@ have_tpm = get_option('tpm') \
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
> @@ -2129,6 +2133,7 @@ endif
>   config_host_data.set('CONFIG_SNAPPY', snappy.found())
>   config_host_data.set('CONFIG_TPM', have_tpm)
>   config_host_data.set('CONFIG_TSAN', get_option('tsan'))
> +config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
>   config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
>   config_host_data.set('CONFIG_VDE', vde.found())
>   config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
> @@ -4051,6 +4056,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
>   summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
>   summary_info += {'vhost-vdpa support': have_vhost_vdpa}
>   summary_info += {'build guest agent': have_ga}
> +summary_info += {'iommufd support': have_iommufd}
>   summary(summary_info, bool_yn: true, section: 'Configurable features')
>   
>   # Compilation information
> diff --git a/meson_options.txt b/meson_options.txt
> index aaea5ddd77..aed91d173b 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -105,6 +105,8 @@ option('dbus_display', type: 'feature', value: 'auto',
>          description: '-display dbus support')
>   option('tpm', type : 'feature', value : 'auto',
>          description: 'TPM support')
> +option('iommufd', type : 'feature', value : 'auto',
> +       description: 'iommufd support')
>   
>   # Do not enable it by default even for Mingw32, because it doesn't
>   # work on Wine.
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 9da3fe299b..719401ffb0 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -113,6 +113,7 @@ meson_options_help() {
>     printf "%s\n" '  hax             HAX acceleration support'
>     printf "%s\n" '  hvf             HVF acceleration support'
>     printf "%s\n" '  iconv           Font glyph conversion support'
> +  printf "%s\n" '  iommufd         iommufd support'
>     printf "%s\n" '  jack            JACK sound support'
>     printf "%s\n" '  keyring         Linux keyring support'
>     printf "%s\n" '  kvm             KVM acceleration support'
> @@ -325,6 +326,8 @@ _meson_option_parse() {
>       --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
>       --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
>       --interp-prefix=*) quote_sh "-Dinterp_prefix=$2" ;;
> +    --enable-iommufd) printf "%s" -Diommufd=enabled ;;
> +    --disable-iommufd) printf "%s" -Diommufd=disabled ;;
>       --enable-jack) printf "%s" -Djack=enabled ;;
>       --disable-jack) printf "%s" -Djack=disabled ;;
>       --enable-keyring) printf "%s" -Dkeyring=enabled ;;


