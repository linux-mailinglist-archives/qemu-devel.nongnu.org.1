Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D78BD5FF9
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 21:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8OUF-0008AQ-9T; Mon, 13 Oct 2025 15:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8OUC-00089W-30
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:45:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8OU8-00057g-7d
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:45:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so2789222f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760384730; x=1760989530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILvSF3WsZxulQy/peuKeQc/syQw8y66TKZyReDbmr2U=;
 b=A5Nq/ZGOgEAs12c162kOfaJumcuKUlJBWxgzGxhs0r4AVQD7oVe98GZhFKgfnMw8XI
 N5igvOnHEoJrZjcwMOu7KCVcCeMEzDQVDNLndXfQzCRtYy+lLWcnhGPluTPuep2UP2de
 ouU8Sr8ZPJDUMrYGl0uaRJZm9LO4YaNtxeMts/VcTYdE9zedjK3Ko79mWWU/K2XNJDXj
 MNQAM/dyoFBOo1k+Cu9fHA6tMljnNx6m+rkl+7IDSDAjfqoq1cb2JY5vOTp/WxgGC0AN
 6CvE62nqvoS2uDpOLjseXto+qmihSadSyLuTpt6xyB6dL7RZGF91/7rb2FH6zFtUuOk1
 Xwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760384730; x=1760989530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILvSF3WsZxulQy/peuKeQc/syQw8y66TKZyReDbmr2U=;
 b=rXP+Yg0yPKyuQB24FeNyUbKJGXdToBRFZ9A7pXZXKo2gTxjw+aVuqbpYFV5n287N+D
 POkXAM+iNQNSBD6sNS8CUcOrX4S3uAE0UDGubQ8IhxfI+0xMORQ4VuLW1dedKIl2amOD
 4G+fVOr2TsMlwtiiWpCUV8zUoxqD4Z5Ky7QvX0uBC4oT9e5ETMLBumZIQ6FC9Av7dpYQ
 yFFxuKBqfo355T6BgpddEjG6A0G6/5Fwh3+JAuApVgqy+pyY0gxigSm1a2qbZK+3OIqd
 +ECbsPqvyp/1jlAX3byRpHxiIjiuZtpMZOutYQdcXqgqOzmyyO1dLw+ofbZ+0wI1BqsD
 26dg==
X-Gm-Message-State: AOJu0Yx3Q/CK+3IrpmcJhOELA0X4d3ZFi8LNNXxsg0SoxLTw9EZrDF59
 fe5GUOQh+zr32lHxy0RPhRLGKgg0L+yKM+6gDOLwbD61sdLCtHzzUbm8
X-Gm-Gg: ASbGncunRoP5BusXd3t/WjqbU3DlkhGEh1vIe6ju4Bac07MovGkixE/uzM99oOyAZKr
 LdzvcyhhM9FnypQQuFCOhspPgiL0c5dP8jxPyVPAH9dDFfUV29uNUckYtqim6MhDxh2qEHGUflt
 wIjojejDLNawQTf/fi/zRFgfnlpAb7rG0J6WE8E93IJHEURWz+u1TIFeqeQPlNBGB2XzYcn1IDe
 3p/NO4zs7lIZ4MAJPW3TVQdnxo6S8HWF49ZpYpmgXGvcbVIjteP/FnlG46bfKZoqf7B4UUMcIJO
 VzAN26vuXedCTUQ+NthOX2QjeSF8CKNNza1bEi8ODJq670Gd0dgWXpXhZ0p6YAvqySS04QROjDf
 rzuk40RsbIdTjw7q1zh5Ynu4ALoUrt3KZmIbTv6q9hsZSkKnsGC0RycO2smAOF4+pHa2A4bq5mK
 iKXS9IPRM7z0aJYFn24zKkmO8+fDy1P7/ooCfuFKlTc2RjzT8c
X-Google-Smtp-Source: AGHT+IHGRUzsu6z84Bld14uuGoXTjUT9w5ZqQUwBW9KelwtGtwUD2FCbaDSddq8OOd+fxh2n9srevA==
X-Received: by 2002:a05:6000:41cc:b0:426:d56e:124c with SMTP id
 ffacd0b85a97d-426d56e125dmr5760215f8f.32.1760384730311; 
 Mon, 13 Oct 2025 12:45:30 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf27140090f580845fcf2f0a.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:90f5:8084:5fcf:2f0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b44sm19890009f8f.16.2025.10.13.12.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:45:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:36:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <aOzm2ukHfkPF-zhT@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org> <aOzm2ukHfkPF-zhT@redhat.com>
