Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC7708E19
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 05:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzqMG-0007oX-T4; Thu, 18 May 2023 23:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1pzqM9-0007oA-Jz
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:00:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1pzqM4-0000gT-Bm
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:00:36 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1aaea43def7so20427635ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684465224; x=1687057224;
 h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RozrxPDQlKsl55n4bEZ9TCblZLAySbMDNrUzjIhVor8=;
 b=DepELET8HR+7zalLY2QqwZDDBdWa9d5Q56fF7E4EhznVb1s5EbxyBfplxk0UqLMjPO
 d5hSxblhgyYndaCklYw99Fu8GFgFpVNGKaJMnoWJAeAhDIi0WJWYzItu7UqI5unwMjYl
 1CTYQlyqYqjGhMB7ivZgAJaLiphv24nMdXzrmJl4R66l1PW5Oq60EUoKVqkcJ+ZiDPaY
 9inEpwfp6hrujJ2t9vlfJAvxvobj04nAMDWHCGh7aESxjV11WfHX1z/O3y2kq6ynL0Az
 UYb+/pALj1vCnzrR++UuyH50lim56fSTio6VW0ru/CFUqMczTVkPdrPgaII9XbmJUpq6
 LidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684465224; x=1687057224;
 h=to:subject:message-id:date:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RozrxPDQlKsl55n4bEZ9TCblZLAySbMDNrUzjIhVor8=;
 b=CkdVexWADD+fVwk3DDXI7RzOyib16z87ypiTF9lGtBfggQz49JHmhm9RXREEWbt928
 fJxbT+kGAbhC1bwA+Y+j446YsOsxdj4ho0qd9DNpXkQQNS6OYoxN9ouFPBO3cv9ek7Fz
 fQk6kHj/o3EJ3DIV1w63Ez8RX8xiLZ+3DTScedikPRlyvADbEILsxYfY6rQ3J7Xw2OaS
 Dlw/K+1LUgI1RLD6XZUTomF9HrZEpxRsZcj6MKIeqUj8KpHYhUVbPjaphuI3qTKmXoI1
 hntkb7bfcADK9KfyPFGrAKSAUj43cmbVVV+vqs4B1k/i30U/PHXHKDCiNrAnqQomQNhH
 sSZw==
X-Gm-Message-State: AC+VfDxnG2EXgEnkelAtx0pwebn3Ne3dW1jtuPfKD7w0DjOpK5EzPbOJ
 TxYsxGBw/4+QkBDYvsi53ig6dFQltrpOy81xFpwXvGX9Izt8eQxC
X-Google-Smtp-Source: ACHHUZ7VcWpg5UF9gWkmyxKUAJ45ZxcTC0DjtKVAmckvroGfZMvaGFTYH1Z2yQDgdrYdnFwVep1pcRqkD+FvjmE1oB8=
X-Received: by 2002:a17:903:1d1:b0:1ac:8837:de9 with SMTP id
 e17-20020a17090301d100b001ac88370de9mr1512927plh.3.1684465224208; Thu, 18 May
 2023 20:00:24 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 18 May 2023 20:00:23 -0700
From: Hao Xiang <hao.xiang@bytedance.com>
Mime-Version: 1.0
Date: Thu, 18 May 2023 20:00:23 -0700
Message-ID: <CAAYibXhsM8rWghEtUoehodK1u+SZ5of81vA-gshmTWiH7PvbLg@mail.gmail.com>
Subject: Configure no longer works after pulling in the latest QEMU commits
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000053afde05fc031f8f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=hao.xiang@bytedance.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000053afde05fc031f8f
Content-Type: text/plain; charset="UTF-8"

Hi,

After pulling in the QEMU latest commits, I can no longer run the
"configure" command. Below is the error message I am seeing. I believe this
is related to this change "configure: create a python venv
unconditionally".
I am running on Debian GNU/Linux 11 (bullseye) and 5.15 kernel version.
What can I do to fix/work around the issue?

Thanks, Hao

$ ~/source/qemu-community-trees/qemu/bin/debug/test$ ../../../configure
--enable-debug --static --disable-gnutls
python determined to be '/usr/bin/python3'
python version: Python 3.9.2
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
Skipping existing file
/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/bin/pip

Skipping existing file
/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/bin/pip3

