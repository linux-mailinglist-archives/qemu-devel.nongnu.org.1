Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C27E41EF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0NDR-0008PN-5V; Tue, 07 Nov 2023 09:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0NDH-0008OY-7U
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0NDE-0002VD-H8
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699367871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8qZoO5b+FJyfPojYJ46fzIYiR7H3sVbsSiLHi17LHo=;
 b=HUENNfhgIcbLjE+VmKSvR3jknDdar3IzMK8cmF9uB92qJLA91M8fZr+yP7vMgmm2uNf4AF
 lm6A/vtA9ddPeJpsnTD1tkXlj8k8FUD71oxnBQfR9jIay4/o/H3u9/++ECvazgsz20Yt8t
 xayLR/q9vlCRHRKGMNM2uU6rTly+gvE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-TtkMiHM4OSyHySnAHL_OOQ-1; Tue, 07 Nov 2023 09:37:39 -0500
X-MC-Unique: TtkMiHM4OSyHySnAHL_OOQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b5942eaf64so5014644b6e.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367850; x=1699972650;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8qZoO5b+FJyfPojYJ46fzIYiR7H3sVbsSiLHi17LHo=;
 b=uSsQ5F2NPNJrUcAxlbd4+sLcY7SotMoSGRFpSA9wwqT1XMNSmisXMlSOocsoI0W78e
 TiD0/WInldP81iftWBUBODC/3a9rIIc37C4mQcVtt5qrUyTHW2O+3TMGRTEWfAKB6Igq
 oAfszhNzV39B16XxlCPT+Qef1t9yYBlN+q9t1fGBcYYxYRPmNsMy2kgzo+Qi5kL9ZISE
 GvJdd6EhRvf63orzW4+iKol7xhoeFZzyWG/2wR3L0TlKme9r0U9cEhhhdfV42mx8gTum
 CtwrsnpaHYsEhY/Zf2lt3oWd/JB9lAbQSRgnpo2R8OhFl9S8FbuRYi5gwbd5WvEvowTB
 sLCg==
X-Gm-Message-State: AOJu0YwjRVjD6kGNXo7/wzZ96qSk8ffJs0eRhdwyV8kP8GEic3Nv2KFc
 /ohIkeEqQjDMp7j+IBxMAmARPMavPamDKNpXlgOemrOyPL1ZMOppqrhkBCvGEjXLN+pLC8jgAIG
 eLvDZpYxJEPZnuXA=
X-Received: by 2002:a05:6808:4188:b0:3a7:1b28:4bc9 with SMTP id
 dj8-20020a056808418800b003a71b284bc9mr29674683oib.54.1699367849825; 
 Tue, 07 Nov 2023 06:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK8BVdDxVNs0bewzQEqt2hULtuXTgDqbm4cvuEV6n70WXeWDwu48OilCoVHqDnJN+DDDjT0Q==
X-Received: by 2002:a05:6808:4188:b0:3a7:1b28:4bc9 with SMTP id
 dj8-20020a056808418800b003a71b284bc9mr29674659oib.54.1699367849491; 
 Tue, 07 Nov 2023 06:37:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05620a101600b0076dacd14484sm4217257qkj.83.2023.11.07.06.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 06:37:29 -0800 (PST)
Message-ID: <95315815-4baa-42c2-9ec2-943955f110b3@redhat.com>
Date: Tue, 7 Nov 2023 15:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/41] Add iommufd configure option
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
 <b20a0864-6592-4544-9b73-4ba029f707da@redhat.com>
In-Reply-To: <b20a0864-6592-4544-9b73-4ba029f707da@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/7/23 14:14, Cédric Le Goater wrote:
> On 11/2/23 08:12, Zhenzhong Duan wrote:
>> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
>> iommufd support, enabled by default.
> 
> I don't think a configure option is the right approach. I will
> comment other patches to propose another solution relying on
> Kconfig and activating IOMMUFD for aarch64, s390x, x86_64 only.

