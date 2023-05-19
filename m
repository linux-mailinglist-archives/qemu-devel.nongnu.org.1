Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F09709CEA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03KF-0007gf-9N; Fri, 19 May 2023 12:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03KD-0007gW-40
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03K9-0003cm-Ua
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684515084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMzfVDN9Hs7kdb/WcGJ4W5/v/lgVweZJLv7vzzJzqu0=;
 b=MhR4pMTN2Aw0/rM850Op/S8FBQnjvcd8ClnUA6iQJN+W8J+F9Ix2xqOSxhrK/Z4rbfbp1s
 pOHwHBskUbn+oiRJp0vL32kILiRPSmh7v2Isij1Hjzy3xFegZGNAclYsNJBYOwrC2nyYBr
 TgErBxb+NbLOkO9yMeL+D3OCgyG3OtQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-eWG7M76JOPa-yrvg54zw1w-1; Fri, 19 May 2023 12:51:23 -0400
X-MC-Unique: eWG7M76JOPa-yrvg54zw1w-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-43483abf52aso2269674137.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 09:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515082; x=1687107082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMzfVDN9Hs7kdb/WcGJ4W5/v/lgVweZJLv7vzzJzqu0=;
 b=ZCfA9drvAa8r2CoGuEgsvVGcmdSFWCB43f34wnsORww80YWxgJoUsKEBpqDaytck2g
 +0/cMiroRR6oulD7fD+U3D4YKh7vIW2wuYWXR/xrL+ZjL5C/CHPzzY6aEjQtZ5ED1OTr
 N/2MGaAcYlw2uhGUuanQMjrHtg4nx+ED11iJilooStm9DMZE70rdR+Rtaw2wCLgTrqWu
 hD0dMghn+5/NT/Rf28iD5xcfuqbbK/XpY3kdn0KpuKZBWYmotAZRcUALJ9omNkTlftwq
 RpZ8v+U/MiUOJCVv5YYk0pC7wNqYEv2J30BXnsQDK1a9Mnt6XZuD1pszAei/LJhwLzne
 mEsg==
X-Gm-Message-State: AC+VfDwuFgJz08mTaXbmQ9fIDF6mhLcVSiFahcUIb9dS1PI+9SBS2qfp
 ujauUteA9EqkZM/TTX3uliVL5wZcz4fVQ2CeUM5XnOqrmpnbxbxyTAplixh07OsrhgPeCBb7onx
 dFApASEC6gfO34i+A6JufU5ufctrLJ4s=
X-Received: by 2002:a05:6102:e44:b0:434:536c:7078 with SMTP id
 p4-20020a0561020e4400b00434536c7078mr1241269vst.26.1684515082603; 
 Fri, 19 May 2023 09:51:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MXNalZAQLZIDl4fQRTmxJGcXzP/TQNfNFykI1xge6/XVPNBm3swUFIDRjRveigFhss1IzwBciCFENINcgkks=
X-Received: by 2002:a05:6102:e44:b0:434:536c:7078 with SMTP id
 p4-20020a0561020e4400b00434536c7078mr1241262vst.26.1684515082289; Fri, 19 May
 2023 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230518114025.1006732-1-pbonzini@redhat.com>
 <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
In-Reply-To: <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2023 18:51:11 +0200
Message-ID: <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000019546905fc0ebba5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000019546905fc0ebba5
Content-Type: text/plain; charset="UTF-8"

Il ven 19 mag 2023, 16:39 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Thu, 18 May 2023 at 12:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > ----------------------------------------------------------------
> > * kvm: enable dirty ring for arm64
> > * target/i386: new features
> > * target/i386: AVX fixes
> > * configure: create a python venv unconditionally
> > * meson: bump to 0.63.0 and move tests from configure
> > * meson: Pass -j option to sphinx
> > * drop support for Python 3.6
> > * fix check-python-tox
> > * fix "make clean" in the source directory
>
> Hi; this seems to have broken builds from not-clean on my system.
> Blowing away the build tree and recreating it from scratch
> works, as does manually re-running configure,
> but the Makefile ought to re-run parts of configure
> etc when it needs to.
>

