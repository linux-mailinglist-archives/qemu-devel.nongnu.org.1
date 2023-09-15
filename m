Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B87A22F7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhB8I-00011R-41; Fri, 15 Sep 2023 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qhB8F-00010x-AO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qhB8D-0002Rh-LX
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694793201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfdTHNvw1+EKSfdvGLPxVyi5z1lrFRjBped8uf6AKR0=;
 b=Nq4oo7LFTTONVNGIAAasIqpAQFR2BjDMakypttdjukFEp5w9fZqOCW9BGXT397yk8Fn8ey
 u4CJ1IPw/R8eCY7piTuYzzTMm6k0VXFuTWXfFfe8cn+J3LG3O2d3dEWg+nBDq9b7ImMtbW
 KQvZa1p55VXTA60W8m4eicbYrHt7vKs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-7qcr4-kYPRyff763MUZn9A-1; Fri, 15 Sep 2023 11:53:19 -0400
X-MC-Unique: 7qcr4-kYPRyff763MUZn9A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso151369666b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694793198; x=1695397998;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xfdTHNvw1+EKSfdvGLPxVyi5z1lrFRjBped8uf6AKR0=;
 b=G/LACquV31XBXdrXVPHLQkBV9rThEBKxiBHlg0BTcpGRIbwMwyTTLKGA86i0RVVSZe
 Zs6qPORIgDjf+mP+RYa4Fe/E0VD5dx1sajb2Lla2WrzWNF/2x7CWnG9VErIU+FbcP43T
 iDpd4Rzo3E9FMQqBDwVSPp11JhEnzKVGZX/1D4aYtiPua8+Z9qIbof6sFzUj3iXN49wQ
 2r09MtXzkcnd5c89bUqjFR52aI3ioAADHsxsn2dnxNxyfIxitJGNucRN8sL4TSsi+K+M
 UkW1QXHB3i5x+50328ugCoKpspqnuew9NFPnQgsegCc8KYyd3EpNQT/BbXlVn5v8fyUT
 ut9w==
X-Gm-Message-State: AOJu0YyJ+u5qI9JAvZEftHM9XN5ULKnm0l3VOVPOv4J1RHy1KiiLSntM
 8OnZPJuw9EJ7ha8UXkc7TLWWxLCFKGtzg/yiJDjHZDnUOWBP4/+Wvjp1DueR9Ck2WcQ28CYHMYG
 5jE6iqq/6ezst5yM=
X-Received: by 2002:a17:906:10c:b0:9a6:4fe0:4552 with SMTP id
 12-20020a170906010c00b009a64fe04552mr1816406eje.46.1694793198485; 
 Fri, 15 Sep 2023 08:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPRcWTIUT6mx9aXVAg3HcXHREoZlzBKPTDb96GIOC2S8EeH/9Wg8WMsvlfeiUUnV0xo/y6YA==
X-Received: by 2002:a17:906:10c:b0:9a6:4fe0:4552 with SMTP id
 12-20020a170906010c00b009a64fe04552mr1816391eje.46.1694793198086; 
 Fri, 15 Sep 2023 08:53:18 -0700 (PDT)
Received: from [192.168.178.136] (port-92-192-229-70.dynamic.as20676.net.
 [92.192.229.70]) by smtp.gmail.com with ESMTPSA id
 sd5-20020a170906ce2500b00992a8a54f32sm2561095ejb.139.2023.09.15.08.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:53:16 -0700 (PDT)
Message-ID: <bbf3127802e95a7c9985c179bb470de4a970b64f.camel@redhat.com>
Subject: Re: [PATCH v2 00/10] Generate x86 cpu features
From: Tim Wiederhake <twiederh@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Date: Fri, 15 Sep 2023 17:53:16 +0200
In-Reply-To: <20230911132618.16af94de@imammedo.users.ipa.redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908164846.184aba1c@imammedo.users.ipa.redhat.com>
 <ZPtR8BQquJ3BRgPH@redhat.com>
 <20230911132618.16af94de@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2023-09-11 at 13:26 +0200, Igor Mammedov wrote:
> On Fri, 8 Sep 2023 17:55:12 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Fri, Sep 08, 2023 at 04:48:46PM +0200, Igor Mammedov wrote:
> > > On Fri,=C2=A0 8 Sep 2023 14:45:24 +0200
> > > Tim Wiederhake <twiederh@redhat.com> wrote:
> > > =C2=A0=20
> > > > Synchronizing the list of cpu features and models with qemu is
> > > > a recurring
> > > > task in libvirt. For x86, this is done by reading qom-list-
> > > > properties for
> > > > max-x86_64-cpu and manually filtering out everthing that does
> > > > not look like
> > > > a feature name, as well as parsing target/i386/cpu.c for cpu
> > > > models.=C2=A0=20
> > >=20
> > > modulo fixing typos/name conflicts in 1st 3 patches,
> > >=20
> > > I don't think it's a great idea for libvirt (or any other user)
> > > to parse
> > > QEMU source (whether it's C code or yaml) or other way around for
> > > users
> > > to influence QEMU internals.=C2=A0=20
> >=20
> > NB It isn't for libvirt to parse at runtime, rather it is for
> > libvirt
> > maintainers to consume during dev, so libvirt keeps in sync with
> > QEMU
> > features.
>=20
> As QEMU dev, I'm not fond of code generators as sometimes they make
> difficult for me to read, and on to of that inventing new 'language'
> to describe features that works on some cases only (not everything
> is described in feature array, and for non x86 properties mostly
> coded in initfn/realizefn).
> (I'd dislike it less if it were part of QMP schema as it gets us
> closer to processing '-device' with QMP machinery).
>=20
> why not use existing QMP interface there as well (or alter it if
> it's not sufficient)?
>=20
>=20
I understand your concern regarding the legibility of generated code.
If you have a look at patches 6 - 9, you will see that the only changes
introduced are white space changes, harmonizing the usage of trailing
commas, breaking lines, and filling the "feat_names" field fully. That,
if anything, makes the code more readable in my opinion.

The format of the yaml file is chosen to mimic struct FeatureWordInfo
as closely as possible, it is effectively a 1:1 mapping.

Regarding using the QMP interface: That is what libvirt is currently
doing, see [1] if you are interested. The problem with that approach is
that the response to

    {
        "execute": "qom-list-properties",
        "arguments": { "typename": "max-x86_64-cpu"}
    }

does not distinguish between cpu features and other information about
that cpu model, thus forcing libvirt to maintain a list of non-
features. Examples of such items are "check", "enforce", "start-
powered-off", or "migratable".

Additionally, the response does not include information about the cpuid
leaf, register and bit, or msr register respectively. This has to be
supplemented manually.

If there is a way to query for this information that I am not aware of,
please let me know.

Ultimately I would love to see libvirt stop querying qemu for x86 cpu
feature information but instead have both qemu and libvirt query a
common source / database for this kind of information, for all
architectures, not only x86.

Regards,
Tim

[1]
https://gitlab.com/libvirt/libvirt/-/blob/master/src/cpu_map/sync_qemu_feat=
ures_i386.py


