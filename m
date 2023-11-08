Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19607E5EE1
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 20:53:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0obJ-00074s-D2; Wed, 08 Nov 2023 14:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0obH-00074W-0U
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:52:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0obE-00080I-ML
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 14:52:30 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 29CF075A4B9;
 Wed,  8 Nov 2023 20:52:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1D2C875A4B8; Wed,  8 Nov 2023 20:52:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1A999756094;
 Wed,  8 Nov 2023 20:52:43 +0100 (CET)
Date: Wed, 8 Nov 2023 20:52:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Rene Engel <ReneEngel80@emailn.de>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: [NOTFORMERGE PATCH 1/2] configure: Use distrib meson
In-Reply-To: <CAFEAcA9xgS_8VV1S+-7vaqSqzK_2=0hJ+ceDP7BVdFd6TUR-nw@mail.gmail.com>
Message-ID: <44d8c245-122a-47f0-25e2-eae1dac8ac18@eik.bme.hu>
References: <20231108183251.80572-1-philmd@linaro.org>
 <20231108183251.80572-2-philmd@linaro.org>
 <CAFEAcA9xgS_8VV1S+-7vaqSqzK_2=0hJ+ceDP7BVdFd6TUR-nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1472163992-1699473163=:15444"
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-1472163992-1699473163=:15444
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 8 Nov 2023, Peter Maydell wrote:
> On Wed, 8 Nov 2023 at 18:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>  configure | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/configure b/configure
>> index f1456f6123..93735b7661 100755
>> --- a/configure
>> +++ b/configure
>> @@ -955,15 +955,8 @@ if $python -c 'import sys; sys.exit(sys.version_info >= (3,11))'; then
>>      $mkvenv ensure --dir "${source_path}/python/wheels" \
>>          'tomli>=1.2.0' || exit 1
>>  fi
>> -$mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>> -     ${source_path}/pythondeps.toml meson || exit 1
>>
>> -# At this point, we expect Meson to be installed and available.
>> -# We expect mkvenv or pip to have created pyvenv/bin/meson for us.
>> -# We ignore PATH completely here: we want to use the venv's Meson
>> -# *exclusively*.
>> -
>> -meson="$(cd pyvenv/bin; pwd)/meson"
>> +meson="$(which meson)"

Doesn't this revert 66e2c6cbace ?

> Presumably the other approach would be to make the pythondeps.toml
> say "on macos we need at least version X of meson" ?
>
> Do we know what the upstream meson issue is that we're running into
> with the older version on this host ?

Linked from the QEMU ticket in the cover letter:
https://github.com/mesonbuild/meson/issues/12399

AFAIU the problem is that macOS has system python in 
/Library/Frameworks/python.framework (or something like that) but homebrew 
does not use that but installs its own python somewhere in /opt and meson 
from homebrew uses that python but configure finds the system python which 
does not have meson so it then downloads its own meson but that's too old 
for macOS Sonoma. It should probably check for homebrew or macports 
locations too or check for meson and get the python that's using. A 
workaround apparently is to pass --python with the right path to 
configure.

Regards,
BALATON Zoltan
--3866299591-1472163992-1699473163=:15444--

