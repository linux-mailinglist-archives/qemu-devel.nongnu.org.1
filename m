Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBA77172A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 00:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSlui-0007dD-0u; Sun, 06 Aug 2023 18:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1qSluf-0007cn-Id
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 18:07:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1qSlub-0003pa-Fx
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 18:07:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-522462d8416so5356282a12.1
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1691359661; x=1691964461;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9ooOkdoknyQHTqbGMoyr9neUy0Trlp+HEUArBeYm3IA=;
 b=U0CqC0BFqAaySuTzT4mXQpYWWtwyC8bda188zr+gdfEZBB+yFPl7HNao2AhpR8Ce1v
 hLWedO/ko7AOOE0DxHUT+61Lqh3z7YjKKcnZvfG5Kc2329MEZ/LlLGM40gJZFvaBSAA4
 o+Wt+ondwmcS9swhn6Jdw2sdeqpvBKbMhM/EaP7hlQ008TdWmtoMR6FjYuZHrqeawbBB
 Xp3hU+t/xxx/B6xW5Rq8RgtVtgdmPOCxTbFrcAe2zHjMEtbStXDa+y0sFnTxBgacpKG1
 sUnqU/I3F6LMVzuA2GmayTlY+B7adttuRXfWbCfB1RRHSEDI4xdo53tdxt44nhyYnMZE
 SQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691359662; x=1691964462;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ooOkdoknyQHTqbGMoyr9neUy0Trlp+HEUArBeYm3IA=;
 b=DaarsLkrhIvaa7sfMZqIF9Ye27hxjmxedouuFNzeOQTQYgwb3sLAb+uw3/vlzSBjdB
 gf110S/c5Wu6uRZ0lzx3SVqm1KUu11VjESVpZz3rqWqVu1qWB9KsOhwYyHM/OUJom0Am
 TBQFzj20txAoAGetX32ppZqTBmvgNSt4FRSu0qBRhndmYRTuijDWq/1nEl5F1yPPwHhM
 z60JTlm69nEiwv+zZcI6i3emBWRpFsFxEpQPmFaqGm2pIW5o/xnYlK+RQqceo+qimpDH
 DyQiEkznpRe5fE3bhAXSIx0CrhqpCnmjfet9GXZazwgPPlEPF86OrxXDr68HQ3oR9bl/
 bTUg==
X-Gm-Message-State: AOJu0YyWQvtMEzHnp3DFXh9BR27WUaWPOCluSnpIEFynm2RrToI2xdVF
 +eLF+lzpunuwtcpB5auVuIg0c+2MrrhDIxCIaA9Eo2g5jLl4ARXupBA=
X-Google-Smtp-Source: AGHT+IF64lrR8vdt5m3N07cajL6sSl9ydd2etwnv1EROl0tRg9VziaxgWMrx8SHE4ImRtAFTWIL0gfMaDlCOKC7ZiQA=
X-Received: by 2002:a05:6402:514:b0:522:1fd2:ca7a with SMTP id
 m20-20020a056402051400b005221fd2ca7amr6170663edv.29.1691359661712; Sun, 06
 Aug 2023 15:07:41 -0700 (PDT)
MIME-Version: 1.0
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 7 Aug 2023 00:07:31 +0200
Message-ID: <CAHEcVy6_HUjwvww9WrqeqruYRyEDwq1Tee-tm3mxaQE=w92-HA@mail.gmail.com>
Subject: about QEMU TLS
To: qemu-devel <qemu-devel@nongnu.org>, Jinpu Wang <jinpu.wang@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: multipart/alternative; boundary="000000000000d2fe260602485b14"
Received-SPF: permerror client-ip=2a00:1450:4864:20::52d;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000d2fe260602485b14
Content-Type: text/plain; charset="UTF-8"

Hi all,

According to qemu docs [1], TLS parameters are specified as an object in
the QEMU command line:

   -object tls-creds-x509,id=id,endpoint=endpoint,dir=/path/to/cred/dir ...

of which "endpoint" is a type of "QCryptoTLSCredsEndpoint" and can be
either a "server" or a "client".

I'd like to know:

- When a VM is started with this config, is there a way (e.g. QMP) to
change the value of "endpoint"?
  If possible, how to do this? or else after the first migration of a VM,
the VM has "endpoint=server",
  which can't be migrated without stop / start.

- In which case does the QEMU reload its TLS certificate, e.g. when a QEMU
VM has been run longer
  than the valid period of its TLS certificate?

- The migration is done by using HMP monitor on both source and target
side. Is it possible to do it
  by using QMP commands?

[1] https://www.qemu.org/docs/master/system/tls.html
[2]
https://www.berrange.com/posts/2016/08/16/improving-qemu-security-part-7-tls-support-for-migration/

Thank you so much for your reply!

Yu Zhang @ Compute Platform IONOS
06.08.2023

--000000000000d2fe260602485b14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>According to qemu docs [1], TLS parameters =
are specified as an object in the QEMU command line:<br><br>=C2=A0 =C2=A0-o=
bject tls-creds-x509,id=3Did,endpoint=3Dendpoint,dir=3D/path/to/cred/dir ..=
.<br><br>of which &quot;endpoint&quot; is a type of &quot;QCryptoTLSCredsEn=
dpoint&quot; and can be either a &quot;server&quot; or a &quot;client&quot;=
.<br>=C2=A0 =C2=A0<br>I&#39;d like to know:<br><br>- When a VM is started w=
ith this config, is there a way (e.g. QMP) to change the value of &quot;end=
point&quot;? <br>=C2=A0 If possible, how to do this? or else after the firs=
t migration of a VM, the VM has &quot;endpoint=3Dserver&quot;, <br>=C2=A0 w=
hich can&#39;t be migrated without stop / start. <br>=C2=A0 =C2=A0<br>- In =
which case does the QEMU reload its TLS certificate, e.g. when a QEMU VM ha=
s been run longer <br>=C2=A0 than the valid period of its TLS certificate?<=
br>=C2=A0 <br>- The migration is done by using HMP monitor on both source a=
nd target side. Is it possible to do it <br>=C2=A0 by using QMP commands? =
=C2=A0 =C2=A0<br><br>[1]=C2=A0<a href=3D"https://www.qemu.org/docs/master/s=
ystem/tls.html">https://www.qemu.org/docs/master/system/tls.html</a><br>[2]=
 <a href=3D"https://www.berrange.com/posts/2016/08/16/improving-qemu-securi=
ty-part-7-tls-support-for-migration/">https://www.berrange.com/posts/2016/0=
8/16/improving-qemu-security-part-7-tls-support-for-migration/</a><br><br><=
div>Thank you so much for your reply!</div><div><br>Yu Zhang @ Compute Plat=
form IONOS<br><div>06.08.2023</div></div></div>

--000000000000d2fe260602485b14--

