Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D42B7E206A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:53:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuJ-0003Vq-0J; Mon, 06 Nov 2023 06:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qzxuH-0003V2-3U
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:37 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1qzxuF-0003PF-94
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:36 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so7387380a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699270594; x=1699875394; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mBbyElX34CKK1zi5gagq0XPgAxuuNu+5Eo8xogL8Kdo=;
 b=OJBOOL4FQ4hSTGK5KYXMPWRTtssUSdIxlMyJP8dweVGJBMeSMTJzTfckxozKtQJNMe
 P4xpu2j/BmDJYhHS/toECiig6bhhyXHIuNoD/sLxcoEneOs5hLSLuIsnqAjTzI7ftbsK
 q01qrj9bdMJUZzyRdZpI56SvKBB8L96KedMck5mHmXSzzJ6uv9JTU7tIPCc1pf5V4Ii3
 53QKkFgeS3/vyj6Dy8suJUmmbXg0VhavMFtcQiaT3iz3MXNjUA7ICG1lx2bUv3T5mBlf
 RHJtjoghZBY6OvqLqC9NjmQRY3oXBU2U9CUFaGdWBBeM3Lmv0HHihCYZAJX2ppyLUobw
 j6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270594; x=1699875394;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBbyElX34CKK1zi5gagq0XPgAxuuNu+5Eo8xogL8Kdo=;
 b=GpwWtZ6g/yJ3jwb7LxY+GuFZCEsb+/40anG6YgPCiVl2v+ZxfzFj3dzzpxNaeReOzL
 dJK1gvI7kOlXLaL+6eHib6CjLVzbIBtlVLj+HoBuPEHLNN21uoPuWUC59dnQIGKm28B9
 EBRkUkvgPmaggQv+GHCHWmU3pm9kvrxlLuvCawJ0BuGM8DGkokZ7LFu6rOZukblcfRsG
 AUE9zdTPfDw03lyq3woi6sk+7sVab6kyFhwEG5gXSJw2xsBLcbDvgILQcLzbbAyjFGQO
 ZdzN85/urXpdjyrtuhE/euTPuYI3mrHGMsDwoTwceTaVreQGizXLw9/VqdiO5MtU+VHJ
 wJ3g==
X-Gm-Message-State: AOJu0Yz7E09wkPU9HzUEY0ssYWMck1FXaJWSeP++B1pXhJBLFAw2LOHo
 BfG239ce6HIOPhn19LJFvAjbzcYoKKujYUTUCrcr4OLhfg8=
X-Google-Smtp-Source: AGHT+IEsgjGVoHmAiGKITqNO3MWfvboeNf0j3Y7zHOu0tnVwT4NzNH1Jkya33wJmqHrel8S+E3JYfQWp7Gu8SM7F4iw=
X-Received: by 2002:a05:6402:717:b0:53e:10a1:21d with SMTP id
 w23-20020a056402071700b0053e10a1021dmr22210088edx.35.1699270593626; Mon, 06
 Nov 2023 03:36:33 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 6 Nov 2023 12:36:20 +0100
Message-ID: <CABLmASE+b5CmTyBB4vGqR7w=4cV5mXN5pg0cp6crzq6K4_zEGQ@mail.gmail.com>
Subject: Re: Error detecting linker while compiling qemu-system-ppc on macOS
To: BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001c496306097a44f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000001c496306097a44f7
Content-Type: text/plain; charset="UTF-8"

Hello,

macOS seems to use
'/Library/Frameworks/Python.framework/Versions/3.11/bin/python3'
hsp@MacOSVentura qemu-ppc % ./configure --target-list=ppc-softmmu
Using './build' as the directory for build output
python determined to be
'/Library/Frameworks/Python.framework/Versions/3.11/bin/python3'
python version: Python 3.11.0

I had both python 3.11 and 3.12 installed through brew. I now removed 3.11.
When building with
--python=/usr/local/Cellar/python@3.12/3.12.0/bin/python3.12 I get:

