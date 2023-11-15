Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB87EBE66
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:10:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ax4-00056f-N5; Wed, 15 Nov 2023 03:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3Ax2-00056J-US
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3Ax1-0006e6-4G
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700035721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pvcVHWM4j/QCmbSe1xNMFqy8ksb099N0PHv0DnQlxWo=;
 b=X63zatWflJz05/D0dUTh02MXrQ1APPioG7+vXjeU1Fe96gMQlZowl1XCnwve+VdASx2uYp
 a+4DXF4cOUplrFc3d03ctxSnb67Ap7QvefqHK0tpySb6Z4LG5xcoLFDVij4VC+YvY939nU
 yB+jvDIhw7FQM+L//bdVtk4FjbhvTgo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-_W4DmY5aPVSq5enjU24Dpw-1; Wed, 15 Nov 2023 03:08:40 -0500
X-MC-Unique: _W4DmY5aPVSq5enjU24Dpw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32fd5f67818so2788977f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 00:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700035719; x=1700640519;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pvcVHWM4j/QCmbSe1xNMFqy8ksb099N0PHv0DnQlxWo=;
 b=VThqckXY33B15o5Y5Rnz5EYwh2PQQGUau2LlImc14aQex1erNdMBliYQw1HSYnlz+u
 xDsajUkAfKQVN1GJWRlaqoMmKdqZjDsNj5raN4MJMd2lSjR27t+TDBDDwHk2bmOjlw0H
 kEyyY1ZfcMTIAsxim27lPuL8alpnTOfGYsgXLrthKFQk50mqt3r1Mlq7fGJ1SpBeQHq7
 ZQOn0vPucfQib0j46FK/UGR9ggQkTdm6uUEZbBnqqlacXMJk9mqpRNq701hCpEfA6Box
 AczeW0NGQjgBLAZa0R5E+tWQWG9iQ8Eqg1QEWVwG5REbh68i2PnfDjPAlT5Ew6BbJbf/
 gW9Q==
X-Gm-Message-State: AOJu0YwSzDvvZQE80BDY8m8H4p/AfuWdOdEPTz1QzDGOV0PDBJ4zu346
 IkN15ssFY+PpnJiw3Vqt3E+jEMS+j++hWwru1fjBfKFobFBEE+eXRkEGLpd3pyILUIK06p8W6Ea
 r8PxKgZIzlGI8hq4=
X-Received: by 2002:a5d:64ab:0:b0:331:42b1:a1ed with SMTP id
 m11-20020a5d64ab000000b0033142b1a1edmr7141873wrp.51.1700035719306; 
 Wed, 15 Nov 2023 00:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1hJ/ZQyF/vkQIyNcbz7HnRgYK+mzpxtWb+pE2Op9b3teAzawyAAOH4nv9y5+Y7MmtmN2wJQ==
X-Received: by 2002:a5d:64ab:0:b0:331:42b1:a1ed with SMTP id
 m11-20020a5d64ab000000b0033142b1a1edmr7141864wrp.51.1700035719040; 
 Wed, 15 Nov 2023 00:08:39 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 z14-20020adff74e000000b0032f7865a4c7sm9780826wrp.21.2023.11.15.00.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 00:08:38 -0800 (PST)
Message-ID: <c1b546d4-bcc6-4108-bcd9-432b1f6a737c@redhat.com>
Date: Wed, 15 Nov 2023 09:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: remove unused variables
Content-Language: en-US
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20231115080014.12273-1-zhujun2@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231115080014.12273-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 15/11/2023 09.00, zhujun2 wrote:
> These variables are never referenced in the code, just remove them
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>   tests/qtest/test-filter-mirror.c     | 2 +-
>   tests/qtest/test-filter-redirector.c | 4 ++--
>   tests/qtest/virtio-net-test.c        | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
> index adeada3eb8..7aa81daa93 100644
> --- a/tests/qtest/test-filter-mirror.c
> +++ b/tests/qtest/test-filter-mirror.c
> @@ -60,7 +60,7 @@ static void test_mirror(void)
>   
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
> -    ret = recv(recv_sock[0], recv_buf, len, 0);
> +    recv(recv_sock[0], recv_buf, len, 0);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       g_free(recv_buf);
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
> index e72e3b7873..e4dfeff2e0 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -117,7 +117,7 @@ static void test_redirector_tx(void)
>   
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
> -    ret = recv(recv_sock, recv_buf, len, 0);
> +    recv(recv_sock, recv_buf, len, 0);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       g_free(recv_buf);
> @@ -184,7 +184,7 @@ static void test_redirector_rx(void)
>   
>       g_assert_cmpint(len, ==, sizeof(send_buf));
>       recv_buf = g_malloc(len);
> -    ret = recv(backend_sock[0], recv_buf, len, 0);
> +    recv(backend_sock[0], recv_buf, len, 0);
>       g_assert_cmpstr(recv_buf, ==, send_buf);
>   
>       close(send_sock);
> diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
> index fab5dd8b05..26df5bbabe 100644
> --- a/tests/qtest/virtio-net-test.c
> +++ b/tests/qtest/virtio-net-test.c
> @@ -90,7 +90,7 @@ static void tx_test(QVirtioDevice *dev,
>       g_assert_cmpint(ret, ==, sizeof(len));
>       len = ntohl(len);
>   
> -    ret = recv(socket, buffer, len, 0);
> +    recv(socket, buffer, len, 0);
>       g_assert_cmpstr(buffer, ==, "TEST");
>   }

Wouldn't it be better to check the ret value for success?

  Thomas



