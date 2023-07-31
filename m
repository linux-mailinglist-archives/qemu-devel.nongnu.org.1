Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362277695A9
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRie-0000RD-8H; Mon, 31 Jul 2023 08:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRic-0000Qx-Dv; Mon, 31 Jul 2023 08:09:46 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRia-0004c2-Ol; Mon, 31 Jul 2023 08:09:46 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id AF3B540F1DF9;
 Mon, 31 Jul 2023 12:09:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AF3B540F1DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1690805382;
 bh=Jxo4PH2ieTYvFyB05tXQiTqHTF4Ff6heSeijrZBZEmI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cKMW/W+cWxO0Efl6OvqzCfgEmpDLVXgwm6xmoDEQmdxniwQVBETYWa/pU5hlIl4ST
 fcjuToMRXwXnHqufeI2fJIAxBpVuGWdTO+Iz5zfZlHiBIdUFeTdQqf8o8nx//sgHAR
 KZvM3cAVGPKFGUUTnIejN4OJomdIlH7omgWFDvrY=
Message-ID: <137331e2-2d20-9578-e932-c28072c4c2a9@ispras.ru>
Date: Mon, 31 Jul 2023 15:09:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] tests/avocado: ppc64 reverse debugging tests for
 pseries and powernv
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-8-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230726183532.434380-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 26.07.2023 21:35, Nicholas Piggin wrote:
> These machines run reverse-debugging well enough to pass basic tests.
> Wire them up.
> 
> Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/reverse_debugging.py | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
> index 7d1a478df1..fc47874eda 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -233,3 +233,32 @@ def test_aarch64_virt(self):
>   
>           self.reverse_debugging(
>               args=('-kernel', kernel_path))
> +
> +class ReverseDebugging_ppc64(ReverseDebugging):
> +    """
> +    :avocado: tags=accel:tcg
> +    """
> +
> +    REG_PC = 0x40
> +
> +    # unidentified gitlab timeout problem
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_ppc64_pseries(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +        # SLOF branches back to its entry point, which causes this test
> +        # to take the 'hit a breakpoint again' path. That's not a problem,
> +        # just slightly different than the other machines.
> +        self.endian_is_le = False
> +        self.reverse_debugging()
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_ppc64_powernv(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        """
> +        self.endian_is_le = False
> +        self.reverse_debugging()