hsp@MacOSVentura qemu-ppc % ./configure --target-list=ppc-softmmu
--python=/usr/local/Cellar/python@3.12/3.12.0/bin/python3.12
Using './build' as the directory for build output
python determined to be '/usr/local/Cellar/python@3.12/3.12.0/bin/python3.12'
python version: Python 3.12.0

And configure succeeds.




On Mon, 6 Nov 2023, Howard Spoelstra wrote:

Hi all,

I'm getting a error while compiling on macOS (Intel). It seems linker
detection is passed an unknown argument "--version", whereas "-v" works OK?
See log below.

See also
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg10375.html and
the tickets listed in there. It should work with meson 1.2.x according to
Rene's ticket to Meson and you can install that from homebrew but it seems
it's not picked up. Why is it using
/Users/hsp/src/qemu-ppc/build/pyvenv/bin/python3.11
? How many pythons do you8 have on macOS? What does which python tell you
and does it work better when you add
--python=/path/to/python/that/homebrew/meson/uses ? Regards, BALATON Zoltan

--0000000000001c496306097a44f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<pre style=3D"margin:0em">Hello,

macOS seems to use &#39;/Library/Frameworks/Python.framework/Versions/3.11/=
bin/python3&#39;<br>hsp@MacOSVentura qemu-ppc % ./configure --target-list=
=3Dppc-softmmu<br>Using &#39;./build&#39; as the directory for build output=
<br>python determined to be &#39;/Library/Frameworks/Python.framework/Versi=
ons/3.11/bin/python3&#39;<br>python version: Python 3.11.0<br><br>I had bot=
h python 3.11 and 3.12 installed through brew. I now removed 3.11.<br>When =
building with --python=3D/usr/local/Cellar/python@3.12/3.12.0/bin/python3.1=
2 I get:

hsp@MacOSVentura qemu-ppc % ./configure --target-list=3Dppc-softmmu --pytho=
n=3D/usr/local/Cellar/python@3.12/3.12.0/bin/python3.12 <br>Using &#39;./bu=
ild&#39; as the directory for build output<br>python determined to be &#39;=
/usr/local/Cellar/python@3.12/3.12.0/bin/python3.12&#39;<br>python version:=
 Python 3.12.0<br><br></pre><pre style=3D"margin:0em">And configure succeed=
s.<br></pre><pre style=3D"margin:0em"><br>

On Mon, 6 Nov 2023, Howard Spoelstra wrote:
</pre><blockquote style=3D"border-left:0.2em solid rgb(85,85,238);margin:0e=
m;padding-left:0.85em"><pre style=3D"margin:0em">Hi all,

I&#39;m getting a error while compiling on macOS (Intel). It seems linker
detection is passed an unknown argument &quot;--version&quot;, whereas &quo=
t;-v&quot; works OK?
See log below.
</pre></blockquote><pre style=3D"margin:0em"></pre><tt>See also=20
</tt><tt><a rel=3D"nofollow" href=3D"https://lists.nongnu.org/archive/html/=
qemu-devel/2023-10/msg10375.html">https://lists.nongnu.org/archive/html/qem=
u-devel/2023-10/msg10375.html</a>
</tt><tt>and the tickets listed in there. It should work with meson 1.2.x a=
ccording=20
</tt><tt>to Rene&#39;s ticket to Meson and you can install that from homebr=
ew but it=20
</tt><tt>seems it&#39;s not picked up. Why is it using=20
</tt><tt>/Users/hsp/src/qemu-ppc/build/pyvenv/bin/python3.11 ? How many pyt=
hons do=20
</tt><tt>you8 have on macOS? What does which python tell you and does it wo=
rk=20
</tt><tt>better when you add --python=3D/path/to/python/that/homebrew/meson=
/uses ?
</tt>Regards,
BALATON Zoltan

</div>

--0000000000001c496306097a44f7--

