Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D654A763131
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOaSr-0005x5-T8; Wed, 26 Jul 2023 05:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOaSo-0005ww-TZ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:05:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOaSn-0007wp-1N
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 05:05:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A2D91645F;
 Wed, 26 Jul 2023 12:05:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 48C3019782;
 Wed, 26 Jul 2023 12:05:41 +0300 (MSK)
Message-ID: <0b562fb1-5fc0-38d8-f0d0-65f52f726bc5@tls.msk.ru>
Date: Wed, 26 Jul 2023 12:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: how to build qemu 8.1 - keycodemapdb?
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <efc23b6f-861f-43eb-a4b4-900f45e77ef6@tls.msk.ru>
 <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
 <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
 <ZMDeSBP7tkYowKV6@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZMDeSBP7tkYowKV6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

26.07.2023 11:50, Daniel P. Berrangé wrote:
..
>> make-release.sh apparently does the right thing. But the published
>> tarball does not include the 3 required sub-projects anyway.
>>
>> Is it about how the release is made?  What is used to make the
>> actual release tarball, is it not make-release.sh?
> 
> make-release is what I expect to be used for making release
> tarballs.

When I run ./scripts/make-release 8.1.0-rc1 , the resulting tarball
includes the necessary submodules in subprojects/.

It is more: it includes 2 copies of berkeley-softfloat & berkeley-testfloat,
one in subprojects/ and one in roms/edk2/ArmPkg/Library/ArmSoftFloatLib/ .

But the tarballs published on qemu.org does not include these.

So I conclude the tarballs were not created using make-release.sh.

/mjt