Message-ID: <FB00047D-8A4F-4725-BC20-AD809DE70098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 13=2E Oktober 2025 11:47:38 UTC schrieb "Daniel P=2E Berrang=C3=A9" <be=
rrange@redhat=2Ecom>:
>On Mon, Oct 13, 2025 at 07:12:31AM -0400, Michael S=2E Tsirkin wrote:
>> On Mon, Oct 13, 2025 at 10:40:36AM +0000, Bernhard Beschow wrote:
>> >=20
>> >=20
>> > Am 8=2E September 2025 14:45:40 UTC schrieb "Michael S=2E Tsirkin" <m=
st@redhat=2Ecom>:
>> > >On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>> > >> Currently our security policy defines a "virtualization use case"
>> > >> where we consider bugs to be security issues, and a
>> > >> "non-virtualization use case" where we do not make any security
>> > >> guarantees and don't consider bugs to be security issues=2E
>> > >>=20
>> > >> The rationale for this split is that much code in QEMU is older an=
d
>> > >> was not written with malicious guests in mind, and we don't have t=
he
>> > >> resources to audit, fix and defend it=2E  So instead we inform use=
rs
>> > >> about what the can in practice rely on as a security barrier, and
>> > >> what they can't=2E
>> > >>=20
>> > >> We don't currently restrict the "virtualization use case" to any
>> > >> particular set of machine types=2E  This means that we have effect=
ively
>> > >> barred ourselves from adding KVM support to any machine type that =
we
>> > >> don't want to put into the "bugs are security issues" category, ev=
en
>> > >> if it would be useful for users to be able to get better performan=
ce
>> > >> with a trusted guest by enabling KVM=2E This seems an unnecessary
>> > >> restriction, and in practice the set of machine types it makes
>> > >> sense to use for untrusted-guest virtualization is quite small=2E
>> > >>=20
>> > >> Specifically, we would like to be able to enable the use of
>> > >> KVM with the imx8 development board machine types, but we don't
>> > >> want to commit ourselves to having to support those SoC models
>> > >> and device models as part of QEMU's security boundary:
>> > >> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-she=
ntey@gmail=2Ecom/
>> > >>=20
>> > >> This patch updates the security policy to explicitly list the
>> > >> machine types we consider to be useful for the "virtualization
>> > >> use case"=2E
>> > >
>> > >This use-case sounds reasonable to me=2E I also imagine that
>> > >some machines can get fixed down the road perhaps to
>> > >the point where they enter the "virtualization use case"=2E
>> > >
>> > >However, since we are
>> > >getting this elaborate, would my old idea of a runtime flag
>> > >make sense now?
>> > >
>> > >To recap, the idea was to add a "-virt" flag that will
>> > >block any machines, devices and so on not considered
>> > >part of the "virtualization use case"=2E
>> > >
>> > >We could also create a mechanism for downstreams to
>> > >tweak this as they see fit=2E
>> >=20
>> > Hi Michael,
>> >=20
>> > Thanks for confirming that the use case seems reasonable=2E
>> >=20
>> > For now, we'd like to sharpen the term "virtualization use case" to a=
llow for KVM to be usable in machines that aren't inside the security bound=
ary and where maintenance commitment is unrealistic=2E The current approach=
 is to adjust the policy and to spell out the machines where these commitme=
nts are made=2E
>> >=20
>> > The trigger for this RFC was to be able to add KVM support to the imx=
8mp-evk machine=2E I have it working but can't currently upstream it due to=
 our policy=2E It asks for unreasonable work and commitment which adds an u=
njustifyable burden on the maintainers=2E
>> >=20
>> > I do see a need for further enhancements on the broader topic like ad=
ding a -virt switch etc=2E Maybe we should come up with a different term th=
an "virtualization use case" which appears to leave a lot of room for inter=
pretation=2E I propose these topics to be addressed separately=2E
>> >=20
>> > What is missing for your R-b?
>> >=20
>> > Thanks,
>> > Bernhard
>>=20
>> rebase on top of this:
>> https://lore=2Ekernel=2Eorg/all/20250926140144=2E1998694-1-berrange@red=
hat=2Ecom
>>=20
>> if there's anything missing there, add it=2E
>
>I don't think that its desirable to rebase on top of that series,
>as it is liable to unduly delay Bernhard's work=2E
>
>With a very minimal wording tweak our current defined policy could
>avoid being a blocker for enabling KVM in imx8mp-evk=2E In
>
>  https://www=2Eqemu=2Eorg/docs/master/system/security=2Ehtml
>
>where it describes the "virtualization use case", we could simply
>tweak it to always require a versioned machine type
>
>Change
>
>  "These use cases rely on hardware virtualization extensions
>   to execute guest code safely on the physical CPU at close-
>   to-native speed=2E"
>
>To say
>
>  "These use cases apply to versioned machine types when used
>   in combination with hardware virtualization extensions
>   to execute guest code safely on the physical CPU at close-
>   to-native speed"
>
>Since imx8mp-evk won't be a versioned machine type, it is thus
>trivially excluded, without us having to enumerate all machine
>types int he docs=2E

Yeah, requiring the machine type to be versioned makes a lot of sense to m=
e=2E

Peter, what do you think?

Best regards,
Bernhard

>
>
>With regards,
>Daniel

