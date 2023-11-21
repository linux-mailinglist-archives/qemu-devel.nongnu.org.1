Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AE7F25E0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 07:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5KSJ-00059F-3U; Tue, 21 Nov 2023 01:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5KS6-00058c-BU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5KS3-0004L3-Io
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700548898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5JKfyV18PUgnHESCrPIM3kx5k+xyBw+Bst7LYC1RHoU=;
 b=buJfBr6Q3+m3Tpm3oM0OBX7P/dmsSIIHCtUDH6kcmk0PHH6Mhle8s4sxTRym3TnY/HPPPb
 ZcvvZ6+c4EHJ0360QXHO+6qYVwqig9iCFsnZ9WYZUjiy0AESHgLSDFG7LHHutBT5nWqAbM
 DFrhBNEFoH3he+jgfK4ML0w6Wbw8liY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-QomELDfHPC6YHp3-CxkcqQ-1; Tue, 21 Nov 2023 01:41:36 -0500
X-MC-Unique: QomELDfHPC6YHp3-CxkcqQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5400c8c6392so3786084a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 22:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700548895; x=1701153695;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JKfyV18PUgnHESCrPIM3kx5k+xyBw+Bst7LYC1RHoU=;
 b=YmRp2UB4GIhAtnC1n7c7icQl/CSjlgd+oslvW6jitKibXbTilk/Y63Nl/aifAK/MC/
 SxI+nyjN+Gqz3W4xAqe4dXJGTw63yAs234wUPoQAKIyNa1Qen++/jtS7tj2gOeYUjtKy
 /cSv1yi2HKIg3ZatWdtchnS32xQ5zeopjYmd4mJlgcwxlP97f+r3upqW0V279xtLiYc+
 DKJEF2v3FtMRBDKjnN/2p198PsDS9qvd75ivSfgFbcaX0V8usieQln3pJn1Qwtqv1pPY
 fu1yejcMMICBUzJ1ny/artc99+jhviSkOcbXDdpSmgztibdI7njllf9LUAJMX+hf5rcZ
 gQZg==
X-Gm-Message-State: AOJu0Yzs7el6eNyhypL3zwUa4wniD4AbT7IAOXBOqYzommyKOfn6F36v
 To18MWZ2HhyLFUaqcXdNNYiBPRKXuOsUpEvSr7fALaTS+CQnxgwo+UfMRwIIysgcmFj9ytjtOLb
 PcA7KL1iXKCvkMRA=
X-Received: by 2002:aa7:d604:0:b0:53f:d261:7945 with SMTP id
 c4-20020aa7d604000000b0053fd2617945mr1350717edr.21.1700548895454; 
 Mon, 20 Nov 2023 22:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENqif+FGH51Td0Low9u86tMa4g9TFsl/0HQDuSnH7HpPy7P8R7jhGvd9lZOZdFu6eRKGYaZw==
X-Received: by 2002:aa7:d604:0:b0:53f:d261:7945 with SMTP id
 c4-20020aa7d604000000b0053fd2617945mr1350707edr.21.1700548895193; 
 Mon, 20 Nov 2023 22:41:35 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de.
 [109.43.176.233]) by smtp.gmail.com with ESMTPSA id
 m7-20020a509307000000b00546d9d81ec8sm4592325eda.93.2023.11.20.22.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 22:41:34 -0800 (PST)
Message-ID: <08e7104d-5a6c-4a4a-a737-200f04fffd57@redhat.com>
Date: Tue, 21 Nov 2023 07:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: check the return value
To: zhujun2 <zhujun2@cmss.chinamobile.com>, chen.zhang@intel.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <CYYPR11MB8432C52A61F5A47F4025BDEB9BB0A@CYYPR11MB8432.namprd11.prod.outlook.com>
 <20231121061630.3350-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231121061630.3350-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Thanks, patch looks better this way, but I'd still like to ask you to fix 
two small issues:

On 21/11/2023 07.16, zhujun2 wrote:
> These variables "ret" are never referenced in the code, that

s/, that/, thus/

> add check logic for the "ret"
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

Could you *please* fix your ~/.gitconfig file, like we asked you last time 
already:

 
https://lore.kernel.org/qemu-devel/27bd1017-fd0a-4e90-ae54-6064b434b9aa@redhat.com/

  https://lore.kernel.org/qemu-devel/87sf5w198d.fsf@pond.sub.org/

  Thanks,
   Thomas


> ---
>   tests/qtest/test-filter-mirror.c     | 1 +
>   tests/qtest/test-filter-redirector.c | 2 ++
>   tests/qtest/virtio-net-test.c        | 1 +
>   3 files changed, 4 insertions(+)
> 
> diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
> index adeada3eb8..f3865f7519 100644
> --- a/tests/qtest/test-filter-mirror.c
> +++ b/tests/qtest/test-filter-mirror.c
> @@ -61,6 +61,7 @@ static void test_mirror(void)
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
>       ret = recv(recv_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, ==, len);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       g_free(recv_buf);
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
> index e72e3b7873..a77d5fd8ec 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -118,6 +118,7 @@ static void test_redirector_tx(void)
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
>       ret = recv(recv_sock, recv_buf, len, 0);
> +    g_assert_cmpint(ret, ==, len);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       g_free(recv_buf);
> @@ -185,6 +186,7 @@ static void test_redirector_rx(void)
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
>       ret = recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, ==, len);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       close(send_sock);
> diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
> index fab5dd8b05..b470d8c6e2 100644
> --- a/tests/qtest/virtio-net-test.c
> +++ b/tests/qtest/virtio-net-test.c
> @@ -92,6 +92,7 @@ static void tx_test(QVirtioDevice *dev,
>   
>       ret = recv(socket, buffer, len, 0);
>       g_assert_cmpstr(buffer, ==, "TEST");
> +    g_assert_cmpint(ret, ==, len);
>   }
>   
>   static void rx_stop_cont_test(QVirtioDevice *dev,


