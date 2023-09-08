Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC17986AB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qea9Z-0002Y3-CK; Fri, 08 Sep 2023 08:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qea9W-0002R6-2s
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:59:58 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qea9T-0006wc-Bj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:59:57 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C9981C0006;
 Fri,  8 Sep 2023 11:59:51 +0000 (UTC)
Message-ID: <4508010f-12e8-8565-d091-e8c68ae0493e@ovn.org>
Date: Fri, 8 Sep 2023 14:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
 <CAJSP0QVf3CFf1zuBnQev-G54SiGZ53MWBj19SyH__19bo=vfWg@mail.gmail.com>
 <1186b0b7-7dc5-d926-e6ff-ba3da2238b9c@ovn.org> <ZPsKUDp7nVS/Z+j2@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PULL 00/17] Net patches
In-Reply-To: <ZPsKUDp7nVS/Z+j2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.197; envelope-from=i.maximets@ovn.org;
 helo=relay5-d.mail.gandi.net
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/23 13:49, Daniel P. Berrangé wrote:
> On Fri, Sep 08, 2023 at 01:34:54PM +0200, Ilya Maximets wrote:
>> On 9/8/23 13:19, Stefan Hajnoczi wrote:
>>> Hi Ilya and Jason,
>>> There is a CI failure related to a missing Debian libxdp-dev package:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/5046139967
>>>
>>> I think the issue is that the debian-amd64 container image that QEMU
>>> uses for testing is based on Debian 11 ("bullseye" aka "oldstable")
>>> and libxdp is not available on that release:
>>> https://packages.debian.org/search?keywords=libxdp&searchon=names&suite=oldstable&section=all
>>
>> Hmm.  Sorry about that.
>>
>>>
>>> If we need to support Debian 11 CI then either XDP could be disabled
>>> for that distro or libxdp could be compiled from source.
>>
>> I'd suggest we just remove the attempt to install the package for now,
>> building libxdp from sources may be a little painful to maintain.
>>
>> Can be re-added later once distributions with libxdp 1.4+ will be more
>> widely available, i.e. when fedora dockerfile will be updated to 39,
>> for example.  That should be soon-ish, right?
> 
> If you follow the process in docs/devel/testing.rst for adding
> libxdp in libvirt-ci, then lcitool will "do the right thing"
> when we move the auto-generated dockerfiles to new distro versions.

Thanks!  I'll prepare changes for libvirt-ci.

In the meantime, none of the currently tested images will have a required
version of libxdp anyway, so I'm suggesting to just drop this one dockerfile
modification from the patch.  What do you think?

Best regards, Ilya Maximets.

