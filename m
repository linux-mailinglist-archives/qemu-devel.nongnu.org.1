Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F2787658
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDk1-0005No-BH; Thu, 24 Aug 2023 13:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZDjy-0005Mu-EQ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZDjw-0004Ne-Ba
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3kRLz+ZA06am4JR2aJDif9dpMhEwje4+NgoZ/0pufE=;
 b=Aw4f/bXUJmQsS+evsZ6MP9rFUnIh3aKwkWImVoQNbHLgrTRFgwgyxHsJfGSBGNbX1voHdM
 k6LMVJB5wxEF9GxrptvhmNo01Si8ILmq/wFx761oixd04PiNAwJA0wRbx8NNabZCNbYzBx
 WwcE3CZgDp3INH4p3B4d0GcFRmPoke8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-iOIExoSUOuePnhwoO3S97A-1; Thu, 24 Aug 2023 13:03:22 -0400
X-MC-Unique: iOIExoSUOuePnhwoO3S97A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c6c275c83so1436429f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 10:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896601; x=1693501401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3kRLz+ZA06am4JR2aJDif9dpMhEwje4+NgoZ/0pufE=;
 b=Pk7EmejnQZdTN9Slvo5+lsvxsbMA16TJGkmH7xXWgsI33F4w3qpe8Q68bN+GN/v4cJ
 8sSeDJ0HIOGKkibXhstlDBKHArY6CZdjUbBgIXdY0zT+oJ/2q83w+2pCrcEoYG80Txhh
 L19KYOVrOiIv2bZ7v45gTKyGx46TLzLT8Rg5dEQklq8kb4Y6ahi0AT2cKzZeD9/ZKnqz
 5rmZt7XHxNiEha+/ykcrh7n12zqUUi0QAf64tgEsWGEeMMvjzf6kbZWrDPC4poYpI9Ad
 Of5A+lJ6MxF2UXkzjMt5zb0jMRJHK0zXwB7Gx7dAprvaJSkchPNSNQUJxTF/DWiLMLMk
 cdow==
X-Gm-Message-State: AOJu0Yw6S6q52NQz53raHWLJ4DTwe9EtIbpw8pYGv/FeJpCbJRZbXAqc
 AvJBRHp9zFFR7tvr9c08vpjBKNvh979ci5qTNxlxOmKQMwx32w2iVAEmdwCGobM/OJnR8726DiL
 QvCxVpgnbJg/s5js=
X-Received: by 2002:a5d:6911:0:b0:317:6639:852d with SMTP id
 t17-20020a5d6911000000b003176639852dmr12071942wru.43.1692896601141; 
 Thu, 24 Aug 2023 10:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzu+G0hTOEJ7ugouWWC19SrhovLekYg9kRfvrB/aIEj6kwUZvqsGZ7a2ZTI5KWHt3TFV77LA==
X-Received: by 2002:a5d:6911:0:b0:317:6639:852d with SMTP id
 t17-20020a5d6911000000b003176639852dmr12071927wru.43.1692896600855; 
 Thu, 24 Aug 2023 10:03:20 -0700 (PDT)
Received: from [192.168.8.103] (tmo-099-164.customers.d1-online.com.
 [80.187.99.164]) by smtp.gmail.com with ESMTPSA id
 y12-20020adfee0c000000b0031aeca90e1fsm18908588wrn.70.2023.08.24.10.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 10:03:20 -0700 (PDT)
Message-ID: <e46d4326-de82-7221-b7f1-cedad7ab7e00@redhat.com>
Date: Thu, 24 Aug 2023 19:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/qtest/netdev-socket: Avoid variable-length array in
 inet_get_free_port_multiple()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>
References: <20230824164535.2652070-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230824164535.2652070-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/08/2023 18.45, Peter Maydell wrote:
> We use a variable-length array in inet_get_free_port_multiple().
> This is only test code called at the start of a test, so switch to a
> heap allocation instead.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/netdev-socket.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
> index 097abc0230b..8eed54801f2 100644
> --- a/tests/qtest/netdev-socket.c
> +++ b/tests/qtest/netdev-socket.c
> @@ -82,7 +82,7 @@ static int inet_get_free_port_socket_ipv6(int sock)
>   
>   static int inet_get_free_port_multiple(int nb, int *port, bool ipv6)
>   {
> -    int sock[nb];
> +    g_autofree int *sock = g_new(int, nb);
>       int i;
>   
>       for (i = 0; i < nb; i++) {

Reviewed-by: Thomas Huth <thuth@redhat.com>


