Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5C72600B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sc6-0001e7-1e; Wed, 07 Jun 2023 08:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6sbv-0001b6-UX; Wed, 07 Jun 2023 08:49:59 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6sbu-0002dA-EF; Wed, 07 Jun 2023 08:49:59 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-39b86f95a66so1550079b6e.1; 
 Wed, 07 Jun 2023 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686142196; x=1688734196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/kXMaN8FEAm6ZEjehbYv9MK9vgRZm8lvoD/IES1+nE=;
 b=h7zVEdjzsPqiWeP3PSAdCLTkvyb4LVSy21Kyrk0sJzM6eECMb2CQStDxLMDUhOYAdL
 PDGzukmTZtUwVV24A8MGld1cp3+RukyXbmL4Nt1H8JZXGcy6clp48xEkxAynByA7F3n2
 t6l+ay4t5c3q7AiIvXnWXEcvmxU6YTW7iTtf54Urn2o0TU9/QCUKh6KKcSzyny00s7UZ
 RqIuENAMTU4aymtg7+p9WRRu7JEFmbGpNMFnPU6fKNkr8MwAxR8hchyyJ+cd0llgo44v
 hWfWP+MUCWz8O+B87MCEE1ElFXYkTKSlSTTPV0PDc4YhqNt1EYTjSUJUdYWQykgM4Rca
 /ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686142196; x=1688734196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/kXMaN8FEAm6ZEjehbYv9MK9vgRZm8lvoD/IES1+nE=;
 b=jsBHQDYgg5BitBy2oLGIKG7xFE6epQ5M0VxOfapykLjkmgOLYOjhF2hvSyJL/2lEoi
 OtrZbraaUSXyBFxJP9DknuoofpT8+wUyskcduZbr55d5QEinipwurkTtHp82LYRZrNWV
 o85MBoBVqIqu/iItJyDbtMddyNO5sfGllJ/nxrbfQFLmEVqONwJfkBdrUnk9XJiUraam
 m7zjkgGe2D75pxMzzpAAa4zbpji+kjoI5h5jeu/3D30QK932UGVCmGOiu3qRQ/FFu0WY
 A8AyNLB0qbjY3M3izQ7dPqratgXBHMW9OFZNp32JleNYQoCqs5K+6vuCrC7NnaHCCjUZ
 x/PA==
X-Gm-Message-State: AC+VfDytZnSMJWE77MZMriml8ry0Qrrz68dSwvH0CcxX+CilPDO4g5bO
 HUEFsIIcRXYz+f4fOvYOcTPrRrC0pWM=
X-Google-Smtp-Source: ACHHUZ709NMbxPpepwckNquxU2cH1XtnBPbtdeXuZbDdIqExwE9O3NWdMrZowXQUsCjQ4VG7u1/sLg==
X-Received: by 2002:a54:4487:0:b0:39a:a92b:c546 with SMTP id
 v7-20020a544487000000b0039aa92bc546mr3696324oiv.19.1686142196385; 
 Wed, 07 Jun 2023 05:49:56 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 bm26-20020a0568081a9a00b0039b008b309esm2505591oib.19.2023.06.07.05.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 05:49:55 -0700 (PDT)
Message-ID: <0cafafda-7757-1f4c-0620-e929e3129502@gmail.com>
Date: Wed, 7 Jun 2023 09:49:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kautuk Consul <kconsul@linux.vnet.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230606192802.666000-1-thuth@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230606192802.666000-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 6/6/23 16:28, Thomas Huth wrote:
> The ppc64 tuxrun tests are currently failing if "slirp" has been
> disabled in the binary since they are using "-netdev user" now.
> We have to skip the test if this network backend is missing.
> 
> Fixes: 6ee3624236 ("improve code coverage for ppc64")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

>   tests/avocado/tuxrun_baselines.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
> index 3a46e7a745..e12250eabb 100644
> --- a/tests/avocado/tuxrun_baselines.py
> +++ b/tests/avocado/tuxrun_baselines.py
> @@ -184,6 +184,7 @@ def common_tuxrun(self,
>   
>       def ppc64_common_tuxrun(self, sums, prefix):
>           # add device args to command line.
> +        self.require_netdev('user')
>           self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
>                            '-device', 'virtio-net,netdev=vnet')
>           self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',

