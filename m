Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8961723FFD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:47:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6UDZ-0001jV-Pb; Tue, 06 Jun 2023 06:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6UDW-0001Zm-Vz; Tue, 06 Jun 2023 06:47:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6UDU-0008Vj-0z; Tue, 06 Jun 2023 06:47:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB5E4AFEE;
 Tue,  6 Jun 2023 13:47:05 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 169889DAB;
 Tue,  6 Jun 2023 13:47:05 +0300 (MSK)
Message-ID: <100a5e86-624f-bea1-8f53-e13072cb2eee@tls.msk.ru>
Date: Tue, 6 Jun 2023 13:47:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-3-hreitz@redhat.com>
 <4604b88b-5499-9e60-2d25-63b93f0517f4@tls.msk.ru>
 <8e681dcd-43ab-40ed-5e96-426557d87380@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <8e681dcd-43ab-40ed-5e96-426557d87380@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.06.2023 11:45, Hanna Czenczek wrote:
> On 06.06.23 10:00, Michael Tokarev wrote:
..
>> This seems to be over-complicated, both of them, no?
> 
> I would have preferred to have this discussion while the patch was still on-list for review (this specific version was for two months, counting from 
> the first version was three).  Do you think it is so complicated and thus bug-prone that we must revert this series now and try the other route?

Well. I come across this change only now when reviewing patches applied to qemu/master.
This one fixes a real bug which people were hitting, which is also quite difficult to
diagnose and which has a possibility for data corruption and other "interesting" effects,
so it is quite a natural thing to at least think about back-porting this change to
previous -stable qemu release.  Bugs like this should be fixed in -stable IMHO.

Sadly I haven't noticed this change before, sure I'd have exactly the same thoughts
by then, and would be glad to help analyzing other parts of the code with potential
of having issues with IOV_MAX-exceeding vectors.

> I can agree that perhaps the other route could have been simpler, but now we already have patches that are reviewed and in master, which solve the 
> problem.  So I won’t spend more time on tackling this issue from another angle.  If you are happy to do so, patches are always welcome.

That's a good point too.

Thanks,

/mjt


