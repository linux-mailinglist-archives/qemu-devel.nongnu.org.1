Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B672C829DB7
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:39:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNaf4-0003Db-AU; Wed, 10 Jan 2024 10:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNaf1-0003Cw-1I
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:38:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNaev-0005w6-Lv
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:38:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e43e48a16so39888415e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 07:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704901103; x=1705505903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ltRYVOSoYJXqop0TadygErcb+YqoS0pC/DKW0pbaciA=;
 b=ofagZxKd0FqZXQXDTV8fEN37lDeS7QUb/E2mj0Wsp62DHaLRLTRGIZBYp/HEMAQUXn
 BuieAVlKiYRw5OU4YuK06wxFC7TIvJ/yDgKXYUXnYfIfRTTfQnmnvRIQW2YGLckrUiw3
 gkv8vnB5Sd+R6kNPuHxFMM/Oc0GrPTKz4d4i2mVvSAYa5jPwlfROnC898b86xO+6DL+Y
 4wPfwia6dYV5ErYbg2JudGWPjkoUDpRjRqlfO8/SugnXqcsEfaPi3QxejYYR/fGOstoY
 Opp3KvbD801oEPcJ7wQ1ivBH20GxG1p8gDMq+QWBiitpfd5vtf5onfZL2YPbHqv/HQna
 TcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704901103; x=1705505903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltRYVOSoYJXqop0TadygErcb+YqoS0pC/DKW0pbaciA=;
 b=I13mCiKvk9h04o6bE9c1s/3htQErENlwFPmZwUATZ7py180cTvhOe5x+vty+3AVrKm
 qK7KvAo57hnV5A8BHW9+Ok0q4qt19MqCJsytkYT1EzHE27tyHE6OOz6G4O1SjFLXoXyb
 s45oW80EPHNQ2tlA+/jPhNA3WHbVdhdYbI8Z9mC8/qYJ3ndaeYLm+J/jh425QQzAmjMV
 0Vc4wDrq8ADXehPqzenPkyK3BaoCoTVONz5I/lK88HvQmTV3O/xsn0My6tReFmvXWjXc
 5UKhmkANeareCdrLCjzwjXTMGqytbOYN+IEWVXX9RXK4qKpclU9mHnMVCgEsOKGi6faa
 kjVw==
X-Gm-Message-State: AOJu0YwCV1aqwGJSi8NUKolWR72aRZ5F21wmb1vC9GYZYabR0gqdi5gL
 rxoLaZdea9G7wwNjzMLfczgC++bc9akLiw==
X-Google-Smtp-Source: AGHT+IEdKOR0o6QE2gBY5cJ185Xoea0wRtPqp35zR9MBDR4dDUBNhMLE6zs8Qllsx4hb4zL02bje0w==
X-Received: by 2002:a05:600c:1798:b0:40d:4085:a146 with SMTP id
 x24-20020a05600c179800b0040d4085a146mr669105wmo.77.1704901103396; 
 Wed, 10 Jan 2024 07:38:23 -0800 (PST)
Received: from [192.168.69.100] ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a05600c354800b0040e555f12d8sm2571785wmq.8.2024.01.10.07.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:38:22 -0800 (PST)
Message-ID: <d067db1f-aeff-4730-a4a0-3ca470b3efc0@linaro.org>
Date: Wed, 10 Jan 2024 16:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x/kvm/pv: Provide some more useful
 information if decryption fails
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clegoate@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
References: <20240110142916.850605-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110142916.850605-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/1/24 15:29, Thomas Huth wrote:
> It's a common scenario to copy guest images from one host to another
> to run the guest on the other machine. This (of course) does not work
> with "secure exection" guests since they are encrypted with one certain

"execution"

> host key. However, if you still (accidentally) do it, you only get a
> very user-unfriendly error message that looks like this:
> 
>   qemu-system-s390x: KVM PV command 2 (KVM_PV_SET_SEC_PARMS) failed:
>    header rc 108 rrc 5 IOCTL rc: -22
> 
> Let's provide at least a somewhat nicer hint to the users so that they
> are able to figure out what might have gone wrong.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-18212
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Print the error in s390_machine_protect() instead of doing it
>       in s390_pv_set_sec_parms(), report the text via Error **errp
> 
>   hw/s390x/ipl.h             |  2 +-
>   target/s390x/kvm/pv.h      |  2 +-
>   hw/s390x/ipl.c             |  5 ++---
>   hw/s390x/s390-virtio-ccw.c |  5 ++++-
>   target/s390x/kvm/pv.c      | 25 ++++++++++++++++++++-----
>   5 files changed, 28 insertions(+), 11 deletions(-)


> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 6a69be7e5c..7ca7faec73 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -29,7 +29,8 @@ static bool info_valid;
>   static struct kvm_s390_pv_info_vm info_vm;
>   static struct kvm_s390_pv_info_dump info_dump;
>   
> -static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
> +static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
> +                         int *pvrc)
>   {
>       struct kvm_pv_cmd pv_cmd = {
>           .cmd = cmd,
> @@ -46,6 +47,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>                        "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
>                        rc);
>       }
> +    if (pvrc) {
> +        *pvrc = pv_cmd.rc;

Changing __s390_pv_cmd() is a bit more than improving error reporting,
so I'd rather see a preliminary commit. Either ways:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    }
>       return rc;
>   }
>   
> @@ -53,12 +57,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>    * This macro lets us pass the command as a string to the function so
>    * we can print it on an error.
>    */
> -#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data)
> +#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
> +#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
>   #define s390_pv_cmd_exit(cmd, data)    \
>   {                                      \
>       int rc;                            \
>                                          \
> -    rc = __s390_pv_cmd(cmd, #cmd, data);\
> +    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
>       if (rc) {                          \
>           exit(1);                       \
>       }                                  \