Can you send your config-host.mak after a failed rebuild? I think what's
happening is that the path to meson has changed but Makefile still tries
the old one (which could be the system meson in /usr/bin).

If so, you should be able to get out of the breakage by adding

MESON=pyvenv/bin/meson

after the "-include config-host.mak" line.

Paolo


> It does seem to try to, but (unlike a manual configure re-run)
> it doesn't prevent the failure.
>
> You can see that it says it needs to run configure, and mkvenv
> claims to be installing meson 0.6.3, but then the actual build
> says it didn't work. (A second run of 'make' at this point doesn't
> do the rerun of configure but meson fails in the same way.)
>
> Other weird things:
> (1) the error message is printed three times
> (2) "warn: ignoring non-existent submodule meson"
>
> $ make -C build/x86-tgts
> make: Entering directory
> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'
> config-host.mak is out-of-date, running configure
> python determined to be '/usr/bin/python3'
> python version: Python 3.10.6
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=0.63.0
> mkvenv: installing meson>=0.63.0
> mkvenv: checking for sphinx>=1.6.0, sphinx-rtd-theme>=0.5.0
> /usr/bin/ninja  build.ninja && touch build.ninja.stamp
> [0/1] Regenerating build files.
> The Meson build system
> Version: 0.61.5
> Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
> Build type: native build
>
> ../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project
> requires >=0.63.0
>
> A full log can be found at
>
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-log.txt
> FAILED: build.ninja
> /usr/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
> regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
> ninja
> ninja: error: rebuilding 'build.ninja': subcommand failed
>   GIT     ui/keycodemapdb meson tests/fp/berkeley-testfloat-3
> tests/fp/berkeley-softfloat-3 dtc
> warn: ignoring non-existent submodule meson
> /usr/bin/ninja  build.ninja && touch build.ninja.stamp
> [0/1] Regenerating build files.
> The Meson build system
> Version: 0.61.5
> Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
> Build type: native build
>
> ../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project
> requires >=0.63.0
>
> A full log can be found at
>
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-log.txt
> FAILED: build.ninja
> /usr/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
> regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
> ninja
> ninja: error: rebuilding 'build.ninja': subcommand failed
>   GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
> tests/fp/berkeley-softfloat-3 dtc
> [0/1] Regenerating build files.
> The Meson build system
> Version: 0.61.5
> Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
> Build type: native build
>
> ../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project
> requires >=0.63.0
>
> A full log can be found at
>
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-log.txt
> ninja: error: rebuilding 'build.ninja': subcommand failed
> FAILED: build.ninja
> /usr/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
> regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
> ninja
> make: *** [Makefile:165: run-ninja] Error 1
> make: Leaving directory
> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'
>
>
> thanks
> -- PMM
>
>

