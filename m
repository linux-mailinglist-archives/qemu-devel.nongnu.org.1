Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E276828A77
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:52:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFKo-0005i0-HL; Tue, 09 Jan 2024 11:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rNFKh-0005WX-Hm
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rNFKf-0001Zu-F3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704819123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bJ1JYzsmkIXYU8PY+PrtA7QOZq6OZmKYvDNZWpqw0Q=;
 b=glaIzIrF8d+LTiEow/N/V0xj4dZiKZXNT3yHTJ3ErSNcl4rNkT36VET3x8ds2grKy4kYO0
 SOMSRYO2i6Om3EdkbMWFu/3Rrsm0DThnzIMX/9OeQSFfFtY4herh7hH4qbaSoqvNoIuPGO
 RI9RPeUffIcUFSmCxSUahB0wQ3bOJAk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-GQqVrB1MMIGa4YarisbGyg-1; Tue, 09 Jan 2024 11:52:02 -0500
X-MC-Unique: GQqVrB1MMIGa4YarisbGyg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-429abac743fso6488141cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704819122; x=1705423922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5bJ1JYzsmkIXYU8PY+PrtA7QOZq6OZmKYvDNZWpqw0Q=;
 b=o9qb+OYNcwRfy9Qz5MOm7H5rNtf+iC0KkMJpEs5BHWNFN/WyLdsVcQxsjXADlRvVBY
 b92yJyR/Vxis4M0Q0bDqwBuQrCBD//9WaP1ffn39bkadzlIaJL3cxb4PYLmlDw8eqk6E
 R+GCOWnK9gEvZqpuR2mLxt72rikdSfKdLa+q027A5DvSLz3eJ9DalIQNCR53zaiGoHhk
 WTuLf7/AKcrKQAMCQxQm187bVJgnR9lJNONH5nvpF8Woq+ZSo072yx94rlnvI69pdiKL
 G+k5GU+mfANER06AAP4pFqlAW114uY+FjBQR3QFFMfcBBtXYMr/objmJAFtSPM7eOYAb
 GXUw==
X-Gm-Message-State: AOJu0YyYVrThClEdRw8eusl0iMCxBaNLGkma9YZ65Ewp2GA+UWvWU4NZ
 H73QEWJuUwWK+iSSBalQmNcQCYmNHXTv8W2oW/jmCkth8ZsfbKbs2oks/EKUWSLaby4wI8z6WC+
 e6zF7a21u9vAZZIO/zlA6fu8=
X-Received: by 2002:ac8:5751:0:b0:429:8a1d:45a9 with SMTP id
 17-20020ac85751000000b004298a1d45a9mr6377257qtx.127.1704819121930; 
 Tue, 09 Jan 2024 08:52:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvTNWFxoyLXCeQudNQVUmqnGvtsfOcIwkSa7rIpvMjZdB3WzgOX+ay7MniVSeftpQaJRL2GA==
X-Received: by 2002:ac8:5751:0:b0:429:8a1d:45a9 with SMTP id
 17-20020ac85751000000b004298a1d45a9mr6377248qtx.127.1704819121713; 
 Tue, 09 Jan 2024 08:52:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v17-20020ac87291000000b0042837900d7bsm998377qto.11.2024.01.09.08.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 08:52:01 -0800 (PST)
Message-ID: <9296cdea-3144-4f4c-af7a-d7cadf8ea107@redhat.com>
Date: Tue, 9 Jan 2024 17:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/kvm/pv: Provide some more useful information
 if decryption fails
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
References: <20240109143038.155512-1-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240109143038.155512-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 1/9/24 15:30, Thomas Huth wrote:
> It's a common scenario to copy guest images from one host to another
> to run the guest on the other machine. This (of course) does not work
> with "secure exection" guests since they are encrypted with one certain
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
>   target/s390x/kvm/pv.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 6a69be7e5c..2833a255fa 100644
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
> @@ -144,12 +149,19 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>   
>   int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>   {
> +    int ret, pvrc;
>       struct kvm_s390_pv_sec_parm args = {
>           .origin = origin,
>           .length = length,
>       };
>   
> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
> +    if (ret && pvrc == 0x108) {

why do we need to test for 0x108 also ? if this sub error code is important,
adding a define would be a plus.

> +        error_report("Can't set secure parameters, please check whether "
> +                     "the image is correctly encrypted for this host");
The error reporting in s390x_machine_protect() could be improved.

I would add a 'Error *' argument to the routines called by
s390x_machine_protect() and report the error in s390x_machine_protect()
or above. s390_machine_protect() return value is ignored also, could be
replaced by a bool.

Thanks,

C.



> +    }
> +
> +    return ret;
>   }
>   
>   /*


