Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3DB3FA48
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Sep 2025 11:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNHA-0004ue-28; Tue, 02 Sep 2025 05:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1utNH3-0004rx-7V
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1utNH0-0006v3-Os
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756805151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q23EhZawwYEdOrF2PoOaxgHpl0JdBZEDRwLO8LmDk5Q=;
 b=UxG3JAZrwJ6t4ZkNdapkvVSQXXTAzb4HZkEAuDiIVKbtw8IU0LT4ofZJ+v+0a23jvedGXj
 9Zty+o9S0dRaAYwoQM8hVP5KbCn4PzvpHbCg3pSp1kk6lb91AaDGsOgAS3zqB/zuicAoA0
 cHvF0RsjjmDR7OZfJoAWuTbJOXiyDfg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-zXICGao-MBy975HTQZ0_Mg-1; Tue, 02 Sep 2025 05:25:49 -0400
X-MC-Unique: zXICGao-MBy975HTQZ0_Mg-1
X-Mimecast-MFC-AGG-ID: zXICGao-MBy975HTQZ0_Mg_1756805148
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b85c93afdso8522395e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756805148; x=1757409948;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q23EhZawwYEdOrF2PoOaxgHpl0JdBZEDRwLO8LmDk5Q=;
 b=djmRLhkHR1KiWQYYQRy3oNsJE9BZMHAMhRv70NpQcsW/XppC0O5EgxfYtNsZN7L0gZ
 SpAIgTANA9y1kB6gvbnC6bUEe/tsf3JyVkdnQdGAeDHJ6ZLxoQmJKEjvcrZThk7IesN3
 bpYxiGjfn9XDQptjjjJBYf21kou5qgUkNtz9UTQd0zaCQTbzL4/yxksJU/zUdqIi5+pe
 LV6TRYxQB+LQwUSkRm0Ej5cJmtvukOxgVMCeGoN24pDte6iHZc1FAIm0gy2uxkPji72t
 JMFiFKD1DT0ns7WepI3MYad3ixcUOaGwYLNFwWpOYv+7GHDJ5h+l4B6UxETF0SIV0gNB
 m/Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxEaZhYiM1eGuHMBFX/Kesvz6fZ6ifBwlH//zIEU5naZuwuwB6c9NmKAzRFsvbEuo0F61sq7i+Nosr@nongnu.org
X-Gm-Message-State: AOJu0Ywt2uv8zaSmE5ioIFyjN+nTnnLM0w+OlSy0oc9EHNzAov4ccYpz
 T6j8LsLxzXCj4zWikGzivKKtZAmT9VPHFgU3stPx6K39gy96mB3xCWozkb/A1fbEYoYpWzRvRF3
 QVCMCaFAjMqgUlyzl1xTMsHOtcxMN8CZAnSajKgg4eXD78Or4lnAwn29z
X-Gm-Gg: ASbGncveKRQwTbjcBWTKSrJ1C7zU9XU/zPpBg20ZtN80sjCOjUy3bTWRzN5m9sjImsh
 S3ls70YOhJzRcjD5frytGl2htW0KdsnWwDWV25z89s/68gNtNH1NdMCMomMZBUhlPyhEYg4B8Cl
 1FpSq2cvn9Y4cei992KbjyVlvaKjLFSXbQ9JF68r36bKO4rMCSVYk38eE3SpKYvQdKlr/aXhi/S
 BAynjYx9yViC4NYz3f8yjJA+IToHrUT3UgIz704BXkhY6ygatP6O/SGEJ2+8GY2pPbq5GS7EyZD
 npuIdxmkMLhx8BB6bQABXGihQeeYCcmCxQZIoqYGnRyoBhR9tj0l7gmC59qcb/eeAoG7th3Fvbm
 p3ug=
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id
 5b1f17b1804b1-45b9861e89dmr11904785e9.4.1756805148279; 
 Tue, 02 Sep 2025 02:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4RnJewGnvKK9L9+5Rytykl5qucgvHKts4nO0UMfhvyl2lsWFVCjJZqGu/t4nfTIsleiecag==
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id
 5b1f17b1804b1-45b9861e89dmr11904465e9.4.1756805147828; 
 Tue, 02 Sep 2025 02:25:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b9ab7c7dbsm10640075e9.11.2025.09.02.02.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 02:25:47 -0700 (PDT)
Message-ID: <0d030541-e533-489f-bc0c-82ee2c7fcd70@redhat.com>
Date: Tue, 2 Sep 2025 11:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] vfio-user client functional test
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250828100555.1893504-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/28/25 12:05, John Levon wrote:
> Add a basic functional test for the vfio-user client, along with a couple of
> test framework extensions to support it.
> 
> John Levon (2):
>    tests/functional: return output from cmd.py helpers
>    tests/functional: add vm param to cmd.py helpers
> 
> Mark Cave-Ayland (1):
>    tests/functional: add a vfio-user smoke test
> 
>   MAINTAINERS                                   |   1 +
>   tests/functional/qemu_test/cmd.py             |  65 ++-
>   tests/functional/x86_64/meson.build           |   1 +
>   .../x86_64/test_vfio_user_client.py           | 407 ++++++++++++++++++
>   4 files changed, 462 insertions(+), 12 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_vfio_user_client.py
> 

The test is failing :


2025-09-02 11:24:37,944 - ERROR: Server logs did not match:
2025-09-02 11:24:37,944 - ERROR: ---

2025-09-02 11:24:37,944 - ERROR: +++

2025-09-02 11:24:37,944 - ERROR: @@ -50,8 +50,10 @@

2025-09-02 11:24:37,944 - ERROR:  gpio: removing DMA region [0xf0000, 0x8000000) flags=0
2025-09-02 11:24:37,944 - ERROR:  gpio: adding DMA region [0, 0x8000000) offset=0 flags=0x3
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0x494f from (0:2)
2025-09-02 11:24:37,944 - ERROR: -gpio: region7: read 0 from (0xe:1)
2025-09-02 11:24:37,944 - ERROR: -gpio: region7: read 0x494f from (0:2)
2025-09-02 11:24:37,944 - ERROR: +gpio: region7: read 0 from (0xa:2)
2025-09-02 11:24:37,944 - ERROR: +gpio: region7: read 0 from (0xe:1)
2025-09-02 11:24:37,944 - ERROR: +gpio: region7: read 0x494f from (0:2)
2025-09-02 11:24:37,944 - ERROR: +gpio: region7: read 0 from (0xa:2)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0 from (0xe:1)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0x494f from (0:2)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0xdc8494f from (0:4)
2025-09-02 11:24:37,944 - ERROR: @@ -106,6 +108,7 @@

2025-09-02 11:24:37,944 - ERROR:  gpio: removing DMA region [0xd0000, 0xf0000) flags=0
2025-09-02 11:24:37,944 - ERROR:  gpio: adding DMA region [0xc4000, 0xe8000) offset=0 flags=0x1
2025-09-02 11:24:37,944 - ERROR:  gpio: adding DMA region [0xe8000, 0xf0000) offset=0 flags=0x3
2025-09-02 11:24:37,944 - ERROR: +gpio: region7: read 0 from (0xa:2)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0x494f from (0:2)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0xdc8 from (0x2:2)
2025-09-02 11:24:37,944 - ERROR:  gpio: region7: read 0 from (0xe:1)



Thanks,

C.



