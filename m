Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E048784EB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 17:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiNE-0005bZ-L4; Mon, 11 Mar 2024 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjiNC-0005ap-UJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjiNB-0006rb-Cm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710173972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kfAIWEk2h63FGSCqouXzrZiDAOiiGQWQqUA6j5tBais=;
 b=Xzu843Cr/Ovw2XIksiLpgapTVyBSfxFU5j8svg8BkduXaw0rzV/RrxyRa+l+U1Ch5sHplw
 yC6bZCdvkqeVE8DuefU+L/45PeahnG521g38BXsBloz2HUn3mlT+HAuDX1zh/Qc0v+oyQA
 IojoU27vPADDDlpVFcYGId6oZ6DOGBE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-5_vZcxUyPlGG_oLnSEcoHw-1; Mon, 11 Mar 2024 12:19:30 -0400
X-MC-Unique: 5_vZcxUyPlGG_oLnSEcoHw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c242d5f310so2484940b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 09:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710173969; x=1710778769;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfAIWEk2h63FGSCqouXzrZiDAOiiGQWQqUA6j5tBais=;
 b=flFqPTE9BCTqyytDurjFDwLygTGPOjQy80D749y9MVLeT7B6IsFpGmfbXvH2bKsvHz
 5HJGVu8juvYvcFMd/0KjDuRAjb/eOqUDyUE798PCC+7cap7hSFqNtjsUrTXHq6AmrEzC
 0jkag/3hMpJ0jrmx7Fthmx0Cw2jvyNZXeQhe9936BbdN4SJSsQ09yo1pHt/R17oLIoxf
 oqySW6rvdAV0dIB4I+EJxtwm/VPNmcK7rOwH4r0I1gn6931kbXKxMnEN5NZTJ+L3KoWH
 PdlRjfihbzH5DUqkcy43gDMzgTMSM3UrdyvWT2COcILmQ1WAiN73piul//M5axs/Q36t
 ZLeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQAQe2Znl1mMjGkgGOVAUlSeSsX8H8CMODjSn1ecEaRwNBVT9J4Znh5r6w7QlUOu3wyEJoTVzltfRyHkw+UKtNkarODbw=
X-Gm-Message-State: AOJu0YwPJ4Ox+Y6IhpFNniP7/tLbAq5tI9lalto68xH8Er2HDHQj9jpy
 0OBVk/jlj7Eqeanm9fjITqjo4czh2F+lMAqBVkS6ncBbFFX2JODW7OGs2Q+OZoOR7BG2bywE18G
 XeCfkb/B76ov43UqbuIbcqXJxhOYumptpDLV4mjN5SDGBhYr8alUa
X-Received: by 2002:a54:458c:0:b0:3c1:f000:8f41 with SMTP id
 z12-20020a54458c000000b003c1f0008f41mr7877930oib.13.1710173969497; 
 Mon, 11 Mar 2024 09:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyuoZhV0BXO0JxlwLRC8E2G12khSk8DfKIgHlhEkoBpowMJzpQC0o0U0/kESpApoqGxAMspA==
X-Received: by 2002:a54:458c:0:b0:3c1:f000:8f41 with SMTP id
 z12-20020a54458c000000b003c1f0008f41mr7877916oib.13.1710173969199; 
 Mon, 11 Mar 2024 09:19:29 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 fc11-20020ad44f2b000000b00690cd39da04sm1404036qvb.32.2024.03.11.09.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 09:19:28 -0700 (PDT)
Message-ID: <1e9b681b-7223-4538-b10d-29e2ef9a383b@redhat.com>
Date: Mon, 11 Mar 2024 17:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] crypto: use error_abort for unexpected failures
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240311121929.212472-1-berrange@redhat.com>
 <20240311121929.212472-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240311121929.212472-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/03/2024 13.19, Daniel P. Berrangé wrote:
> This improves the error diagnosis from the unit test when a cipher
> is unexpected not available from
> 
> ERROR:../tests/unit/test-crypto-cipher.c:683:test_cipher: assertion failed: (err == NULL)
> Bail out! ERROR:../tests/unit/test-crypto-cipher.c:683:test_cipher: assertion failed: (err == NULL)
> Aborted (core dumped)
> 
> to
> 
> Unexpected error in qcrypto_cipher_ctx_new() at ../crypto/cipher-gcrypt.c.inc:262:
> ./build//tests/unit/test-crypto-cipher: Cannot initialize cipher: Invalid cipher algorithm
> Aborted (core dumped)
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/unit/test-crypto-cipher.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
> index 11ab1a54fc..d0ea7b4d8e 100644
> --- a/tests/unit/test-crypto-cipher.c
> +++ b/tests/unit/test-crypto-cipher.c
> @@ -676,9 +676,8 @@ static void test_cipher(const void *opaque)
>       cipher = qcrypto_cipher_new(
>           data->alg, data->mode,
>           key, nkey,
> -        &err);
> +        data->plaintext ? &error_abort : &err);
>       if (data->plaintext) {
> -        g_assert(err == NULL);
>           g_assert(cipher != NULL);
>       } else {
>           error_free_or_abort(&err);

Reviewed-by: Thomas Huth <thuth@redhat.com>


