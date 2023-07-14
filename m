Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8075436B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 21:52:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKOof-0001gz-9J; Fri, 14 Jul 2023 15:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKOoc-0001gX-V0; Fri, 14 Jul 2023 15:50:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKOob-0002gh-6Q; Fri, 14 Jul 2023 15:50:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56B0A13F64;
 Fri, 14 Jul 2023 22:51:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9B53E14CA2;
 Fri, 14 Jul 2023 22:50:51 +0300 (MSK)
Message-ID: <65ac6e0e-da5a-ed96-e5ff-1487e79ee22b@tls.msk.ru>
Date: Fri, 14 Jul 2023 22:50:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] treewide: spelling fixes in comments and some strings
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-3-mjt@tls.msk.ru>
 <20230714122201.3b118f40.alex.williamson@redhat.com>
 <849f5b3a-33cd-3406-4462-90ac11bcde96@tls.msk.ru>
 <20230714134028.2c987970.alex.williamson@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230714134028.2c987970.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

14.07.2023 22:40, Alex Williamson wrote:

>> $ git diff qemu-master..spelling | grep -c re-enable
>> 8
>>
>> I can drop those 8 out of 400 :)
> 
> If we consider codespell to be the authority I guess we can leave it,
> but it seems a bit pedantic to me.  Thanks,

Let's just drop this one.  Please if you consider reviewing the series or
some patches from it, just omit the changes with re-enables. They're as good
as gone, all 8 of them.

Thank you for the feedback!

/mjt

