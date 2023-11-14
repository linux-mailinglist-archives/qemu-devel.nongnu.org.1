Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB87EAE59
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:55:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2r3z-0003dF-P1; Tue, 14 Nov 2023 05:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1r2r3y-0003d2-6Q
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:54:34 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1r2r3v-0004dS-Nf
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:54:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id B029460E21;
 Tue, 14 Nov 2023 13:54:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b661::1:13] (unknown
 [2a02:6b8:b081:b661::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1sgCLI6OgKo0-wZQ295k7; Tue, 14 Nov 2023 13:54:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699959264;
 bh=Urz4298mhYTAq//kNaf50IMmQlynv+IIQ0aNY3l9JI8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xSXXSXh0ShwsBhpnmE8rvJ9/0VhAqCzV9V+4acRvoUTbngbh8OlCqXaQ4LS4hPaAk
 XwfIGFO9gMPJiBDyJpiv7tqRhsphBUnrmWN1M2fMuccbYENhYlmVJqDAqPJIxI9Bae
 9gYaYLNjc7m2BCqw+qd5Fcq7UfN/+pFpHoEhjOfg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e627b443-615a-422a-8a9d-0ae2b64c9202@yandex-team.ru>
Date: Tue, 14 Nov 2023 13:54:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] python: add binary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, jsnow@redhat.com,
 crosa@redhat.com, bleal@redhat.com, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, thuth@redhat.com, darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com, lvivier@redhat.com
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-4-davydov-max@yandex-team.ru>
 <e52a7cea-5f89-40f0-8bba-e244c3642a0a@linaro.org>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <e52a7cea-5f89-40f0-8bba-e244c3642a0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thanks for reviewing!
I'll change patch subject to more appropriate one and fix the docstring

On 11/10/23 10:03, Philippe Mathieu-Daudé wrote:
> On 8/11/23 16:38, Maksim Davydov wrote:
>> Add a supportive property to access the path to the qemu binary
>>
>> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
>> ---
>>   python/qemu/machine/machine.py | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/python/qemu/machine/machine.py 
>> b/python/qemu/machine/machine.py
>> index 31cb9d617d..78436403b2 100644
>> --- a/python/qemu/machine/machine.py
>> +++ b/python/qemu/machine/machine.py
>> @@ -328,6 +328,11 @@ def args(self) -> List[str]:
>>           """Returns the list of arguments given to the QEMU binary."""
>>           return self._args
>>   +    @property
>> +    def binary(self) -> str:
>> +        """Returns path to the qemu binary"""
>> +        return self._binary
>> +
>>       def _pre_launch(self) -> None:
>>           if self._qmp_set:
>>               if self._monitor_address is None:
>
> Better patch subject could be:
> "python/qemu/machine: Add method to retrieve QEMUMachine::binary field"

-- 
Best regards,
Maksim Davydov