--00000000000019546905fc0ebba5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 19 mag 2023, 16:39 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, 18 May 2023 at 12:41, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt; ----------------------------------------------------------------<br>
&gt; * kvm: enable dirty ring for arm64<br>
&gt; * target/i386: new features<br>
&gt; * target/i386: AVX fixes<br>
&gt; * configure: create a python venv unconditionally<br>
&gt; * meson: bump to 0.63.0 and move tests from configure<br>
&gt; * meson: Pass -j option to sphinx<br>
&gt; * drop support for Python 3.6<br>
&gt; * fix check-python-tox<br>
&gt; * fix &quot;make clean&quot; in the source directory<br>
<br>
Hi; this seems to have broken builds from not-clean on my system.<br>
Blowing away the build tree and recreating it from scratch<br>
works, as does manually re-running configure,<br>
but the Makefile ought to re-run parts of configure<br>
etc when it needs to.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Can you send your config-host.mak after a failed rebui=
ld? I think what&#39;s happening is that the path to meson has changed but =
Makefile still tries the old one (which could be the system meson in /usr/b=
in).</div><div dir=3D"auto"><br></div><div dir=3D"auto">If so, you should b=
e able to get out of the breakage by adding</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">MESON=3Dpyvenv/bin/meson</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">after the &quot;-include config-host.mak&quot; line.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
It does seem to try to, but (unlike a manual configure re-run)<br>
it doesn&#39;t prevent the failure.<br>
<br>
You can see that it says it needs to run configure, and mkvenv<br>
claims to be installing meson 0.6.3, but then the actual build<br>
says it didn&#39;t work. (A second run of &#39;make&#39; at this point does=
n&#39;t<br>
do the rerun of configure but meson fails in the same way.)<br>
<br>
Other weird things:<br>
(1) the error message is printed three times<br>
(2) &quot;warn: ignoring non-existent submodule meson&quot;<br>
<br>
$ make -C build/x86-tgts<br>
make: Entering directory<br>
&#39;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts&#39;<br>
config-host.mak is out-of-date, running configure<br>
python determined to be &#39;/usr/bin/python3&#39;<br>
python version: Python 3.10.6<br>
mkvenv: Creating non-isolated virtual environment at &#39;pyvenv&#39;<br>
mkvenv: checking for meson&gt;=3D0.63.0<br>
mkvenv: installing meson&gt;=3D0.63.0<br>
mkvenv: checking for sphinx&gt;=3D1.6.0, sphinx-rtd-theme&gt;=3D0.5.0<br>
/usr/bin/ninja=C2=A0 build.ninja &amp;&amp; touch build.ninja.stamp<br>
[0/1] Regenerating build files.<br>
The Meson build system<br>
Version: 0.61.5<br>
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts<br>
Build type: native build<br>
<br>
../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project<br>
requires &gt;=3D0.63.0<br>
<br>
A full log can be found at<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-=
log.txt<br>
FAILED: build.ninja<br>
/usr/bin/python3<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal<br>
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend<br>
ninja<br>
ninja: error: rebuilding &#39;build.ninja&#39;: subcommand failed<br>
=C2=A0 GIT=C2=A0 =C2=A0 =C2=A0ui/keycodemapdb meson tests/fp/berkeley-testf=
loat-3<br>
tests/fp/berkeley-softfloat-3 dtc<br>
warn: ignoring non-existent submodule meson<br>
/usr/bin/ninja=C2=A0 build.ninja &amp;&amp; touch build.ninja.stamp<br>
[0/1] Regenerating build files.<br>
The Meson build system<br>
Version: 0.61.5<br>
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts<br>
Build type: native build<br>
<br>
../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project<br>
requires &gt;=3D0.63.0<br>
<br>
A full log can be found at<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-=
log.txt<br>
FAILED: build.ninja<br>
/usr/bin/python3<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal<br>
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend<br>
ninja<br>
ninja: error: rebuilding &#39;build.ninja&#39;: subcommand failed<br>
=C2=A0 GIT=C2=A0 =C2=A0 =C2=A0ui/keycodemapdb tests/fp/berkeley-testfloat-3=
<br>
tests/fp/berkeley-softfloat-3 dtc<br>
[0/1] Regenerating build files.<br>
The Meson build system<br>
Version: 0.61.5<br>
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts<br>
Build type: native build<br>
<br>
../../meson.build:1:0: ERROR: Meson version is 0.61.5 but project<br>
requires &gt;=3D0.63.0<br>
<br>
A full log can be found at<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-logs/meson-=
log.txt<br>
ninja: error: rebuilding &#39;build.ninja&#39;: subcommand failed<br>
FAILED: build.ninja<br>
/usr/bin/python3<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal<br>
regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu<br>
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend<br>
ninja<br>
make: *** [Makefile:165: run-ninja] Error 1<br>
make: Leaving directory<br>
&#39;/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts&#39;<br>
<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000019546905fc0ebba5--


