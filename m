Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E1CAC0CBE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 15:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5xI-0005te-1E; Thu, 22 May 2025 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI5xF-0005tI-PV
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI5xC-00006I-4U
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747920438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNkTqJvG/9mywneZi8pDRbkYgS1F0EKIZ2pDUprKTc4=;
 b=esX1xgDjsxhzaehlspucsmkk/2h4Uw76BUMTgYLN+MrC+DKf6AmqizB2Bp427rW7Wdk1oF
 GuDWw/8NjF0S51MnLm+48aquQGlEwrSIQ1fiuwfMAW9P+vQBbwOSYTNqXvUvZDoXGu02C7
 m1yjZlzIm8VIWvyjxSDhA457sJ9f1eE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-QIs2PSKTNUKAyf35b5uDTQ-1; Thu, 22 May 2025 09:27:16 -0400
X-MC-Unique: QIs2PSKTNUKAyf35b5uDTQ-1
X-Mimecast-MFC-AGG-ID: QIs2PSKTNUKAyf35b5uDTQ_1747920435
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a379218f6cso1552918f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 06:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747920435; x=1748525235;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNkTqJvG/9mywneZi8pDRbkYgS1F0EKIZ2pDUprKTc4=;
 b=hyguynte51DrFfyRj8BukA7zzdF49Lx8kl9O5+hVvHOVGlJBUzVQefFlAQx4OBbvfo
 nEiM0nwsG35ty1HA4FKAFzpTHo/5IxMRSdjxe15K1y7q+FtCpiM5X1F4wzbbb3TiUAjE
 s44DbzMFVvUgIvC9hqvLUR1Dnzy8OGZ9Pf7d0zDGfyjSqn2bbEBchwkMDrbnZQ73xiVI
 73p9TZVDr7WPNWML0Vz/ehklDI4veNojsBm16B5p7hbb6wuhK3P0C7SOMdcLULDR64vU
 4ZUCeeKJE1cyxAJ6XsdUXDZl20uDqFmLiRGL8aPuuHGKkLrpWUzz/hFs//gsLSCXljju
 IvUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUObyx4MO0aEhZwc441JuT+MU2kDFp40rMZXzDbtDfrBWPfTb2ibs73lEUp/MTqgNy8ls72Tg/c5QUh@nongnu.org
X-Gm-Message-State: AOJu0Yz0Yha+uffbptF0A47H6M4V2WEu6vs5sRuIXJRdFLf/mMyk+rBW
 R7Yj9k11I827Sjav3IXtXj5GiVWA0kVZUJxBmtgt5qRHKs0P72SJDVYvmau6Ezst64inOrrKIqZ
 r8Wxg6R1TXF10nbp08pg91rWRfaAJf9GGMqZ/VucEflqXw+uTtXR6mYpD
X-Gm-Gg: ASbGncvLdcKbQwt5ug/e7w0VxcTNGn4kgEG1BbxSfGSX8s5CHYyF+pZNe0xBGRNH51l
 BflJ3V/iRTh8L8WfYmvAFGxjcIIwcj2znyLZ0aTNfxxByfMXyChWJOzSEZKB+VrfSKRgC/ecOq8
 +835/IaONSd1VTUKeulmmwQRHf8pdJrANiSz8WzdyTB/xu21BJRb/Hc4EDDISuDtjaNv362H8qN
 02/R939xbroG6VuIkar7zp1AuaHo0LqOIznS/mCK/PrTG9DTgThYJJADcm6Ac138fPK1LkstS0w
 m7CQxGfzrODUgVfZToiF1CtI2MLf8X1wnvnJ6O6sWplBAM5duw==
X-Received: by 2002:a5d:5a44:0:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-3a35c8443f5mr19266007f8f.29.1747920435430; 
 Thu, 22 May 2025 06:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuUEjBme2SL4OZHvVw2L3+0Y0aqwQpk4TYMQNuN04/zMDRpNIvW18YTYLHf/TsYRwJFr1HFA==
X-Received: by 2002:a5d:5a44:0:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-3a35c8443f5mr19265967f8f.29.1747920435051; 
 Thu, 22 May 2025 06:27:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29619sm112890555e9.7.2025.05.22.06.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 06:27:14 -0700 (PDT)
Message-ID: <f917f4f3-836b-4bdf-8dde-4d83cb226334@redhat.com>
Date: Thu, 22 May 2025 15:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-3-rreyes@linux.ibm.com>
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
In-Reply-To: <20250512180230.50129-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/25 20:02, Rorie Reyes wrote:
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3d0af7a54a..5ea5dd9cca 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>       EventNotifier cfg_notifier;
>   };
>   
> +typedef struct APConfigChgEvent {
> +    QTAILQ_ENTRY(APConfigChgEvent) next;
> +} APConfigChgEvent;
> +
> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
> +

Could cfg_chg_events be static ?


Thanks,

C.



>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -74,12 +81,17 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>   
>   static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   {
> +    APConfigChgEvent *cfg_chg_event;
>       VFIOAPDevice *vapdev = opaque;
>   
>       if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
>           return;
>       }
>   
> +    cfg_chg_event = g_new0(APConfigChgEvent, 1);
> +
> +    QTAILQ_INSERT_TAIL(&cfg_chg_events, cfg_chg_event, next);
> +
>       css_generate_css_crws(0);
>   
>   }


