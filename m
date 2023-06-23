Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CD73BBD2
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiqu-0000Fw-1g; Fri, 23 Jun 2023 11:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiqr-0000FE-ST
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:37:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiqp-00079s-65
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:37:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fa79605a3bso8073065e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687534649; x=1690126649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JCDhBOGR9wUEmUe0obPbKzLCbCa0o8VK8ZcobAyHGvc=;
 b=gCzrzzQgJiS4l/fz1OuhdUOROwMPTZXnliNmUo870zY/oRW4VXhjbR+KHLVoCMd03T
 fObbEEGCi0fcvXEOdlXCKkeamLz0PnpaWymPTxoXKV6ipTqlyYQxlvzJx1SAqfWDdwZ/
 h0tvHrnxKemlBX6KYF54bTsMdEgHh9JbHcKZXoNpkDiX2S13AqFC55ok768tH5JE3QG6
 irn1u7IxN1m+do4DA54UkvuzvI8fQ5IvdHuSuK41zUpcN2eROJTeSeLxjXBIvxdQc09N
 VaOzpx4Y4W+0lVKQ2s/1cuJ1rrNphs3oPQG5rY7X9/u2NL8v6oy01+jE6Hsai8l0Qx5W
 61lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534649; x=1690126649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JCDhBOGR9wUEmUe0obPbKzLCbCa0o8VK8ZcobAyHGvc=;
 b=BH90LU9ulFbofQMKp5Gr9hZYkh4V+Tys6W/ga79u4vt3+Ea+aoB9dggLapzITHORRE
 WZ+nXFbNktQOpxRftuE0lmWTZG+W+eGvRaTPHPy1MpY7V5BsHssU2fv+gxT9lipSel0J
 4XA+woTNTxd0WBiQ+DFafbiGtpkGVlsZeWDQfgj0dTHXBldlhBj8Yh6yd8Hdf4sUPQye
 KUozCUCXsdsd9sXtT+KdNbTU2eAMLYUWLtDKnCTycUCAs7fs15+icup1JPcGScSssISQ
 Iip4lrEXFFJyxIda/RDH+7+yP+IWJtmSSMutn6kk6gCpX80d9STTO6HWloR6b+n6cO5P
 6qYA==
X-Gm-Message-State: AC+VfDyxRWXVYPBJ5w9F3IsCzShxrDKvLfTxUEMG1zEeubAYKB0x+cqJ
 xkKe5mQHeh2vd9nIhRFM6rci0Q==
X-Google-Smtp-Source: ACHHUZ5lG61WnkZ7fyF8AACrSiKiUMJuJLJeo4vdNFrsxlMQ5S67LTBbtKu1gbYaR+nUNGu+CYIGeQ==
X-Received: by 2002:a05:600c:21d8:b0:3f9:bc32:ca6c with SMTP id
 x24-20020a05600c21d800b003f9bc32ca6cmr8461385wmj.13.1687534649588; 
 Fri, 23 Jun 2023 08:37:29 -0700 (PDT)
Received: from [192.168.93.175] (94.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.94]) by smtp.gmail.com with ESMTPSA id
 a6-20020adffac6000000b0030aefa3a957sm9834189wrs.28.2023.06.23.08.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:37:29 -0700 (PDT)
Message-ID: <ca2121fd-e430-f3f7-48fa-5ff3bb6ffe7b@linaro.org>
Date: Fri, 23 Jun 2023 17:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] tests/avocado: ppc test VOF bios Linux boot
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20230623122135.320261-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623122135.320261-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/6/23 14:21, Nicholas Piggin wrote:
> VOF is the new lightweight fast pseries bios. Add a Linux boot test
> using VOF.
> 
> More tests could be moved to use VOF becasue it's much faster, but

Typo "because".

> just dip one toe in the water first here. SLOF should continue to be
> tested too.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> This applies on top of the SMP/SMT avocado test I sent. Just
> thought it would be a nice addition.
> 
> Thanks,
> Nick
> 
>   tests/avocado/ppc_pseries.py | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
> index ff42c770f2..a8311e6555 100644
> --- a/tests/avocado/ppc_pseries.py
> +++ b/tests/avocado/ppc_pseries.py
> @@ -29,6 +29,17 @@ def do_test_ppc64_linux_boot(self):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>   
> +    def test_ppc64_vof_linux_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries

Note, you could add 'tags:firmware:vof' if filtering to run only tests
booting VOF is useful.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


