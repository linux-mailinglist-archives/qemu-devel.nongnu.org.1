Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B657E52E0
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:51:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fCy-0002IQ-At; Wed, 08 Nov 2023 04:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0fCu-0002I9-QD
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:50:45 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0fCe-0001PH-Ou
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:50:44 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5329:0:640:5ed5:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 0006E61948;
 Wed,  8 Nov 2023 12:50:21 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b423::1:d] (unknown
 [2a02:6b8:b081:b423::1:d])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KoZBd00Od0U0-lqHhiDGd; Wed, 08 Nov 2023 12:50:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699437021;
 bh=0AjxZ10KfKn9FYxFJ+fuIy8HhQLBmSRuGzddZN1WlTY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nn5buKkO6mHgC+krSNnsg/xhHrQn46mf5fk8NYOaVf4sMuyy9fj1gwgqfm6mjUopt
 jBRaKR2MdimBX5HYGcvdtqLmhef0cahqeYtTAsxT4skgKqzpgB0MByU5WXcEas0vDS
 kJ3bqw++xReRNOmEb1QupDLJiBYkKE08nbKZ54sI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7d547b41-b896-4c4d-beaa-e3d69383a13d@yandex-team.ru>
Date: Wed, 8 Nov 2023 12:50:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coverity: physmem: use simple assertions instead of
 modelling
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 peterx@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru
References: <20231005140326.332830-1-vsementsov@yandex-team.ru>
 <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

ping) Is it queued?

On 06.10.23 01:53, Paolo Bonzini wrote:
> On Thu, Oct 5, 2023 at 4:04 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>> +            /*
>> +             * Assure Coverity (and ourselves) that we are not going to OVERRUN
>> +             * the buffer by following ldn_he_p().
>> +             */
>> +            assert((l == 1 && len >= 1) ||
>> +                   (l == 2 && len >= 2) ||
>> +                   (l == 4 && len >= 4) ||
>> +                   (l == 8 && len >= 8));
> 
> I'll queue it shortly, but perhaps you can try if assert(l <= len) is enough?
> 
> Alternatively I can try applying the patch on top of the tree that we
> test with, and see how things go.
> 
> Paolo
> 
>>               val = ldn_he_p(buf, l);
>>               result |= memory_region_dispatch_write(mr, addr1, val,
>>                                                      size_memop(l), attrs);
>> @@ -2784,6 +2793,15 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>>               l = memory_access_size(mr, l, addr1);
>>               result |= memory_region_dispatch_read(mr, addr1, &val,
>>                                                     size_memop(l), attrs);
>> +
>> +            /*
>> +             * Assure Coverity (and ourselves) that we are not going to OVERRUN
>> +             * the buffer by following stn_he_p().
>> +             */
>> +            assert((l == 1 && len >= 1) ||
>> +                   (l == 2 && len >= 2) ||
>> +                   (l == 4 && len >= 4) ||
>> +                   (l == 8 && len >= 8));
>>               stn_he_p(buf, l, val);
>>           } else {
>>               /* RAM case */
>> --
>> 2.34.1
>>
> 

-- 
Best regards,
Vladimir


