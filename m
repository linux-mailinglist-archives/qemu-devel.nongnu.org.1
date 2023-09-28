Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA37B1369
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 08:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlkwf-0002c6-LN; Thu, 28 Sep 2023 02:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qlkwY-0002bs-V3; Thu, 28 Sep 2023 02:56:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qlkwW-0003AC-PV; Thu, 28 Sep 2023 02:56:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C3B0425DA1;
 Thu, 28 Sep 2023 09:56:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19CA22B47A;
 Thu, 28 Sep 2023 09:56:08 +0300 (MSK)
Message-ID: <d27a4c44-1f8c-0c3a-1ba4-ab81b44449a9@tls.msk.ru>
Date: Thu, 28 Sep 2023 09:56:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz with
 null
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-2-peterx@redhat.com>
 <0c8f70af-90dc-cdd9-f0fd-746eb503368e@tls.msk.ru>
 <87wmwa5060.fsf@pond.sub.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87wmwa5060.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

28.09.2023 08:36, Markus Armbruster wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
>> 05.09.2023 19:23, Peter Xu:
>>> QEMU will crash if anyone tries to set tls-authz (which is a type
>>> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
>>> qstring just like the other two tls parameters.
>>
>> Ping?  Has this been forgotten?
> 
> Obviously not: review of the series is ongoing.  PATCH 1+2 look ready,
> though, and could be expedited.

Yeah, obviously.  Please excuse my morning slow brain in -ENOCOFFEE
mode :)  I realized it is a part of patch series ([PATCH 1/4] in the
subject) only after sending this ping out - was looking at what's
left in my qemu-stable mailbox, and this single patch was there in
isolation from the rest of the series.  D'oh :)

/mjt

