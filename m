Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157B74E609
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 06:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ5EY-00044T-BK; Tue, 11 Jul 2023 00:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qJ5EV-000442-H3; Tue, 11 Jul 2023 00:44:15 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qJ5ET-0007M2-AD; Tue, 11 Jul 2023 00:44:15 -0400
Received: from [192.168.0.100] (unknown [62.118.138.151])
 by mail.ispras.ru (Postfix) with ESMTPSA id E6F8F40737B0;
 Tue, 11 Jul 2023 04:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E6F8F40737B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1689050627;
 bh=7Qhrt9jVMyHbjYsAOua1FkC57fPfaEUIjTpUnGEDmEw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gt9UrydfnGX3XUXlil5RDqeNVY1tEvug4HOVzZJp7rDoxbldOPYX2oVYI10al2673
 cNfrEVWtH2MOZs8Hq277UKvsMNsX8YXBzomMyChI3kquZVJdAX/OCk33rcfkENZvYz
 fyncfQ3PCh65HqegyPoN7sscXOAfX73LvH3VD1zI=
Message-ID: <e7590da1-4586-17d7-b036-ecbfe179e3aa@ispras.ru>
Date: Tue, 11 Jul 2023 07:43:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: tests/avocado/replay_kernel: ReplayKernelNormal.test_aarch64_virt
 failing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <666fb6bf-f3dd-f0b8-877e-9e73acf31c7d@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <666fb6bf-f3dd-f0b8-877e-9e73acf31c7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10.07.2023 20:14, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Per tests/avocado/replay_kernel.py:
> 
>      def test_aarch64_virt(self):
>          ...
>          console_pattern = 'VFS: Cannot open root device'
> 
> the test is succeeding, but Avocado reports an error.

Does the emulator exit when error "Cannot open root device" happens?
Therefore 'quit' command can't be processed in this case.

> 
> I could get a verbose debug.log, so sharing it here, enjoy!
> 
> Regards,
> 
> Phil.


