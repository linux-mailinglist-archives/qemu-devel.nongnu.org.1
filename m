Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB2AD685A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 08:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPbt0-00065M-EB; Thu, 12 Jun 2025 02:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbsy-00065D-9m
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbsw-0001eZ-Cf
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749711479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8P4uHXFR1C03p2jtY7IwgRG5YL/a+gu44c0GhiUcCE=;
 b=L36iGtZ0ku08Rb+irwO9Bwsrtm8VRAwCWMRIB+2gKDrFbWkWoQndyUK6iQmy3B2ce4dk3w
 pcr5a/lr7+EtJCelv3lfJRh0XrwWiEVrUmJiXeUU9Y3D7wz3wmCIp8q+b7J7msJL398n00
 ZkrGSrHf9CfMxoU0qwLw6pFHE+dha5A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-z0vfeAP4OqK7e-CWHd0_qw-1; Thu, 12 Jun 2025 02:57:58 -0400
X-MC-Unique: z0vfeAP4OqK7e-CWHd0_qw-1
X-Mimecast-MFC-AGG-ID: z0vfeAP4OqK7e-CWHd0_qw_1749711477
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450787c8626so2998165e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 23:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749711477; x=1750316277;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8P4uHXFR1C03p2jtY7IwgRG5YL/a+gu44c0GhiUcCE=;
 b=IyJcpWpclIh2DQTHWyf+EDPK0qunbTpY4sU2AhKb87pufdsrZo0WfgHJUfom2xioo7
 wuHL24t7K844oBc2327WMKoKOj0dehmjYDVyZhU5dbqbWssW5hav3mR3f7wv0JM3hyIJ
 mFnQrS0lZqkvVrcc0LjepcvmvBUiholhkNLiwq+MTK0MTbfLxMaITMkg7VLrdDWl4hbx
 hpc+bXVpiUiMXqMthAPAR3GGyJw7iENa8yROHlLDhb6WYTiLXiqDMSf/7XAYgdmwtLiS
 imPVeGEN5dE1jfqFeTyIUOmy37YtTGWZUDGydMJ02Z9z++hjevYURtUAwilwvWV/XN0q
 8WIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsYI8lnCTvZ70XxroSmIBhEdKQIGyKk8VPeo/YRc05HPULr3v5cBw9zilRTQrhNsY7+uGHr/6jt4xD@nongnu.org
X-Gm-Message-State: AOJu0YwVmIc9p80fAKaTLtQJmB2qaORNKJfYfl3KzI1BjKDrGHwBbLzR
 bAI3yB0bevkxNBAZwUg5qiQworES1EhzrzkMDkfoz++zmVjwteEVjsXNhEkpDS49r0jPYXJy6FX
 Dw3o2UWRFGpiQ9SZ7jjs37BdEb2nmzFbV1QL9L32h4TvHfBOnukBQ+3RH
X-Gm-Gg: ASbGncsAln8yYdYVtM1rlAQEhrSn+F9O6vXwveRsVezd3iFV8g5kMyXlye76fY9vci/
 BN0fWW1Ethxca6+GbDM/surtQUFd1hSSBa2RlDw+arunCoUaBySqjDjXzHrbBvOGi9NwjT2hCMc
 kgqy9X/tO3Zz0vPaCnUmtDF77UKHtYmPGlYGifqb1C4KIfV+EntwjMaQ6fpRSo85OBQoiPdp1J3
 EZRH+vW9EaVs2EfVb6CRaqLD9/jrIvrwZxdot9piNMwJ9LQ5OMBUCId3Ba/tYRS//93oOHw9FnO
 Y+gxOsjvWt/23axikQ/aOTkz4eHX3Eh8Zs9LNSAJakDRgLMvj+Tn3pdbAyLA
X-Received: by 2002:a05:600c:6297:b0:452:fdfa:3b3b with SMTP id
 5b1f17b1804b1-4532d292ec9mr17087275e9.5.1749711476653; 
 Wed, 11 Jun 2025 23:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7AZ1yCcQUUmYPIxodkMXBlGJDkIFHeMaUZN/NEgR/n/bhvt/3kYGBiG+x+6SXiulRBCPUbQ==
X-Received: by 2002:a05:600c:6297:b0:452:fdfa:3b3b with SMTP id
 5b1f17b1804b1-4532d292ec9mr17087095e9.5.1749711476313; 
 Wed, 11 Jun 2025 23:57:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e244392sm10622005e9.22.2025.06.11.23.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 23:57:55 -0700 (PDT)
Message-ID: <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com>
Date: Thu, 12 Jun 2025 08:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John,

On 6/7/25 02:10, John Levon wrote:
> The series contains an implement of a vfio-user client in QEMU, along with a few
> more preparatory patches.
> 
> The vfio-user protocol allows for implementing (PCI) devices in another
> userspace process; SPDK is one example, which includes a virtual NVMe
> implementation.
> 
> The vfio-user framework consists of 3 parts:
>   1) The VFIO user protocol specification.
>   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
>      and sends them to the server.
>   3) A server - a remote process that emulates a device.
> 
> This patchset implements parts 1 and 2.
> 
> It has been tested against libvfio-user test servers as well as SPDK.

Is libvfio-user a server-only library ? It seems a bit odd not to use it
on the client side. Anyhow,


We have now merged upstream all the prerequisite changes for vfio-user.
This gives us about 1 month to fix regressions and merge the model for
the vfio-user-pci device, its documentation and tests.


I *really* would prefer if we had functional tests although I don't how
complex it would be. At least an initial framework would be good to have.
More sophisticated scenarios, such as mappings and interrupts, can come
later.

Thanks,

C.


