Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0995AF26
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 09:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh28x-0004Z5-H4; Thu, 22 Aug 2024 03:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sh28g-0004YE-A0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 03:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sh28d-0001Ww-Ab
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 03:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724311302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RGI//FL3panaezNoertxPQQGfWMh13B5RIAM5TK9dNk=;
 b=VSfgDS38DuvGW3tsismvaLMoK1GJbycs+EVMANa84OBY5nv971nTTk4nxV8SSWE00d/Wgw
 k1TNH72LDZzB6777S1FCCXZ+466hIPAcKheq0ZAmbwRXJq2DcduBzgWgXKbDpgCZmLH//E
 w8ILWp1bRVppxSfG+fzRH1U2L9Y0x5U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Iaq6j1y_PYmjVru1S7NOJA-1; Thu, 22 Aug 2024 03:21:39 -0400
X-MC-Unique: Iaq6j1y_PYmjVru1S7NOJA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5bee85b49c7so566072a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724311298; x=1724916098;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGI//FL3panaezNoertxPQQGfWMh13B5RIAM5TK9dNk=;
 b=kEO4AvV7MxayzJP4YNFHSv0Kldw3bs82Qu9eNh1NMdxrsmwOAOGnfE1QDpSfbLYpVd
 HpjZLIfyRROV88r9IYQ6J42T692ozNTRuvMLJcXViDdMT7nkKYoezRJ+xiozUquusMci
 V8RrcLL8ABvVnDWzukQPoU8FnupUdVAYTDZ60rRRlUeGEzRWR5Kxkz91dH/xpDfNaWPR
 N3L6dr/BTkgxHQw1son59G0hEGwHH4g3S9Ohot33k9YY2y+iuEteORsSYsIld4BSAN8T
 wtT4SjPM9ouwVa4ISL21DFRiaBjsmC3YaOEM/PiptsgPSRX70w9rD4pERhLFDqsM1s3h
 EUow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCQlVVEE94lZwmlsrLZ5mzZG+eepAiyrH6vGbLSB1W9JQF3tUtd0TirRQGShTNusepwFWjxNJ5r+lD@nongnu.org
X-Gm-Message-State: AOJu0YyvakDBfz3HSYVsIC9XQXGsWT1X2lQ6nFvQl7FkoG53aUEYlzxy
 Kwe78LFNUCR1uhyqcjGz8kl3fe9g6SjiiwJ9Nv4oJswdzIL5MSux6nCRLBM1CZAxS2RTjgZ3BPS
 Je1P3vR66BdGwyWIHtQPtoASz4tYUCRwjfFGZXc+PHZceRfE7SUI8
X-Received: by 2002:a05:6402:540a:b0:5bf:d25:1fc9 with SMTP id
 4fb4d7f45d1cf-5bf1f2765a2mr2783705a12.35.1724311298392; 
 Thu, 22 Aug 2024 00:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSgMuDM2kzshPUJp76ItI8MP3CQ1sXvfLMtu87eNL6xTpARwtrOUvsyMEXqEkvbP5UsMO2tQ==
X-Received: by 2002:a05:6402:540a:b0:5bf:d25:1fc9 with SMTP id
 4fb4d7f45d1cf-5bf1f2765a2mr2783690a12.35.1724311297843; 
 Thu, 22 Aug 2024 00:21:37 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-41.web.vodafone.de.
 [109.43.177.41]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a3ca017sm559016a12.24.2024.08.22.00.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 00:21:37 -0700 (PDT)
Message-ID: <0e7e30cf-bd67-4d21-9ee9-b6ab77b8e35f@redhat.com>
Date: Thu, 22 Aug 2024 09:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Allow running user-mode tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20240821153836.67987-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240821153836.67987-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 21/08/2024 17.38, Philippe Mathieu-Daudé wrote:
> Commit 816d4201ea ("tests/avocado: Move LinuxTest related
> code into a separate file") removed the Avocado 'process'
> import which is used by the QemuUserTest class, restore it.
> 
> Fixes: 816d4201ea ("tests/avocado: Move LinuxTest ...")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Unfortunately the single linux-user test is not run on CI,
> and I haven't ran it manually since too long...:
> https://gitlab.com/qemu-project/qemu/-/issues/2525
> ---
>   tests/avocado/avocado_qemu/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index ef935614cf..0d57addfea 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -17,7 +17,7 @@
>   import uuid
>   
>   import avocado
> -from avocado.utils import ssh
> +from avocado.utils import process, ssh
>   from avocado.utils.path import find_command

Reviewed-by: Thomas Huth <thuth@redhat.com>

... but is the test itself still working for you? When I run it, I get:

  ...
  (074/281) 
tests/avocado/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64eb_kernel3_2_0: 
SKIP: Test might timeout
  (075/281) 
tests/avocado/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0: 
SKIP: Test might timeout
  (076/281) tests/avocado/load_bflt.py:LoadBFLT.test_stm32: ERROR: Command 
'./qemu-arm  /bin/busybox ' failed.\nstdout: b''\nstderr: 
b''\nadditional_info: None (0.06 s)
Interrupting job (failfast).

Seem like self.workdir is not set here??

  Thomas


