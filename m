Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454382AE0F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:58:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtgD-0001PB-8l; Thu, 11 Jan 2024 06:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rNtg6-0001Oe-C3
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rNtg4-0004Ov-8h
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704974210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PakVoPIp43Opdls+SNnLdWZPcfa94O4FJUMftqddXRo=;
 b=auM+GK0ezk5oTbEouXg+2e06Kg8/sCGR+mb61QHc8UhGq4cr76flPxAafZ0rpYOFB299L+
 Qq1Ejc7sGsuCllVKdbrTnAA2x5BzoNsIvemhMdD3fE8Rlru1xMBEhKutLuSA94mODDkpNu
 aXI7gi2tD2i0iP6Rg35q4ZUQan9YBH8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-OeHSxfuBNUO5ipzj6gkz3A-1; Thu, 11 Jan 2024 06:56:49 -0500
X-MC-Unique: OeHSxfuBNUO5ipzj6gkz3A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6805f615543so98781816d6.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704974209; x=1705579009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PakVoPIp43Opdls+SNnLdWZPcfa94O4FJUMftqddXRo=;
 b=ikGOlVJFDN6Vi6i73mbbNnWGM5kc7QY2S4AnyKJV2TxCJJKl5qKTQEjMHqyKfFtub/
 gferWd2qPKteJu8DDogJNYTKV+v40nQWdOCV7gJSKgpCFWc2mEpBJZIOYhu5XOMIlJUv
 WAG3ItU0+7uPMQ0ousoP2bnDUIsmR7rZQAU/+Qq4HXnrulZ1yV3Ssxsgm/bo0sIjTNcm
 j2Mm6na9eBMYqggcw7G7VB8ibskxd0RMXfeHxR1gYyDPhDLx1Oc4YGKTiipUu8qrz1fb
 swp0muGKlnGnnTNHQqNeT3F8ZbeRIhjUXuzdnsPv19+TZEmuaXzT9u/mSQTZXmdlD016
 nHUw==
X-Gm-Message-State: AOJu0YxmDraBYn8YPajIkuoco83pCNed/z+Xken9/7N5+GX4z6CksxhG
 Box3ay6W5t6A8GI8RHFAbXjnqFJE0h+jKWNFU/TW4xb6S7LYv6hONchVUoay5+YpYRqtdQIXc8p
 sxxI/gJjbx+cCaCZoilxYzw4=
X-Received: by 2002:a05:6214:27e4:b0:681:25c6:4311 with SMTP id
 jt4-20020a05621427e400b0068125c64311mr1030196qvb.23.1704974208747; 
 Thu, 11 Jan 2024 03:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4WZbuy+Ep9L/eYUMeTu8Au973thCWtB3DegvLtfM+luLwCHThfWJpIZqevPeWUIIE2z5ygA==
X-Received: by 2002:a05:6214:27e4:b0:681:25c6:4311 with SMTP id
 jt4-20020a05621427e400b0068125c64311mr1030186qvb.23.1704974208461; 
 Thu, 11 Jan 2024 03:56:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a0cfc4b000000b00680e5b70ef3sm253822qvp.62.2024.01.11.03.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 03:56:48 -0800 (PST)
Message-ID: <514897d2-ef5e-45fc-9b30-3d6be701bfb8@redhat.com>
Date: Thu, 11 Jan 2024 12:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x/kvm/pv: Provide some more useful
 information if decryption fails
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>
References: <20240110142916.850605-1-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240110142916.850605-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/10/24 15:29, Thomas Huth wrote:
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
>   v2: Print the error in s390_machine_protect() instead of doing it
>       in s390_pv_set_sec_parms(), report the text via Error **errp


Reviewed-by: Cédric Le Goater <clg@redhat.com>

s390_pv_query_info(), s390_ipl_pv_unpack() and s390_pv_verify() are
good candidates for similar changes. Anyhow, it can come later.

Thanks,

C.


>   hw/s390x/ipl.h             |  2 +-
>   target/s390x/kvm/pv.h      |  2 +-
>   hw/s390x/ipl.c             |  5 ++---
>   hw/s390x/s390-virtio-ccw.c |  5 ++++-
>   target/s390x/kvm/pv.c      | 25 ++++++++++++++++++++-----
>   5 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 7fc86e7905..57cd125769 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -107,7 +107,7 @@ typedef union IplParameterBlock IplParameterBlock;
>   
>   int s390_ipl_set_loadparm(uint8_t *loadparm);
>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
> -int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_prepare_pv_header(Error **errp);
>   int s390_ipl_pv_unpack(void);
>   void s390_ipl_prepare_cpu(S390CPU *cpu);
>   IplParameterBlock *s390_ipl_get_iplb(void);
> diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
> index 7b935e2246..fca373a826 100644
> --- a/target/s390x/kvm/pv.h
> +++ b/target/s390x/kvm/pv.h
> @@ -42,7 +42,7 @@ int s390_pv_query_info(void);
>   int s390_pv_vm_enable(void);
>   void s390_pv_vm_disable(void);
>   bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
> -int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp);
>   int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>   void s390_pv_prep_reset(void);
>   int s390_pv_verify(void);
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 76110e8f58..e934bf89d1 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -702,7 +702,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>       cpu_physical_memory_unmap(addr, len, 1, len);
>   }
>   
> -int s390_ipl_prepare_pv_header(void)
> +int s390_ipl_prepare_pv_header(Error **errp)
>   {
>       IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
>       IPLBlockPV *ipib_pv = &ipib->pv;
> @@ -711,8 +711,7 @@ int s390_ipl_prepare_pv_header(void)
>   
>       cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>                                ipib_pv->pv_header_len);
> -    rc = s390_pv_set_sec_parms((uintptr_t)hdr,
> -                               ipib_pv->pv_header_len);
> +    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
>       g_free(hdr);
>       return rc;
>   }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1169e20b94..eaf61d3640 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -391,7 +391,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>       }
>   
>       /* Set SE header and unpack */
> -    rc = s390_ipl_prepare_pv_header();
> +    rc = s390_ipl_prepare_pv_header(&local_err);
>       if (rc) {
>           goto out_err;
>       }
> @@ -410,6 +410,9 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>       return rc;
>   
>   out_err:
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>       s390_machine_unprotect(ms);
>       return rc;
>   }
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
> @@ -142,14 +147,24 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>       return true;
>   }
>   
> -int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
>   {
> +    int ret, pvrc;
>       struct kvm_s390_pv_sec_parm args = {
>           .origin = origin,
>           .length = length,
>       };
>   
> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
> +    if (ret) {
> +        error_setg(errp, "Failed to set secure execution parameters");
> +        if (pvrc == 0x108) {
> +            error_append_hint(errp, "Please check whether the image is "
> +                                    "correctly encrypted for this host\n");
> +        }
> +    }
> +
> +    return ret;
>   }
>   
>   /*


