Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A777F489
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWacy-0000vD-Kt; Thu, 17 Aug 2023 06:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qWact-0000ut-Sp
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:53:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qWacr-0002ET-DI
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:53:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1A521B181;
 Thu, 17 Aug 2023 13:53:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24F581FE6B;
 Thu, 17 Aug 2023 13:53:10 +0300 (MSK)
Message-ID: <84ada7aa-7472-53e0-f641-95f1a923bf7e@tls.msk.ru>
Date: Thu, 17 Aug 2023 13:53:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] qga: Start qemu-ga service after NetworkManager start
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Efim Shevrin <efim.shevrin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, den@openvz.org
References: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
 <ZN318fFGAsT4up83@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZN318fFGAsT4up83@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.165,
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

17.08.2023 13:26, Daniel P. Berrangé wrote:
..
> A host mgmt app should not be assuming that networking is
> running at all, and if it is, the guest might not even be
> on the same subnet as the host. Conceivably someone could
> even be using QGA to inject files to configure networking.
> 
> Overall, IMHO, it is wrong to correlate host notification
> that QGA is running, with any assumption about state of
> the guest networking.
> 
> IOW, I don't think we should make an attempt to serialize
> startup of QGA after guest networking. The QGA should be
> run as soon as its data transport (virtio-serial/vsock)
> is available, which is the current state.
> 
> If a host consumer of QGA wants to do something with
> guest networking, they should check for guest network
> state with the 'guest-network-get-interfaces' command.

Full nod.

/mjt


