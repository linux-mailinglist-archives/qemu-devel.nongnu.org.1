Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF67C570A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaKC-0001QH-0u; Wed, 11 Oct 2023 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqaK7-0001MO-2m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:31 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqaK3-0005p1-4q
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:30 -0400
Message-ID: <6cfa7d66-09ae-a4d4-3ce0-c70af50ff720@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1697034982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kfs/xD2tMCEnbSmZKYwaIO9PogAUzDPE0Jv9iKGWN7I=;
 b=SXa5YEzvp7VgsQ2b/b5kgBeWzyKg9AAMhnqsU+pDao8A70AFmvS6UAT0VsojVdYgZ81Fmk
 dfrIrlys0PndGlGCqoBnGMyo9+y6gniXEt1iHP+32LZDnsTD7sMWGCCXBvjWMioK7ovleZ
 G4py141ySeZtGJQOMQ72kdVPky5mc54=
Date: Wed, 11 Oct 2023 17:36:22 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
Content-Language: en-US
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20231010104851.802947-1-frolov@swemel.ru> <ZSWkvPH0asP8xXSu@x1n>
 <04093899-57e7-75bf-5b16-0ec08708a2d0@swemel.ru>
 <ZSawNzXp523+/sDe@x1n> <87zg0p6xff.fsf@secure.mitica>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <87zg0p6xff.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 11.10.2023 17:33, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
>> On Wed, Oct 11, 2023 at 04:20:42PM +0300, Дмитрий Фролов wrote:
>>> I do not insist on accepting this patch - it is more like RFC.
>>> Also, i can add more verbose message and assert, if necessary.
>> That's totally fine. It's just that then we should drop the Fixes line
>> above because it doesn't need to be backported to stable.
>>
>> Also feel free to add more verbose print message or assert if you're
>> posting a new version.
> I queued it as it is.
Many thanks!
>
> I can drop the Fixes if required.
Would be nice. Thanks a lot!
> Later, Juan.
>
Regards, Dmitry.

