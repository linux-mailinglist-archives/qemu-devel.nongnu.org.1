Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95C7BB541
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoi6o-0004Kl-IS; Fri, 06 Oct 2023 06:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoi6k-0004KQ-Le
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:30:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoi6h-0005hc-T8
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:30:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 7EB5E60BDE;
 Fri,  6 Oct 2023 13:30:53 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7322::1:25] (unknown
 [2a02:6b8:b081:7322::1:25])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qUWDwZ5OoqM0-JwcOVWrD; Fri, 06 Oct 2023 13:30:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696588252;
 bh=t4MXEt5cVR1ggNnyLheG9sVWgAbeV/7zIUX/GIzs6vs=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=FvU6ua426uqYhHQjb+UKmPDM7uxOBXU3ks/ovRBz3dsck1wGElsfg5Ir7ClD+Rjnn
 ED1jtLiqEDLUp1pQBL5h4uiSkU+Dg2PcviSpYSpJTdIVBIBGomKe7OvBCPNl90KgJZ
 1GmpKFd78QdSFwKebzUieeci7wt25g59SpI/geTs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1cbaa0fb-c9ab-48b9-a7f8-061957346908@yandex-team.ru>
Date: Fri, 6 Oct 2023 13:30:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coverity: physmem: use simple assertions instead of
 modelling
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 peterx@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru
References: <20231005140326.332830-1-vsementsov@yandex-team.ru>
 <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
 <42bc3ca1-a28f-4d8e-b1ed-af696a4c2a3e@yandex-team.ru>
In-Reply-To: <42bc3ca1-a28f-4d8e-b1ed-af696a4c2a3e@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.10.23 13:27, Vladimir Sementsov-Ogievskiy wrote:
> On 06.10.23 01:53, Paolo Bonzini wrote:
>> On Thu, Oct 5, 2023 at 4:04 PM Vladimir Sementsov-Ogievskiy
>> <vsementsov@yandex-team.ru> wrote:
>>> +            /*
>>> +             * Assure Coverity (and ourselves) that we are not going to OVERRUN
>>> +             * the buffer by following ldn_he_p().
>>> +             */
>>> +            assert((l == 1 && len >= 1) ||
>>> +                   (l == 2 && len >= 2) ||
>>> +                   (l == 4 && len >= 4) ||
>>> +                   (l == 8 && len >= 8));
>>
>> I'll queue it shortly, but perhaps you can try if assert(l <= len) is enough?
>>
>> Alternatively I can try applying the patch on top of the tree that we
>> test with, and see how things go.
>>
> 
> I've now made 4 runs:
> 
> master:

I wanted to write:

master: 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d

> patched = master + this patch
> l_len = master + this patch, but reduce assertion to assert(l <= len)


also, cov-build version:
cov-build 2023.3.2 (build 865d3107dd p-2023.3-push-63)


-- 
Best regards,
Vladimir


