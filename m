Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF9B10A69
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Jul 2025 14:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevEG-0003V5-0G; Thu, 24 Jul 2025 08:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uevEB-0003TZ-N2
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uevE8-0000PJ-AV
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753360750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cr4mA/0k2d9BXE6HfBnZX0knuh3SqhmHKuiDB0LtU9Q=;
 b=D6u6eSckXs8P8ibYWrGQH7MEVx7HiTWAUAsSa2762HhvtUeERfN47A2B4dM1HFRjpb2Ihz
 3hdpaybwv3D3YR3viZkLauDw6CZK8Z/A6yM+9w/8QSH9SpEiZMwXRVOsStdHWwT8DxzGJn
 wtbscbwtGsR56LkXkb4KlM9t48s4H64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-7k68fflDP4CdCVVmWYmgZw-1; Thu, 24 Jul 2025 08:39:09 -0400
X-MC-Unique: 7k68fflDP4CdCVVmWYmgZw-1
X-Mimecast-MFC-AGG-ID: 7k68fflDP4CdCVVmWYmgZw_1753360748
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so7470845e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753360747; x=1753965547;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cr4mA/0k2d9BXE6HfBnZX0knuh3SqhmHKuiDB0LtU9Q=;
 b=Gc9YXN7klFYp5ioFbPEfzbyioY6YORGnVkV2u5d4gup6htqod0spDiVdlIoma98sgh
 uEnxKWZ/5RSgQY2afYqrxsXz/59fBh2Ler0iN7ncFFm3pyvXSVJD+0kQHeJNPmBxABMc
 sZtyCTFjQz5qWqSBPEZTnx7bNloLts8YVTuBJvTrcCcAOJDyEtXhTfKa1JW5htBcK00q
 RhyQGRhHjWxQaE/ze1bi2wHm+v4Prn1/EYtCUz1DF4Ns9tVpxu+HgVUobNWtPkbBiht2
 lZAb9EYSQ6H8br3pU8e5GdwUFxx/JC9OpwqXu3S+hDwEa6DHsxzGTsOb1iVRr40Mv8jq
 x3Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQRUMQmnsrWTBeqUhyMOmeJOCQwYc9+aS/pw5kn1Zp8rgHb6b636VNbq2E3poYz6FZI22eN0b66zJF@nongnu.org
X-Gm-Message-State: AOJu0YzrBn/uSk0K+XbnTNhYLWMIGliIUi4luUxwcsAMAhVwYOJ2+gCJ
 ZmwwRKR05Y/aBjsNlhJk3eMIdtcAZVe8YiP5KofAAa4iyaoDP+bxxRJhpjC+NdXjqKzob+RTUGc
 AGw6cJiUCene3eDo70IZF3XLyilaWXxxKuOT8e8zx/4aLOeBWmMVFx5YKSq9QBf7F
X-Gm-Gg: ASbGncsRXVJIHX4N4Xi3ggP25gp0efV0rKdiF2l/6rbWGf7VC0f80m3SACRqd7ZxH29
 km7+jN5s5aATOxyeoLo6KaJdusvS2A2CKuXIeWhiHQt9X/K68ZeRi/tD+iXGc6h69RFu3Y/I4lI
 3FnoHVHneFm/0NetboUiCBKga+HyUuJ3fTiKzEK0eOdtq5R7FMHmZM0z4/iZIYdC9jIKz6iWgr3
 9UAO31BlJ4A7l2w6xFRCSn9mkewQvjCWEbDGQ7QW+p/mKcZ7IeG35O5kThdJDEcieRsGi6qLflC
 n4zcpR7kM0o1N+wqr/s5mynJzr5VpxN483Rt3BApA2+lGP9Ud0bB6XCW0fRoFkyUpswlXkMM+Cu
 dZQ==
X-Received: by 2002:a05:600c:3b9a:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-45868c8bcbdmr56984955e9.7.1753360746945; 
 Thu, 24 Jul 2025 05:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwcxTyoDI1f0WtInE4UJZm/unCAhbD6by84DeMLTvGkTB0eYpF1gGcXAOtOtR/wzE7waZxtQ==
X-Received: by 2002:a05:600c:3b9a:b0:456:1ab0:d56d with SMTP id
 5b1f17b1804b1-45868c8bcbdmr56984695e9.7.1753360746403; 
 Thu, 24 Jul 2025 05:39:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054e37dsm18698845e9.14.2025.07.24.05.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 05:39:05 -0700 (PDT)
Message-ID: <64c2231e-94cb-43dc-9606-2ad1e0c0295e@redhat.com>
Date: Thu, 24 Jul 2025 14:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove myself as ppc maintainer/reviewer
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20250724123416.3115941-1-danielhb413@gmail.com>
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
In-Reply-To: <20250724123416.3115941-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/25 14:34, Daniel Henrique Barboza wrote:
> It has been awhile since I actively did anything for qemu-ppc aside from
> reading the qemu-ppc inbox a couple of times each month. It's not enough
> to justify a reviewer role, let alone being a maintainer.
> 
> Given that we're doing qemu-ppc maintainership changes across the board
> I'll take the opportunity and remove myself from the premises too. Feel
> free to reach out with questions about code I did in the past, but at
> this moment I'm no longer able to keep up with qemu-ppc activities.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   MAINTAINERS | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a462345618..088b561aa0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -295,7 +295,6 @@ F: tests/tcg/openrisc/
>   
>   PowerPC TCG CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/
> @@ -452,7 +451,6 @@ F: target/mips/system/
>   
>   PPC KVM CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   S: Odd Fixes
>   F: target/ppc/kvm.c
>   
> @@ -1550,7 +1548,6 @@ F: tests/functional/test_ppc_40p.py
>   
>   sPAPR (pseries)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



