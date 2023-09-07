Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F100E796F95
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 06:21:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe6V0-0000Uz-6O; Thu, 07 Sep 2023 00:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xu@linux.dev>) id 1qe6Uv-0000Uo-5h
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 00:20:06 -0400
Received: from out-225.mta1.migadu.com ([95.215.58.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xu@linux.dev>) id 1qe6Ur-0006Jy-AK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 00:20:04 -0400
Message-ID: <8a8321ba-3ad3-49e2-41bc-d8ee42c0f0fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1694060398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95+eboJApKm8MWKtY+9fHi/Cd+2e7rZuHtsnNsp99UA=;
 b=eRe6jYLCbM/ti9WWcx5GY+kkTlMEMLMUGS7CJnkJKlVnTF3dSTxFcIdYyTw0d/le2PYi2M
 Yu3CtexaP3brpXmoyM5LR8ub7bikC5dqiE74DgKpRONrOxTjU6GTnrWpk12PmMA5wfRke1
 souTjtxLiiyJAeWMW7HrJa+D32oEsoY=
Date: Thu, 7 Sep 2023 12:19:50 +0800
MIME-Version: 1.0
Subject: Re: [Virtio-fs] Status of DAX for virtio-fs/virtiofsd?
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 virtio-fs@redhat.com, Erik Schilling <erik.schilling@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <87v8grlzu9.fsf@linaro.org>
 <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
 <5e6b1bbd-bc0a-cff5-119c-639a9d15e72a@linux.dev>
 <CAJSP0QUZ51y4bBTRgp_g6AO_6iEFamhOqMbcfFi5UiWBCkJQJQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Hao Xu <hao.xu@linux.dev>
In-Reply-To: <CAJSP0QUZ51y4bBTRgp_g6AO_6iEFamhOqMbcfFi5UiWBCkJQJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.225; envelope-from=hao.xu@linux.dev;
 helo=out-225.mta1.migadu.com
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


On 9/6/23 21:57, Stefan Hajnoczi wrote:
> On Wed, 6 Sept 2023 at 09:07, Hao Xu <hao.xu@linux.dev> wrote:
>> On 5/18/23 00:26, Stefan Hajnoczi wrote:
>>> On Wed, 17 May 2023 at 11:54, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> Hi Alex,
>>> There were two unresolved issues:
>>>
>>> 1. How to inject SIGBUS when the guest accesses a page that's beyond
>>> the end-of-file.
>> Hi Stefan,
>> Does this SIGBUS issue exist if the guest kernel can be trusted? Since in
>>
>> that case, we can check the offset value in guest kernel.
> The scenario is:
> 1. A guest userspace process has a DAX file mmapped.
> 2. The host or another guest that is also sharing the directory
> truncates the file. The pages mmapped by our guest are no longer
> valid.
> 3. The guest loads from an mmapped page and a vmexit occurs.
> 4. Now the host must inject a SIGBUS into the guest. There is
> currently no way to do this.
>
> I believe this scenario doesn't happen within a single guest, because
> the guest kernel will raise SIGBUS itself without a vmexit if another
> process inside that same guest truncates the file.
>
> Another scenario is when the guest kernel access the DAX pages. A
> vmexit can occur here too.
>
> If you trust the host and all guests sharing the directory not to
> truncate files that are mmapped, then this issue will not occur.
>
> Stefan


I see, my use case should be fine since the directory is not shared and 
fs is read-only.

Thanks for detail explanation.


Regards,

Hao


