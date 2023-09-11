Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23279A75C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfeMY-0004df-11; Mon, 11 Sep 2023 06:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfeMQ-0004Lg-EO
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:41:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfeMN-0006Tz-Kn
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:41:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0467C20C13;
 Mon, 11 Sep 2023 13:41:38 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2966A27333;
 Mon, 11 Sep 2023 13:41:36 +0300 (MSK)
Message-ID: <73e59f47-71ad-83c3-a4f5-983cd857f323@tls.msk.ru>
Date: Mon, 11 Sep 2023 13:41:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com> <ZPtZvXcQhIWA3Iu0@redhat.com>
 <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

08.09.2023 22:21, Paolo Bonzini wrote:
> On Fri, Sep 8, 2023 at 7:28 PM Kevin Wolf <kwolf@redhat.com> wrote:
>> Maybe the calls aren't eliminated because --enable-debug implies -O0?
> 
> My experience is that it will still fold simple dead code like "0 &&
> foo()" or even "if (0) { ... }", but maybe it's a GCC vs. clang
> difference. [..]

In my view it's too fragile to rely on this.  And yes, it's the clang
builds which triggers this issue.

We've a bugreport, https://gitlab.com/qemu-project/qemu/-/issues/1848 ,
where obviously-unreachable code hasn't been detected by gcc when
optimizing for certain CPU type.  This smells like a GCC bug but still
it's something which we shouldn't rely on.

What can be done though is, instead of making kvm_arch_get_supported_cpuid
et all a stubs, to replace them in .h file with an empty macro when some
condition(s) are met.  In other words, fold kvm_enabled() "inside" of
kvm_arch_get_supported_cpuid() and use some assert_not_reached() there.

/mjt

