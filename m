Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48728A46658
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 17:16:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnK4o-0005lq-C3; Wed, 26 Feb 2025 11:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnK4f-0005Vq-Ri
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnK4e-0007xu-4Q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 11:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740586550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cgVCleQy6VV36R+FJeQRA3lc/wl+PQVefuez+MAXM3g=;
 b=ALz5FzZPSoXOiJWH/Oy9eGmzXr3rD2smmd1PK2oLrZZkhpJJJFt+niwocdVPoJCXQAfmWz
 AGRJhNErYnC/0DPYm9bPw1p1gMUKbO1KpUyjGVN3ZwlS5UyHYaOsNM77O+sM9bARlKsKVi
 HJE4q44qkIPxCBx9kZ+AcCofQZxM3d0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-5MkFRzqhMjOc9KF_ZPiUpw-1; Wed, 26 Feb 2025 11:15:48 -0500
X-MC-Unique: 5MkFRzqhMjOc9KF_ZPiUpw-1
X-Mimecast-MFC-AGG-ID: 5MkFRzqhMjOc9KF_ZPiUpw_1740586547
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso38273245e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 08:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740586547; x=1741191347;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgVCleQy6VV36R+FJeQRA3lc/wl+PQVefuez+MAXM3g=;
 b=hb50dcJKn0BluIPGriCrsLn3CMGlsNHHVUU3hHLAD4ycKu1+ENiQLJIKYMcRVsU/Sm
 F35Jf/0RqpDUd9pomP36bIbpn0C/gFihdLmIBVGh77yy8dBE+n6BcoJvbRQQglHiiH2P
 s+mqziZGmMzdyaANo9nBHACtVm3eEMRea1GxyhJNuxo49WLeSIcxO3HtLMWDhJBEDdUe
 S32BwzAqawc4PscpK0xF2czYdD0xWGOseNqKRiX7ZYms4WpTn0HTXs53q7aObR4BU6yH
 vSzeAancBo/TjkQItxvacyGMqZ21xPpW/of3z1GZv1BGcWUqxQavCuP0E8u4vTxcRvUf
 JBwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHNy35++/ZNaG/VpjrVBuUxxNplIn/aHAI4c7AZLLZY/guttKKMrVX9qH2cOcJVLrdUk1treXHhFBN@nongnu.org
X-Gm-Message-State: AOJu0YwTn814aNeI46p2oF0OggZQyBvNdPjsYmltWUO1e320nrEV8Swa
 03O+/bDbFH989C7nZCHM1C8RpZYbcRx6x585caVxyXWz8FOg9D+kfGXErjI4g+8XylgGyjz5Ogg
 /Mx5DWP2Wp38sQ6qCrzOkFqhxKD0FhSJ8ngG629RlMk8A9tSM7rwQ
X-Gm-Gg: ASbGncuGQfZAw8I9OdvzR/YzpmbwKj/YJZBXW0Dzn7XiQMcVAQqY9q+InNlOIwZy11J
 03KdfObpIU/OV4uuGldhqyLlBQGQyViGTYN6oOYEOxk2qa2qLkBJz+f+LIlBcGvRx+70reD+p/t
 drH7giAer2XCasJ2BIBkUlzYdNOi3lRTmpjTWJqdupiHrGSa1YehZG/36+bvzS6ECby4SHnsuGA
 9paL6x/HIy0bj4C1ZFLhEfcMxUGzu1M/QGmEgvDO9/SnI6MBZVbRr3HWK6A/Bos/WmfbNyB+Wee
 ivPKeCrcKnxdA5ioato2fnlm67RPezseJ8eaIQn5tUEsBPc=
X-Received: by 2002:a05:600c:3b8e:b0:439:99ab:6178 with SMTP id
 5b1f17b1804b1-43ab0f2883dmr70599805e9.6.1740586547215; 
 Wed, 26 Feb 2025 08:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3O8yM1lMpTiOMbzCMbNgljSynBcj5qowMBMSafUW14cbpXClfP9s+8JifioxM3fTfJ/T2bQ==
X-Received: by 2002:a05:600c:3b8e:b0:439:99ab:6178 with SMTP id
 5b1f17b1804b1-43ab0f2883dmr70599475e9.6.1740586546878; 
 Wed, 26 Feb 2025 08:15:46 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba539445sm26580685e9.22.2025.02.26.08.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 08:15:46 -0800 (PST)
Message-ID: <cc8802a7-20fd-446d-ac15-e593333360b1@redhat.com>
Date: Wed, 26 Feb 2025 17:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] tests/vm: bump timeout for shutdown
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-11-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226140343.3907080-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/02/2025 15.03, Alex Bennée wrote:
> On my fairly beefy machine the timeout was triggering leaving a
> corrupted disk image due to power being pulled before the disk had
> synced. Double the timeout to avoid this.

Triple the timeout?

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/basevm.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 6d41ac7574..9e879e966a 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -83,7 +83,7 @@ class BaseVM(object):
>       # command to halt the guest, can be overridden by subclasses
>       poweroff = "poweroff"
>       # Time to wait for shutdown to finish.
> -    shutdown_timeout_default = 30
> +    shutdown_timeout_default = 90
>       # enable IPv6 networking
>       ipv6 = True
>       # This is the timeout on the wait for console bytes.

With the commit description fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


