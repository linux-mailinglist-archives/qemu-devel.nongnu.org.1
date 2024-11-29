Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A19DA341
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Nov 2024 08:42:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGCfg-0002f1-04; Wed, 27 Nov 2024 02:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tGCfa-0002ee-NU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:41:07 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tGCfW-0001yk-DG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:41:06 -0500
Message-ID: <04edda40-32d2-43e0-8ade-a4b2a3e06eab@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1732693256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7cRTFNEHy+uKdH8+AWNBo+R70NdpdNPuW8z/01NfxU=;
 b=wcqJLaQtK6e+Ldm8MD/aA2UW3/e60xAmRFawx9ik8HjdIkm/uvaFDBQTEAiBG1azuE33dU
 VI1nZnqHq/Ia6/Om1opjlRCiWQsIShZoTOqHYHrsa7StFukvVbJ+2geB+FU39oo+qZMDYX
 TAHi+V+2v+L/ird0Gw0aDE4MNlJAQb8=
Date: Wed, 27 Nov 2024 10:40:56 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241113094342.282676-2-frolov@swemel.ru>
 <Z0YUMoPr0oyQhqqK@redhat.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <Z0YUMoPr0oyQhqqK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello, Daniel

On 26.11.2024 21:32, Daniel P. Berrangé wrote:
> On Wed, Nov 13, 2024 at 12:43:40PM +0300, Dmitry Frolov wrote:
>> Some tests need more time when qemu is built with
>> "--enable-asan --enable-ubsan"
>>
>> As was discussed here:
>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.r/u
>>
>> TIMEOUT_MULTIPLIER enviroment variable will be
>> a useful option, allowing non-invasive timeouts
>> increasing for a specific build.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> ---
>>   scripts/mtest2make.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>> index eb01a05ddb..ff60b62724 100644
>> --- a/scripts/mtest2make.py
>> +++ b/scripts/mtest2make.py
>> @@ -27,7 +27,9 @@ def names(self, base):
>>   .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
>>   .speed.thorough = $(foreach s,$(sort $1), --suite $s)
>>   
>> +ifndef TIMEOUT_MULTIPLIER
>>   TIMEOUT_MULTIPLIER = 1
>> +endif
> Can you explain what scenario this is needed for, as unless I'm
> missing something this change has no purpose. This assignment is
> merely defining the defalt value, which can already be overridden
> at runtime without this 'ifndef'
>
> eg
>
> $ make check-unit TIMEOUT_MULTIPLIER=7
>
> In another shell:
>
> $ ps -axuwwf | grep 'meson test'
> berrange 1931657  3.9  0.1 330904 99344 pts/1    S+   18:29   0:00                  \_ /var/home/berrange/src/virt/qemu/build/pyvenv/bin/python3 /var/home/berrange/src/virt/qemu/build/pyvenv/bin/meson test --no-rebuild -t 7 --num-processes 1 --print-errorlogs --suite unit
>
> shows TIMEOUT_MULTIPLIER being honoured
Yeah... You are right!
It is possible to set TIMEOUT_MULTIPLIER only to run tests.
It is not necessary to set it for the whole build.

Sorry, and thanks a lot!
>
>
> With regards,
> Daniel
regards,
Dmitry