mkvenv: checking for meson>=0.63.0
Metadata: missing: ['Author'], warnings: []
Metadata: missing: ['Home-page', 'Author'], warnings: []
Metadata: missing: ['Home-page', 'Author'], warnings: []
Not recognised as a requirement: ''
Unexpected line: quitting requirement scan: '[docs]'
Not recognised as a requirement: ''
Unexpected line: quitting requirement scan: '[jedi]'
Not recognised as a requirement: ''
Unexpected line: quitting requirement scan: "[:python_version < '3']"
Metadata: missing: ['Home-page', 'Author'], warnings: []
Not recognised as a requirement: ''
Unexpected line: quitting requirement scan: '[ARC]'
Not recognised as a requirement: ''
Unexpected line: quitting requirement scan: '[DNSSEC]'
mkvenv did not complete successfully:
Traceback (most recent call last):
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 730, in __init__
   self._data = json.loads(data)
  File "/usr/lib/python3.9/json/__init__.py", line 346, in loads
   return _default_decoder.decode(s)
  File "/usr/lib/python3.9/json/decoder.py", line 337, in decode
   obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib/python3.9/json/decoder.py", line 355, in raw_decode
   raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/hao.xiang/source/qemu-community-trees/qemu/python/scripts/
mkvenv.py", line 877, in main
   ensure(
  File "/home/hao.xiang/source/qemu-community-trees/qemu/python/scripts/
mkvenv.py", line 768, in ensure
   _do_ensure(dep_specs, online, wheels_dir)
  File "/home/hao.xiang/source/qemu-community-trees/qemu/python/scripts/
mkvenv.py", line 723, in _do_ensure
   dist = dist_path.get_distribution(matcher.name)
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
database.py", line 240, in get_distribution
   self._generate_cache()
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
database.py", line 167, in _generate_cache
   for dist in self._yield_distributions():
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
database.py", line 157, in _yield_distributions
   yield old_dist_class(r.path, self)
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
database.py", line 878, in __init__
   metadata = self._get_metadata(path)
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
database.py", line 958, in _get_metadata
   metadata = Metadata(path=path, scheme='legacy')
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 741, in __init__
   self.validate()
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 958, in validate
   missing, warnings = self._legacy.check(True)
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 522, in check
   self.set_metadata_version()
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 289, in set_metadata_version
   self._fields['Metadata-Version'] = _best_version(self._fields)
  File
"/data00/home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/
metadata.py", line 167, in _best_version
   raise MetadataConflictError('Unknown metadata set')
pip._vendor.distlib.metadata.MetadataConflictError: Unknown metadata set

--00000000000053afde05fc031f8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_1.26.2_NqQ2J3sz" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div class=3D"" style=3D"font-size:14px">Hi,
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><br></div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"fon=
t-size:14px">After pulling in the QEMU latest commits, I can no longer run =
the &quot;configure&quot; command. Below is the error message I am seeing. =
I believe this is related to this change &quot;configure: create a python v=
env unconditionally&quot;.
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">I am running on Debian GNU/Linux =
11 (bullseye) and 5.15 kernel version.
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">What can I do to fix/work around =
the issue?
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><br></div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"fon=
t-size:14px">Thanks, Hao
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><br></div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"fon=
t-size:14px">$ ~/source/qemu-community-trees/qemu/bin/debug/test$ ../../../=
configure --enable-debug --static --disable-gnutls
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">python determined to be &#39;/usr=
/bin/python3&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">python version: Python 3.9.2
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">mkvenv: Creating non-isolated vir=
tual environment at &#39;pyvenv&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Skipping existing file /data00/ho=
me/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/bin/pip
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Skipping existing file /data00/ho=
me/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/bin/pip=
3
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">mkvenv: checking for meson&gt;=3D=
0.63.0
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Metadata: missing: [&#39;Author&#=
39;], warnings: []
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Metadata: missing: [&#39;Home-pag=
e&#39;, &#39;Author&#39;], warnings: []
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Metadata: missing: [&#39;Home-pag=
e&#39;, &#39;Author&#39;], warnings: []
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Not recognised as a requirement: =
&#39;&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Unexpected line: quitting require=
ment scan: &#39;[docs]&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Not recognised as a requirement: =
&#39;&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Unexpected line: quitting require=
ment scan: &#39;[jedi]&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Not recognised as a requirement: =
&#39;&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Unexpected line: quitting require=
ment scan: &quot;[:python_version &lt; &#39;3&#39;]&quot;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Metadata: missing: [&#39;Home-pag=
e&#39;, &#39;Author&#39;], warnings: []
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Not recognised as a requirement: =
&#39;&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Unexpected line: quitting require=
ment scan: &#39;[ARC]&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Not recognised as a requirement: =
&#39;&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Unexpected line: quitting require=
ment scan: &#39;[DNSSEC]&#39;
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">mkvenv did not complete successfu=
lly:
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">Traceback (most recent call last)=
:
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 730, in __init__
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 self._data =3D json=
.loads(data)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/usr/lib/python=
3.9/json/<a href=3D"http://__init__.py" target=3D"_blank" rel=3D"noopener n=
oreferrer" style=3D"margin-right:2px;text-decoration:none;color:rgb(51,112,=
255)">__init__.py</a>&quot;, line 346, in loads
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 return _default_dec=
oder.decode(s)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/usr/lib/python=
3.9/json/<a href=3D"http://decoder.py" target=3D"_blank" rel=3D"noopener no=
referrer" style=3D"margin-right:2px;text-decoration:none;color:rgb(51,112,2=
55)">decoder.py</a>&quot;, line 337, in decode
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 obj, end =3D self.r=
aw_decode(s, idx=3D_w(s, 0).end())
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/usr/lib/python=
3.9/json/<a href=3D"http://decoder.py" target=3D"_blank" rel=3D"noopener no=
referrer" style=3D"margin-right:2px;text-decoration:none;color:rgb(51,112,2=
55)">decoder.py</a>&quot;, line 355, in raw_decode
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 raise JSONDecodeErr=
or(&quot;Expecting value&quot;, s, err.value) from None
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">json.decoder.JSONDecodeError: Exp=
ecting value: line 1 column 1 (char 0)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><br></div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"fon=
t-size:14px">During handling of the above exception, another exception occu=
rred:
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><br></div></div><div style=3D"mar=
gin-top:4px;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"fon=
t-size:14px">Traceback (most recent call last):
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/home/hao.xiang=
/source/qemu-community-trees/qemu/python/scripts/<a href=3D"http://mkvenv.p=
y" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:2px;=
text-decoration:none;color:rgb(51,112,255)">mkvenv.py</a>&quot;, line 877, =
in main
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 ensure(
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/home/hao.xiang=
/source/qemu-community-trees/qemu/python/scripts/<a href=3D"http://mkvenv.p=
y" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:2px;=
text-decoration:none;color:rgb(51,112,255)">mkvenv.py</a>&quot;, line 768, =
in ensure
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 _do_ensure(dep_spec=
s, online, wheels_dir)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/home/hao.xiang=
/source/qemu-community-trees/qemu/python/scripts/<a href=3D"http://mkvenv.p=
y" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:2px;=
text-decoration:none;color:rgb(51,112,255)">mkvenv.py</a>&quot;, line 723, =
in _do_ensure
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"><span> =C2=A0=C2=A0 dist =3D dist=
_path.get_distribution(<a href=3D"matcher.name)" target=3D"_blank">matcher.=
name)</a>
</span></div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-heig=
ht:1.6"><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/=
home/hao.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share=
/python-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http:/=
/database.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin=
-right:2px;text-decoration:none;color:rgb(51,112,255)">database.py</a>&quot=
;, line 240, in get_distribution
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 self._generate_cach=
e()
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://databa=
se.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">database.py</a>&quot;, line=
 167, in _generate_cache
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 for dist in self._y=
ield_distributions():
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://databa=
se.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">database.py</a>&quot;, line=
 157, in _yield_distributions
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 yield old_dist_clas=
s(r.path, self)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://databa=
se.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">database.py</a>&quot;, line=
 878, in __init__
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 metadata =3D self._=
get_metadata(path)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://databa=
se.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">database.py</a>&quot;, line=
 958, in _get_metadata
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 metadata =3D Metada=
ta(path=3Dpath, scheme=3D&#39;legacy&#39;)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 741, in __init__
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 self.validate()
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 958, in validate
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 missing, warnings =
=3D self._legacy.check(True)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 522, in check
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 self.set_metadata_v=
ersion()
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 289, in set_metadata_version
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 self._fields[&#39;M=
etadata-Version&#39;] =3D _best_version(self._fields)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">=C2=A0 File &quot;/data00/home/ha=
o.xiang/source/qemu-community-trees/qemu/bin/debug/test/pyvenv/share/python=
-wheels/distlib-0.2.8-py2.py3-none-any.whl/distlib/<a href=3D"http://metada=
ta.py" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:=
2px;text-decoration:none;color:rgb(51,112,255)">metadata.py</a>&quot;, line=
 167, in _best_version
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px"> =C2=A0=C2=A0 raise MetadataConfl=
ictError(&#39;Unknown metadata set&#39;)
</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"=
><div class=3D"" style=3D"font-size:14px">pip._vendor.distlib.metadata.Meta=
dataConflictError: Unknown metadata set
</div></div></div></body></html>

--00000000000053afde05fc031f8f--

