Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD973D8D8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgyg-0001Rh-HZ; Mon, 26 Jun 2023 03:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDgyc-0001Qp-8P; Mon, 26 Jun 2023 03:49:34 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDgyZ-0002nn-Rt; Mon, 26 Jun 2023 03:49:33 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6FD3140D403D;
 Mon, 26 Jun 2023 07:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6FD3140D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1687765746;
 bh=aT4YzmmXehdlmMLAAe4VQdLUCWlxHRM92XPhILNinTs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YQIftqwaidA5i1DQV7Arzn+SQOoXeAv3bpMBRQ6rCBla31JWF1Ip6tK0EVASAucMA
 C6kkeso03L12HO4Bsknaxik3Y7dgZEocOz04zI068wSEdki5rhYFgSybG3/Kc/Xh8b
 CVUkVK5ucB6YDyIZrwiRrutsqwrzeewWHWTerFT8=
Message-ID: <74691561-c288-abf5-9673-6e230d55b813@ispras.ru>
Date: Mon, 26 Jun 2023 10:49:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] tests/avocado: ppc64 pseries reverse debugging test
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-8-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230623125707.323517-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23.06.2023 15:57, Nicholas Piggin wrote:
> pseries can run reverse-debugging well enough to pass basic tests.
> 
> There is strangeness with reverse-continue possibly relating to a bp
> being set on the first instruction or on a snapshot, that causes
> the PC to be reported on the first instruction rather than last
> breakpoint, so a workaround is added for that for now.

It means that the test reveals some kind of a bug in PPC debugging 
server implementation.
In this case it is better to fix that instead of adding workaround.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/reverse_debugging.py | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
> index 680c314cfc..553c931994 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -94,7 +94,7 @@ def gdb_bstep(g):
>       def vm_get_icount(vm):
>           return vm.qmp('query-replay')['return']['icount']
>   
> -    def reverse_debugging(self, shift=7, args=None):
> +    def reverse_debugging(self, shift=7, args=None, initial_skip=False):
>           logger = logging.getLogger('replay')
>   
>           # create qcow2 for snapshots
> @@ -135,6 +135,10 @@ def reverse_debugging(self, shift=7, args=None):
>               self.fail('Reverse continue is not supported by QEMU')
>   
>           logger.info('stepping forward')
> +
> +        if initial_skip:
> +            self.gdb_step(g)
> +
>           steps = []
>           # record first instruction addresses
>           for _ in range(self.STEPS):
> @@ -216,3 +220,25 @@ def test_aarch64_virt(self):
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
> +        # start with BIOS only
> +        self.endian_is_le = False
> +        # reverse-continue fails (seems to end up at the start) if a break
> +        # is put on the first instruction. initial_skip skips one before the
> +        # first bp, and it works. Could be due to break at the same icount
> +        # as the snapshot?
> +        self.reverse_debugging(initial_skip=True)


