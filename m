Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 859ADAB6DCD
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 16:07:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCkO-0001Wj-7r; Wed, 14 May 2025 10:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uFCk2-0001VP-3f
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:05:50 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uFCjz-0002VA-Ar
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:05:49 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 9200F2412D095;
 Wed, 14 May 2025 16:05:44 +0200 (CEST)
Message-ID: <68665dcb-c5d4-4770-8e9b-9baa3dd87c71@lauterbach.com>
Date: Wed, 14 May 2025 16:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <87tt5ve3jc.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <87tt5ve3jc.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747231544603
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08.05.2025 13:38, Markus Armbruster wrote:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
> 
>> This patch series introduces support for the Multi-Core Debug (MCD) API, a
>> commonly used debug interface by emulators. The MCD API, defined through a
>> header file, consists of 54 functions for implementing debug and trace.
>> However, since it is a header-file-only interface, MCD does not specify a
>> communication protocol.
>>
>> To keep the overhead of a communication protocol on top of MCD minimal,
>> we follow a remote procedure call approach by using QAPI as an interface
>> definition and transport infrastructure. This way, we can use qapi-gen to
>> take care of generating the infrastructure to dispatch MCD functions and
>> to (un)marshal their arguments and results. Furthermore, qapi-doc and qtest
>> provide good integration into QEMU's documentation and test frameworks.
>>
>> In v1 of this patch series, the MCD protocol was directly integrated in QMP
>> and the QMP monitor was responsible for dispatching MCD's server stub. This
>> introduced a dependency between QEMU's machine protocol and the MCD debug
>> protocol which is not to be expected. For this reason, v2 introduces a MCD
>> monitor which uses as much of the QMP monitor's framework as possible but
>> keeps the two protocols separate from each other.
>> Similarly, MCD's test suite uses as much of the qtest framework as is useful
>> for sending JSON commands to the QEMU under test but adds new code where
>> required to prevent dependencies to QMP.
>>
>> To enable MCD, configure QEMU with `--enable-mcd`.
>>
>> To start the MCD monitor, run QEMU with the `-mcd` option:
>> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
> 
> -mcd, I presume.

Yes, that one slip through.

>> To run the MCD test suite independently, start `mcd-test`:
>> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>>
>> To connect from a MCD client, a client stub corresponding to this
>> patch series can be found at https://gitlab.com/lauterbach/mcdrefsrv

