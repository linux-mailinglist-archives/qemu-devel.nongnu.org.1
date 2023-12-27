Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC3181EDA1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 10:10:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPvo-00089b-4l; Wed, 27 Dec 2023 04:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPvO-00088J-Cq
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:10:02 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPvG-0006B9-9I
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:10:01 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5553cc31f1cso1257860a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 01:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703668192; x=1704272992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JY+n2duBOxrCr5Uwt4OmIS/fXa1Zfd0Ul91kO1BKyow=;
 b=Ud7bMuab3SgDzTvyf7qR6Em+GPvhdreBZnxrG/p+FEH4B6XsSYze5ZBvhn3IYw1gcF
 aJfkyUkMdvbLYKQfasL2/x0U0laCK/5/I8kLzI2lFhsluSTf4L77dAm7CCIsegW8Q2Bb
 T4ue/l9JNz5maAgjswy5DwxEbFpYt6s4FE5FBiLjYiia7nklZWGoPM4QIrNcSfukAt+L
 U5hvjAuBCUdT2msWvdl43RJt8HD03vinurVNKp68qDnGvL/1Mssl1pVf/EghZ4HUmP5c
 cxNYKj24x9JZiMyfdiGuE4CJzDGqJcRF7Vk34kAEMsIM6zQka/aFHaHJzsX3L9nwkcIo
 /meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703668192; x=1704272992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JY+n2duBOxrCr5Uwt4OmIS/fXa1Zfd0Ul91kO1BKyow=;
 b=fa7DCyvEZenO4n9/9LgU6+wSx2kl9klSdRD9sXo3ZN4OsiUkxYcVqn6VRfeaHw3HrL
 D4rzaAVs2LZUe6Xbuezha2PyN14FAMpW0c+ZRFDmL2TE6nituISDNOTFbMn3MrdCvZiL
 OrXMr4PDpsQoTGa0JM+GP1Yy24Ds/Afx3V+GZy05BFnZ6ChVRC/FbtwRRFSoTGgOXshF
 B+1C7jI3pT96lJ5Er1XQ1BdYUYaH1i6Y3g6Yx//cXJBLpnR+RtMYNe5v8UnL6g6fJkAW
 924cxgtYlPWnQBhYHI8B6HEsreruPCsCkozvmbJPNzVekMV3xAiGVWhmTlC91poWzpUV
 0D+g==
X-Gm-Message-State: AOJu0YwgXMnuimmZmeY2/aS5klWc3spwlTKdSYX36Qq0frkwJc3SEi2Y
 S7t7FT8hmHlm+PSomdTMrRWKuryBabi9wQ==
X-Google-Smtp-Source: AGHT+IE+XnziAygLxK58BkONBSDM1Gud32VcjsfWZ7DKbc3s7yb/oPUB8ETNwzz5UgKL2YNkAeCHNA==
X-Received: by 2002:a17:906:2854:b0:a1d:c376:216b with SMTP id
 s20-20020a170906285400b00a1dc376216bmr7545853ejc.45.1703668192385; 
 Wed, 27 Dec 2023 01:09:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a170906c4c200b00a19afc16d23sm6328819ejb.104.2023.12.27.01.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 01:09:52 -0800 (PST)
Message-ID: <6d649879-a092-4ebc-ab26-3e2dfca3d8a7@linaro.org>
Date: Wed, 27 Dec 2023 10:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Document conventional file prefixes and
 suffixes
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231226150441.97501-1-philmd@linaro.org>
 <ZYvObNOY0ThdpyYi@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZYvObNOY0ThdpyYi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On 27/12/23 08:12, Zhao Liu wrote:
> Hi Philippe,
> 
> On Tue, Dec 26, 2023 at 04:04:41PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Tue, 26 Dec 2023 16:04:41 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH] docs/devel: Document conventional file prefixes and
>>   suffixes
>> X-Mailer: git-send-email 2.41.0
>>
>> Some header and source file names use common prefix / suffix
>> but we never really ruled a convention. Start doing so with
>> the current patterns from the tree.
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/devel/style.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
>> index 2f68b50079..4da50eb2ea 100644
>> --- a/docs/devel/style.rst
>> +++ b/docs/devel/style.rst
>> @@ -162,6 +162,55 @@ pre-processor. Another common suffix is ``_impl``; it is used for the
>>   concrete implementation of a function that will not be called
>>   directly, but rather through a macro or an inline function.
>>   
>> +File Naming Conventions
>> +-----------------------
>> +
>> +Public headers
>> +~~~~~~~~~~~~~~
>> +
>> +Headers expected to be access by multiple subsystems must reside in
>> +the ``include/`` folder. Headers local to a subsystem should reside in
>> +the sysbsystem folder, if any (for example ``qobject/qobject-internal.h``
>> +can only be included by files within the ``qobject/`` folder).
>> +
>> +Header file prefix and suffix hints
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When headers relate to common concept, it is useful to use a common
>> +prefix or suffix.
>> +
>> +When headers relate to the same (guest) subsystem, the subsystem name is
>> +often used as prefix. If headers are already in a folder named as the
>> +subsystem, prefixing them is optional.
>> +
>> +For example, hardware models related to the Aspeed systems are named
>> +using the ``aspeed_`` prefix.
>> +
>> +Headers related to the same (host) concept can also use a common prefix.
>                                                                      ^^^^^^
>                                                               Maybe "suffix"?
> 
> since below you provide examples of "suffix".

Oops, indeed :)

>> +For example OS specific headers use the ``-posix`` and ``-win32`` suffixes.
>> +
>> +Registered file suffixes
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +* ``.inc``
>> +
>> +  Source files meant to be included by other source files as templates
>> +  must use the ``.c.inc`` suffix. Similarly, headers meant to be included
>> +  multiple times as template must use the ``.h.inc`` suffix.
>> +
>> +Recommended file prefixes / suffixes
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +* ``target`` and ``common`` suffixes
>> +
>> +  Files which are specific to a target should use the ``target`` suffix.
> 
> emm, it seems linux-use/* and bsd-user/* have many ``target`` prefix
> headers. Should they get cleaned up?

No, these are special to user emulation, and are defined for each
target, to be included once per target build, i.e. for Linux:

$ git grep '#include "target_' linux-user
linux-user/elfload.c:23:#include "target_signal.h"
linux-user/flatload.c:43:#include "target_flat.h"
linux-user/main.c:50:#include "target_elf.h"
linux-user/mmap.c:26:#include "target_mman.h"
linux-user/qemu.h:12:#include "target_syscall.h"
linux-user/strace.c:21:#include "target_mman.h"
linux-user/syscall.c:27:#include "target_mman.h"
linux-user/syscall.c:6313:#include "target_prctl.h"
linux-user/syscall.c:8252:#include "target_proc.h"
linux-user/syscall_defs.h:497:#include "target_signal.h"
linux-user/syscall_defs.h:701:#include "target_resource.h"
linux-user/syscall_defs.h:1230:#include "target_mman.h"
linux-user/syscall_defs.h:2256:#include "target_fcntl.h"
linux-user/syscall_defs.h:2577:#include "target_errno_defs.h"
linux-user/user-internals.h:184:#include "target_cpu.h"
linux-user/user-internals.h:185:#include "target_structs.h"

I'll add a paragraph to describe that.

> 
>> +  Such ``target`` suffixed headers usually *taint* the files including them
>> +  by making them target specific.
>> +
>> +  Files common to all targets should use the ``common`` suffix, to provide
>> +  a hint that these files can be safely included from common code.
>> +
>> +
> 
> An additional question that kind of confuses me is whether header file
> naming should use "-" or "_" to connect prefixes/suffixes?

Yeah, we use a mix of both with no particular preference.

Not sure it is worth cleaning only for aesthetic style, let's see
what other think.

> 
>>   Block structure
>>   ===============
>>   
>> -- 
>> 2.41.0
>>

Thanks!

Phil.


