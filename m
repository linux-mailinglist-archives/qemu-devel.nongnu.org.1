Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B44A7FDAB8
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:03:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8M50-0001c2-Fr; Wed, 29 Nov 2023 10:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r8M4U-0001Sl-PH
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:02:02 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r8M4O-0000Fd-4h
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:01:49 -0500
Received: (qmail 1961 invoked by uid 484); 29 Nov 2023 15:01:22 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.521504 secs); 29 Nov 2023 15:01:22 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <alex.bennee@linaro.org>; 29 Nov 2023 15:01:21 -0000
Content-Type: multipart/alternative;
 boundary="------------0LCCgr6xToBMFx09Z2ThKsb4"
Message-ID: <2fbb34b1-b2cb-4456-b358-919442a21b47@lauterbach.com>
Date: Wed, 29 Nov 2023 16:01:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] first version of mcdstub
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Boenig <christian.boenig@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <87a5qwbov0.fsf@draig.linaro.org>
Content-Language: en-US
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <87a5qwbov0.fsf@draig.linaro.org>
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------0LCCgr6xToBMFx09Z2ThKsb4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29/11/2023 15:44, Alex Bennée wrote:
> Nicolas Eder<nicolas.eder@lauterbach.com>  writes:
>
>> SUMMARY
>> =======
>>
>> This patch-set introduces the first version of the mcdstub.
>> The mcdstub is a debug interface, which enables debugging QEMU
>> using the MCD (Multi-Core Debug) API.
>> The mcdstub uses TCP to communicate with the host debug software. However,
>> because MCD is merely an API, the TCP communication is not part of
>> the MCD spec but specific to this project.
>>
>> To translate between the MCD API and the TCP data stream coming from the mcdstub,
>> the host has to use a shared library (.dll/.so).
>> Such a shared library will be available soon Lauterbach's open source site
>> and will be linked to from inside this project in a future patch.
> Do you have a timeline for this? Its impossible to test without some
> sort of open implementation of the library.

You can find the library source code here:

https://gitlab.com/lauterbach/mcdrefsrv

It can be built using CMake.

>
>> The MCD API itself can be downloaded here:https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip
>>
>> QUICK START
>> ===========
>>
>> Attention: MCD is currently only supported for qemu-system-arm !
>>
>> Three components are required to Debug QEMU via MCD:
>>
>> 1. qemu-system-arm (built with this patch series applied).
>> 2. MCD shared library (translates between the MCD API and TCP data).
>> 3. Host debugging software with support for the MCD API (e.g.
>> Lauterbach TRACE32).
> We will need some sort of basic implementation to exercise the API as I
> assume TRACE32 is a paid for binary.

I am working on a python script, which directly calls the API functions. 
Upon completion it will be added to the mcdrefsrv gitlab.

--------------0LCCgr6xToBMFx09Z2ThKsb4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 29/11/2023 15:44, Alex Bennée wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a5qwbov0.fsf@draig.linaro.org">
      <pre class="moz-quote-pre" wrap="">Nicolas Eder <a class="moz-txt-link-rfc2396E" href="mailto:nicolas.eder@lauterbach.com">&lt;nicolas.eder@lauterbach.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">SUMMARY
=======

This patch-set introduces the first version of the mcdstub.
The mcdstub is a debug interface, which enables debugging QEMU
using the MCD (Multi-Core Debug) API.
The mcdstub uses TCP to communicate with the host debug software. However,
because MCD is merely an API, the TCP communication is not part of
the MCD spec but specific to this project.

To translate between the MCD API and the TCP data stream coming from the mcdstub,
the host has to use a shared library (.dll/.so).
Such a shared library will be available soon Lauterbach's open source site
and will be linked to from inside this project in a future patch.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Do you have a timeline for this? Its impossible to test without some
sort of open implementation of the library.</pre>
    </blockquote>
    <p>You can find the library source code here:</p>
    <p><a class="moz-txt-link-freetext" href="https://gitlab.com/lauterbach/mcdrefsrv">https://gitlab.com/lauterbach/mcdrefsrv</a></p>
    <p>It can be built using CMake.<br>
    </p>
    <blockquote type="cite" cite="mid:87a5qwbov0.fsf@draig.linaro.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The MCD API itself can be downloaded here: <a class="moz-txt-link-freetext" href="https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip">https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip</a>

QUICK START
===========

Attention: MCD is currently only supported for qemu-system-arm !

Three components are required to Debug QEMU via MCD:

1. qemu-system-arm (built with this patch series applied).
2. MCD shared library (translates between the MCD API and TCP data).
3. Host debugging software with support for the MCD API (e.g.
Lauterbach TRACE32).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
We will need some sort of basic implementation to exercise the API as I
assume TRACE32 is a paid for binary.</pre>
    </blockquote>
    <p>I am working on a python script, which directly calls the API
      functions. Upon completion it will be added to the mcdrefsrv
      gitlab.</p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------0LCCgr6xToBMFx09Z2ThKsb4--

