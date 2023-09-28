Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 100AD7B23F3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 19:32:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlurB-0005wl-8U; Thu, 28 Sep 2023 13:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qlur7-0005wO-2U
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:31:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qlur5-0003ns-2O
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:31:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BB1E260D6;
 Thu, 28 Sep 2023 20:31:46 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F6EF2B79A;
 Thu, 28 Sep 2023 20:31:10 +0300 (MSK)
Message-ID: <8d5b686d-53b0-d231-e8a4-2a5e0ea72c62@tls.msk.ru>
Date: Thu, 28 Sep 2023 20:31:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: stable-8.1.1: which bug do we keep?
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
 <ZQq4kMVHNtxeVH6o@redhat.com>
 <688aae83-b8fb-5867-2451-dc0c67fe9319@tls.msk.ru>
 <bcc10b9c-d53a-63c7-9a9e-64b3960ae8e3@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <bcc10b9c-d53a-63c7-9a9e-64b3960ae8e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

28.09.2023 20:24, Richard Henderson:
> On 9/20/23 16:45, Michael Tokarev wrote:
>> I just collected the first version of Richard's fixes (with Phil's
>> changes and tags), added them to qemu debian package and pushed that
>> one out, - debian has much wider CI than qemu has, hopefully it will
>> clear things out.
> 
> Thanks for that.  Any surprises?

Hi Richard, I'm very glad to hear from you, I really am! :)

Nope, there was no single surprise so far, it is more, it all
works now quite well, all long-standing issues which we had
are now gone.

We have new discoveries, but that's just that - new discoveries,
like stuff which was broken the same way in 6.0 as in current
master.  Or new tests which no one run before, discovering new
issues in new code.  But overall, this part works fairy well.

> The timing of all this has been poor, coming just before I've been away for a few weeks. I plan to get the can_do_io patch set upstreamed soon.

Yeah, I guess everyone noticed your absence :)
You did great job at fixing this stuff, it waited for the
good refresh for quite some time.

Thank you!

/mjt

