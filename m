Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C97341BE
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Jun 2023 16:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAXHy-0008Or-9L; Sat, 17 Jun 2023 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lebrongandalf@gmail.com>)
 id 1qAXHw-0008Oi-O4
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 10:52:28 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lebrongandalf@gmail.com>)
 id 1qAXHu-0002Fa-W2
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 10:52:28 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-25ee8d84b4fso129185a91.0
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687013545; x=1689605545;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FO0K05JL4XfxiE2zvFeXaFHSSvaTpSbT7j5tHQSArbE=;
 b=OizAPsGBKnJPEh7UYc+tihMiSB6ab+4JZ1cMI0G5KZF40KMo8ZDlKHTh+EJo9W+ZcY
 jTm/R73A3p9OKx/iwDCGluRiBDER7+7yO6W3Qpvp8f11lIle4a94QXtJx4Ou+lYzPHN9
 x8lMxaMIzl+BMwm8ynOiUrINP721Kl+4A+pu5KZSBz7xf6RmwMF5cVaU2D42UJml/y6M
 CGUkUpJLkDYBNcPewuMv72AfKNOj5suGDtDmtT76OFNWTbRS2JsLHWIMAOFcoJGe1QiQ
 A2VG4I0drhUC1scXTeouAKSKB4t2Ys1zjpf/VvPM+fkUt/jNLID5j6lNkZSQzy6N18MQ
 JC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687013545; x=1689605545;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FO0K05JL4XfxiE2zvFeXaFHSSvaTpSbT7j5tHQSArbE=;
 b=OBIf5UN3WChIjeDUcHYS+7eN/BnZQXPLOsGEPUbnLXhBj8dxxOMjRbIlVReU6fNVw2
 de12Ca2kn5UDNuBgYDUaJN7CdI/Zwh0Tt9nXOqPQ1Btp2orPdPuW+260yFf8YpnCwSOU
 bmmCelS2IwGfobEJCvnHysqta4ulZw4SDWsBsXAGyVqV/RppZNzxkR3XXNYNS/epaUwg
 6KY33quXLOP76Aoz0q+D6k5EFOfJIH24w32nL06EWwv4XcApHGcJiUvMWOawEl37jsQc
 g10vI5hFNcqOuUfdzh1ld6QtVB89oCYi8NKHTyQuQlhKLoSEiFoQYHPXx3KTjEAfcBsA
 IEpA==
X-Gm-Message-State: AC+VfDxdZWGTJ0JAZ9qkgGxZfK3dBg1hCYgXOd07x7XjQwvlP3qvHwTL
 0sB7b1H/zh+GV5brNotHEa31f4TWcvbR1nwn6J1zx79fKw==
X-Google-Smtp-Source: ACHHUZ4QqR8uJfPPvw76Ysq86bWWSLR0aNl0ScOO7NJuF1Md0iEEZWEW/MT6LQ70av0tVmcY7bRaGM3J4HYne5fBLVc=
X-Received: by 2002:a17:90b:a14:b0:259:224a:9d05 with SMTP id
 gg20-20020a17090b0a1400b00259224a9d05mr5094552pjb.3.1687013544715; Sat, 17
 Jun 2023 07:52:24 -0700 (PDT)
MIME-Version: 1.0
From: GanDalf LeBron <lebrongandalf@gmail.com>
Date: Sat, 17 Jun 2023 22:52:13 +0800
Message-ID: <CA+V5jYVVhPubovF8An+6cuDbiv2mrxtRmWfUujbnEo3q63u0XA@mail.gmail.com>
Subject: The real function of calling cpu_io_recompile in non-icount mode
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000010690d05fe5473f2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=lebrongandalf@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--00000000000010690d05fe5473f2
Content-Type: text/plain; charset="UTF-8"

As said in the comment, instructions doing device I/Os must be at the end
of the TB in deterministic execution mode, icount mode or replay mode in
other words.

But cpu_io_recompile is still got called when I disable icount opt. The
corresponding MemoryRegion is apic-msi with the access address fee000b0.
Why is the cpu_io_recompile called in non-icount mode?

I checked a lot of historical commit messages about cpu_io_recompile. It
was brought into QEMU because of the use of icount.
/*
commit 2e70f6efa8b960d3b5401373ad6fa98747bb9578
Add instruction counter.
git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@4799
c046a42c-6fe2-441c-8c8c-71466251a162
2e70f6ef pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162> on 2008/6/29
at 09:03
*/

The commit below explained that TB would be recompiled if MMIO touching
address is located in the middle of TB.
/*
commit afd46fcad2dceffda35c0586f5723c127b6e09d8
icount: fix cpu_restore_state_from_tb for non-tb-exit cases  In icount
mode, instructions that access io memory spaces in the middle of the
translation block invoke TB recompilation.
*/

Anyway, there is no evidence to prove that cpu_io_recompile would be used
in non-icount mode?

Is it correctly? Or I just encountered some EXTREME BUG?

--00000000000010690d05fe5473f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As said in the comment, instructions doing device I/Os mus=
t be at the end of the TB in=C2=A0deterministic execution mode, icount mode=
 or replay mode in other words.<div><br></div><div>But cpu_io_recompile is =
still got called when I disable icount opt. The corresponding MemoryRegion =
is apic-msi with the access address=C2=A0fee000b0. Why is the cpu_io_recomp=
ile called in non-icount mode?=C2=A0</div><div><br></div><div>I checked a l=
ot of historical commit messages about cpu_io_recompile. It was brought int=
o QEMU because of the use of icount.</div><div>/*</div><div>commit=C2=A02e7=
0f6efa8b960d3b5401373ad6fa98747bb9578</div><div>Add instruction counter.<br=
>git-svn-id: svn://<a href=3D"http://svn.savannah.nongnu.org/qemu/trunk@479=
9">svn.savannah.nongnu.org/qemu/trunk@4799</a> c046a42c-6fe2-441c-8c8c-7146=
6251a162<br>2e70f6ef pbrook &lt;pbrook@c046a42c-6fe2-441c-8c8c-71466251a162=
&gt; on 2008/6/29 at 09:03<br></div><div>*/</div><div><br></div><div>The co=
mmit below explained that TB would be recompiled if MMIO touching address i=
s located in the middle of TB.</div><div>/*</div><div>commit afd46fcad2dcef=
fda35c0586f5723c127b6e09d8<br></div><div>icount: fix cpu_restore_state_from=
_tb for non-tb-exit cases =C2=A0In icount mode, instructions that access io=
 memory spaces in the middle of the translation block invoke TB recompilati=
on.<br></div><div>*/</div><div><br></div><div>Anyway, there is no evidence =
to prove that cpu_io_recompile would be used in non-icount mode?</div><div>=
<br></div><div><pre style=3D"font-family:courier,&quot;courier new&quot;,mo=
nospace;font-size:14px;margin:0em;color:rgb(0,0,0)">Is it correctly? Or I j=
ust encountered some EXTREME BUG?</pre></div></div>

--00000000000010690d05fe5473f2--

