Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140817E7418
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:02:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1D4w-0000fx-D1; Thu, 09 Nov 2023 17:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1D4p-0000f1-9N
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:00:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r1D4m-0000aL-Jx
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:00:38 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AABBB75A4B8;
 Thu,  9 Nov 2023 23:00:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 95AA675A4B7; Thu,  9 Nov 2023 23:00:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 905EC756094;
 Thu,  9 Nov 2023 23:00:49 +0100 (CET)
Date: Thu, 9 Nov 2023 23:00:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Howard Spoelstra <hsp.cat7@gmail.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
In-Reply-To: <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
Message-ID: <7ed360eb-fe8c-d77e-d151-067ecbb41cc0@eik.bme.hu>
References: <20231109160504.93677-2-philmd@linaro.org>
 <20231109170144.848401-1-pbonzini@redhat.com>
 <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-230211573-1699567249=:43836"
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-230211573-1699567249=:43836
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 9 Nov 2023, John Snow wrote:
> On Thu, Nov 9, 2023 at 12:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> We need meson v1.2.3 to build QEMU on macOS Sonoma.
>>>
>>> It also build fine all our CI jobs, so let's use it as our
>>> "good enough" packaged wheel.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@linaro.org>
>>> ---
>>>  python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
>>>  python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
>>>  pythondeps.toml                             |   2 +-
>>>  3 files changed, 1 insertion(+), 1 deletion(-)
>>>  delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
>>>  create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl

So these are packaged with the source. I did not know that. Now I get what 
you mean by s/downolads/installs/ in your reply. But then this is disabled 
by --disable-download but actually downloading avocado isn't? Confusing.

Regards,
BALATON Zoltan

>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index 0a35ebcf9f..a2f8c1980b 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -18,7 +18,7 @@
>>>
>>>  [meson]
>>>  # The install key should match the version in python/wheels/
>>> -meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
>>> +meson = { accepted = ">=1.2.3", installed = "1.2.3", canary = "meson" }
>>
>> We don't need to block older versions of Meson, and indeed we don't
>> want to because it's fine to use the distro package everywhere
>> (including Sonoma).  (So the subject would become would be
>> "buildsys: Bump known good meson version to v1.2.3).
>>
>> You can look at sphinx below for another case where the accepted
>> versions are much older than the installed one.
>>
>> If there's anything you'd like to add to the (just sent) documentation
>> to clarify this, please help.
>>
>> Paolo
>>
>>>
>>>  [docs]
>>>  sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
>>
>
> I'd like you to also bump the version in the python/scripts/vendor.py
> script. You may have obtained it by other means, but I like
> documenting precisely where these .whl files come from in the form of
> the script.
>
>
>
--3866299591-230211573-1699567249=:43836--

