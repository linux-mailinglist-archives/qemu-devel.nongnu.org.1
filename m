Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F6A2CA1D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 18:25:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgS6V-0003dU-KS; Fri, 07 Feb 2025 12:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tgS6P-0003cm-Ka
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tgS6N-0000tP-Ga
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738949113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lL5b7RJmgyhiKOxUfDfD7TODJIBWag/8R4MWPcxcNlA=;
 b=AfG7Lh/LrimaUvYW86VN5GbS5Brcf3aCP31136YNLDWw0/FEIAHXDqFvc2vqqqdEr4TYli
 BgtqtyOmmdyvV7X0Z+1bwKcDLRKGNFcSRHmljKp+0yGyEcDH70XueyZZH/evQOeTqma0Jh
 m76dRjrUVkbPXapHF54vlhWfBpKn6cU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-_Qm9PPdfP4aNzgiK-R6iow-1; Fri, 07 Feb 2025 12:25:11 -0500
X-MC-Unique: _Qm9PPdfP4aNzgiK-R6iow-1
X-Mimecast-MFC-AGG-ID: _Qm9PPdfP4aNzgiK-R6iow
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436225d4389so16034425e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738949110; x=1739553910;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lL5b7RJmgyhiKOxUfDfD7TODJIBWag/8R4MWPcxcNlA=;
 b=ZDBh1z/+S2Fp2FqPzDmJpkltTuxo3OKNe8zbjCjR+UKs8H8wZ2yQ6LLS3WH9lRy1Yt
 tbBzzWLrdxINKhk2c23qLjqFRFzDEld6fPuG8WtHhns4bQU9ohwgjFpTgm7ZkzB0BiEy
 BbbqbhuL31QfLrMDF2yX2QeXg+G5sM6MgR2EtXSGsh8hSpXJ90XL/IOlWBw5tbFTbNql
 hQ8wJBtvbzv1ga8do8tL6+tVthw2xKcWgJxOQXMGCHURbpcfs2Y4si/AJOb+K9Qt7tCl
 Zmfnw1OP2p59pwFIMNsK5h+kHLxtBkRu9J1sr4BFHaWPgDjXrYUVFeOsqsyOo5zTzKy0
 C00A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qVcEl8cjxH39Fi1QHt8jG3L5fGoeN4QWFembxOobvigiDxVlPBV7iPhhdu9UDxbtt+4OCNj3yc5F@nongnu.org
X-Gm-Message-State: AOJu0YwCAsoSPUY9Wurr3p93ztvcc8vTN+zEazbMm/GdG6T7GAEqcAVD
 WP/wN4+PT4tde4SHDxtIydN+hggyOBDaOPuY9wqj3gkPj4sLYHIbIsY8pSN0meUauZnsPWUCIio
 tI3d3WrY+kxcqul1SIOQOQWj5BhFzkXtcFnHeJU0zVeJUenZv/zR4
X-Gm-Gg: ASbGncuTq7DUqkJra5dRRcGD6j0dx2g5Lu5P6nb3k+XxDsm82KINX08Nz3vtUpVnuUq
 VWEx4JhwP/639ZPyNwS+tO+nX+vL7vvuDJ5W5ilC0Tru7FcDQmZIqnHagOKi7oNYu/reLP0feWG
 BpUyMOMv5qYB22ZFB788Uce2+GuRSf0eWqm2WMOSfB+skpEcEjtRihm3/kScOOstwJ61QMkPDaq
 Rk2SnkYd6lSPrQoXGQdItI0iKW7o459JmbuqyRqMThZT1Y5dckyX3lEn3AllRnR6lqqBV06+yz4
 GXrc86mErdJn9sGvtiYohF5k1Ligbp3XxUe8M5Bphmc=
X-Received: by 2002:a05:600c:8712:b0:438:e2ce:92d2 with SMTP id
 5b1f17b1804b1-439255503demr29194515e9.4.1738949110347; 
 Fri, 07 Feb 2025 09:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6nE2U2a4sueaCa7yTakF4VCon26L7bNt3Dps1gNoASTpQdIhZdNT0YMfUTEWtCm3Xv9DGvA==
X-Received: by 2002:a05:600c:8712:b0:438:e2ce:92d2 with SMTP id
 5b1f17b1804b1-439255503demr29194285e9.4.1738949109918; 
 Fri, 07 Feb 2025 09:25:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcae80dsm59800005e9.22.2025.02.07.09.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 09:25:09 -0800 (PST)
Message-ID: <2a18c763-cde4-4798-8866-3e023fc6ffc3@redhat.com>
Date: Fri, 7 Feb 2025 18:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
To: Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <Z6Y6sf064FBWT5G1@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z6Y6sf064FBWT5G1@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/7/25 17:54, Peter Xu wrote:
> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
>> This is a follow-up of Peter's attempt to fix the fact that
>> vIOMMUs are likely to be reset before the device they protect:
>>
>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
>>
>> This is especially observed with virtio devices when a qmp system_reset
>> command is sent but also with VFIO devices.
>>
>> This series puts the vIOMMU reset in the 3-phase exit callback.
>>
>> This scheme was tested successful with virtio-devices and some
>> VFIO devices. Nevertheless not all the topologies have been
>> tested yet.
> 
> Eric,
> 
> It's great to know that we seem to be able to fix everything in such small
> changeset!
> 
> I would like to double check two things with you here:
> 
>    - For VFIO's reset hook, looks like we have landed more changes so that
>      vfio's reset function is now a TYPE_LEGACY_RESET, and it always do the
>      reset during "hold" phase only (via legacy_reset_hold()).  That part
>      will make sure vIOMMU (if switching to exit()-only reset) will order
>      properly with VFIO.  Is my understanding correct here?


Eric,

We were still seeing DMA errors from VFIO devices :

   VFIO_MAP_DMA failed: Bad address

with this series at shutdown (machine or OS) when using an intel_iommu
device. We could see that the VIOMMU was reset and the device DMAs
were still alive. Do you know why now ?

Thanks,

C.


> 
>    - Is it possible if some PCIe devices that will provide its own
>      phase.exit(), would it matter on the order of PCIe device's
>      phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
>      exit()-only approach like this one)?
> 
> PS: it would be great to attach such information in either cover letter or
> commit message.  But definitely not a request to repost the patchset, if
> Michael would have Message-ID when merge that'll be far enough to help
> anyone find this discussion again.
> 
> Thanks!
> 


