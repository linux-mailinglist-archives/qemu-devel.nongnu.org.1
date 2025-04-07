Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6DA7E82D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 19:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qF4-0003rV-Ry; Mon, 07 Apr 2025 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u1qEy-0003p4-0t
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:26:32 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u1qEv-0005Wa-Pl
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:26:31 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 9DB2171435E5;
 Mon,  7 Apr 2025 19:26:09 +0200 (CEST)
Message-ID: <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
Date: Mon, 7 Apr 2025 19:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 christian.boenig@lauterbach.com
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <87semkw3qx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1744046769652
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

Thanks a lot for the response, I really appreciate your time.

On 07.04.2025 14:33, Markus Armbruster wrote:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
> 
>> This patch series introduces support for the Multi-Core Debug (MCD) API, a
>> commonly used debug interface by emulators. The MCD API, defined through a
>> header file, consists of 54 functions for implementing debug and trace.
>> However, since it is a header-file-only interface, MCD does not specify a
>> communication protocol. We get around this limitation by following a remote
>> procedure call approach using QMP. The client stub corresponding to this
>> implementation can be found at https://gitlab.com/lauterbach/mcdrefsrv
>>
>> This series is the successor to:
>> "[PATCH v5 00/18] first version of mcdstub"
>> (https://patchew.org/QEMU/20231220162555.19545-1-nicolas.eder@lauterbach.com/)
>>
>> * Architecture-independent MCD implementation
>> * QMP instead of custom TCP protocol
> 
> Rationale?  There must be pros and cons.

Assuming you're referring to the protocol of the previous patch series:
The previous TCP protocol only supported a subset of MCD. As the 
implementation progresses, the protocol eventually needs to be extended, 
possibly resulting in backwards compatibility problems.
Following an RPC approach and keeping the communication layer as close 
to the MCD API as possible results in a larger protocol at first, but 
does not need to be changed afterwards.
By directly mapping MCD functions onto QMP commands, the complexity in 
the server and client stubs can be minimized.

Assuming you're referring to the QMP choice:
QMP is being described as the "protocol which allows applications to 
control a QEMU instance".
It provides a RPC framework which automatically (de)serializes methods 
and their parameters, even inside QTests.
The whole interface is automatically documented.

> How much data would you expect to flow in practical usage?  QMP isn't
> designed for bulk transfer...

According to ifstat, the expected data rate in practical usage is around

KB/s in  KB/s out
    100      100

I fully understand your concern and agree that a JSON-based
protocol does not result in the lowest data rate.

If the data rate is the highest priority: *Before* the QMP supported was 
implemented, the MCD interface was built on a custom RPC framework, 
generated with the code generator at:

https://gitlab.com/lauterbach/mcdrefsrv/-/tree/main/codegen

The resulting header file was basically a set of functions capable of 
serializing MCD's function arguments into a byte stream and vice-versa:

https://gitlab.com/lauterbach/mcdrefsrv/-/blob/df754cef7f19ece2d00b6ce4e307ba37e91e5dcb/include/mcd_rpc.h

The QMP support was added because of the advantages listed above and in 
order to evade yet another custom communication protocol.
As a user of the MCD interface, I haven't noticed any negative impact of 
the increased data rate in realistic debugging scenarios, even when 
trying to drive the data rate up. If that would have been the case, I 
would have sent this patch request with our custom RPC protocol.

>> qemu-system-<arch> [options] -qmp tcp::1235,server=on,wait=off
>>
>> * Architecture-independent QTest test suite
>>
>> V=1 QTEST_QEMU_BINARY="./qemu-system-<arch> [options]" tests/qtest/mcd-test
>>
>> * Architecture-specific tests can be found at the client stub
> 
> [...]
> 
>>   qapi/mcd.json             | 2366 ++++++++++++++++++++++
> 
> This is *massive*.  By non-blank, non-comment lines, it's the second
> largest module in qapi/, almost 9% of the entire schema.  It's larger
> than the entire QEMU guest agent QAPI schema.  The QAPI generator
> generates some 280KiB of C code for it.

I understand your point and I think it touches on the point made above 
regarding MCD's complexity:

> mcd/mcd_api.h             | 3963 +++++++++++++++++++++++++++++++++++++

I hope that we agree that RPC is generally the right approach to 
implement MCD. As far as the implementation is concerned, I'm open to 
any suggestion you have. I've always avoided to introduce any 
unnecessary external dependencies.

Best regards,
Mario

