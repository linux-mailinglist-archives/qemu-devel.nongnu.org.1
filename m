Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DDD70843E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:50:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzex9-0006JX-T7; Thu, 18 May 2023 10:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzewK-0006Ew-Rf
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:49:22 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzewH-0003ib-B9
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:49:11 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 92B0A605AC;
 Thu, 18 May 2023 17:49:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:34] (unknown
 [2a02:6b8:b081:7204::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1ne6TB3OfuQ0-x83zwo9J; Thu, 18 May 2023 17:49:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684421341; bh=1nknve0PBTFn4CxPqA8/imB1Y5jBrllMx5B4ozWTOl0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tzDw7OEGID0Uob8j1/hkmOScImAt24HZ64yl1tpK4S/rgtaZTbUcnSWpa/8jabD5E
 FfCHjSSkmUGtbq36sUSaIeY6fmukNOkQeEbCZqhakRWDoC5BkgGPUT1zUCVGoaCo+d
 WSc7Oo1UngDKHzQeT3uLplE3vdpudWEEkhAPaCr0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <19a170c1-fd9f-e62e-ed17-0315b566cd7f@yandex-team.ru>
Date: Thu, 18 May 2023 17:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] Restore vmstate on cancelled/failed migration
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, leobras@redhat.com,
 peterx@redhat.com, yc-core@yandex-team.ru
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <871qjdevcj.fsf@secure.mitica>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <871qjdevcj.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18.05.23 14:23, Juan Quintela wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>> Hi all.
>>
>> The problem I want to solve is that guest-panicked state may be lost
>> when migration is failed (or cancelled) after source stop.
>>
>> Still, I try to go further and restore all possible paused states in the
>> same way. The key patch is the last one and others are refactoring and
>> preparation.
> 
> Hi
> 
> I like and agree with the spirit of the series in general.  But I think
> that we need to drop the "never fail in global_state_store()".  We
> shouldn't kill a guest because we found a bug on migration.
> 

Why migration is better in this sense than non-migration? We have a lot of places where we just assert things instead of creating unreachable error messages. I think assert/abort is always better in such cases. Really, if we fail in this assertion it means that memory is corrupted, and stopping the execution is the best thing to do.

(Should we consider the case that in future we add 100 character length vmstate? I hope we should not)

-- 
Best regards,
Vladimir


