Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D685CFAC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 06:31:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcfBQ-0000GC-8z; Wed, 21 Feb 2024 00:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcfBN-0000Fn-Ae
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 00:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rcfBK-0006kW-F8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 00:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708493407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyuseMr93S3mg/Puxtk8ri3RLefHMKBv0SC2N0mxXXc=;
 b=U4/4o0cNUhbUlorMf99kU6iPaz5XaeZeHp5zuxODGvU5pvYwFZ2WuhBF21Oph3JXkzQpQR
 RUn3GtGV0tCOgQNamqJ3kgxKX+4ioow0hOOnjV5YWDFmaefbk7KF0KfTfC/g3tqUj4V/gh
 cI9tqxQzIVQlWPqZ6lGYbDX+P8zgjpo=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-l-le56xVMSKEE1OSdHR_cg-1; Wed, 21 Feb 2024 00:30:05 -0500
X-MC-Unique: l-le56xVMSKEE1OSdHR_cg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c15c0203e0so3743298b6e.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 21:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708493405; x=1709098205;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyuseMr93S3mg/Puxtk8ri3RLefHMKBv0SC2N0mxXXc=;
 b=XPC0OMe0T582P/qKMjyrf1NxW1020HabFG7yQV5SYb0U5mr5R+PbvgsD/wGIXAB1tJ
 EAQb0Rw2UwZYwpUzRwhE3lBeoNEHunJr27egmMxV1AJcERLcwwm8AKV37EpieAYI9wPJ
 284yeFegWfPELr0oaJrHbgWwUc8d6LYPJ9SIIfUBrwXUQRY8eJRbSHRJ9rjKlEA2/4Ab
 W5IO1fbozGsmCrfEjguEKMMwN+eTIMPss31QdRV6NSH8TTRib/8olq6zwHGZINPXSdT+
 ETHRjKrXABMF11+yr7v4fC7DaF4nhOtG4vMYAEg3jE6KCY9mQjfigpgiOG2Owf8CNBQy
 gEaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jdEi9M9I40cnfFm9ZKQiiqKxmcPKBBKUWqsAQAt8LLVTGTcd2YmPmlQh+3PxRIOKz674KceshGbNX5EODiWHQQyCoW0=
X-Gm-Message-State: AOJu0YwzNzXJzeO68zuhFlfdhkEtI2azg/lRdYLEdXeMp9k39g1XxHQA
 1a9rB7fhFtywh5hq7JYt3dqCVK0FvO2pCYmcHybZhe2wzXZt6UNATAwT3BIeRZ9s8B0/O/7HlQ+
 EaTm+gd04nT2Bpo7QvSGBinjU3pDH2FSqWNamYThp5ObkcltFSpSN
X-Received: by 2002:a05:6808:140e:b0:3c0:3a17:b9d4 with SMTP id
 w14-20020a056808140e00b003c03a17b9d4mr19534195oiv.36.1708493404697; 
 Tue, 20 Feb 2024 21:30:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKVRk7/N4iLTgRUyZ2ZIbZovTttb5Ng0W9Hz8ZWcueY4VBBqnwT+/iTgvMPq+3ZPwywKq21g==
X-Received: by 2002:a05:6808:140e:b0:3c0:3a17:b9d4 with SMTP id
 w14-20020a056808140e00b003c03a17b9d4mr19534175oiv.36.1708493404399; 
 Tue, 20 Feb 2024 21:30:04 -0800 (PST)
Received: from smtpclient.apple ([115.96.143.141])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a056a000c9200b006e48e64ef54sm472736pfv.173.2024.02.20.21.30.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Feb 2024 21:30:03 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3] pc: q35: Bump max_cpus to 4096 vcpus
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <vp63d36mcuib6trlqyjqpy72ysxb7ftlodr3eldhqklfg7bqi6@zc74olpzwknw>
Date: Wed, 21 Feb 2024 10:59:49 +0530
Cc: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4608F5FA-584C-4FE9-A73A-EBEF1E7B7FEA@redhat.com>
References: <20240220154204.29676-1-anisinha@redhat.com>
 <ZdTKYV5AuhYxvi1Q@redhat.com>
 <vp63d36mcuib6trlqyjqpy72ysxb7ftlodr3eldhqklfg7bqi6@zc74olpzwknw>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 20-Feb-2024, at 21:46, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Tue, Feb 20, 2024 at 03:50:57PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>> On Tue, Feb 20, 2024 at 09:12:04PM +0530, Ani Sinha wrote:
>>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS =
to allow up to 4096 vCPUs")
>>> Linux kernel can support upto a maximum number of 4096 vCPUS when =
MAXSMP is
>>> enabled in the kernel. At present, QEMU has been tested to correctly =
boot a
>>> linux guest with 4096 vcpus both with edk2 and seabios firmwares.
>>> So bump up the value max_cpus to 4096 for q35 machines versions 9 =
and newer.
>>> Q35 machines versions 8.2 and older continue to support 1024 maximum =
vcpus
>>> as before for compatibility reasons.
>>>=20
>>> If KVM is not able to support the specified number of vcpus, QEMU =
would
>>> return the following error messages:
>>>=20
>>> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
>>> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus =
requested (1728) exceeds the recommended cpus supported by KVM (12)
>>> qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus =
requested (1728) exceeds the recommended cpus supported by KVM (12)
>>> Number of SMP cpus requested (1728) exceeds the maximum cpus =
supported by KVM (1024)
>>>=20
>>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Julia Suvorova <jusual@redhat.com>
>>> Cc: kraxel@redhat.com
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> hw/i386/pc_q35.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> Changelog:
>>> v3: bump up to 4096 vcpus. It has now been tested to work with edk2.
>>> See RH Jira: https://issues.redhat.com/browse/RHEL-22202
>>=20
>> That bug indicates a dependancy on a EDK2 patch
>>=20
>>  =
https://github.com/kraxel/edk2/commit/7a03c17f0f4f4a9003d77db2660c8e087604=
b2f0
>>=20
>> we'll need to rebase the EDK2 ROMs in QEMU to get that included.
>=20
> Which will btw take a while.  edk2 is in freeze for the 2024-02 =
release
> right now, I expect the changes land upstream shortly thereafter and
> will be part of the 2024-05 release.  So end may / early june would be
> the time when rebasing to release, or somewhen in march or april when =
we
> rebase to a git snapshot ...
>=20
>> Meanwhile, plesae at least call out this EDK2 commit as a
>> pre-requisite in the commit message, so people know the
>> EDK2 ROMs in QEMU won't work (yet).
>=20
> That surely makes sense.
>=20
> Oh, and it's more than just that one commit.  I don't think it makes
> sense to compile a list of commits given this is a moving target
> (upstream review is in progress right now).

Looking at the edk2 GH, are these the PR that are waiting for upstream =
review/merge that relate to vcpu scaling?

https://github.com/tianocore/edk2/pull/5375
https://github.com/tianocore/edk2/pull/5327


