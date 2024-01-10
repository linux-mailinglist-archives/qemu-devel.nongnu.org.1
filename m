Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C38F82A04B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:32:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNdLz-0006xx-V4; Wed, 10 Jan 2024 13:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNdLn-0006xY-B3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNdLh-0003Vs-3C
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704911443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKYRFmP7XGYaBLUjE91Eyy2PONpEIiZPfslTAhDCtdM=;
 b=DbALvIcH36V49zAvkgSon//OI6/Gbg1cMoNjzrxsHnha5SxTF48G1fxFHufUVi4W7ZuUr2
 UMpqJY7oas5VA0YQ/7CeUzpwo7lcxPKc4e37xdFYCg1yBkdMMgE37jPFv9eEIwdiM0iy7J
 JvTQwzk8DAt1GBngB0nDTntN4MdlSoU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-2aUZRv1ZMbCMM62EJDtDMA-1; Wed, 10 Jan 2024 13:30:42 -0500
X-MC-Unique: 2aUZRv1ZMbCMM62EJDtDMA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-781d8e14fd8so529833985a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 10:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704911440; x=1705516240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pKYRFmP7XGYaBLUjE91Eyy2PONpEIiZPfslTAhDCtdM=;
 b=oYLoani9+j2w3LqzzwSNFgkVcsbr8nDPe5VYG0F+3HdqJ7UYKbmOAOIl9yo+/0/L4/
 92Of19xxJDT/gitPn6Zyuk4u9l/FPe5vj9oW2eo89heRE0J4s/IbVnVbui+RkpMYLxdN
 v0Tq0umBkTG+ZQv92w9QdusVo8WXDGsmH1uxP0HpmolCE9E4QfIt8s9+kcpxkeDuusi9
 2u7rlEtKeVx0ZGVN77SGRZ8SGYRJfZ+XyBMvnPK9Er0BALU/OcUhBOvJk9WUZS1AmAP4
 x4VTCjDMAUAV65zewOyWkRIz9QN1aF08fog4Uk923b+hnmSAw967eemThThQen8OM+a7
 3NRA==
X-Gm-Message-State: AOJu0YxS3PieTYE3SIu490nVr3FkPCQEQ9zIjtMykbZ1cOJI3MCTX8A3
 XnvgHChCli7kxDunhck9yjIZOIxEanp3jIwXonCsCHfERiY/OqqEQYZw/Qgk2wGtMOwUEpBHB8F
 TxzX1pXWNWTM5HRU87RxuQ/VqtOI9L/E=
X-Received: by 2002:a37:de01:0:b0:783:3167:472f with SMTP id
 h1-20020a37de01000000b007833167472fmr61655qkj.3.1704911440718; 
 Wed, 10 Jan 2024 10:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7PAP+QgZ9Xi4IVAhbXcT5eTCZxA9g0CUqcWgIAsxAdIDXH+6ILAkK3H9GCMKRDHbzklM9HQ==
X-Received: by 2002:a37:de01:0:b0:783:3167:472f with SMTP id
 h1-20020a37de01000000b007833167472fmr61642qkj.3.1704911440453; 
 Wed, 10 Jan 2024 10:30:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05620a0d8900b007816e4e9bf8sm1788948qkl.102.2024.01.10.10.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:30:39 -0800 (PST)
Message-ID: <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
Date: Wed, 10 Jan 2024 19:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230912114112.296428-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On 9/12/23 13:41, Thomas Huth wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Bound APQNs have to be reset before tearing down the secure config via
> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
> code.
> 
> So let's do a subsystem_reset() which includes a AP reset before the
> unprotect call. We'll do a full device_reset() afterwards which will
> reset some devices twice. That's ok since we can't move the
> device_reset() before the unprotect as it includes a CPU clear reset
> which the Ultravisor does not expect at that point in time.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Message-ID: <20230901114851.154357-1-frankja@linux.ibm.com>
> Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3dd0b2372d..2d75f2131f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
>       switch (reset_type) {
>       case S390_RESET_EXTERNAL:
>       case S390_RESET_REIPL:
> +        /*
> +         * Reset the subsystem which includes a AP reset. If a PV
> +         * guest had APQNs attached the AP reset is a prerequisite to
> +         * unprotecting since the UV checks if all APQNs are reset.
> +         */
> +        subsystem_reset();


This commit introduced a regression with pass-though ISM devices.

After startup, a reboot will generate extra device resets (vfio-pci in
this case) which break the pass-though ISM device in a subtle way,
probably related to IOMMU mapping according to 03451953c79e
("s390x/pci: reset ISM passthrough devices on shutdown and system
reset"). After poweroff, the device is left in a sort-of-a-use state
on the host and the LPAR has to be rebooted to clear the invalid state
of the device. To be noted, that standard PCI devices are immune to
this change.

The extra resets should avoided in some ways, (a shutdown notifier and
a reset callback are already registered for ISM devices by 03451953c79e)
and, most important, once the VM terminates, the device resources
should be cleared in the host kernel. So there seem to be two issues
to address in mainline QEMU and in Linux AFAICT.

Thanks,

C.



>           if (s390_is_pv()) {
>               s390_machine_unprotect(ms);
>           }
>   
> +        /*
> +         * Device reset includes CPU clear resets so this has to be
> +         * done AFTER the unprotect call above.
> +         */
>           qemu_devices_reset(reason);
>           s390_crypto_reset();
>   


