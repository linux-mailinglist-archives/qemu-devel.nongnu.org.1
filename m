Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBB8BC49DB
	for <lists+qemu-devel@lfdr.de>; Wed, 08 Oct 2025 13:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Sdh-0007ui-76; Wed, 08 Oct 2025 07:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Sdd-0007uS-BL
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6SdU-0007mj-QB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 07:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759924025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GLvX2sHAlKlFM/JfXvLH3BDvHXb0pdmT8X99ao8jtUU=;
 b=F3rQJ25TtLmQrUuVJrcqJ3cee1rbmrjJzlRVVBYEwdsFXregdn2ogwowY3UThE+r4Q1ft6
 jntPpcxnEo//Liu3pZXKQ9V2FUsHLiYb54F+czNdcUBpMkl8pqj/i2AfGZcjA+Ab3TrZhp
 58MahI3lpynA4SmRYRXUiZA4FJcKcDg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Nxs6INzlMQa1TP5px3gylg-1; Wed, 08 Oct 2025 07:47:04 -0400
X-MC-Unique: Nxs6INzlMQa1TP5px3gylg-1
X-Mimecast-MFC-AGG-ID: Nxs6INzlMQa1TP5px3gylg_1759924023
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f93db57449so3872004f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 04:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759924023; x=1760528823;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLvX2sHAlKlFM/JfXvLH3BDvHXb0pdmT8X99ao8jtUU=;
 b=STkgy6isWHNwWRkorMtexyB16+34JFPk90/wPTnw3QgJ40ndIgXuuN0rErXTCizFpN
 QVxahh2+L8UXoztm3GTReByEygrqkqzTZSryxVLY+TdVzVmT1gTeuO4KsaXv6kpHiNSJ
 XJmK07vR6oLRCp/c4Ge/Hc76FOE+w+3fukoS10i1gggn5SQ5SimVAm+2ByRF9qmmYxKH
 2sd4q3CXdFAmV/jsjJPhzJ6pNHkL3qP1KnLj88c3tOdM1tiP1RVy2aHLp6dNEfIcDA68
 xc2u8rG2X+jAjk5Z8lPH0eTodW1Y0nr3vWeVpSo5AbVgcisQDKImEUmcFGhixe2jqntm
 CHdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMvKzSAd2XgJztZ6NmrKahXumoFvGQ2jYVcUbXyfJbRi/VqU7FN5kF2XZ1ByiAXgu9vOktu7Nasj66@nongnu.org
X-Gm-Message-State: AOJu0YwCGgwNlLE45wDyU8iS7eFBo9adkpfUB+IdN4saiBEIR68UmQC4
 npNwgoNJqxyjhMvGBm2hx2AwYxAIwdQMd0Ri7RecsyuBq2Z979l1vTFpZ9jyyy+pNgbezcK3msz
 QCT7c2jyQJjF7r3FxqgtOgHs4BK0nu4CDtYQwoT1rm+82iZQ4XWL/C67h
X-Gm-Gg: ASbGncuSaMmheuzJawiqKhVNuO/f/CBCE3QqvhDdoUDVlSyaiZ60gKzDwAZpxR+b35k
 ROj/tTofzuo2fZ7iRQ+jKq1YoO6fuDVxfVY9q357ghlH2TNnYmcZ/Jx9clIXPjsqRspzYUFQ4Nh
 gzvVqzTTmCQC8X/ADu1TdXAeFVjzNLzuJU1xrWhiE+K7y+mb49HblJT1con03I21jDWugWnsUp1
 RPxD6h84Zs3/UceFsz00C/UZBSwX0utiIFaJRO3J49uJmyQVPWYn8citNutz5zMDMfAgUke0tJK
 YeP/KuZ5Ymugx3u7MZOzdwmL3X1li9+D7VHLH4LBp6OrMBUIwAujgrfimnMBR+IBVQF95TmVjD+
 +YwlC7u1zsw==
X-Received: by 2002:a05:6000:208a:b0:3ee:152e:6774 with SMTP id
 ffacd0b85a97d-42666ac6d60mr1740253f8f.28.1759924022988; 
 Wed, 08 Oct 2025 04:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzFftw0YAs2lAfrHqbn6mp9Nvs4WWPfG1qtqtO3v7YOJi2Qu8526bS6LfeW/K356+1BS6mww==
X-Received: by 2002:a05:6000:208a:b0:3ee:152e:6774 with SMTP id
 ffacd0b85a97d-42666ac6d60mr1740231f8f.28.1759924022589; 
 Wed, 08 Oct 2025 04:47:02 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c1589esm34372565e9.9.2025.10.08.04.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 04:47:02 -0700 (PDT)
Message-ID: <d4072dec-62da-45cf-b342-c5c785125847@redhat.com>
Date: Wed, 8 Oct 2025 13:47:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests: print reason when I/O test is skipped in TAP
 mode
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251008113552.747002-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/10/2025 13.35, Daniel P. Berrangé wrote:
> The TAP output on a skipped test:
> 
>    ok raw 181 # SKIP
> 
> is not informative.
> 
> The test program included a reason, and that should be displayed
> in TAP mode (it is already shown in non-TAP mode):
> 
>    ok raw 181 # SKIP Postcopy is not supported
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/testrunner.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> index 14cc8492f9..c4ce3e29e9 100644
> --- a/tests/qemu-iotests/testrunner.py
> +++ b/tests/qemu-iotests/testrunner.py
> @@ -174,7 +174,7 @@ def test_print_one_line(self, test: str,
>               elif status == 'fail':
>                   print(f'not ok {self.env.imgfmt} {test}')
>               elif status == 'not run':
> -                print(f'ok {self.env.imgfmt} {test} # SKIP')
> +                print(f'ok {self.env.imgfmt} {test} # SKIP {description}')
>               return
>   
>           if lasttime:

Reviewed-by: Thomas Huth <thuth@redhat.com>


