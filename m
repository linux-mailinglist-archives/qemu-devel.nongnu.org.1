Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A69C3E78
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Nov 2024 13:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATS5-0005r9-JS; Mon, 11 Nov 2024 07:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tATS1-0005qi-KT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:23:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tATS0-0001P0-7U
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731327803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aGkQRw705gA6xn048nQcioQvcOTtVEzH9VPvSoZbs0A=;
 b=Sdhz55zow53qK9dqbp3lIVOIFi+ySO5vJt7iv0DbJze+pPE0PyqrVy//a9VVYd6e63fFWY
 7d2fPImOgbm+nsDowdIau8w20in9sZVmP21MWI6L1YZP+RnWA3AmCI3l/Pq2/qnacbQ8bZ
 nEHLS1uufwWQFI9F79GUp/RKW13YmMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-1GL_PSaRMO-p51F5fa_nLw-1; Mon, 11 Nov 2024 07:23:22 -0500
X-MC-Unique: 1GL_PSaRMO-p51F5fa_nLw-1
X-Mimecast-MFC-AGG-ID: 1GL_PSaRMO-p51F5fa_nLw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso41535285e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 04:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731327801; x=1731932601;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGkQRw705gA6xn048nQcioQvcOTtVEzH9VPvSoZbs0A=;
 b=vPPYv4NxLez0pB9u2b0BPmk0sDoD621D9ejCn7H74IAlO1KET5r9MoSEn8DCWAIT2u
 Z6jQseUiWtPV2jC7tbRMdadyMdNQTeJC85Qy3GcjymUWev94BEvgrpGliMeRlgVfTwKW
 jaGmsBRC69tjnIHevvF1o4NCAh5Smf6MZJZ4vgvYEcJzwuKyARh+oxcEPtHoBBwwbqAN
 +jT3wJDlpRE0koG1+7wMuVTqk7jO4tV2fPnFlqqXwGAkp6o0GLeXESR5wvliwJsm4/eg
 tSA1IDzHq2kZsk1REuDq9q6JPuHwPIBTZAkDGr8Fmlp51bzHDR/BfeN3Co2oW2iNplRO
 0fjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5UeU7AzRX6Kr1mAmbZ9mC2uQsnzejbQGJeV81hASyV12ai8zsWD60/zP0ycNGTG14rXSfJqzb6GCm@nongnu.org
X-Gm-Message-State: AOJu0YxvhkE59uMg1+Yq5bzZjt+L6VK7D8IkIY0FUXYXbFJT9BXzGFrR
 n6+MGt445LuccmoU6AhZE7uHy0o37kGZkPhfuux3n49AkIBbbkN2e43NpMtFL/FcQXfNmgDrtXw
 FZqNN658l730fEYgLmPXpHLzgNGJq+woeYCfDOWQqSmWtKws2W7cE
X-Received: by 2002:a05:600c:1d20:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-432b751ee6bmr121684125e9.28.1731327800847; 
 Mon, 11 Nov 2024 04:23:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlxYOAAOmjNPnn3L28z2gg6Dyfrtgzjy3YlcueUyBLA0JNl7Wk8lJn7kisf0n1PD2UNLzljw==
X-Received: by 2002:a05:600c:1d20:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-432b751ee6bmr121683965e9.28.1731327800484; 
 Mon, 11 Nov 2024 04:23:20 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970e23sm12704155f8f.18.2024.11.11.04.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 04:23:20 -0800 (PST)
Message-ID: <551160c5-8d68-467c-85b1-8f18cf4f3d8c@redhat.com>
Date: Mon, 11 Nov 2024 13:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
From: Thomas Huth <thuth@redhat.com>
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
 <c5bff27a-0aae-4356-9403-89d126426610@linux.ibm.com>
 <6d6466b5-1d6c-49b3-abb0-f268aa617c6a@redhat.com>
 <af01b629-7df1-4f55-9b18-3f3bc1d393c9@linux.ibm.com>
 <592e9413-f2cf-4e84-b594-4017ca8d60e1@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <592e9413-f2cf-4e84-b594-4017ca8d60e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/11/2024 15.37, Thomas Huth wrote:
...
> And in case you're interested (it's maybe not so important since it's rather 
> unlikely that the users will do this), there is another issue when trying to 
> boot from multiple network devices where the first one has a DHCP server but 
> no bootfile:
> 
> qemu-system-s390x -nographic -accel kvm -m 2G -netdev user,id=n1 \
>   -device virtio-net-ccw,netdev=n1,bootindex=1 \
>   -netdev user,id=n2,tftp=/boot,bootfile=vmlinuz \
>   -device virtio-net-ccw,netdev=n2,bootindex=2 -d guest_errors
> 
> The firmware seems to panic while trying to request DHCP information from 
> the second boot device.

I had a look at this problem now, and the solution is as simple as this:

diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -51,6 +51,8 @@ int virtio_net_init(void *mac_addr)
      void *buf;
      int i;

+    rx_last_idx = 0;
+
      vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
      virtio_setup_ccw(vdev);

Otherwise the rx_last_idx does not get reset to 0 when starting the 2nd 
network boot, so the code tries to access some ring data that contains 
garbage later. I'll send it as a proper patch...

  Thomas


