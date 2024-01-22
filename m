Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADC836493
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:42:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRuXh-0006Yz-S2; Mon, 22 Jan 2024 08:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRuXa-0006YU-Jp
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rRuXY-0002Rm-7e
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705930838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ChsysDllRcaKaxgyaNTpU+uYSSYGx8ovAMmNNHt49SM=;
 b=Ck7Hrek4ULQSBQdewGowJgW8bLj30a5aDE3Ys7sBXoqKcoJm7kbFKqgz3QMe5ExPAY4rWP
 HRTGa1iWG+tTwU6iLsoqHSgUmGQgJEapVN1wUF5fcrHOIib7tVRviN607yet77BZXk2WaM
 vabz/5RuNhwDbXGdmI2pfmnN2guwlxg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-bBrSxPlKO0mcLf0g8edP-Q-1; Mon, 22 Jan 2024 08:40:37 -0500
X-MC-Unique: bBrSxPlKO0mcLf0g8edP-Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7817253831cso537240685a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705930836; x=1706535636;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ChsysDllRcaKaxgyaNTpU+uYSSYGx8ovAMmNNHt49SM=;
 b=vumcM4fMAL7pqKtpfekkJaUFS7pcJG9VVfX+5EuBfXRYFFLfQBEJaTXedcaI/dtWtT
 3R0+UGqgA921u7eL0q5PM5NwMWKksiQHkYKe1DiAzxo1woSbV+GtX+Jc6FzlRhEIn+Ss
 LlJv6wAxafE5Jbjk/x0K/2FDM9jaVbShPYDEtE/e1GeFrM1hqDlt4qwWkBSIqWc61kF+
 VdTGkSwGUS+YX6GYgObGGlXiAo0d9rCRsHwNeWOlTemAiPowVFYrH2oM3pMf4WwrQxDq
 8APy4wHMZVoC8b0rD7rqaMRdjYjORxPEFdeJd9442wcAQ7DeSFNWlxnWpOZjHzt8GeVH
 HaWA==
X-Gm-Message-State: AOJu0YxP7tAZtwoN3BFdFfOZYt3t0UyActe83OnYNKP8rpxoyG9IuXoc
 iWcJ9Vb+df4y26Z4Au6Yd9KW0+V6IlSINGSAlc5Ss6IwvidISxOMLB4uaWxIyEBXPBegVGeX9rM
 UcgNcZxJvypwPO9sfDMw5LtkyDrNctJmz1sl8xF43a7JHLLrtWKtJ
X-Received: by 2002:a05:620a:46a5:b0:783:9dc9:9a6f with SMTP id
 bq37-20020a05620a46a500b007839dc99a6fmr2271461qkb.120.1705930836713; 
 Mon, 22 Jan 2024 05:40:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhpqMR5y8IDp18ca3vTO/wglFdmfcJUBiYBXi6i3tDxPbjnNQruuejsi/YX56TqSrYKCLf2A==
X-Received: by 2002:a05:620a:46a5:b0:783:9dc9:9a6f with SMTP id
 bq37-20020a05620a46a500b007839dc99a6fmr2271454qkb.120.1705930836492; 
 Mon, 22 Jan 2024 05:40:36 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 d8-20020a05620a204800b007832bb4dbcdsm2119234qka.72.2024.01.22.05.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 05:40:36 -0800 (PST)
Message-ID: <c05bf905-de71-42c0-aeb6-9993bcbcbaca@redhat.com>
Date: Mon, 22 Jan 2024 14:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: add dumpdtb command only in device-tree-enabled
 targets
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240122092409.280919-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240122092409.280919-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22/01/2024 10.24, Paolo Bonzini wrote:
> Remove the command altogether from targets that do not have device tree support,
> instead of leaving it nonfunctional.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build        | 2 --
>   qapi/machine.json  | 2 +-
>   hmp-commands.hx    | 2 +-
>   system/meson.build | 2 +-
>   4 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index de8e5ad67dc..6bf7f3eb685 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3126,8 +3126,6 @@ if fdt_required.length() > 0 or get_option('fdt').enabled()
>     endif
>   endif
>   
> -config_host_data.set('CONFIG_FDT', fdt.found())
> -
>   vhost_user = not_found
>   if host_os == 'linux' and have_vhost_user
>     libvhost_user = subproject('libvhost-user')
> diff --git a/qapi/machine.json b/qapi/machine.json
> index b6d634b30d5..c5e40857ba4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1828,4 +1828,4 @@
>   ##
>   { 'command': 'dumpdtb',
>     'data': { 'filename': 'str' },
> -  'if': 'CONFIG_FDT' }
> +  'if': 'TARGET_NEEDS_FDT' }
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 17b5ea839d9..f7263957240 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1819,7 +1819,7 @@ ERST
>           .flags      = "p",
>       },
>   
> -#if defined(CONFIG_FDT)
> +#if defined(TARGET_NEED_FDT)
>       {
>           .name       = "dumpdtb",
>           .args_type  = "filename:F",
> diff --git a/system/meson.build b/system/meson.build
> index 25e21172505..4e54f5d1a4b 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -32,7 +32,7 @@ if have_tpm
>   endif
>   
>   system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
> -system_ss.add(when: fdt, if_true: files('device_tree.c'))
> +system_ss.add(when: 'TARGET_NEED_FDT', if_true: [fdt, files('device_tree.c')])

IIUC this does not work. For example, I applied your patch and tried to 
"make qemu-system-xtensa", I got:

/usr/bin/ld: libcommon.fa.p/hw_core_guest-loader.c.o: in function 
`loader_insert_platform_data':
/home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:55: 
undefined reference to `qemu_fdt_add_subnode'
/usr/bin/ld: 
/home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:56: 
undefined reference to `qemu_fdt_setprop'
/usr/bin/ld: 
/home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:60: 
undefined reference to `qemu_fdt_setprop_string_array'
/usr/bin/ld: 
/home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:67: 
undefined reference to `qemu_fdt_setprop_string'
/usr/bin/ld: 
/home/thuth/tmp/qemu-build/../../devel/qemu/hw/core/guest-loader.c:73: 
undefined reference to `qemu_fdt_setprop_string_array'
collect2: error: ld returned 1 exit status
ninja: build stopped: subcommand failed.

system_ss is a common set, so you must not use a TARGET_* switch for 
deciding what goes into that set, or did I get that wrong? I.e. I think you 
have to drop the system/meson.build change here?

Also, there is another #ifdef CONFIG_FDT in hw/xtensa/xtfpga.c which likely 
needs some treatment, too?

  Thomas



