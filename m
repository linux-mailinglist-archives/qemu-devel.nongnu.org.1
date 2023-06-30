Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D437437B9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9nh-0005Md-2u; Fri, 30 Jun 2023 04:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qF9nf-0005ML-41
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qF9nd-0005fS-L4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688114896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TB8wM4H6TBhOOT2MNHjZR0ekToWhlAhT8+JOtuFFcM=;
 b=RUZM1vz5bJdFflV0/tE/u5scpUrJ727ZWQTswl+Pz3rQ3Uy4n0heW6Or2VaMneluZRVUa3
 a2cZxc+Z1C/eZKmQ8XwMEaStb2gKCCDsyfTlAkd3ARS0jB0aWEGasUuPdusyMkUQsCflVK
 IuN5zFtlYgchUPPPwMyej5tjssRuli4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-sFyVr8BqOBurAzDTHXfF0A-1; Fri, 30 Jun 2023 04:48:14 -0400
X-MC-Unique: sFyVr8BqOBurAzDTHXfF0A-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4718c0dea6fso427739e0c.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688114894; x=1690706894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TB8wM4H6TBhOOT2MNHjZR0ekToWhlAhT8+JOtuFFcM=;
 b=ObmU2cvGdsQCXBI95IvxO/WiripUFOj1AvunWzw2j+kiGEyFdOsmKuiwEIgM7ScH7S
 L/w9ExUF+o2RjpSQaU0YE6/usB4OIo0wcikaa/9R+MT3L7f26vq+luFc/6K1izsbQZ42
 ZAnYEIwOOreQakB/rRC9tKVHf1KjFjTb0ZK6XASClpHIeR7gfDtHU4Mx3phNRwaBdQyb
 xZZ8xuOY3Bs9YT5zg2Wm4I31hPSY4SEY8dSduXMUOVVVtCt/8K4zlvwnWSNWZIZKpoPU
 V2vYhrRVf3ij4HYCQiv2NTpFoFKnee6OUhaeUK7aPuc5HPe0Y7zsYsEyS8iSSxh/kjoU
 mawg==
X-Gm-Message-State: ABy/qLZ6aHEjxmsyACKP4BipdV3YtkhCxlvDg1o0qIsUSUzlno5nGtr3
 ZrtDzPsmiLiHY5HMOuZo9grE3fh0s1Re6LA6RBj9QnAMmbpAhOqctNi2FRC8IKgfvxCO9v+xeCj
 Lab8zf2bTvzsEICOVAh+lrJ8306E5C4U=
X-Received: by 2002:a1f:3d8c:0:b0:471:875d:598e with SMTP id
 k134-20020a1f3d8c000000b00471875d598emr1400121vka.14.1688114894111; 
 Fri, 30 Jun 2023 01:48:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLUzgXllamVoix4PwpFQXjNbgp7rb8mGurpVINlrMfIinygDVMGUbf2XJJGJivCKigjBqJZrM1Q0MOPOs/BI8=
X-Received: by 2002:a1f:3d8c:0:b0:471:875d:598e with SMTP id
 k134-20020a1f3d8c000000b00471875d598emr1400118vka.14.1688114893881; Fri, 30
 Jun 2023 01:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
In-Reply-To: <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 30 Jun 2023 10:48:02 +0200
Message-ID: <CABgObfamZEHv0W3B6kPXGTiT1f2G__S=Bi1-_PYeSomsiVFaFg@mail.gmail.com>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
To: Bernhard Beschow <shentey@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, 
 "open list:X86" <xen-devel@lists.xenproject.org>, 
 Stefano Stabellini <sstabellini@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000009718d505ff54e07a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000009718d505ff54e07a
Content-Type: text/plain; charset="UTF-8"

Il mer 28 giu 2023, 13:28 Bernhard Beschow <shentey@gmail.com> ha scritto:

>
>
> Am 27. Juni 2023 12:07:40 UTC schrieb Olaf Hering <olaf@aepfle.de>:
> >Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail.com>:
> >
> >> The BAR is a 32 bit register whose default value is 0x00000001. I think
> what's supposed to happen here is a pci_set_long() rather than a
> pci_set_byte().
> >
> >Indeed, the u32 at that address changes from c121 to c101 with the
> current code.
>
> Neat! Would you mind sending a patch fixing the BMIBA register to be reset
> as 32 bit?
>

I think we should also check why writing the command register is not
disabling the BAR as well.

Paolo


> Best regards,
> Bernhard
> >
> >Olaf
>
>

--0000000000009718d505ff54e07a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 28 giu 2023, 13:28 Bernhard Beschow &lt;<a href=
=3D"mailto:shentey@gmail.com">shentey@gmail.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><br>
<br>
Am 27. Juni 2023 12:07:40 UTC schrieb Olaf Hering &lt;<a href=3D"mailto:ola=
f@aepfle.de" target=3D"_blank" rel=3D"noreferrer">olaf@aepfle.de</a>&gt;:<b=
r>
&gt;Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow &lt;<a href=3D"mailto:=
shentey@gmail.com" target=3D"_blank" rel=3D"noreferrer">shentey@gmail.com</=
a>&gt;:<br>
&gt;<br>
&gt;&gt; The BAR is a 32 bit register whose default value is 0x00000001. I =
think what&#39;s supposed to happen here is a pci_set_long() rather than a =
pci_set_byte().<br>
&gt;<br>
&gt;Indeed, the u32 at that address changes from c121 to c101 with the curr=
ent code.<br>
<br>
Neat! Would you mind sending a patch fixing the BMIBA register to be reset =
as 32 bit?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I think we should also check why writing the command register is =
not disabling the BAR as well.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Best regards,<br>
Bernhard<br>
&gt;<br>
&gt;Olaf<br>
<br>
</blockquote></div></div></div>

--0000000000009718d505ff54e07a--


