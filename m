Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33664803547
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 14:46:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9Fk-0005KR-Gj; Mon, 04 Dec 2023 08:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9Fj-0005KF-Ay
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9Fg-00025O-MP
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 08:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701697485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tdkQxNqtMWP8bSr1GKih/F4rURaRyVyZ5CNGBJ3ThtY=;
 b=RNI+842DXOsJwQa+2xlbWK5sZoz/WGnY2hcwnM0vccK4rqT3c+vqDJ804OsC3h7DnvdhLw
 fD/Q1M+Z4cbU6mZeASg/g7s2dEB80y9AX1aP14PpCGiD6AwF7uB/AmPcxl0YdYNXp5NxZX
 B4nVP2NvfJROK9NBKPM/wUedDiL5OKw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-9JcfZaQ-Ota9EyjsvmrGnw-1; Mon, 04 Dec 2023 08:44:19 -0500
X-MC-Unique: 9JcfZaQ-Ota9EyjsvmrGnw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3333c009305so1876825f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 05:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701697452; x=1702302252;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdkQxNqtMWP8bSr1GKih/F4rURaRyVyZ5CNGBJ3ThtY=;
 b=FS5YxzHQ2Jl40zfwlk4T6DeY38P6BUPAplbT+2T/tDIUJCAxzbBzhqZILSG68VCPzu
 RWa0oGrWry7xjdBLGDa3raE7jUZJbapu1X+wqqAE3ctxKKZv53vFWGIVmQOM8XYGO8xh
 wyisydZ0y/hTVdXXRe1o6/+/DTPvR6KWsiWTPtKOlyEvV9ez9kH83TiGe6B40u3VTxoW
 ht6nVFl0/Kpqp/h2p+L7yTK2538vBpfuBnr+Uq7rRD1xtX+mnB84dOMNf+UAJyiWshk9
 Kl32P8S1ZSUskwafkU7HJ738Oo5EhN5LFKEjeE9xLL6ohsRaqFajN1cC+4dqRm53DIhj
 v3aA==
X-Gm-Message-State: AOJu0YzTpGpiODgWs9rsru55KqPVHFMMoSo0iFADO5fUdaw76RK0EISg
 s+/vREE9AYqTOgkiSk8J0mq0RzkjS2XQ5RMFdQYwTF3LCfTxiUcoYn6ftk9poxsW3r/zTEyhsZj
 SooGUTn12kt48sLo=
X-Received: by 2002:a05:600c:8608:b0:40c:707:261f with SMTP id
 ha8-20020a05600c860800b0040c0707261fmr1755552wmb.134.1701697452832; 
 Mon, 04 Dec 2023 05:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeP1anA4UUJPWyi5biHuQSAzA4rfDL3sKV8KLMcmQM3cXm+fMnmhaDED3Vzg3bn5iJ0m0tfQ==
X-Received: by 2002:a05:600c:8608:b0:40c:707:261f with SMTP id
 ha8-20020a05600c860800b0040c0707261fmr1755541wmb.134.1701697452473; 
 Mon, 04 Dec 2023 05:44:12 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-85.web.vodafone.de.
 [109.43.178.85]) by smtp.gmail.com with ESMTPSA id
 f16-20020a05600c4e9000b0040b4e44cf8dsm15014378wmq.47.2023.12.04.05.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 05:44:11 -0800 (PST)
Message-ID: <02ad8ad4-147a-472b-b865-5ebdcd0d622d@redhat.com>
Date: Mon, 4 Dec 2023 14:44:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v2] tests/avocado: Update yamon-bin-02.22.zip URL
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Beraldo Leal <bleal@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20231201205630.10837-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231201205630.10837-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/12/2023 21.56, Philippe Mathieu-Daudé wrote:
> http://www.imgtec.com/tools/mips-tools/downloads/ redirects
> to https://mips.com/downloads/yamon-version-02-22/ then points
> to an invalid path to a s3 bucket. Use the correct path. The
> site will eventually be fixed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Supersedes: <20231201142139.39816-1-philmd@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   tests/avocado/machine_mips_malta.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
> index 9bd54518bf..8e1ee120f4 100644
> --- a/tests/avocado/machine_mips_malta.py
> +++ b/tests/avocado/machine_mips_malta.py
> @@ -124,8 +124,9 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>   class MaltaMachine(QemuSystemTest):
>   
>       def do_test_yamon(self):
> -        rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
> -                   'yamon/yamon-bin-02.22.zip')
> +        rom_url = ('https://s3-eu-west-1.amazonaws.com/'
> +                   'downloads-mips/mips-downloads/'
> +                   'YAMON/yamon-bin-02.22.zip')
>           rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
>           zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