Here is an example on your series :

   https://github.com/legoater/qemu/commits/vfio-8.2

The backend is always compiled (since it is common) but the VFIO frontend
and the 'iommufd' object are only available on x86_64, arm, s390x.

Looks like a good compromise. Please tell me what you think about it.

Thanks,

C.





> 
> Please drop this patch.
> 
> Thanks,
> 
> C.
> 
> 
> 
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   meson.build                   | 6 ++++++
>>   meson_options.txt             | 2 ++
>>   scripts/meson-buildoptions.sh | 3 +++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index dcef8b1e79..72a57288a0 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -560,6 +560,10 @@ have_tpm = get_option('tpm') \
>>     .require(targetos != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
>>     .allowed()
>> +have_iommufd = get_option('iommufd') \
>> +  .require(targetos == 'linux', error_message: 'iommufd is supported only on Linux') \
>> +  .allowed()
>> +
>>   # vhost
>>   have_vhost_user = get_option('vhost_user') \
>>     .disable_auto_if(targetos != 'linux') \
>> @@ -2133,6 +2137,7 @@ if get_option('tcg').allowed()
>>   endif
>>   config_host_data.set('CONFIG_TPM', have_tpm)
>>   config_host_data.set('CONFIG_TSAN', get_option('tsan'))
>> +config_host_data.set('CONFIG_IOMMUFD', have_iommufd)
>>   config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
>>   config_host_data.set('CONFIG_VDE', vde.found())
>>   config_host_data.set('CONFIG_VHOST', have_vhost)
>> @@ -4075,6 +4080,7 @@ summary_info += {'vhost-user-crypto support': have_vhost_user_crypto}
>>   summary_info += {'vhost-user-blk server support': have_vhost_user_blk_server}
>>   summary_info += {'vhost-vdpa support': have_vhost_vdpa}
>>   summary_info += {'build guest agent': have_ga}
>> +summary_info += {'iommufd support': have_iommufd}
>>   summary(summary_info, bool_yn: true, section: 'Configurable features')
>>   # Compilation information
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 3c7398f3c6..91bb958cae 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -109,6 +109,8 @@ option('dbus_display', type: 'feature', value: 'auto',
>>          description: '-display dbus support')
>>   option('tpm', type : 'feature', value : 'auto',
>>          description: 'TPM support')
>> +option('iommufd', type : 'feature', value : 'auto',
>> +       description: 'iommufd support')
>>   # Do not enable it by default even for Mingw32, because it doesn't
>>   # work on Wine.
>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>> index 7ca4b77eae..1effc46f7d 100644
>> --- a/scripts/meson-buildoptions.sh
>> +++ b/scripts/meson-buildoptions.sh
>> @@ -125,6 +125,7 @@ meson_options_help() {
>>     printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
>>     printf "%s\n" '  hvf             HVF acceleration support'
>>     printf "%s\n" '  iconv           Font glyph conversion support'
>> +  printf "%s\n" '  iommufd         iommufd support'
>>     printf "%s\n" '  jack            JACK sound support'
>>     printf "%s\n" '  keyring         Linux keyring support'
>>     printf "%s\n" '  kvm             KVM acceleration support'
>> @@ -342,6 +343,8 @@ _meson_option_parse() {
>>       --enable-install-blobs) printf "%s" -Dinstall_blobs=true ;;
>>       --disable-install-blobs) printf "%s" -Dinstall_blobs=false ;;
>>       --interp-prefix=*) quote_sh "-Dinterp_prefix=$2" ;;
>> +    --enable-iommufd) printf "%s" -Diommufd=enabled ;;
>> +    --disable-iommufd) printf "%s" -Diommufd=disabled ;;
>>       --enable-jack) printf "%s" -Djack=enabled ;;
>>       --disable-jack) printf "%s" -Djack=disabled ;;
>>       --enable-keyring) printf "%s" -Dkeyring=enabled ;;
> 


