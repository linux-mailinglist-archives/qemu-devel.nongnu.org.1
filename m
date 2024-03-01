Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E4486E3C1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 15:53:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg4Fp-0007nv-U7; Fri, 01 Mar 2024 09:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg4Fn-0007nd-CJ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:52:51 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg4Fj-0003B1-DY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:52:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 95D9260E16;
 Fri,  1 Mar 2024 17:52:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eqcj3f3IXmI0-oFjZtiQF; Fri, 01 Mar 2024 17:52:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709304761;
 bh=JlkcK4KKtldf6CkZ2taT7jNT2c7IEiNluFvotzpAYd8=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=P7J5n+Yw7iQBc3D1jKC1MQisT0GczuXmtU7cZMYFC9HDSHOTNCOerMjqApSvOHFbm
 7IcoG0dr1FXf8/kY+Yk8N0vqy5b3dYPTAd8Pn0YlHBrR8EGx1kmqPZbhdAcVrKOvrK
 t2CR/Un3h/rbZu3ae1SOeshRQYWpmdUBqeVwjDOg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cf4950ce-80ae-42c8-820b-0f29c0c5c009@yandex-team.ru>
Date: Fri, 1 Mar 2024 17:52:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
 <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
 <bea4ca16-a2ea-4a06-bb8d-27b485d63cc1@redhat.com>
 <875xy7xv6t.fsf@pond.sub.org>
 <626d7918-b96c-48ba-8891-a0f519f2023b@yandex-team.ru>
In-Reply-To: <626d7918-b96c-48ba-8891-a0f519f2023b@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 01.03.24 17:44, Vladimir Sementsov-Ogievskiy wrote:
> On 29.02.24 16:21, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 29/02/2024 08.20, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 29.02.24 09:32, Markus Armbruster wrote:
>>
>> [...]
>>
>>>>> Anti-pattern: fail without setting an error.  There might be more
>>>>> elsewhere in the series.
>>>>>
>>>>> qapi/error.h's big comment:
>>>>>
>>>>>    * - On success, the function should not touch *errp.  On failure, it
>>>>>    *   should set a new error, e.g. with error_setg(errp, ...), or
>>>>>    *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>>>>    *
>>>>>    * - Whenever practical, also return a value that indicates success /
>>>>>    *   failure.  This can make the error checking more concise, and can
>>>>>    *   avoid useless error object creation and destruction.  Note that
>>>>>    *   we still have many functions returning void.  We recommend
>>>>>    *   • bool-valued functions return true on success / false on failure,
>>>>>    *   • pointer-valued functions return non-null / null pointer, and
>>>>>    *   • integer-valued functions return non-negative / negative.
>>>>>
>>>>>          }
>>>>>          qemu_put_be64(f, STATTR_FLAG_EOS);
>>>>>          return 0;
>>>>>      }
>>>>>
>>>>> When adding Error **errp to a function, you must also add code to set an
>>>>> error on failure to every failure path.  Adding it in a later patch in
>>>>> the same series can be okay,
>>>>
>>>> Personally, I'd prefer not doing so. Creating wrong commits and fixing them in same series - better to merge all fixes into bad commit:)
>>>
>>> I agree - that might create issues with bisecting later. Please fix it in this patch here already!
>>
>> Depends on the wrongness, really.
> 
> In my understanding, unset errp on failure path is wrong enough.
> 
> For example, simple pattern
> 
> Error *local_err = NULL;
> 
> int ret = foo(&local_err);
> if (ret < 0) {
>      error_report_err(local_err);
>      return;
> }
> 
> will just crash.
> 
> When I write code, I expect that "errp is set" === "ret < 0", for all functions returning negative integer on failure.
> 
> Also, we have enough code that relying on errp for failure checking:
> $ git grep 'if (local_err)' | wc -l
> 373
> 
> Of course, most of this should be checking failure of functions that return void, but who knows.
> 
>>
>> We don't want broken intermediate states, no argument.
>>
>> But intermediate states that are merely unclean can be acceptable.
>>
>> For instance, my commit a30ecde6e79 (net: Permit incremental conversion
>> of init functions to Error) added such Error ** parameters to a somewhat
>> tangled nest of functions, along with FIXME comments where errors
>> weren't set.  The next few commits fixed most, but not all of them.
>> Later commits fixed some more.  The one in tap-win32.c is still there
>> today.
>>
>> This was acceptable, because it improved things from "bad error
>> reporting" to "okay error reporting in most cases, unclean and bad error
>> reporting in a few cases marked FIXME", with "a few" over time going
>> down to the one I can't test, and nobody else seems to care about.
>>

You may be sure, that functions you modify are never used in conditions I've described above. But you can't guarantee that this will not change in future. Of course, if someone will create new call of the function, he should look (at least once) at that function  and see "FIXME", but better not rely on this. Also, if someone will add a call to another function that calls function with bad error reporting, most probably he will not see the "FIXME"...

Formally, you should add such FIXME to all functions with errp, that may do (nested) calls to a function with FIXME

-- 
Best regards,
Vladimir


